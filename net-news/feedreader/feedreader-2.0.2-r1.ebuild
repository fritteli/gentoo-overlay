# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit cmake-utils gnome2 vala

CMAKE_MIN_VERSION="2.6"
VALA_MIN_API_VERSION="0.26"

MY_PN="FeedReader"
MY_PV="${PV}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple News Feed Reader for feeds aggregated by Tiny Tiny RSS or feedly"
HOMEPAGE="https://github.com/jangernert/${MY_PN}"
SRC_URI="https://github.com/jangernert/${MY_PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

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
	net-libs/gnome-online-accounts
	net-libs/libsoup:2.4
	net-libs/rest
	net-libs/webkit-gtk:4
	net-misc/curl
	>=x11-libs/gtk+-3.22:3
	x11-libs/libnotify"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	vala_src_prepare
	eapply_user
}

src_configure() {
	local PREFIX=/usr
	local mycmakeargs=(
		-DWITH_LIBUNITY=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		-DCMAKE_INSTALL_PREFIX="${PREFIX}"
		-DGSETTINGS_LOCALINSTALL=OFF
		-DUSE_WEBKIT_4=ON
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
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
