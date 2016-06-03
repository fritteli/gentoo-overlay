# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

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

	newinitd "${FILESDIR}/init.sh" nexus

	fowners -R nexus:nexus ${INSTALL_DIR}
	fperms 755 "${WEBAPP_DIR}/bin/nexus"
}
