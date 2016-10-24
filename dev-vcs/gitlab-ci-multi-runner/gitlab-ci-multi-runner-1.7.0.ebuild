# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils golang-build golang-vcs-snapshot

EGO_PN="gitlab.com/gitlab-org/gitlab-ci-multi-runner/..."

MY_PV="v${PV/_/-}"
MY_BRANCH="1-7-stable"
MY_GIT_HASH="c66b00d"

DESCRIPTION="Official GitLab CI Runner written in Go"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci-multi-runner"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.gz?ref=v${PV} -> ${P}.tar.gz
	!docker-build? (
		https://${PN}-downloads.s3.amazonaws.com/${MY_PV}/docker/prebuilt-x86_64.tar.xz -> ${P}-prebuilt-x86_64.tar.xz
		https://${PN}-downloads.s3.amazonaws.com/${MY_PV}/docker/prebuilt-arm.tar.xz -> ${P}-prebuilt-arm.tar.xz
	)"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0/${PVR}"
IUSE="docker-build"

DEPEND=">=dev-go/gox-0.3.1_alpha
	>=dev-go/go-bindata-3.0.8_alpha
	docker-build? ( >=app-emulation/docker-1.5 )
	!dev-vcs/gitlab-ci-multi-runner-bin"

RESTRICT="test"

src_prepare() {
	if ! use docker-build; then
		mkdir -p src/${EGO_PN%/*}/out/docker || die
		cp "${DISTDIR}"/${P}-prebuilt-x86_64.tar.xz src/${EGO_PN%/*}/out/docker/prebuilt-x86_64.tar.xz || die
		cp "${DISTDIR}"/${P}-prebuilt-arm.tar.xz src/${EGO_PN%/*}/out/docker/prebuilt-arm.tar.xz || die
	else
		einfo "You need to have docker running on your system during build time"
		einfo "$(docker info)"
	fi

	epatch "${FILESDIR}/0001-fix-Makefile.patch"
	local arch="$(usev amd64)$(usev x86)$(usev arm)$(usev arm64)"

	sed -i -E \
		-e "s/@@VERSION@@/v${PV/_/-}/" \
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
}
