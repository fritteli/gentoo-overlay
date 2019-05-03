# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Drone CI - Automate Software Testing and Delivery"
HOMEPAGE="https://drone.io/"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sqlite mysql"

RESTRICT="mirror"
DEPEND=""
RDEPEND="app-emulation/docker
	sqlite? ( dev-db/sqlite:3 )
	mysql? ( dev-db/mysql )"

S="${WORKDIR}"

src_install() {
	newconfd "${FILESDIR}"/"${P}.confd" "${PN}"
	newinitd "${FILESDIR}"/"${P}.initd" "${PN}"
}
