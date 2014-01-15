# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils

# Maintainer notes:
# - This ebuild supports only "standalone mode". If you want to use JBoss AS in
#   "domain mode", please fix this ebuild yourself and send me a pull request.

DESCRIPTION="JBoss Application Server ${PV} (standalone only)" 

MY_P="jboss-as-${PV}.Final"
SLOT="7.1"
SRC_URI="http://download.jboss.org/jbossas/${SLOT}/jboss-as-${PV}.Final/jboss-as-${PV}.Final.tar.gz"
HOMEPAGE="http://www.jboss.org/jbossas/"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"

IUSE="+doc"

RDEPEND=">=virtual/jdk-1.6"
DEPEND="sys-apps/sed ${RDEPEND}"

S="${WORKDIR}/${MY_P}"
JBOSS_NAME="jboss-as-${SLOT}"
INSTALL_DIR="/opt/${JBOSS_NAME}"
SERVER_CONFIG_DIR="/etc/${JBOSS_NAME}"
SERVER_BASE_DIR="/var/lib/${JBOSS_NAME}"
SERVER_LOG_DIR="/var/log/${JBOSS_NAME}"
SERVER_TEMP_DIR="/var/tmp/${JBOSS_NAME}"


pkg_setup() {
	enewgroup jboss 260 || die "Unable to create jboss group"
	enewuser jboss 260 /bin/sh ${INSTALL_DIR} jboss \
		|| die	"Unable to create jboss user"
}

src_install() {
	# create dir structure

	diropts -m755
	dodir "${INSTALL_DIR}"

	diropts -m755 -o jboss -g jboss
	dodir "${SERVER_CONFIG_DIR}/"

	diropts -m750 -o jboss -g jboss
	dodir "${SERVER_BASE_DIR}"
	keepdir "${SERVER_BASE_DIR}/lib"
	keepdir "${SERVER_BASE_DIR}/deployments"
	keepdir	"${SERVER_LOG_DIR}"
	keepdir "${SERVER_TEMP_DIR}"

	# copy files

	insopts -m644
	diropts -m755

	insinto "${INSTALL_DIR}/bin"
	doins bin/appclient.conf bin/jboss-cli.xml

	# remove unused files
	rm -f bin/domain.sh bin/run.sh

	exeinto "${INSTALL_DIR}/bin"
	doexe bin/*.sh

	insinto "${INSTALL_DIR}"
	doins -r appclient bundles welcome-content jboss-modules.jar *.txt
	einfo "This may take a few minutes..."
	doins -r modules

	if use doc; then
		docinto "examples"
		dodoc docs/examples/configs/*
		docinto "schema"
		dodoc docs/schema/*
	fi

	diropts -m750 -o jboss -g jboss
	insopts -m640 -o jboss -g jboss

	insinto "${SERVER_CONFIG_DIR}"
	doins -r standalone/configuration/*

	insinto "${SERVER_BASE_DIR}/deployments"
	doins -r standalone/deployments/*

	# some utilities doesn't work with non-default paths...
	dosym "${SERVER_BASE_DIR}" "${INSTALL_DIR}/standalone"
	dosym "${SERVER_CONFIG_DIR}" "${SERVER_BASE_DIR}/configuration"
	dosym "${SERVER_LOG_DIR}" "${SERVER_BASE_DIR}/log"
	dosym "${SERVER_TEMP_DIR}" "${SERVER_BASE_DIR}/tmp"

	# filter and copy init.d, conf.d

	for FILE in "${FILESDIR}"/jboss-as.*; do
		cp "${FILE}" "${T}"
		tfile="${T}"/`basename ${FILE}`
		sed -i -e "s:__JBOSS_NAME__:${JBOSS_NAME}:g" $tfile || die "sed failed"
		sed -i -e "s:__JBOSS_VER__:${SLOT}:g" $tfile || die "sed failed"
	done

	newinitd "${T}/jboss-as.init" ${JBOSS_NAME}
	newconfd "${T}/jboss-as.conf" ${JBOSS_NAME}
}

pkg_postinst() {
	ewarn "This ebuild supports only \"standalone mode\". If you want to use"
	ewarn "JBoss AS in \"domain mode\", please fix this ebuild yourself and send" 
	ewarn "me a pull request."
}
