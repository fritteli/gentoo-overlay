# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit systemd

DESCRIPTION="Reposilite - Simple Maven Repository hosting"
HOMEPAGE="https://reposilite.com/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"
DEPEND=""
RDEPEND="acct-user/reposilite
	app-emulation/docker
"

S="${WORKDIR}"

src_prepare() {
	sed -e "s/<VERSION>/${PV}/g" "${FILESDIR}/reposilite.sh" > "${T}/reposilite.sh"

	eapply_user
}

src_install() {
	exeinto /usr/sbin
	doexe "${T}/reposilite.sh"

	systemd_dounit "${FILESDIR}/${PN}.service"

	insinto "/etc/reposilite"
	doins "${FILESDIR}/app.ini"
	newins "${FILESDIR}/reposilite-2.9.16.cdn" reposilite.cdn

	fowners reposilite /etc/reposilite
	fperms 0700 /etc/reposilite
	fowners reposilite:reposilite /etc/reposilite/app.ini /etc/reposilite/reposilite.cdn
	fperms 0600 /etc/reposilite/app.ini /etc/reposilite/reposilite.cdn
}
