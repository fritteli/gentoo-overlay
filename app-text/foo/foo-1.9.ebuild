# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-bin/quake4-bin-1.4.2.ebuild,v 1.2 2007/08/20 17:23:52 wolf31o2 Exp $

inherit eutils versionator games

VER="$(get_version_component_range 1-2)"
REV="$(get_version_component_range 3-3)"
MY_PV="${VER}-full.${REV:+r${REV}.}"
MY_BODY="ETQW-client-${MY_PV}x86"

DESCRIPTION="Enemy Territory"
HOMEPAGE="http://zerowing.idsoftware.com/linux/etqw/"
#SRC_URI="ftp://ftp.idsoftware.com/idstuff/etqw/${MY_BODY}.run"

#LICENSE="ETQW"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa cdinstall dedicated opengl"

#RESTRICT="strip"

src_unpack() {
	einfo "MY_PV: ${MY_PV}"
	einfo "MY_BODY: ${MY_BODY}"
}
