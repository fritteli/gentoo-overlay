# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit font

MY_PN="Snowflake-Letters"
MY_P="${MY_PN}"
S="${WORKDIR}"
DESCRIPTION="Snowflake Letters Truetype Font"
HOMEPAGE="http://www.fontstock.net/9746/Snowflake-Letters.html"
SRC_URI="http://www.fontstock.net/font/9746/Snowflake-Letters.zip -> snowflakeletters.zip"
LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch"
IUSE=""

DOCS="fonts101.txt"
FONT_SUFFIX="ttf"
FONT_S="${S}"
DEPEND="app-arch/unzip"
RDEPEND=""

pkg_nofetch() {
	einfo "Please download ${MY_P} from here:"
	einfo "http://www.fontstock.net/9746/Snowflake-Letters.html"
}
