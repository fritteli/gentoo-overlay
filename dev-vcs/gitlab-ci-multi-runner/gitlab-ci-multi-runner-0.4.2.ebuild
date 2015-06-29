# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

#USE_RUBY="ruby19 ruby20 ruby21"
#PYTHON_DEPEND="2:2.7"

#inherit eutils python ruby-ng user
inherit eutils user

DESCRIPTION="GitLab CI Multi Runner is the new build processor needed for GitLab CI >= 7.12"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci-multi-runner"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.gz?ref=${PV} -> ${P}.tar.gz"
#"x86?   ( https://${PN}-downloads.s3.amazonaws.com/${PV}/binaries/${PN}-linux-386 -> ${PN}-x86 )
#         amd64? ( https://${PN}-downloads.s3.amazonaws.com/${PV}/binaries/${PN}-linux-amd64 -> ${PN}-amd64 )
#         arm?   ( https://${PN}-downloads.s3.amazonaws.com/${PV}/binaries/${PN}-linux-arm -> ${PN}-arm )"

RESTRICT="mirror"

REQUIRED_USE="^^ ( x86 amd64 arm )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amd64 arm x86"

DEPEND="dev-vcs/git"
CDEPEND="dev-lang/go"
RDEPEND="${DEPEND}
	virtual/mta"

MY_NAME="${PN}"
MY_USER="gitlab_ci_runner"

DEST_DIR="/opt/${MY_NAME}"
LOGS_DIR="/var/log/${MY_NAME}"
TEMP_DIR="/var/tmp/${MY_NAME}"
RUN_DIR="/run/${MY_NAME}"

S="${WORKDIR}/${PN}.git"

pkg_setup() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 /bin/bash ${DEST_DIR} ${MY_USER}
	export GOPATH="${WORKDIR}"
}

#src_unpack() {
#    local a="$(usev amd64)$(usev arm)$(usev x86)"
#    mkdir -p "${S}"
#    cp "${DISTDIR}/${PN}-${a}" "${S}/${PN}"
#}

src_prepare() {
	git init
}

src_compile() {
	emake deps build || die "Failed to make deps build"
}

src_install() {
	local dest=${DEST_DIR}
#	local logs=${LOGS_DIR}
#	local temp=${TEMP_DIR}
#	local runs=${RUN_DIR}

	# prepare directories
#	diropts -m750
#	dodir ${logs} ${temp}

	diropts -m755
	dodir ${dest}

#	dosym ${temp} ${dest}/tmp
#	dosym ${logs} ${dest}/log

	# install the files using cp 'cause doins is slow
	cp -Rl "${S}/"* "${D}/${dest}/"

	# install logrotate config
#	dodir /etc/logrotate.d
#	cat > "${D}/etc/logrotate.d/${MY_NAME}" <<-EOF
#		${logs}/*.log {
#		    missingok
#		    delaycompress
#		    compress
#		    copytruncate
#		}
#	EOF

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${dest}
#	fowners -R ${MY_USER}:${MY_USER} ${dest} ${temp} ${logs}

	## RC script and conf.d file ##

	local rcscript=gitlab-ci-multi-runner.init
	local rcconf=gitlab-ci-multi-runner.conf

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|" \
		-e "s|@GITLAB_CI_MULTI_RUNNER_BASE@|${dest}|" \
		-e "s|@LOGS_DIR@|${logs}|" \
		-e "s|@RUN_DIR@|${runs}|" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${MY_NAME}"
	newconfd "${FILESDIR}/${rcconf}" "${MY_NAME}"
}

pkg_postinst() {
	elog
	elog "If this is a fresh install of GitLab CI Multi Runner, please configure it"
	elog "with the following command:"
	elog "        emerge --config \"=${CATEGORY}/${PF}\""
}

pkg_config() {
	einfo "You need to register the runner with your GitLab CI instance. Please"
	einfo "Follow the instructions on"
	einfo
	einfo "https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/linux-manually.md"
	einfo
	einfo "Perhaps I'll improve the ebuild later ... kthxbye."
}
