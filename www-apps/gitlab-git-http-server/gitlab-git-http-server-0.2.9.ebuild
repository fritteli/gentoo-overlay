# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils user

DESCRIPTION="GitLab Git HTTP Server is the new backend for Git-over-HTTP communication needed for GitLab >= 8.0"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-git-http-server"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.bz2?ref=${PV} -> ${P}.tar.bz2"
S="${WORKDIR}/${P}-ffd46d3adeb1ebaf88eaedf4d4845834cfe8b385"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND=">=dev-lang/go-1.5"

MY_USER="gitlab_git_http_server"

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

pkg_postinst() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 -1 -1 ${MY_USER}
}
