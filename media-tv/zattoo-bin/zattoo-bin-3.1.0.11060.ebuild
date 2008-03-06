# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${PN/-bin}-${PV}

DESCRIPTION="live TV via Internet"
HOMEPAGE="http://zattoo.com/"
SRC_URI="http://download.zattoo.com/${MY_P}-i386.tgz"

LICENSE="Zattoo"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

#NOTE: As there is no real documentation, I don't know
#      exactly what dependancies are needed.
#      These are just the ones I came across:
DEPEND=""
RDEPEND=">=sys-libs/glibc-2.4
	x11-libs/gtkglext
	net-libs/libgssglue
	app-crypt/mit-krb5
	gnome-base/libgnome
	gnome-base/libgnomeui
	media-libs/alsa-lib
	net-dns/libidn
	net-libs/xulrunner
	net-www/netscape-flash
	dev-libs/nspr
	dev-libs/openssl"

RESTRICT="fetch mirror strip"
QA_TEXTRELS="usr/lib/zattoo/*"

S=${WORKDIR}/dist

src_install() {
	dobin usr/bin/zattoo_player usr/bin/zattood
	insinto /usr/lib/zattoo
	doins usr/lib/zattoo/*
	insinto /usr/share/zattoo_player
	doins -r usr/share/zattoo_player/*
	domenu usr/share/applications/zattoo_player.desktop

	dosym /usr/lib/xulrunner/libgtkembedmoz.so /usr/lib/zattoo/libgtkembedmoz.so.0d
	dosym /usr/lib/xulrunner/libmozjs.so /usr/lib/zattoo/libmozjs.so.0d
	dosym /usr/lib/nspr/libnspr4.so /usr/lib/zattoo/libnspr4.so.0d
	dosym /usr/lib/nspr/libplc4.so /usr/lib/zattoo/libplc4.so.0d
	dosym /usr/lib/nspr/libplds4.so /usr/lib/zattoo/libplds4.so.0d
	dosym /usr/lib/xulrunner/libxpcom.so /usr/lib/zattoo/libxpcom.so.0d
	dosym /usr/lib/xulrunner/libxul.so /usr/lib/zattoo/libxul.so.0d

	dosym /opt/netscape/plugins/flashplayer.xpt /usr/lib/zattoo/flashplayer.xpt
	dosym /opt/netscape/plugins/libflashplayer.so /usr/lib/zattoo/libflashplayer.so
}
