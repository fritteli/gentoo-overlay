# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils python-r1 git-r3
DESCRIPTION="BOSH connection manager for jabber implemented in python"
HOMEPAGE="https://github.com/twonds/punjab"
EGIT_REPO_URI="git://github.com/twonds/punjab"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tls"
DEPEND="${PYTHON_DEPS}
	net-im/jabber-base"
RDEPEND="${PYTHON_DEPS}
	>=dev-python/twisted-core-11.1.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-names-11.1.0[${PYTHON_USEDEP}]
	tls? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )
	${DEPEND}"

#pkg_setup() {
#	python_pkg_setup
#}

src_compile() {
	# nothing to be done here?
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install

	insinto /etc/jabber
	newins punjab.tac ${PN}.tac
	fperms 600 /etc/jabber/${PN}.tac
	fowners jabber:jabber /etc/jabber/${PN}.tac
#	dosed \
#		"s:<spool>[^\<]*</spool>:<spool>/var/spool/jabber</spool>:" \
#		/etc/jabber/${PN}.xml

	newinitd "${FILESDIR}/${PN}-initd" ${PN}
#	newconfd "${FILESDIR}/${PN}-confd" ${PN}

}

pkg_postinst() {
	einfo "A sample config file has been installed into /etc/jabber/${PN}.tac."
	einfo "Please adjust the settings as needed."
}
