# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils user

DESCRIPTION="This is the new backend for Git-over-HTTP communication needed for GitLab >= 8.4"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-workhorse"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.bz2?ref=${PV} -> ${P}.tar.bz2"
S="${WORKDIR}/${P}-8a339b468723d371ab408b528c5882481247f75e"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND=">=dev-lang/go-1.5.1
	!dev-vcs/gitlab-git-http-server"

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
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
}
