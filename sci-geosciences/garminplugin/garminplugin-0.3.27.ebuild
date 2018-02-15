# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
inherit eutils

DESCRIPTION="A free replacement for the Garmin browser plugin"
HOMEPAGE="http://www.andreas-diesner.de/garminplugin/"

SRC_URI="https://github.com/adiesner/GarminPlugin/tarball/V${PV} -> ${P}.tar.gz"
MY_S="adiesner-GarminPlugin-c610187"
S="${WORKDIR}/${MY_S}/src"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~x86 ~amd64"

RDEPEND="sci-geosciences/garmintools
	sci-geosciences/gpsbabel
	dev-libs/tinyxml[stl]
	virtual/libusb:0"

DEPEND="${RDEPEND}"

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	mkdir -p "${D}/usr/lib/nsbrowser/plugins" || die "mkdir failed"
	cp "${S}/npGarminPlugin.so" "${D}/usr/lib/nsbrowser/plugins/" || die "cp failed"
}
