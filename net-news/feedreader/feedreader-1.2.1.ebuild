# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit cmake-utils gnome2 vala

CMAKE_MIN_VERSION="2.6"
VALA_MIN_API_VERSION="0.24"

MY_P="FeedReader"

DESCRIPTION="Simple and modern News Feed Reader for feeds aggregated by Tiny Tiny RSS or feedly"
HOMEPAGE="http://jangernert.github.io/${PN}/"
SRC_URI="https://launchpad.net/${PN}/1.2/${PV}/+download/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+gnome"

RDEPEND=">=x11-libs/gtk+-3.12:3
	app-text/html2text
	$(vala_depend)
	dev-libs/json-glib
	dev-libs/libgee:0.8
	net-libs/libsoup:2.4
	dev-db/sqlite:3
	app-crypt/libsecret
	x11-libs/libnotify
	dev-libs/libxml2
	net-libs/rest:0.7
	net-libs/webkit-gtk:3
	dev-libs/gobject-introspection
	gnome? ( gnome-base/gnome-keyring )"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}-${PV}"

src_prepare() {
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_LIBUNITY=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		-DCMAKE_INSTALL_PREFIX="${PREFIX}"
		-DGSETTINGS_LOCALINSTALL=OFF
	)
#		$(cmake-utils_use_use myUseFlag WEBKIT_4)
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
