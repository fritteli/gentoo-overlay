# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/deskbar-applet/deskbar-applet-2.18.1.ebuild,v 1.12 2007/10/13 13:24:27 eva Exp $

inherit gnome2 eutils autotools python

DESCRIPTION="An Omnipresent Versatile Search Interface"
HOMEPAGE="http://raphael.slinckx.net/deskbar/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="eds spell"

RDEPEND=">=dev-lang/python-2.4
		 >=x11-libs/gtk+-2.6
		 >=dev-python/pygtk-2.6
		 >=dev-python/gnome-python-2.10
		 >=gnome-base/gnome-desktop-2.10
		 >=dev-python/dbus-python-0.71
		 >=dev-python/gnome-python-desktop-2.14.0
		 >=dev-python/gnome-python-extras-2.14
		 >=gnome-base/gconf-2
		 eds? ( >=gnome-extra/evolution-data-server-1.7.92 )
		 spell? ( >=gnome-extra/gnome-utils-2.16.2 )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/intltool-0.35
		>=sys-devel/autoconf-2.60
		dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable eds evolution) --exec-prefix=/usr"
}

src_unpack() {
	gnome2_src_unpack

	# Fix installing libs into pythondir
	epatch "${FILESDIR}"/${PN}-2.15.3-multilib.patch

	AT_M4DIR="m4" eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	ebeep 5
	ewarn "The dictionary plugin in deskbar-applet uses the dictionary from "
	ewarn "gnome-utils.  If it is not present, the dictionary plugin will "
	ewarn "fail silently."
	epause 5
}
