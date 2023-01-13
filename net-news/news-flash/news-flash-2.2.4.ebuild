# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg-utils

MY_PN="news_flash_gtk"
MY_PV="v.${PV}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Simple News Feed Reader for feeds aggregated by an online RSS reader account."
HOMEPAGE="https://gitlab.com/news-flash/news_flash_gtk"
SRC_URI="https://gitlab.com/${PN}/${MY_PN}/-/archive/${MY_PV}/${MY_P}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror network-sandbox"

RDEPEND=""

DEPEND="${RDEPEND}
	dev-db/sqlite
	dev-lang/rust
	dev-libs/openssl
	dev-util/meson
	gui-libs/libhandy
	net-libs/webkit-gtk:5
	sys-devel/gettext
	x11-libs/gtk+:3
	x11-misc/xdg-utils"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
