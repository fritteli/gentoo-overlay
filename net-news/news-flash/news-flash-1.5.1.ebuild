# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="news_flash_gtk"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="NewsFlash is a program designed to complement an already existing web-based RSS reader account."
HOMEPAGE="https://gitlab.com/news-flash/news_flash_gtk"
SRC_URI="https://gitlab.com/${PN}/${MY_PN}/-/archive/${PV}/${MY_P}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

RDEPEND=""

DEPEND="${RDEPEND}
	dev-db/sqlite
	dev-lang/rust
	dev-libs/openssl
	dev-util/meson
	gui-libs/libhandy
	net-libs/webkit-gtk
	sys-devel/gettext
	x11-libs/gtk+:3
	x11-misc/xdg-utils"

S="${WORKDIR}/${MY_P}"
