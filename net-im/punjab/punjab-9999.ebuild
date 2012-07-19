# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils eutils python git-2
DESCRIPTION="BOSH connection manager for jabber implemented in python"
HOMEPAGE="https://github.com/twonds/punjab"
EGIT_REPO_URI="git://github.com/twonds/punjab"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tls"
DEPEND="net-im/jabber-base"
RDEPEND=">=dev-python/twisted-11.1.0
	tls? ( dev-python/pyopenssl )
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

	newinitd "${FILESDIR}/${PN}-initd" ${PN}
	newconfd "${FILESDIR}/${PN}-confd" ${PN}

}

pkg_postinst() {
	einfo "A sample config file has been installed into /etc/jabber/${PN}.xml."
	einfo "Please adjust the settings as needed."
}
