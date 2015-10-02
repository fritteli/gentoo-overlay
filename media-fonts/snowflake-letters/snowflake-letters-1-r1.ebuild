# Copyright 2008 Manuel Friedli <manuel@fritteli.ch>
# This ebuild is distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

MY_PN="Snowflake-Letters"
MY_P="${MY_PN}"
S="${WORKDIR}"
DESCRIPTION="Snowflake Letters Truetype Font"
HOMEPAGE="http://www.fontstock.net/9746/Snowflake-Letters.html"
SRC_URI="http://www.fontstock.net/font/9746/Snowflake-Letters.zip"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~x86 ~amd64"
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
