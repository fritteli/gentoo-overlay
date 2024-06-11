# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="CPU and memory monitoring for prometheus"
HOMEPAGE="https://gittr.ch/linux/gentoo-overlay"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-process/procps"

src_install() {
	dobin "${FILESDIR}/${PN}.sh"
	systemd_dounit "${FILESDIR}/${PN}.service"
	systemd_dounit "${FILESDIR}/${PN}.timer"
}
