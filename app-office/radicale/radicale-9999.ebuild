# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS=1

inherit distutils git

MY_P="${PN/r/R}-${PV}"

DESCRIPTION="A simple CalDAV calendar server"
HOMEPAGE="http://www.radicale.org/"
#SRC_URI="http://www.radicale.org/src/${PN}/${MY_P}.tar.gz"
EGIT_REPO_URI="git://gitorious.org/radicale/radicale.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

PDEPEND="dev-vcs/git"

S=${WORKDIR}/${MY_P}

src_unpack() {
	git_src_unpack
}

src_install() {
	distutils_src_install

	# init file
	newinitd "${FILESDIR}"/radicale.init.d radicale || die

	# config file
	insinto /etc/${PN}
	doins config || die
}

pkg_postinst() {
	elog "If you want to use SSL with ${PN}, please check that you have"
	elog "installed >=dev-lang/python-2.6[ssl]."
}
