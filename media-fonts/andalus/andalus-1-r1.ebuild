# Copyright 2011 Manuel Friedli <manuel@fritteli.ch>
# This ebuild is distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit font

MY_PN="andalus"
MY_P="${MY_PN}"
S="${WORKDIR}"
DESCRIPTION="Andalus Truetype Font"
HOMEPAGE="http://fontzone.net/font-download/andalus"
SRC_URI="http://fontzone.net/downloadfile/andalus -> andlso.ttf"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="fetch"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${S}"
RDEPEND=""

pkg_nofetch() {
	einfo "Please download ${MY_P} from here:"
	einfo "http://fontzone.net/font-download/andalus"
}

#src_unpack() {
#	unzip $A
#}
