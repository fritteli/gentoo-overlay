# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils python-r1
DESCRIPTION="Multi-user chat component for jabber implemented in python"
HOMEPAGE="https://github.com/fritteli/palaver"
SRC_URI="https://github.com/fritteli/palaver/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="${PYTHON_DEPS}
	net-im/jabber-base"
RDEPEND="${PYTHON_DEPS}
	>=dev-python/twisted-core-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-words-0.5[${PYTHON_USEDEP}]
	${DEPEND}"

src_compile() {
	# nothing to be done here?
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install

	insinto /etc/jabber
	newins "${FILESDIR}/"palaver.conf ${PN}.conf
	fperms 600 /etc/jabber/${PN}.conf
	fowners jabber:jabber /etc/jabber/${PN}.conf

	newinitd "${FILESDIR}/${PN}-initd" ${PN}
	newconfd "${FILESDIR}/${PN}-confd" ${PN}
}

pkg_postinst() {
	einfo "A sample config file has been installed into /etc/jabber/${PN}.conf."
	einfo "Please adjust the settings as needed."
}
