# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit games multilib

DESCRIPTION="Point-and-click adventure about robot in steam-punk world"
HOMEPAGE="http://machinarium.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="fetch mirror"
IUSE="multilib"

MY_PN="${PN/ma/Ma}"
SRC_URI="${MY_PN}_full_en.tar.gz"

RDEPEND="
	app-arch/bzip2[abi_x86_32]
	dev-libs/atk[abi_x86_32]
	dev-libs/expat[abi_x86_32]
	dev-libs/glib[abi_x86_32]
	dev-libs/libffi[abi_x86_32]
	dev-libs/nspr[abi_x86_32]
	dev-libs/nss[abi_x86_32]
	media-libs/fontconfig[abi_x86_32]
	media-libs/freetype:2[abi_x86_32]
	=media-libs/libpng-1.5*[abi_x86_32]
	virtual/opengl[abi_x86_32]
	sys-apps/util-linux[abi_x86_32]
	sys-libs/zlib[abi_x86_32]
	x11-libs/cairo[abi_x86_32]
	x11-libs/gdk-pixbuf[abi_x86_32]
	x11-libs/gtk+[abi_x86_32]
	x11-libs/libdrm[abi_x86_32]
	x11-libs/libICE[abi_x86_32]
	x11-libs/libSM[abi_x86_32]
	x11-libs/libX11[abi_x86_32]
	x11-libs/libXau[abi_x86_32]
	x11-libs/libxcb[abi_x86_32]
	x11-libs/libXcomposite[abi_x86_32]
	x11-libs/libXcursor[abi_x86_32]
	x11-libs/libXdamage[abi_x86_32]
	x11-libs/libXdmcp[abi_x86_32]
	x11-libs/libXext[abi_x86_32]
	x11-libs/libXfixes[abi_x86_32]
	x11-libs/libXi[abi_x86_32]
	x11-libs/libXinerama[abi_x86_32]
	x11-libs/libXrandr[abi_x86_32]
	x11-libs/libXrender[abi_x86_32]
	x11-libs/libXt[abi_x86_32]
	x11-libs/libXxf86vm[abi_x86_32]
	x11-libs/pango[abi_x86_32]
	x11-libs/pixman[abi_x86_32]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

REQUIRED_USE="amd64? ( multilib )"
pkg_nofetch() {
	ewarn
	ewarn "Place ${A} to ${DISTDIR}"
	ewarn
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"
	doexe "${MY_PN}"
	rm "${MY_PN}"
	doins -r *

	games_make_wrapper "${PN}" "./${MY_PN}" "${dir}"
	doicon "${FILESDIR}/${MY_PN}.png"
	make_desktop_entry "${PN}" "${MY_PN}" "${MY_PN}"

	prepgamesdirs
}
