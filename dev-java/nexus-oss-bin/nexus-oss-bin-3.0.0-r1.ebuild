# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils user

DESCRIPTION="Maven Repository Manager"
HOMEPAGE="http://nexus.sonatype.org/"
LICENSE="GPL-3"
MAJOR_VERSION="3"
SUB_VERSION="-03"
SRC_URI="http://download.sonatype.com/nexus/${MAJOR_VERSION}/nexus-${PV}${SUB_VERSION}-unix.tar.gz"
RESTRICT="mirror"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

S="${WORKDIR}"

RDEPEND=">=virtual/jdk-1.8"

INSTALL_DIR="/opt/nexus"

WEBAPP_DIR="${INSTALL_DIR}/nexus-oss-webapp"

pkg_setup() {
	enewgroup nexus
	enewuser nexus -1 /bin/bash /opt/nexus "nexus"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	insinto ${WEBAPP_DIR}
	doins -r nexus-${PV}${SUB_VERSION}/*
	doins -r nexus-${PV}${SUB_VERSION}/.install4j

	newinitd "${FILESDIR}/init.sh" nexus

	fowners -R nexus:nexus ${INSTALL_DIR}
	fperms 755 "${WEBAPP_DIR}/bin/nexus"

	# protect config files on upgrade
	echo "CONFIG_PROTECT=\"${WEBAPP_DIR}/bin ${WEBAPP_DIR}/etc\"" > "${T}/25nexus" || die
	doenvd "${T}/25nexus"
}
