# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

# Maintainer notes:
# - This ebuild uses Bundler to download and install all gems in deployment mode
#   (i.e. into isolated directory inside application). That's not Gentoo way how
#   it should be done, but GitLab has too many dependencies that it will be too
#   difficult to maintain them via ebuilds.
#

USE_RUBY="ruby21 ruby23"

inherit eutils ruby-ng user systemd

MY_PV="v${PV/_/-}"
MY_GIT_COMMIT="cde955c9645ddfaae2f154d3d3aded79c9fc574f"

DESCRIPTION="GitLab is a free project and repository management application"
HOMEPAGE="https://about.gitlab.com/"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.gz?ref=${MY_PV} -> ${P}.tar.gz"
RUBY_S="${PN}-${MY_PV}-${MY_GIT_COMMIT}"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="kerberos mysql +postgres +unicorn systemd rugged_use_system_libraries"

## Gems dependencies:
#   charlock_holmes     dev-libs/icu
#   grape, capybara     dev-libs/libxml2, dev-libs/libxslt
#   rugged              dev-util/cmake, virtual/pkgconfig
#   json                dev-util/ragel
#   pygments.rb         python 2.7+
#   execjs              net-libs/nodejs, or any other JS runtime
#   pg                  dev-db/postgresql
#   mysql               virtual/mysql
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
COMMON_DEPEND="
	${GEMS_DEPEND}
	~dev-vcs/gitlab-shell-4.0.0
	>=dev-vcs/git-2.7.4
	~dev-vcs/gitlab-workhorse-1.0.0
	kerberos? ( !app-crypt/heimdal )
	rugged_use_system_libraries? ( net-libs/http-parser dev-libs/libgit2:0/24 )"
DEPEND="
	${CDEPEND}
	${COMMON_DEPEND}"
RDEPEND="
	${COMMON_DEPEND}
	>=dev-db/redis-2.8
	virtual/mta
	systemd? ( sys-apps/systemd:0= )"
# dev-ruby/bundler should be >=1.13.6, but that doesn't exist yet in the tree.
ruby_add_bdepend "
	virtual/rubygems
	>=dev-ruby/bundler-1.0"

#
# fix-sendmail-config:
#     Fix default settings to work with ssmtp that doesn't know '-t' argument.
# fix-redis-config-path:
#     Point to the absolute location of redis_config.rb
#
RUBY_PATCHES=(
	"01-${PN}-8.7.5-fix-sendmail-config.patch"
	"02-${PN}-8.11.0-fix-redis-config-path.patch"
	"03-${PN}-8.14.0-database.yml.patch"
	"04-${PN}-8.12.7-fix-check-task.patch"
	"05-${PN}-8.12.7-replace-sys-filesystem.patch"
)

MY_NAME="gitlab"
MY_USER="git"    # should be same as in gitlab-shell

DEST_DIR="/opt/${MY_NAME}"
CONF_DIR="/etc/${MY_NAME}"
LOGS_DIR="/var/log/${MY_NAME}"
TEMP_DIR="/var/tmp/${MY_NAME}"

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

	einfo "Cleaning old gems ..."
	${RUBY} /usr/bin/bundle clean

	# clean gems cache
	rm -Rf vendor/bundle/ruby/*/cache
	rm -Rf vendor/bundle/ruby/*/bundler/gems/charlock_holmes-dde194609b35/.git

	## RC script ##

	if use systemd ; then
		ewarn "Beware: systemd support has not been tested, use at your own risk!"
		systemd_newunit "${FILESDIR}/gitlab-8.13.0-sidekiq.service" "gitlab-sidekiq.service"
		systemd_dounit "${FILESDIR}/gitlab-unicorn.service"
		systemd_dounit "${FILESDIR}/gitlab-workhorse.service"
		systemd_dounit "${FILESDIR}/gitlab-mailroom.service"
		systemd_dotmpfilesd "${FILESDIR}/gitlab.conf"
	else
		local rcscript=gitlab-8.13.3-sidekiq.init
		use unicorn && rcscript=gitlab-8.13.3-unicorn.init

		cp "${FILESDIR}/${rcscript}" "${T}" || die
		sed -i \
			-e "s|@USER@|${MY_USER}|" \
			-e "s|@GITLAB_BASE@|${dest}|" \
			-e "s|@LOGS_DIR@|${logs}|" \
			"${T}/${rcscript}" \
			|| die "failed to filter ${rcscript}"

		newinitd "${T}/${rcscript}" "${MY_NAME}"
	fi

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${dest} ${temp} ${logs}
}

pkg_postinst() {
	elog "If this is an update from a previous version, stop your GitLab"
	elog "instance and issue the following command to perform all required"
	elog "migrations:"
	elog "       emerge --config \"=${CATEGORY}/${PF}\""
	elog "PLEASE NOTE: It's HIGHLY recommended to backup your database"
	elog "before running the config phase. Run these commands (as root):"
	elog
	elog "    cd /opt/gitlab"
	elog "    sudo -u git -H bundle exec rake gitlab:backup:create RAILS_ENV=production"
	elog
	elog "If this was a fresh install, follow these steps:"
	elog
	elog "1. Configure your GitLab's settings in ${CONF_DIR}/gitlab.yml."
	elog
	elog "2. Configure your database settings in ${CONF_DIR}/database.yml"
	elog "   for \"production\" environment."
	elog
	elog "3. Then you should create a database for your GitLab instance, if you"
	elog "   haven't done so already."
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
	elog "4. Finally execute the following command to initialize the environment:"
	elog "       emerge --config \"=${CATEGORY}/${PF}\""
	elog "   Note: Do not forget to start Redis server first!"
	elog
	elog "If you're running GitLab behind an SSL proxy such as nginx or Apache and"
	elog "you can't login after the upgrade, be sure to read the section about the"
	elog "verification of the CSRF token in GitLab's trouble-shooting guide at"
	elog "http://goo.gl/5XGRGv."
	if use postgres; then
		elog "Please note: As of GitLab 8.6, users of PostgreSQL need to enable the"
		elog "`pg_trgm` extension by running the following command as a PostgreSQL"
		elog "super user for *every* GitLab database:"
		elog "      CREATE EXTENSION IF NOT EXISTS pg_trgm;"
		elog "For details, see the documentation at the GitLab website."
	fi
}

pkg_config() {
	einfo "Checking configuration files"

	if [ ! -r "${CONF_DIR}/database.yml" ]; then
		eerror "Copy ${CONF_DIR}/database.yml.* to"
		eerror "${CONF_DIR}/database.yml and edit this file in order to configure your"
		eerror "database settings for \"production\" environment."; die
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

	su -l ${MY_USER} -c "git config --global repack.writeBitmaps true"

	# determine whether this is an update or a fresh install. we do this by
	# checking whether the ${DEST_DIR}/.git directory exists or not
	# 
	if [ -d "${DEST_DIR}/.git" ]; then
		local update=true
	else
		local update=false
	fi

	## Initialize app ##

	local RAILS_ENV="production"
	local RUBY=${RUBY:-/usr/bin/ruby}
	local BUNDLE="${RUBY} /usr/bin/bundle"

	# FIXME: this line existed in older ebuilds, but the variable is
	# never used. what was it for!?
	# local dbname="$(ryaml ${CONF_DIR}/database.yml production database)"

	if [ "${update}" = 'true' ]; then
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
		# create dummy git repo as workaround for
		# https://github.com/bundler/bundler/issues/2039
		einfo "Initializing dummy git repository to avoid false errors from bundler"
		su -l ${MY_USER} -c "
			cd ${DEST_DIR}
			git init
			git add README.md
			git commit -m 'Dummy repository'" >/dev/null

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
	elog
	elog "If you want to make sure that the install/upgrade was successful, start"
	elog "Gitlab now and then run these commands (as root):"
	elog
	elog "    cd /opt/gitlab"
	elog "    sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production"
	elog "    sudo -u git -H bundle exec rake gitlab:check RAILS_ENV=production"
	elog
	if ! use systemd ; then
		elog "You may also run"
		elog "    /etc/init.d/gitlab check"
		elog " for convenience."
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
