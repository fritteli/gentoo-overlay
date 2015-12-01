# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

# Maintainer notes:
# - This ebuild uses Bundler to download and install all gems in deployment mode
#   (i.e. into isolated directory inside application). That's not Gentoo way how
#   it should be done, but GitLab has too many dependencies that it will be too
#   difficult to maintain them via ebuilds.
#

USE_RUBY="ruby21"
PYTHON_COMPAT=( python2_7 )

inherit eutils git-r3 python-r1 ruby-ng user systemd

DESCRIPTION="GitLab is a free project and repository management application"
HOMEPAGE="https://about.gitlab.com/"
EGIT_REPO_URI="https://gitlab.com/gitlab-org/${PN}.git"
EGIT_BRANCH="master"
EGIT_CHECKOUT_DIR="${WORKDIR}/all"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="kerberos mysql +postgres +unicorn systemd rugged_use_system_libraries"

## Gems dependencies:
#   charlock_holmes		dev-libs/icu
#   grape, capybara		dev-libs/libxml2, dev-libs/libxslt
#   rugged				dev-util/cmake, virtual/pkgconfig
#   json				dev-util/ragel
#   pygments.rb			python 2.7+
#   execjs				net-libs/nodejs, or any other JS runtime
#   pg					dev-db/postgresql
#   mysql				virtual/mysql
#
GEMS_DEPEND="
	dev-libs/icu
	dev-libs/libxml2
	dev-libs/libxslt
	dev-util/ragel
	net-libs/nodejs
	postgres? ( >=dev-db/postgresql-9.1:* )
	mysql? ( virtual/mysql )
	kerberos? ( virtual/krb5 )"
CDEPEND="
	dev-util/cmake
	virtual/pkgconfig"
DEPEND="${GEMS_DEPEND}
	>=dev-vcs/gitlab-shell-2.6.8
	dev-vcs/git
	>=dev-vcs/gitlab-workhorse-0.4.2
	kerberos? ( !app-crypt/heimdal )
	rugged_use_system_libraries? ( net-libs/http-parser dev-libs/libgit2:0/23 )"
RDEPEND="${DEPEND}
	dev-db/redis
	virtual/mta
	systemd? ( sys-apps/systemd:0= )"
ruby_add_bdepend "
	virtual/rubygems
	>=dev-ruby/bundler-1.0"

#
# fix-sendmail-config:
#     Fix default settings to work with ssmtp that doesn't know '-t' argument.
#
RUBY_PATCHES=(
	"${PN}-fix-sendmail-config.patch"
)

MY_NAME="gitlab"
MY_USER="git"    # should be same as in gitlab-shell

DEST_DIR="/opt/${MY_NAME}"
CONF_DIR="/etc/${MY_NAME}"
LOGS_DIR="/var/log/${MY_NAME}"
TEMP_DIR="/var/tmp/${MY_NAME}"

# When updating ebuild to newer version, check list of the queues in
# https://gitlab.com/gitlab-org/gitlab-ce/blob/v${PV}/bin/background_jobs
SIDEKIQ_QUEUES="post_receive,mailer,archive_repo,system_hook,project_web_hook,gitlab_shell,incoming_email,runner,common,default"

all_ruby_unpack() {
	git-r3_fetch
	git-r3_checkout
}

all_ruby_prepare() {
	# fix paths
	local satellites_path="${TEMP_DIR}/repo_satellites"
	local repos_path=/var/lib/git/repositories
	local shell_path=/usr/share/gitlab-shell
	sed -i -E \
		-e "/satellites:$/,/\w:$/   s|(\s*path:\s).*|\1${satellites_path}/|" \
		-e "/gitlab_shell:$/,/\w:$/ s|(\s*path:\s).*|\1${shell_path}/|" \
		-e "/gitlab_shell:$/,/\w:$/ s|(\s*repos_path:\s).*|\1${repos_path}/|" \
		-e "/gitlab_shell:$/,/\w:$/ s|(\s*hooks_path:\s).*|\1${shell_path}/hooks/|" \
		config/gitlab.yml.example || die "failed to filter gitlab.yml.example"

	local run_path=/run/${MY_NAME}
	sed -i -E \
		-e "s|/home/git/gitlab/tmp/(pids\|sockets)|${run_path}|" \
		-e "s|/home/git/gitlab/log|${LOGS_DIR}|" \
		-e "s|/home/git/gitlab|${DEST_DIR}|" \
		config/unicorn.rb.example || die "failed to filter unicorn.rb.example"

	sed -i \
		-e "s|/home/git/gitlab/tmp/sockets|${run_path}|" \
		lib/support/nginx/gitlab || die "failed to filter nginx/gitlab"

	# modify default database settings for PostgreSQL
	sed -i -E \
		-e 's|(username:).*|\1 gitlab|' \
		-e 's|(password:).*|\1 gitlab|' \
		-e 's|(socket:).*|\1 /run/postgresql/.s.PGSQL.5432|' \
		config/database.yml.postgresql \
		|| die "failed to filter database.yml.postgresql"

	# rename config files
	mv config/gitlab.yml.example config/gitlab.yml
	mv config/unicorn.rb.example config/unicorn.rb

	local dbconf=config/database.yml
	if use postgres && ! use mysql; then
		mv ${dbconf}.postgresql ${dbconf}
		rm ${dbconf}.mysql
	elif use mysql && ! use postgres; then
		mv ${dbconf}.mysql ${dbconf}
		rm ${dbconf}.postgresql
	fi

	# remove useless files
	rm -r lib/support/{deploy,init.d}
	use unicorn || rm config/unicorn.rb
}

all_ruby_install() {
	local dest=${DEST_DIR}
	local conf=${CONF_DIR}
	local logs=${LOGS_DIR}
	local temp=${TEMP_DIR}

	# prepare directories
	diropts -m750
	dodir ${logs} ${temp}

	diropts -m755
	dodir ${conf} ${dest}/public/uploads

	dosym ${temp} ${dest}/tmp
	dosym ${logs} ${dest}/log

	# install configs
	insinto ${conf}
	doins -r config/*
	dosym ${conf} ${dest}/config

	echo 'export RAILS_ENV=production' > "${D}/${dest}/.profile"

	# remove needless dirs
	rm -Rf config tmp log

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

	local without="development test aws"
	local flag; for flag in mysql postgres unicorn kerberos; do
		without+="$(use $flag || echo ' '$flag)"
	done
	local bundle_args="--deployment ${without:+--without ${without}}"

	use "rugged_use_system_libraries" && export RUGGED_USE_SYSTEM_LIBRARIES="YES"

	einfo "Running bundle install ${bundle_args} ..."
	${RUBY} /usr/bin/bundle install ${bundle_args} || die "bundler failed"

	# clean gems cache
	rm -Rf vendor/bundle/ruby/*/cache
	rm -Rf vendor/bundle/ruby/*/bundler/gems/charlock_holmes-dde194609b35/.git

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${dest} ${temp} ${logs}

	## RC script ##

	if use systemd ; then
		ewarn "Beware: systemd support has not been tested, use at your own risk!"
		systemd_dounit "${FILESDIR}/gitlab-sidekiq.service"
		systemd_dounit "${FILESDIR}/gitlab-unicorn.service"
		systemd_dounit "${FILESDIR}/gitlab-workhorse.service"
		systemd_dounit "${FILESDIR}/gitlab-mailroom.service"
		systemd_dotmpfilesd "${FILESDIR}/gitlab.conf"
	else
		local rcscript=gitlab-sidekiq-8.2.init
		use unicorn && rcscript=gitlab-unicorn-8.2.init

		cp "${FILESDIR}/${rcscript}" "${T}" || die
		sed -i \
			-e "s|@USER@|${MY_USER}|" \
			-e "s|@GITLAB_BASE@|${dest}|" \
			-e "s|@LOGS_DIR@|${logs}|" \
			-e "s|@QUEUES@|${SIDEKIQ_QUEUES}|" \
			"${T}/${rcscript}" \
			|| die "failed to filter ${rcscript}"

		newinitd "${T}/${rcscript}" "${MY_NAME}"
	fi
}

pkg_postinst() {
	elog
	elog "1. Configure your GitLab's settings in ${CONF_DIR}/gitlab.yml."
	elog
	elog "2. Configure your database settings in ${CONF_DIR}/database.yml"
	elog "   for \"production\" environment."
	elog
	elog "3. Then you should create a database for your GitLab instance, if you"
	elog "haven't done so already."
	elog
	if use postgres; then
		elog "If you have local PostgreSQL running, just copy&run:"
		elog "      su postgres"
		elog "      psql -c \"CREATE ROLE gitlab PASSWORD 'gitlab' \\"
		elog "          NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;\""
		elog "      createdb -E UTF-8 -O gitlab gitlabhq_production"
		elog "  Note: You should change your password to something more random..."
		elog
	fi
	elog "4. Finally execute the following command to initlize environment:"
	elog "       emerge --config \"=${CATEGORY}/${PF}\""
	elog "   Note: Do not forget to start Redis server first!"
	elog
	elog "If this is an update from previous version, it's HIGHLY recommended"
	elog "to backup your database before running the config phase!"
	elog
	elog "If you're running GitLab behind an SSL proxy such as nginx or Apache and"
	elog "you can't login after the upgrade, be sure to read the section about the"
	elog "verification of the CSRF token in GitLab's trouble-shooting guide at"
	elog "http://goo.gl/5XGRGv."
}

pkg_config() {
	local shell_conf='/etc/gitlab-shell.yml'

	einfo "Checking configuration files"

	if [ ! -r "${CONF_DIR}/database.yml" ]; then
		eerror "Copy ${CONF_DIR}/database.yml.* to"
		eerror "${CONF_DIR}/database.yml and edit this file in order to configure your"
		eerror "database settings for \"production\" environment."; die
	fi

	# check gitlab-shell configuration
	if [ -r ${shell_conf} ]; then
		local shell_repos_path="$(ryaml ${shell_conf} repos_path)"
		local gitlab_repos_path="$(ryaml ${CONF_DIR}/gitlab.yml \
			production gitlab_shell repos_path)"

		if [ ! "${shell_repos_path}" -ef "${gitlab_repos_path}" ]; then
			eerror "repos_path in ${CONF_DIR}/gitlab.yml and ${shell_conf}"
			eerror "must points to the same location! Fix the repos_path location and"
			eerror "run this again."; die
		fi
	else
		ewarn "GitLab Shell checks skipped, could not find config file at"
		ewarn "${shell_conf}. Make sure that you have gitlab-shell properly"
		ewarn "installed and that repos_path is the same as in GitLab."
	fi

	local email_from="$(ryaml ${CONF_DIR}/gitlab.yml production gitlab email_from)"
	local git_home="$(egethome ${MY_USER})"

	# configure Git global settings
	if [ ! -e "${git_home}/.gitconfig" ]; then
		einfo "Setting git user"
		su -l ${MY_USER} -c "
			git config --global user.email '${email_from}';
			git config --global user.name 'GitLab'" \
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

		# https://github.com/gitlabhq/gitlabhq/issues/5311#issuecomment-31656496
		einfo "Migrating iids ..."
		exec_rake migrate_iids

		einfo "Cleaning old precompiled assets ..."
		exec_rake assets:clean

		einfo "Cleaning cache ..."
		exec_rake cache:clear
	else
		local update=false

		einfo "Initializing database ..."
		exec_rake gitlab:setup
	fi

	einfo "Precompiling assests ..."
	exec_rake assets:precompile

	if [ "${update}" = 'true' ]; then
		ewarn
		ewarn "This configuration script runs only common migration tasks."
		ewarn "Please read guides on"
		ewarn "    https://github.com/gitlabhq/gitlabhq/blob/master/doc/update/"
		ewarn "for any additional migration tasks specific to your previous GitLab"
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
