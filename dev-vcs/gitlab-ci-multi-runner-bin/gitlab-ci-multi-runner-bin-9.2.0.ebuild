# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils user

MY_PN="gitlab-ci-multi-runner"

DESCRIPTION="Binary version of GitLab CI Multi Runner, the build processor for GitLab 8.14+"
HOMEPAGE="https://gitlab.com/gitlab-org/${MY_PN}"
SRC_URI="x86?     ( https://${MY_PN}-downloads.s3.amazonaws.com/v${PV}/binaries/${MY_PN}-linux-386 -> ${P}-x86 )
	amd64?    ( https://${MY_PN}-downloads.s3.amazonaws.com/v${PV}/binaries/${MY_PN}-linux-amd64 -> ${P}-amd64 )
	arm?      ( https://${MY_PN}-downloads.s3.amazonaws.com/v${PV}/binaries/${MY_PN}-linux-arm -> ${P}-arm )"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

DEPEND="dev-vcs/git
	!dev-vcs/gitlab-ci-multi-runner"
RDEPEND="${DEPEND}
	net-libs/nodejs
	virtual/mta"

MY_USER="gitlab_ci_multi_runner"

DEST_DIR="/opt/${MY_PN}"
LOGS_DIR="/var/log/${MY_PN}"
TEMP_DIR="/var/tmp/${MY_PN}"
RUN_DIR="/run/${MY_PN}"

pkg_setup() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 /bin/bash ${DEST_DIR} ${MY_USER}
}

src_unpack() {
	local a="$(usev amd64)$(usev arm)$(usev x86)"
	mkdir -p "${S}"
	cp "${DISTDIR}/${P}-${a}" "${S}/${MY_PN}"
}

src_prepare() {
	chmod +x "${S}/${MY_PN}"
	eapply_user
}

src_compile() {
	# nothing to compile, binary all-in-one goodness! (?)
	:
}

src_install() {
	local dest=${DEST_DIR}
	local conf="/etc/gitlab-runner"

	diropts -m755
	dodir ${dest}

	exeinto ${dest}
	doexe "${S}/${MY_PN}"

	diropts -m750
	dodir ${conf}

	dosym ${conf} ${dest}/.gitlab-runner

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${dest} ${conf}

	## RC script ##

	local rcscript="${MY_PN}.init"

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${MY_PN}"
	newconfd "${FILESDIR}/${MY_PN}.conf" "${MY_PN}"
}

pkg_postinst() {
	elog
	elog "If this is a fresh install of GitLab CI Multi Runner, please configure it"
	elog "with the following command:"
	elog "        emerge --config \"=${CATEGORY}/${PF}\""
}

pkg_config() {
	einfo "You need to register the runner with your GitLab CI instance. Please"
	einfo "Follow the instructions at"
	einfo
	einfo "https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/linux-manually.md"
	einfo
	einfo "Perhaps I'll improve the ebuild later ... kthxbye."
}
