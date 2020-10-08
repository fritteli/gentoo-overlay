# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit systemd

DESCRIPTION="Drone CI - Docker Runner"
HOMEPAGE="https://drone.io/"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"
DEPEND=""
RDEPEND="acct-user/drone-runner-docker
	app-emulation/docker
"

S="${WORKDIR}"

src_prepare() {
	sed -e "s/<VERSION>/${PV}/g" "${FILESDIR}/drone-runner-docker.sh" > "${T}/drone-runner-docker.sh"

	eapply_user
}

src_install() {
	exeinto /usr/bin
	doexe "${T}/drone-runner-docker.sh"

	systemd_dounit "${FILESDIR}/${PN}.service"

	insinto "/etc/drone-runner-docker"
	doins "${FILESDIR}/app.ini"

	fowners drone-runner-docker:drone-runner-docker /etc/drone-runner-docker
	fperms 0700 /etc/drone-runner-docker
	fowners drone-runner-docker:drone-runner-docker /etc/drone-runner-docker/app.ini
	fperms 0600 /etc/drone-runner-docker/app.ini
}
