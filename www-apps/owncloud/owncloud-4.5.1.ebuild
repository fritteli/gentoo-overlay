# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/owncloud/owncloud-4.5.0.ebuild,v 1.1 2012/10/10 13:26:07 voyageur Exp $

EAPI=4

inherit webapp depend.php

DESCRIPTION="Web-based storage application where all your data is under your own control"
HOMEPAGE="http://owncloud.org"
SRC_URI="http://owncloud.org/releases/${P}.tar.bz2"
LICENSE="AGPL-3"

KEYWORDS="~amd64 ~x86"
IUSE="+curl mysql postgres +sqlite3"
REQUIRED_USE="|| ( mysql postgres sqlite3 )"

DEPEND=""
RDEPEND="dev-lang/php[curl?,gd,json,mysql?,pdo,postgres?,sqlite3?,xmlwriter,zip]"

need_httpd_cgi
need_php_httpd

S=${WORKDIR}/${PN}

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	local docs="README"
	dodoc ${docs}
	rm -f ${docs}

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	dodir "${MY_HTDOCSDIR}"/data

	webapp_serverowned "${MY_HTDOCSDIR}"/apps
	webapp_serverowned "${MY_HTDOCSDIR}"/data
	webapp_serverowned "${MY_HTDOCSDIR}"/config
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_src_install
}
