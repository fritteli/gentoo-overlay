# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils user

DESCRIPTION="Maven Repository Manager"
HOMEPAGE="http://nexus.sonatype.org/"
LICENSE="GPL-3"
SUB_VERSION="-01"
SRC_URI="http://download.sonatype.com/nexus/oss/nexus-${PV}${SUB_VERSION}-bundle.tar.gz"
RESTRICT="mirror"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

S="${WORKDIR}"

RDEPEND=">=virtual/jdk-1.6"

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

src_prepare() {
	epatch "${FILESDIR}/nexus-wrapper-${PV}.patch"
}

src_install() {
	insinto ${WEBAPP_DIR}
	doins -r nexus-${PV}${SUB_VERSION}/*

	newinitd "${FILESDIR}/init.sh" nexus

	fowners -R nexus:nexus ${INSTALL_DIR}
	fperms 755 "${INSTALL_DIR}/nexus-oss-webapp/bin/jsw/linux-x86-64/wrapper"
	fperms 755 "${INSTALL_DIR}/nexus-oss-webapp/bin/jsw/linux-x86-32/wrapper"
	fperms 755 "${INSTALL_DIR}/nexus-oss-webapp/bin/nexus"
}
