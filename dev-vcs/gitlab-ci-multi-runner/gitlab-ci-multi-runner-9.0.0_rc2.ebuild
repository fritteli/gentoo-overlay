# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils golang-build golang-vcs-snapshot user

EGO_PN="gitlab.com/gitlab-org/gitlab-ci-multi-runner/..."

MY_PV="${PV/_/-}"
MY_PV="v${MY_PV/-rc/-rc.}"
#MY_BRANCH="9-0-stable" 
MY_BRANCH="master"
MY_GIT_HASH="0f9ba5fc"

DESCRIPTION="Official GitLab CI Runner written in Go"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci-multi-runner"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.gz?ref=${MY_PV} -> ${P}.tar.gz
	!docker-build? (
		https://${PN}-downloads.s3.amazonaws.com/${MY_PV}/docker/prebuilt-x86_64.tar.xz -> ${P}-prebuilt-x86_64.tar.xz
		https://${PN}-downloads.s3.amazonaws.com/${MY_PV}/docker/prebuilt-arm.tar.xz -> ${P}-prebuilt-arm.tar.xz
	)"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0/${PVR}"
IUSE="docker-build"

DEPEND=">=dev-go/gox-0.3.1_alpha
	>=dev-go/go-bindata-0_pre20151023
	docker-build? ( >=app-emulation/docker-1.5 )
	!dev-vcs/gitlab-ci-multi-runner-bin"

RESTRICT="test mirror"

MY_USER="gitlab_ci_multi_runner"
MY_HOME_DIR="/opt/gitlab-ci-multi-runner"

pkg_setup() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 /bin/bash ${MY_HOME_DIR} ${MY_USER}
}

src_prepare() {
	if ! use docker-build; then
		mkdir -p src/${EGO_PN%/*}/out/docker || die
		cp "${DISTDIR}"/${P}-prebuilt-x86_64.tar.xz src/${EGO_PN%/*}/out/docker/prebuilt-x86_64.tar.xz || die
		cp "${DISTDIR}"/${P}-prebuilt-arm.tar.xz src/${EGO_PN%/*}/out/docker/prebuilt-arm.tar.xz || die
	else
		einfo "You need to have docker running on your system during build time"
		einfo "$(docker info)"
	fi

	epatch "${FILESDIR}/0001-fix-Makefile-1.11.1.patch"
	local arch="$(usev amd64)$(usev x86)$(usev arm)$(usev arm64)"

	sed -i -E \
		-e "s/@@VERSION@@/${MY_PV}/" \
		-e "s/@@REVISION@@/${MY_GIT_HASH}/" \
		-e "s/@@BRANCH@@/${MY_BRANCH}/" \
		-e "s|@@OSARCH@@|linux/${arch}|" \
		src/gitlab.com/gitlab-org/${PN}/Makefile

	eapply_user
}

src_compile() {
	emake GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" RELEASE=true -C src/${EGO_PN%/*} build
}

src_install() {
	golang-build_src_install
	dobin bin/*
	dodoc src/${EGO_PN%/*}/README.md src/${EGO_PN%/*}/CHANGELOG.md

	# set up dirs
	# here be the builds
	diropts -m755
	dodir ${MY_HOME_DIR}

	# here be my home and my castle
	local conf="/etc/gitlab-runner"
	diropts -m750
	dodir ${conf}

	dosym ${conf} ${MY_HOME_DIR}/.gitlab-runner

	# fix permissions
	fowners -R ${MY_USER}:${MY_USER} ${MY_HOME_DIR} ${conf}

	# rc script
	local rcscript="${PN}.init"

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|" \
		-e "s|@HOME@|${MY_HOME_DIR}|" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${PN}"
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
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
