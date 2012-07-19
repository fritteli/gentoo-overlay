# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils eutils python git-2
DESCRIPTION="Multi-user chat component for jabber implemented in python"
HOMEPAGE="https://github.com/twonds/palaver"
EGIT_REPO_URI="git://github.com/twonds/palaver"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="net-im/jabber-base"
RDEPEND=">=dev-python/twisted-2.4.0
	>=dev-python/twisted-words-0.5
	${DEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_compile() {
	# nothing to be done here?
	distutils_src_compile
}

src_install() {
	distutils_src_install

	insinto /etc/jabber
	newins example-config.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	dosed \
		"s:<spool>[^\<]*</spool>:<spool>/var/spool/jabber</spool>:" \
		/etc/jabber/${PN}.xml

#	dosed \
#		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
#		/etc/jabber/${PN}.xml

	newinitd "${FILESDIR}/${PN}-initd" ${PN}
#	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}

}

pkg_postinst() {
	einfo "A sample config file has been installed into /etc/jabber/${PN}.xml."
	einfo "Please adjust the settings as needed."
	einfo "After that, you MUST create a TAP-file for twisted in order to start Palaver, like this:"
	einfo "# cd /etc/jabber"
	einfo "# mktap palaver -c palaver.xml"
}
