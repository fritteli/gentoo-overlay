# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pyicq-t/pyicq-t-0.8.1.5.ebuild,v 1.2 2009/10/03 17:30:43 maekke Exp $

NEED_PYTHON=2.6

inherit eutils multilib python

MY_P="${P/pyicq-t/pyicqt}"

DESCRIPTION="Python based jabber transport for ICQ"
HOMEPAGE="http://code.google.com/p/pyicqt/"
SRC_URI="http://pyicqt.googlecode.com/files/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="webinterface"

DEPEND="net-im/jabber-base"
RDEPEND="${DEPEND}
	>=dev-python/twisted-9.0.0
	>=dev-python/twisted-words-9.0.0
	>=dev-python/twisted-web-9.0.0
	webinterface? ( >=dev-python/nevow-0.4.1 )
	>=dev-python/imaging-1.1"

src_unpack() {
	epatch "${FILESDIR}/${P}-hashlib.patch"
}

src_install() {
	local inspath

	python_version
	inspath=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	insinto ${inspath}
	doins -r data src tools
	newins PyICQt.py ${PN}.py

	insinto /etc/jabber
	newins config_example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	dosed \
		"s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber</spooldir>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		/etc/jabber/${PN}.xml

	newinitd "${FILESDIR}/${P}-initd" ${PN}
	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}

	elog "A sample configuration file has been installed in /etc/jabber/${PN}.xml."
	elog "Please edit it and the configuration of your Jabber server to match."

	ewarn "If you are storing user accounts in MySQL and are upgrading from a "
	ewarn "version older than 0.8.1, then you will need to run the following "
	ewarn "command to create some new tables:"
	ewarn "	 mysql -u user_name -p pyicqt < /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/tools/db-setup.mysql"

	elog  "These instructions along with a list of new config variables are "
	elog  "available at: http://code.google.com/p/pyicqt/wiki/Upgrade"
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/${PN}
}
