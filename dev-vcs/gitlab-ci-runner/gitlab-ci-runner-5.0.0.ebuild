# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

# Maintainer notes:
# - This ebuild uses Bundler to download and install all gems in deployment mode
#   (i.e. into isolated directory inside application). That's not Gentoo way how
#   it should be done, but GitLab CI Runner has too many dependencies that it
#    will be too difficult to maintain them via ebuilds.
#

USE_RUBY="ruby19 ruby20 ruby21"
PYTHON_DEPEND="2:2.7"

inherit eutils python ruby-ng user

DESCRIPTION="GitLab CI Runner is the build processor needed for GitLab CI"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci-runner"
SRC_URI="https://github.com/gitlabhq/gitlab-ci-runner/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# IUSE=""

## Gems dependencies:
#   charlock_holmes		dev-libs/icu
#   grape, capybara		dev-libs/libxml2, dev-libs/libxslt
#

GEMS_DEPEND="
	dev-libs/icu
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${GEMS_DEPEND}
	dev-vcs/git"
RDEPEND="${DEPEND}
	virtual/mta"
ruby_add_bdepend "
	virtual/rubygems
	>=dev-ruby/bundler-1.0"

#
RUBY_PATCHES=(
	"${P}-fix-gemfile.patch"
)

MY_NAME="gitlab-ci-runner"
MY_USER="gitlab_ci_runner"

DEST_DIR="/opt/${MY_NAME}"
LOGS_DIR="/var/log/${MY_NAME}"
TEMP_DIR="/var/tmp/${MY_NAME}"
RUN_DIR="/run/${MY_NAME}"

pkg_setup() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 /bin/bash ${DEST_DIR} ${MY_USER}
}

all_ruby_prepare() {
	# remove useless files
	rm -r lib/support/{init.d,logrotate.d}
}

all_ruby_install() {
	local dest=${DEST_DIR}
	local logs=${LOGS_DIR}
	local temp=${TEMP_DIR}
	local runs=${RUN_DIR}

	# prepare directories
	diropts -m750
	dodir ${logs} ${temp}

	diropts -m755
	dodir ${dest}

	dosym ${temp} ${dest}/tmp
	dosym ${logs} ${dest}/log

	echo 'export RAILS_ENV=production' > "${D}/${dest}/.profile"

	# remove needless dirs
#	rm -Rf config tmp log

	# install the rest files
	# using cp 'cause doins is slow
	cp -Rl * "${D}/${dest}"/

	# install logrotate config
	dodir /etc/logrotate.d
	cat > "${D}/etc/logrotate.d/${MY_NAME}" <<-EOF
		${logs}/*.log {
		    missingok
		    delaycompress
		    compress
		    copytruncate
		}
	EOF

	## Install gems via bundler ##

	cd "${D}/${dest}"

	local bundle_args="--deployment"

	einfo "Running bundle install ${bundle_args} ..."
	${RUBY} /usr/bin/bundle install ${bundle_args} || die "bundler failed"

	# clean gems cache
	rm -Rf vendor/bundle/ruby/*/cache

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${dest} ${temp} ${logs}

	## RC script and conf.d file ##

	local rcscript=gitlab-ci-runner.init
	local rcconf=gitlab-ci-runner.conf

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|" \
		-e "s|@GITLAB_CI_RUNNER_BASE@|${dest}|" \
		-e "s|@LOGS_DIR@|${logs}|" \
		-e "s|@RUN_DIR@|${runs}|" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${MY_NAME}"
	newconfd "${FILESDIR}/${rcconf}" "${MY_NAME}"
}

pkg_postinst() {
	elog
	elog "If this is a fresh install of GitLab CI Runner, please configure it"
	elog "with the following command:"
	elog "        emerge --config \"=${CATEGORY}/${PF}\""
}

pkg_config() {
	einfo "Checking configuration files"

	if [ ! -r "${CONF_DIR}/database.yml" ]; then
		eerror "Copy ${CONF_DIR}/database.yml.* to"
		eerror "${CONF_DIR}/database.yml and edit this file in order to configure your" 
		eerror "database settings for \"production\" environment."; die
	fi


	local email_from="$(ryaml ${CONF_DIR}/application.yml production gitlab_ci email_from)"
	local gitlab_ci_home="$(egethome ${MY_USER})"
	
	# configure Git global settings
	if [ ! -e "${gitlab_ci_home}/.gitconfig" ]; then
		einfo "Setting git user"
		su -l ${MY_USER} -c "
			git config --global user.email '${email_from}';
			git config --global user.name 'GitLab CI'" \
			|| die "failed to setup git name and email"
	fi

	if [ ! -d "${DEST_DIR}/.git" ]; then
		# create dummy git repo as workaround for
		# https://github.com/bundler/bundler/issues/2039
		einfo "Initializing dummy git repository to avoid false errors from bundler"
		su -l ${MY_USER} -c "
			cd ${DEST_DIR}
			git init
			git add README.md
			git commit -m 'Dummy repository'" >/dev/null
	fi

	## Initialize app ##

	local RAILS_ENV="production"
	local RUBY=${RUBY:-/usr/bin/ruby}
	local BUNDLE="${RUBY} /usr/bin/bundle"

	local dbname="$(ryaml ${CONF_DIR}/database.yml production database)"

	if [ -f "${DEST_DIR}/.secret" ]; then
		local update=true

		einfo "Migrating database ..."
		exec_rake db:migrate

	else
		local update=false

		einfo "Initializing database ..."
		exec_rake setup

		einfo "Setting up cron schedules ..."
		exec_rake whenever -w
	fi
	
	if [ "${update}" = 'true' ]; then
		ewarn
		ewarn "This configuration script runs only common migration tasks."
		ewarn "Please read guides on"
		ewarn "    https://gitlab.com/gitlab-org/gitlab-ci/tree/v${PV}/doc/update"
		ewarn "for any additional migration tasks specific to your previous GitLab CI"
		ewarn "version."
	fi
}

ryaml() {
	ruby -ryaml -e 'puts ARGV[1..-1].inject(YAML.load(File.read(ARGV[0]))) {|acc, key| acc[key] }' "$@"
}

exec_rake() {
	local command="${BUNDLE} exec rake $@ RAILS_ENV=${RAILS_ENV}"

	echo "   ${command}"
	su -l ${MY_USER} -c "
		export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8
		cd ${DEST_DIR}
		${command}" \
		|| die "failed to run rake $@"
}
