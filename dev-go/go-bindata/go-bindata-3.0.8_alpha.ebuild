# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils golang-build golang-vcs-snapshot

MY_PV="v${PV/_/-}"

EGO_PN="github.com/fritteli/${PN}/..."
EGIT_COMMIT="a0ff2567cfb70903282db057e799fd826784d41d"
ARCHIVE_URI="https://${EGO_PN%/*}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="A small utility which generates Go code from any file"
HOMEPAGE="https://github.com/fritteli/${PN}"
SRC_URI="${ARCHIVE_URI}"
LICENSE="CC-PD"
SLOT="0/${PVR}"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/0001-github-path.patch"
	eapply_user
}

src_install() {
	golang-build_src_install
	dobin bin/*
}
