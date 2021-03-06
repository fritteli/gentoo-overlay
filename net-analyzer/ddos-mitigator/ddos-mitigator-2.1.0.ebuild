# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )
inherit python-single-r1

DESCRIPTION="Script for blocking IP addresses with many concurrent connections"
HOMEPAGE="https://gittr.ch/linux/ddos-mitigator"
SRC_URI="https://gittr.ch/linux/ddos-mitigator/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/${PN}"

RDEPEND="
	${PYTHON_DEPS}
	app-admin/sudo
	net-analyzer/fail2ban
	sys-apps/coreutils
	sys-apps/grep
	sys-apps/moreutils
	sys-apps/net-tools
	sys-apps/util-linux
"

src_install() {
	dobin ddos-mitigator.sh
	dobin geoip-lookup.py
}
