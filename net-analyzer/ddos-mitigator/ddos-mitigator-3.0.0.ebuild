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
	sys-apps/iproute2
	sys-apps/moreutils
	sys-apps/util-linux
"

src_install() {
	dosbin ddos-mitigator.sh
	dosbin geoip-lookup.py

	insinto /etc
	doins ddos-mitigator.conf
}

pkg_postinst() {
	ewarn "Please note that you will need a GeoIP2 country- or"
	ewarn "city-database in order to use this package."
	elog "It is out of scope for this package to give detailed"
	elog "instructions on how to install such a database. Just"
	elog "google it."
	elog "net-misc/geoipupdate might help, too ..."
}
