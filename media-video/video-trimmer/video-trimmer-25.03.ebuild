# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson

DESCRIPTION="Trim videos quickly"
HOMEPAGE="https://apps.gnome.org/de/app/org.gnome.gitlab.YaLTeR.VideoTrimmer/"
SRC_URI="https://gitlab.gnome.org/YaLTeR/video-trimmer/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror network-sandbox"

RDEPEND="gui-libs/gtk
	gui-libs/libadwaita"

DEPEND="${RDEPEND}
	>=dev-util/blueprint-compiler-0.2.0
	|| ( dev-lang/rust dev-lang/rust-bin )"
