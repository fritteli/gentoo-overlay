# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils mono

DESCRIPTION="Duplicati is a backup client that securely stores encrypted, incremental, compressed backups on cloud storage services and remote file servers."
HOMEPAGE="http://www.duplicati.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64"

CDEPEND=""
DEPEND=">=dev-lang/mono-3.12.1"
RDEPEND=""

PATCHES="
	${FILESDIR}/${P}-filenames-casesensitive.patch
"

src_prepare() {
	for p in ${PATCHES} ; do
		epatch "${p}"
	done
}

src_compile() {
	cd ${S}
	xbuild
}

