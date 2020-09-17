# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Script for blocking IP addresses with many concurrent connections"
HOMEPAGE="https://gittr.ch/linux/ddos-mitigator"
SRC_URI="https://gittr.ch/linux/ddos-mitigator/archive/v${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}"

RDEPEND="
	app-admin/sudo
	dev-lang/python:3.8
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
