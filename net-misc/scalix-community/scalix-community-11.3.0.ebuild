# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# XXX needed? (e.g. for epatch)
inherit eutils

DESCRIPTION="Scalix (Community Edition) - A replacement for Microsoft Exchange"
HOMEPAGE="http://www.scalix.com/community/"
SRC_URI=""
LICENSE="unknown"
SLOT="0"
KEYWORDS="~x86"
IUSE="installer mobile platform sac sis"
RESTRICT="fetch"
DEPEND=">=dev-lang/python-2.2
>=dev-java/ant-1.6.5"
RDEPEND="${DEPEND}"
#S="${WORKDIR}/${P}"

src_unpack() {
	# unpack the main scalix-TGZ-file
	# depending on USE-flags, unpack individual sub-TGZs
}

src_compile() {
	# depending on USE-flags, change to corresonding sub directories
	# installer: - run ant
	#            - 
}

src_install() {
}
