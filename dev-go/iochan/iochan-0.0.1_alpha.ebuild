# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit golang-build golang-vcs-snapshot

EGO_PN="github.com/fritteli/iochan/..."
MY_PV="v${PV/_/-}"
ARCHIVE_URI="https://${EGO_PN%/*}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="A Go library for turning io.Reader into channels"
HOMEPAGE="https://github.com/fritteli/iochan"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0/${PVR}"
IUSE=""
