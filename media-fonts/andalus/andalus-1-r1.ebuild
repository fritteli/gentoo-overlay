# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit font

MY_PN="andalus"
MY_P="${MY_PN}"
S="${WORKDIR}"
DESCRIPTION="Andalus Truetype Font"
HOMEPAGE="http://fontzone.net/font-download/andalus"
SRC_URI="http://fontzone.net/downloadfile/andalus -> andlso.ttf"
LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${S}"
RDEPEND=""

pkg_nofetch() {
	einfo "Please download ${MY_P} from here:"
	einfo "http://fontzone.net/font-download/andalus"
}
