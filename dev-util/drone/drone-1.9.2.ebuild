# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit systemd

DESCRIPTION="Drone CI - Automate Software Testing and Delivery"
HOMEPAGE="https://drone.io/"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sqlite mysql"

RESTRICT="mirror"
DEPEND=""
RDEPEND="acct-user/drone
	app-emulation/docker
	sqlite? ( dev-db/sqlite:3 )
	mysql? ( dev-db/mysql )
"

S="${WORKDIR}"

src_prepare() {
	sed -e "s/<VERSION>/${PV}/g" "${FILESDIR}/drone.sh" > "${T}/drone.sh"

	eapply_user
}

src_install() {
	exeinto /usr/sbin
	doexe "${T}/drone.sh"

	systemd_dounit "${FILESDIR}/${PN}.service"

	insinto "/etc/drone"
	doins "${FILESDIR}/app.ini"

	fowners drone:drone /etc/drone
	fperms 0700 /etc/drone
	fowners drone:drone /etc/drone/app.ini
	fperms 0600 /etc/drone/app.ini

	keepdir /var/lib/drone
	fowners drone:drone /var/lib/drone
	fperms 0700 /var/lib/drone
}
