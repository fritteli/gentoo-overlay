# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils user

DESCRIPTION="GitLab Git HTTP Server is the new backend for Git-over-HTTP communication needed for GitLab >= 8.0"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-git-http-server"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.bz2?ref=${PV} -> ${P}.tar.bz2"
S="${WORKDIR}/${P}-bf2a3cedd9b631939330d2e54241f95a7b478763"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-lang/go-1.5.1"

src_prepare() {
	epatch "${FILESDIR}/fix-Makefile-${PV}.patch"
}

src_install() {
	local dest=/usr/bin

	diropts -m755
	dodir ${dest}

	exeinto ${dest}
	doexe "${S}/${PN}"

	## RC script ##
	newinitd "${FILESDIR}/gitlab-git-http-server.init" "${PN}"
	newconfd "${FILESDIR}/gitlab-git-http-server.conf" "${PN}"
}
