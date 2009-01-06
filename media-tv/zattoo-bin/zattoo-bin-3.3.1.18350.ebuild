# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="live TV via Internet"
HOMEPAGE="http://zattoo.com/"
SRC_URI="http://download.zattoo.com/${PN/-bin}-${PV}-i386.tgz"

LICENSE="Zattoo"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-crypt/mit-krb5
	dev-libs/nspr
	dev-libs/openssl
	gnome-base/libgnome
	gnome-base/libgnomeui
	media-libs/alsa-lib
	net-dns/libidn
	net-libs/libgssglue
	<net-libs/xulrunner-1.9
	net-misc/curl
	net-www/netscape-flash
	>=sys-libs/glibc-2.4
	x11-libs/gtkglext"

RESTRICT="fetch"

S=${WORKDIR}/dist

QA_EXECSTACK="opt/zattoo/bin/zattood
	opt/zattoo/bin/zattoo_player"

pkg_nofetch() {
	einfo "Due to license reasons download manually ${SRC_URI} to ${DISTDIR}"
}

src_install() {
	echo "LD_LIBRARY_PATH=\"/opt/zattoo/lib\" /opt/zattoo/bin/zattoo_player">zattoo
	dobin zattoo || die
	into /opt/zattoo
	dobin usr/bin/zattoo{d,_player,-uri-handler} || die
	newlib.so usr/lib/zattoo/libfaad.so.0.0.0  libfaad.so.0 || die
	sed -i "s:/usr/bin/zattoo_player:/usr/bin/zattoo:g"  usr/share/applications/zattoo_player.desktop
	domenu usr/share/applications/zattoo_player.desktop

	insinto /usr/share/
	doins -r usr/share/{locale,zattoo_player}

	dosym ../../../usr/lib/xulrunner/libgtkembedmoz.so /opt/zattoo/lib/libgtkembedmoz.so.0d
	dosym ../../../usr/lib/xulrunner/libmozjs.so /opt/zattoo/lib/libmozjs.so.0d
	dosym ../../../usr/lib/nspr/libnspr4.so /opt/zattoo/lib/libnspr4.so.0d
	dosym ../../../usr/lib/nspr/libplc4.so /opt/zattoo/lib/libplc4.so.0d
	dosym ../../../usr/lib/nspr/libplds4.so /opt/zattoo/lib/libplds4.so.0d
	dosym ../../../usr/lib/xulrunner/libxpcom.so /opt/zattoo/lib/libxpcom.so.0d
	dosym ../../../usr/lib/xulrunner/libxul.so /opt/zattoo/lib/libxul.so.0d
	dosym ../../../usr/lib/libcurl.so /opt/zattoo/lib/libcurl.so.3
	elog " "
	elog "just enter zattoo to run the player"
	elog " "
}
