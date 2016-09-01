# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils mono-env

MY_PV="2.0.1.11-2.0.1.11_experimental_2016-04-08"

DESCRIPTION="A backup client that securely stores encrypted, incremental, compressed backups."
HOMEPAGE="http://www.duplicati.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""

CDEPEND="dev-dotnet/atk-sharp
	dev-dotnet/gdk-sharp
	dev-dotnet/glib-sharp
	dev-dotnet/gtk-sharp"
DEPEND="${CDEPEND}
	>=dev-lang/mono-4.4.0.40"
RDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-fix-Makefile.patch"
)

MY_MAKE_DIR="${S}/Installer/Makefile"

src_prepare() {
	for p in "${PATCHES[@]}" ; do
		epatch "${p}"
	done
}

src_compile() {
	cd "${MY_MAKE_DIR}"
	emake build
}

src_install() {
	cd "${MY_MAKE_DIR}"
	emake package
}
