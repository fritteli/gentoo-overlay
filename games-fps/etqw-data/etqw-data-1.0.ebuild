# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-bin/quake4-bin-1.4.2.ebuild,v 1.2 2007/08/20 17:23:52 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Enemy Territory: Quake Wars Data Files"
HOMEPAGE="http://zerowing.idsoftware.com/linux/etqw/"
SRC_URI=""

#LICENSE="ETQW"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT=""
IUSE="videos"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/etqw
Ddir=${D}/${dir}

#GAMES_CHECK_LICENSE="yes"

pkg_setup() {
	export CDROM_NAME_SET=("Existing Install" "Quake Wars CD")
	cdrom_get_cds pak004.pk4:Setup/Data/base/zpak_english000.pk4

	if [[ $CDROM_SET -ne 0 && $CDROM_SET -ne 1 ]] ; then
		die "Error locating data files.";
	fi
}

src_install() {
	insinto "${dir}"/base

	if [[ $CDROM_SET -eq 1 ]] ; then
		ZPATH=${CDROM_ROOT}/Setup/Data/base/
	else
		ZPATH=${CDROM_ROOT}/
	fi

	for i in zpak_english000.pk4 pak00*.pk4 megatextures
	do
		einfo "Copying ${i}..."
		doins ${ZPATH}/${i} || die "unable to find/copy ${i}."
	done

	if use videos ; then
		einfo "Copying video..."
		doins -r ${ZPATH}/video || die "unable to find/copy video file."
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}

