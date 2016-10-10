# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit games multilib

DESCRIPTION="Point-and-click adventure about robot in steam-punk world"
HOMEPAGE="http://machinarium.net/"

SLOT="0"
LICENSE="all-rights-reserved"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="fetch mirror"
IUSE="+multilib"
ABI="x86"

MY_PN="${PN/ma/Ma}"
SRC_URI="${MY_PN}_full_en.tar.gz"

RDEPEND="
	multilib? (
		app-arch/bzip2[abi_x86_32(-)]
		dev-libs/atk[abi_x86_32]
		dev-libs/expat[abi_x86_32]
		dev-libs/glib:2[abi_x86_32]
		dev-libs/libffi[abi_x86_32]
		dev-libs/nspr[abi_x86_32]
		dev-libs/nss[abi_x86_32]
		media-libs/fontconfig[abi_x86_32]
		media-libs/freetype:2[abi_x86_32]
		media-libs/libpng:0/16[abi_x86_32]
		virtual/opengl[abi_x86_32]
		sys-apps/util-linux[abi_x86_32]
		sys-libs/zlib[abi_x86_32]
		x11-libs/cairo[abi_x86_32]
		x11-libs/gdk-pixbuf[abi_x86_32]
		x11-libs/gtk+:2[abi_x86_32]
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
	)
	!multilib? (
		app-arch/bzip2
		dev-libs/atk
		dev-libs/expat
		dev-libs/glib:2
		dev-libs/libffi
		dev-libs/nspr
		dev-libs/nss
		media-libs/fontconfig
		media-libs/freetype:2
		media-libs/libpng:0/16
		virtual/opengl
		sys-apps/util-linux
		sys-libs/zlib
		x11-libs/cairo
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:2
		x11-libs/libdrm
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXcomposite
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXt
		x11-libs/libXxf86vm
		x11-libs/pango
		x11-libs/pixman
	)
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
