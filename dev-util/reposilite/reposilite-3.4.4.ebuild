# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Reposilite - Simple Maven Repository hosting"
HOMEPAGE="https://reposilite.com/"
SRC_URI="https://maven.reposilite.com/releases/com/reposilite/reposilite/${PV}/reposilite-${PV}-all.jar -> reposilite-${PV}.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"
DEPEND=""
RDEPEND=">=acct-user/reposilite-1
	|| ( >=virtual/jdk-11 >=virtual/jre-11 )
"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${A}" "${WORKDIR}"
}

src_install() {
	insinto /opt/reposilite
	newins "${WORKDIR}/reposilite-${PV}.jar" reposilite.jar

	systemd_newunit "${FILESDIR}/${PN}-3.service" "${PN}.service"

	keepdir "/etc/reposilite"

	fowners reposilite /etc/reposilite
	fperms 0700 /etc/reposilite
	fowners reposilite:reposilite /opt/reposilite
	fperms 0750 /opt/reposilite
}

pkg_postinst() {
	ewarn "If you upgrade from Reposilite version 2.x, you **must**"
	ewarn "migrate the data from the docker volume. Otherwise, your"
	ewarn "existing artifacts will be lost."
	einfo
	einfo "Copy or move all the files from"
	einfo "    /var/lib/docker/volumes/reposilite-data/_data"
	einfo "to /opt/reposilite."
}
