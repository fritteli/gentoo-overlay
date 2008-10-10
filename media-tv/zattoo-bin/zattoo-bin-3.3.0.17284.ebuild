# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${PN/-bin}-${PV}

DESCRIPTION="live TV via Internet"
HOMEPAGE="http://zattoo.com/"
SRC_URI="http://download.zattoo.com/${MY_P}-i386.tgz"

LICENSE="Zattoo"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-libs/glibc-2.4
	x11-libs/gtkglext
	net-libs/libgssglue
	app-crypt/mit-krb5
	gnome-base/libgnome
	gnome-base/libgnomeui
	media-libs/alsa-lib
	net-dns/libidn
	<net-libs/xulrunner-1.9
	net-www/netscape-flash
	dev-libs/nspr
	dev-libs/openssl
	media-libs/faad2
	net-misc/curl"

RESTRICT="fetch mirror strip"

S=${WORKDIR}/dist

pkg_nofetch() {
	einfo "Due to license reasons download manually http://download.zattoo.com/${MY_P}-i386.tgz to /usr/portage/distfiles"
}

src_install() {
	cp -r "${S}/usr" "${D}"
	
	dosym /usr/lib/xulrunner/libgtkembedmoz.so /usr/lib/zattoo/libgtkembedmoz.so.0d
	dosym /usr/lib/xulrunner/libmozjs.so /usr/lib/zattoo/libmozjs.so.0d
	dosym /usr/lib/nspr/libnspr4.so /usr/lib/zattoo/libnspr4.so.0d
	dosym /usr/lib/nspr/libplc4.so /usr/lib/zattoo/libplc4.so.0d
	dosym /usr/lib/nspr/libplds4.so /usr/lib/zattoo/libplds4.so.0d
	dosym /usr/lib/xulrunner/libxpcom.so /usr/lib/zattoo/libxpcom.so.0d
	dosym /usr/lib/xulrunner/libxul.so /usr/lib/zattoo/libxul.so.0d
	dosym /usr/lib/libcurl.so /usr/lib/zattoo/libcurl.so.3
	dosym /usr/lib/zattoo/libfaad.so.0.0.0 /usr/lib/zattoo/libfaad.so.0
}
