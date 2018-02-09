# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils golang-build golang-vcs-snapshot user

EGO_PN="gitlab.com/gitlab-org/gitlab-pages/..."

MY_PV="v${PV/_/-}"
MY_GIT_HASH="36f16fd"

DESCRIPTION="Simple HTTP server written in Go made to serve GitLab Pages with CNAMEs and SNI"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-pages"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.bz2?ref=v${PV} -> ${P}.tar.bz2"

KEYWORDS="~amd64 ~x86 ~arm ~arm64"
LICENSE="MIT"
SLOT="0/${PVR}"

DEPEND=">=dev-lang/go-1.8.3"

RESTRICT="test mirror"

MY_USER="gitlab_pages"

pkg_setup() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 -1 -1 ${MY_USER}
}

src_prepare() {
	epatch "${FILESDIR}/0001-fix-Makefile-0.3.2.patch"

	sed -i -E \
		-e "s/@@REVISION@@/${MY_GIT_HASH}/" \
		src/gitlab.com/gitlab-org/${PN}/Makefile

	eapply_user
}

src_compile() {
	emake GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" RELEASE=true -C src/${EGO_PN%/*} all
}

src_install() {
	golang-build_src_install
	dobin bin/*
	dodoc src/${EGO_PN%/*}/README.md src/${EGO_PN%/*}/CHANGELOG

	# rc script
	local rcscript="${PN}-0.3.2.init"

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|g" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${PN}"
	newconfd "${FILESDIR}/${PN}-0.3.2.conf" "${PN}"
}
