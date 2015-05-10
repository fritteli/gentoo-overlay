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
KEYWORDS="amd64 ~x86"
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
	"${PN}-5.0.0-fix-gemfile.patch"
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

	# install the files using cp 'cause doins is slow
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
	einfo "You need to register the runner with your GitLab CI instance. In"
	einfo "order to do so, you need to know the URL of GitLab CI and the"
	einfo "authentication token."
	einfo
	einfo "You can find the token on your GitLab CI website at"
	einfo
	einfo "        http://<GITLAB-CI-HOST>/admin/runners"
	einfo
	einfo "Now please follow the instructions on the screen."

	local RUBY=${RUBY:-/usr/bin/ruby}
	local BUNDLE="${RUBY} /usr/bin/bundle"

	su -l ${MY_USER} -c "
		cd ${DEST_DIR}
		${BUNDLE} exec ./bin/setup" \
		|| die "failed to run ${BUNDLE} exec ./bin/setup"
}
