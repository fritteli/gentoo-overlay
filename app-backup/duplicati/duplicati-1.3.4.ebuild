# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils mono-env

DESCRIPTION="A backup client that securely stores encrypted, incremental, compressed backups."
HOMEPAGE="http://www.duplicati.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

CDEPEND=""
DEPEND=">=dev-lang/mono-4.4.0.40"
RDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-filenames-casesensitive.patch"
	"${FILESDIR}/${P}-remove-unsigned-backends.patch"
	"${FILESDIR}/${P}-patch-Makefile.patch"
)

MY_MAKE_DIR="${S}/Installer/Makefile"

src_compile() {
	cd "${MY_MAKE_DIR}"
	emake translations
}

src_install() {
	cd "${MY_MAKE_DIR}"
	emake package
}
