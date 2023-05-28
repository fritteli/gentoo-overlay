# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="Drone CI - Docker Runner"
HOMEPAGE="https://www.drone.io/ https://github.com/drone-runners/drone-runner-docker"
SRC_URI="https://github.com/drone-runners/drone-runner-docker/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://manuel.friedli.info/gentoo-overlay/${P}-vendor.tar.xz"

LICENSE="|| ( PolyForm-Small-Business-1.0.0 PolyForm-Free-Trial-1.0.0 )"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-group/drone-runner-docker
	acct-user/drone-runner-docker"
	RDEPEND="${DEPEND}
		app-containers/docker"

RESTRICT="mirror"

src_compile() {
	ego build
}

src_install() {
	dobin drone-runner-docker
	dodoc CHANGELOG.md HISTORY.md
	newinitd "${FILESDIR}"/drone-runner-docker.initd drone-runner-docker
	newconfd "${FILESDIR}"/drone-runner-docker.confd drone-runner-docker

	systemd_dounit "${FILESDIR}"/drone-runner-docker.service

	keepdir /var/log/drone-runner-docker /var/lib/drone-runner-docker
	fowners -R ${PN}:${PN} /var/log/drone-runner-docker /var/lib/drone-runner-docker
}
