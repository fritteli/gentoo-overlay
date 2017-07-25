# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

EGIT_REPO_URI="https://gitlab.com/gitlab-org/gitaly.git"
EGIT_COMMIT="v${PV}"

inherit eutils git-2 user

DESCRIPTION="Gitaly is a Git RPC service for handling all the git calls made by GitLab."
HOMEPAGE="https://gitlab.com/gitlab-org/gitaly"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

DEPEND=">=dev-lang/go-1.8.3"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/0001-${PN}-0.23.0-fix-Makefile.patch"
	epatch "${FILESDIR}/0002-${PN}-0.11.2-fix-config.toml.example.patch"
}

src_install() {
	# TODO fowners, fperms on config.toml.example
	insinto "/etc/gitlab"
	newins "config.toml.example" "gitaly-config.toml"
	newconfd "${FILESDIR}/${PN}-0.11.2.conf" "gitlab-gitaly"
	newinitd "${FILESDIR}/${PN}-0.11.2.init" "gitlab-gitaly"
	into "/usr"
	newbin "gitaly" "gitlab-gitaly"
}
