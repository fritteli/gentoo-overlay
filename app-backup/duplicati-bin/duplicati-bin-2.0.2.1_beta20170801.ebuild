# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils rpm

MY_PN="duplicati"
MY_PV="2.0.2.1"
MY_BUILDTYPE="beta"
MY_BUILDDATE="2017-08-01"

MY_BASE_PV="${MY_PV}-${MY_PV}_${MY_BUILDTYPE}"

MY_PV_1="v${MY_BASE_PV}_${MY_BUILDDATE}"
MY_PV_2="${MY_PN}-${MY_BASE_PV}_${MY_BUILDDATE//-/}"

DESCRIPTION="A backup client that securely stores encrypted, incremental, compressed backups."
HOMEPAGE="http://www.duplicati.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/${MY_PV_1}/${MY_PV_2}.noarch.rpm -> ${P}.rpm"

RDEPEND="!app-backup/duplicati"

S="${WORKDIR}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""

src_install() {
	cp -R "${S}/usr/" "${D}/" || die "install failed"
}
