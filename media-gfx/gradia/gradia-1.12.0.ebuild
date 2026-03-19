# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Quickly modify screenshots of application windows to put them better in context."
HOMEPAGE="https://github.com/AlexanderVanhee/Gradia"
SRC_URI="https://github.com/AlexanderVanhee/Gradia/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Gradia-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="enable-ocr"

DEPEND="
	dev-util/blueprint-compiler
	sys-devel/gettext
	dev-util/desktop-file-utils
	dev-libs/glib
	dev-libs/appstream
"

RDEPEND="
	dev-libs/glib:2
	dev-python/pygobject
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	gui-libs/gtksourceview:5
"

src_configure() {
	local emesonargs=(
		$(meson_use enable-ocr)
	)
	meson_src_configure
}
