# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-bin/quake4-bin-1.4.2.ebuild,v 1.2 2007/08/20 17:23:52 wolf31o2 Exp $

inherit eutils versionator games

VER="$(get_version_component_range 1-2)"
REV="$(get_version_component_range 3-3)"
MY_PV="${VER}-full${REV:+.r${REV}}"
MY_BODY="ETQW-client-${MY_PV}.x86"

DESCRIPTION="Enemy Territory"
HOMEPAGE="http://zerowing.idsoftware.com/linux/etqw/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/etqw/${MY_BODY}.run"

#LICENSE="ETQW"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa cdinstall dedicated opengl"

RESTRICT="strip"

UIDEPEND="virtual/opengl
	x86? (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		media-libs/libsdl )
	amd64? (
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )"

RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen !games-server/etqw-ded )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	cdinstall? ( games-fps/etqw-data )
	opengl? ( ${UIDEPEND} )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/etqw
Ddir=${D}/${dir}

#GAMES_CHECK_LICENSE="yes"

QA_TEXTRELS="${dir:1}/pb/pbag.so
	${dir:1}/pb/pbags.so
	${dir:1}/pb/pbcl.so
	${dir:1}/pb/pbcls.so
	${dir:1}/pb/pbsv.so"
QA_EXECSTACK="${dir:1}/etqw.x86
	${dir:1}/etqwded.x86
	${dir:1}/libgcc_s.so.1
	${dir:1}/libjpeg.so.62
	${dir:1}/libstdc++.so.6
	${dir:1}/libCgx86.so"

src_unpack() {
	# There is a warning which changes the exit code and causes "unzip" to not
	# return an exit code of "0", so there's no || die here.  If anybody wants
	# to take the time to look into this and actually fix it, I'm open to
	# suggestions.  Otherwise, this is staying like this.
	unzip -qq ${DISTDIR}/${A}
	mv data/* . || die

}

src_install() {
	insinto "${dir}"
	doins -r pb base || die "doins pb base"

	exeinto "${dir}"
	doexe openurl.sh || die "openurl.sh"
	doexe {etqw.x86,libCgx86.so,*.so.?} \
		|| die "doexe x86 exes/libs"

	insinto "${dir}"/base
	doins base/* || die "doins base"

	if use dedicated ; then
		doexe etqwded.x86 || die "doexe etqwded.x86"
		games_make_wrapper etqw-ded ./etqwded.x86 "${dir}" "${dir}"
	fi

	if use opengl || ! use dedicated ; then
		newicon etqw_icon.png etqw.png || die "doicon"
		games_make_wrapper etqw "./etqw.x86" "${dir}" "${dir}"
		make_desktop_entry etqw "Enemy Territory: Quake Wars" etqw.png
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall
	then
		elog "You need to copy pak00*.pk4, zpak_english000.pk4 and the megatextures"
		elog "directory from either your installation media or your hard drive"
		elog "to ${dir}/base before running the game."
		echo
	fi

	if use opengl || !use dedicated ; then
		elog "To play the game, run: etqw"
		echo
	fi
}

