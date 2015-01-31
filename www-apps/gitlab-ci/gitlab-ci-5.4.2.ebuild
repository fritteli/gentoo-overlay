# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

# Maintainer notes:
# - This ebuild uses Bundler to download and install all gems in deployment mode
#   (i.e. into isolated directory inside application). That's not Gentoo way how
#   it should be done, but GitLab has too many dependencies that it will be too
#   difficult to maintain them via ebuilds.
#

USE_RUBY="ruby19 ruby20 ruby21"
PYTHON_DEPEND="2:2.7"

inherit eutils python ruby-ng user

DESCRIPTION="GitLab CI is a continuous integration server that is tightly integrated with GitLab"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci"
SRC_URI="https://github.com/gitlabhq/gitlab-ci/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="mysql +postgres"

## Gems dependencies:
#   charlock_holmes		dev-libs/icu
#   grape, capybara		dev-libs/libxml2, dev-libs/libxslt
#   pg					dev-db/postgresql-base
#   mysql				virtual/mysql
#

GEMS_DEPEND="
	dev-libs/icu
	dev-libs/libxml2
	dev-libs/libxslt
	postgres? ( dev-db/postgresql-base )
	mysql? ( virtual/mysql )"
DEPEND="${GEMS_DEPEND}
	dev-vcs/git"
RDEPEND="${DEPEND}
	dev-db/redis
	virtual/mta"
ruby_add_bdepend "
	virtual/rubygems
	>=dev-ruby/bundler-1.0"

# no patches needed so far ...
#RUBY_PATCHES=(
#)

MY_NAME="gitlab-ci"
MY_USER="gitlab_ci"

DEST_DIR="/opt/${MY_NAME}"
CONF_DIR="/etc/${MY_NAME}"
LOGS_DIR="/var/log/${MY_NAME}"
TEMP_DIR="/var/tmp/${MY_NAME}"
RUN_DIR="/run/${MY_NAME}"

# When updating ebuild to newer version, check list of the queues in
# https://gitlab.com/gitlab-org/gitlab-ci/blob/v${PV}/script/background_jobs
SIDEKIQ_QUEUES="runner,common,default"

pkg_setup() {
	enewgroup gitlab_ci
	enewuser gitlab_ci -1 /bin/bash ${DEST_DIR} "gitlab_ci,cron,redis"
}

all_ruby_prepare() {

	# fix paths
	sed -i -E \
		-e "s|redis://redis.example.com:6379|unix:/run/redis/redis.sock|" \
		config/resque.yml.example || die "failed to filter resque.yml.example"
	sed -i -E \
		-e "s|/home/gitlab_ci/gitlab-ci/tmp/(pids\|sockets)|${RUN_DIR}|" \
		-e "s|/home/gitlab_ci/gitlab-ci/log|${LOGS_DIR}|" \
		-e "s|/home/gitlab_ci/gitlab-ci|${DEST_DIR}|" \
		config/unicorn.rb.example || die "failed to filter unicorn.rb.example"
	
	sed -i \
		-e "s|/home/gitlab_ci/gitlab-ci/tmp/sockets|${RUN_DIR}|" \
		-e "s|/home/gitlab_ci/gitlab-ci/public|${DEST_DIR}/public|" \
		lib/support/nginx/gitlab_ci || die "failed to filter nginx/gitlab_ci"
	
	# modify default database settings for PostgreSQL
	sed -i -E \
		-e 's|(username:).*|\1 gitlab|' \
		-e 's|(password:).*|\1 gitlab|' \
		-e 's|(socket:).*|/run/postgresql/.s.PGSQL.5432|' \
		config/database.yml.postgresql \
		|| die "failed to filter database.yml.postgresql"
	# modify default database settings for MySQL
	sed -i -E \
		-e "s|/tmp/mysql.sock|/run/mysqld/mysqld.sock|" \
		config/database.yml.mysql || die "failed to filter database.yml.mysql"

	# rename config files
	mv config/application.yml.example config/application.yml
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
	rm -r lib/support/init.d
}

all_ruby_install() {
	local dest=${DEST_DIR}
	local conf=${CONF_DIR}
	local logs=${LOGS_DIR}
	local temp=${TEMP_DIR}
	local runs=${RUN_DIR}

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
	local flag; for flag in mysql postgres; do
		without+="$(use $flag || echo ' '$flag)"
	done
	local bundle_args="--deployment ${without:+--without ${without}}"

	einfo "Running bundle install ${bundle_args} ..."
	${RUBY} /usr/bin/bundle install ${bundle_args} || die "bundler failed"

	# clean gems cache
	rm -Rf vendor/bundle/ruby/*/cache

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${dest} ${temp} ${logs}
	fowners ${MY_USER}:${MY_USER} ${conf}/database.yml
	fperms 640 ${conf}/database.yml

	## RC script ##

	local rcscript=gitlab-ci-unicorn.init

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|" \
		-e "s|@GITLAB_CI_BASE@|${dest}|" \
		-e "s|@LOGS_DIR@|${logs}|" \
		-e "s|@RUN_DIR@|${runs}|" \
		-e "s|@QUEUES@|${SIDEKIQ_QUEUES}|" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${MY_NAME}"
}

pkg_postinst() {
	elog
	elog "1. Configure your GitLab CI's settings in ${CONF_DIR}/application.yml."
	elog
	elog "2. Configure your database settings in ${CONF_DIR}/database.yml"
	elog "   for \"production\" environment."
	elog
	elog "3. Adjust the webserver settings in ${CONF_DIR}/unicorn.rb"
	elog
	elog "4. Then you should create a database for your GitLab CI instance, if you"
	elog "haven't done so already."
	elog
	if use postgres; then
        elog "If you have local PostgreSQL running, just copy&run:"
        elog "      su postgres"
        elog "      psql -c \"CREATE ROLE gitlab_ci PASSWORD 'gitlab_ci' \\"
        elog "          NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;\""
        elog "      createdb -E UTF-8 -O gitlab_ci gitlab_ci_production"
		elog "  Note: You should change your password to something more random..."
		elog
	fi
	elog "4. Finally execute the following command to initlize environment:"
	elog "       emerge --config \"=${CATEGORY}/${PF}\""
	elog "   Note: Do not forget to start Redis server first!"
	elog
	elog "If this is an update from previous version, it's HIGHLY recommended"
	elog "to backup your database before running the config phase!"
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
