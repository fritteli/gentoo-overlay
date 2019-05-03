# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils

DESCRIPTION="A Linux interface to the Garmin Forerunner GPS units"
HOMEPAGE="https://github.com/fritteli/garmintools"
SRC_URI="https://github.com/fritteli/${PN}/archive/v${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
RESTRICT="mirror"
KEYWORDS="amd64 ~x86"

IUSE="usb"

RDEPEND="usb? ( virtual/libusb:1 )"

DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/"${PF}"-add-xml-root.patch )

src_configure() {
	local myconf="";
	econf ${myconf}
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
}
