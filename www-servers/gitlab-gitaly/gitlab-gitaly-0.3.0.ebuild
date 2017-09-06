# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils golang-build golang-vcs-snapshot user

EGO_PN="gitlab.com/gitlab-org/gitlab-pages/..."

MY_PN="gitaly"
MY_PV="v${PV/_/-}"
MY_GIT_HASH="fdcb2c9"

DESCRIPTION="Stop relying on NFS for horizontal scaling. Speed up Git access using caching."
HOMEPAGE="https://gitlab.com/gitlab-org/gitaly"
SRC_URI="https://gitlab.com/gitlab-org/${MY_PN}/repository/archive.tar.bz2?ref=v${PV} -> ${P}.tar.bz2"

KEYWORDS="~amd64 ~x86 ~arm ~arm64"
LICENSE="MIT"
SLOT="0/${PVR}"

DEPEND=">=dev-lang/go-1.5"

RESTRICT="test mirror"

pkg_setup() {
	eerror "This ebuild is but a dummy placeholder. Gitaly is not yet supported."
	die "Gitaly is not yet supported."
}
