# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson

DESCRIPTION="Quickly modify screenshots of application windows to put them better in context."
HOMEPAGE="https://github.com/AlexanderVanhee/Gradia"
SRC_URI="https://github.com/AlexanderVanhee/Gradia/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Gradia-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="ocr"

PATCHES="${FILESDIR}/gradia-1.12.0-pygobject-3.50-compat.patch"

DEPEND="
	dev-util/blueprint-compiler
	sys-devel/gettext
	dev-util/desktop-file-utils
	dev-libs/glib
	dev-libs/appstream
	dev-python/pytesseract
"

RDEPEND="
	dev-libs/glib:2
	>=dev-python/pygobject-3.48.0
	gui-libs/gdk-pixbuf-loader-webp
	>=gui-libs/gtk-4.12.0:4
	>=gui-libs/libadwaita-1.5.0:1
	gui-libs/gtksourceview:5
"

IDEPEND="dev-util/desktop-file-utils"

src_configure() {
	local emesonargs=(
		$(meson_use ocr enable-ocr)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
