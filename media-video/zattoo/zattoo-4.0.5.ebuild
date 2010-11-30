# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="watch real-time TV on your computer"
HOMEPAGE="http://zattoo.com"
SRC_URI="http://download.zattoo.com/${P}-i386.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/deb2targz"
RDEPEND="www-plugins/adobe-flash[32bit]
	x86? (
		x11-libs/qt-core
		x11-libs/qt-gui
		x11-libs/qt-xmlpatterns
		x11-libs/qt-webkit
	)
	amd64? ( app-emulation/emul-linux-x86-qtlibs )"

QA_PRESTRIPPED="usr/bin/Zattoo"

src_unpack() {
	unpack ${A}
	tar xf data.tar.gz || die
}

src_prepare() {
	sed -i -e 's:Icon=.*:Icon=/usr/share/pixmaps/zattoo.png:' usr/share/applications/zattoo_player.desktop || die
}

src_install() {
	dobin usr/bin/Zattoo || die

	newmenu usr/share/applications/zattoo_player.desktop zattoo.desktop || die
	newicon usr/share/zattoo_player/resources/images/zattoo_icon.png zattoo.png || die
}
