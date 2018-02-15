# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit golang-build golang-vcs-snapshot eutils

EGO_PN="github.com/fritteli/gox/..."
MY_PV="v${PV/_/-}"
ARCHIVE_URI="https://${EGO_PN%/*}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="A dead simple, no frills Go cross compile tool"
HOMEPAGE="https://github.com/fritteli/gox"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MPL-2.0"
SLOT="0/${PVR}"
IUSE=""

DEPEND="dev-go/iochan"

src_prepare() {
	epatch "${FILESDIR}/0001-github-path.patch"

	eapply_user
}

src_install() {
	mkdir pkg || die
	golang-build_src_install
	dobin bin/*
}
