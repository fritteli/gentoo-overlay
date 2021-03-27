# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit font

MY_PN="andalus"
MY_P="${MY_PN}"
S="${WORKDIR}"
DESCRIPTION="Andalus Truetype Font"
HOMEPAGE="https://fontzone.net/font-download/andalus"
SRC_URI="https://fontzone.net/downloadfile/andalus -> andlso.ttf"
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
	einfo "https://fontzone.net/font-download/andalus"
	einfo "and save it as '/usr/portage/distfiles/andlso.ttf'."
}
