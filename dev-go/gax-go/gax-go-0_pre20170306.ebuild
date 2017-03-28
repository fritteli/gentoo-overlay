# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit golang-build golang-vcs-snapshot

EGO_PN="github.com/googleapis/gax-go/..."
EGIT_COMMIT="8c5154c0fe5bf18cf649634d4c6df50897a32751"
ARCHIVE_URI="https://${EGO_PN%/*}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm"

DESCRIPTION="Google API Extensions for Go"
HOMEPAGE="https://github.com/googleapis/gax-go"
SRC_URI="${ARCHIVE_URI}"
LICENSE="BSD"
SLOT="0/${PVR}"
IUSE=""
DEPEND="
	dev-go/go-net"

src_install() {
	golang-build_src_install
	dobin bin/*
}
