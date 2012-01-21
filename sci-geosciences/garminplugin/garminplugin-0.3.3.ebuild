# Copyright 2011 Christian Wasserthal
# Distributed under the terms of the GNU General Public License v2

EAPI="2"
inherit eutils

DESCRIPTION="A free replacement for the Garmin browser plugin"
HOMEPAGE="http://www.andreas-diesner.de/garminplugin/"

SRC_URI="http://github.com/adiesner/GarminPlugin/tarball/V${PV} -> ${P}.tar.gz"
MY_S="adiesner-GarminPlugin-f2ebb7f"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="x86 amd64"

RDEPEND="sci-geosciences/garmintools
	sci-geosciences/gpsbabel
	dev-libs/tinyxml[stl]
	dev-libs/libusb"

DEPEND="${RDEPEND}"

#src_unpack(){
#	tar -zxf "${DISTDIR}/${A}" || die "unpack failed"
#}

src_configure() {
	cd "${MY_S}/src" || die "barf"
	econf || die "econf failed"
}

src_compile() {
	cd "${MY_S}/src" || die "barf"
	emake || die "emake failed"
}

src_install() {
	mkdir -p "${D}/usr/lib/nsbrowser/plugins" || die "mkdir failed"
	cp "${MY_S}/src/npGarminPlugin.so" "${D}/usr/lib/nsbrowser/plugins/" || die "cp failed"
}
