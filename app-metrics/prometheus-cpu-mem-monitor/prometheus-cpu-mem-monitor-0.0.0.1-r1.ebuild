# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit systemd

KEYWORDS="~amd64"

DESCRIPTION="CPU and memory monitoring for prometheus"
HOMEPAGE="https://gittr.ch/linux/gentoo-overlay"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="sys-process/procps"

S="${WORKDIR}"

src_install() {
	dobin "${FILESDIR}/${PN}.sh"
	systemd_dounit "${FILESDIR}/${PN}.service"
	systemd_dounit "${FILESDIR}/${PN}.timer"
}
