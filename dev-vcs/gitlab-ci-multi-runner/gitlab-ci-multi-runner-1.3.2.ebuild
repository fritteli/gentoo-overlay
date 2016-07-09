# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils user

DESCRIPTION="GitLab CI Multi Runner is the new build processor needed for GitLab CI >= 7.12"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci-multi-runner"
SRC_URI="x86? ( https://${PN}-downloads.s3.amazonaws.com/v${PV}/binaries/${PN}-linux-386 -> ${P}-x86 )
	amd64?    ( https://${PN}-downloads.s3.amazonaws.com/v${PV}/binaries/${PN}-linux-amd64 -> ${P}-amd64 )
	arm?      ( https://${PN}-downloads.s3.amazonaws.com/v${PV}/binaries/${PN}-linux-arm -> ${P}-arm )"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

DEPEND="dev-vcs/git"
RDEPEND="${DEPEND}
	net-libs/nodejs
	virtual/mta"

MY_NAME="${PN}"
MY_USER="gitlab_ci_multi_runner"

DEST_DIR="/opt/${MY_NAME}"
LOGS_DIR="/var/log/${MY_NAME}"
TEMP_DIR="/var/tmp/${MY_NAME}"
RUN_DIR="/run/${MY_NAME}"

pkg_setup() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 /bin/bash ${DEST_DIR} ${MY_USER}
}

src_unpack() {
	local a="$(usev amd64)$(usev arm)$(usev x86)"
	mkdir -p "${S}"
	cp "${DISTDIR}/${P}-${a}" "${S}/${PN}"
}

src_prepare() {
	chmod +x "${S}/${PN}"
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
	doexe "${S}/${PN}"

	disopts -m750
	dodir ${conf}

	dosym ${conf} ${dest}/.gitlab-runner

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${dest} ${conf}

	## RC script ##

	local rcscript="${MY_NAME}.init"

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${MY_NAME}"
	newconfd "${FILESDIR}/${MY_NAME}.conf" "${MY_NAME}"
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
