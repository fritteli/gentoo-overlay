# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsbabel/gpsbabel-1.3.3.ebuild,v 1.3 2007/07/18 02:02:04 cryos Exp $

EAPI="5"

inherit eutils

DESCRIPTION="A Linux interface to the Garmin Forerunner GPS units"

HOMEPAGE="http://code.google.com/p/garmintools/"

SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 amd64"

IUSE="usb"

RDEPEND="usb? ( virtual/libusb:1 )"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/"${PF}"-add-xml-root.patch || die "Unable to apply ${PF}-add-xml-root.patch"
}

#src_unpack(){
#	unpack ${A}
#	cd "${S}"
#	epatch "${FILESDIR}"/${PF}-add-xml-root.patch || die "Unable to apply ${PF}-add-xml-root.patch"
#}

src_configure() {
	local myconf="";
	econf ${myconf}
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	cd "${S}"
	make DESTDIR="${D}" install || die "Install failed"
}

#pkg_postinst(){
#}
