# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

VALA_MIN_API_VERSION="0.50"

MY_PN="FeedReader"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple News Feed Reader for feeds aggregated by Tiny Tiny RSS or feedly"
HOMEPAGE="https://github.com/jangernert/FeedReader"
SRC_URI="https://github.com/jangernert/FeedReader/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

RDEPEND="$(vala_depend)
	app-crypt/libsecret[vala]
	dev-db/sqlite:3
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libgee:0.8
	dev-libs/libpeas
	dev-libs/libxml2
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	>=net-libs/gnome-online-accounts-3.20
	net-libs/libsoup:2.4
	net-libs/rest
	>=net-libs/webkit-gtk-2.20:4
	net-misc/curl
	>=x11-libs/gtk+-3.22:3
	x11-libs/libnotify"

DEPEND="${RDEPEND}
	dev-libs/gumbo
	dev-util/intltool
	dev-util/ninja
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	vala_setup
}

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
