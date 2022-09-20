# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

KEYWORDS="~amd64"

DESCRIPTION="Prometheus Exporter for Postfix"
HOMEPAGE="https://github.com/kumina/postfix_exporter"
SRC_URI="https://github.com/kumina/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://manuel.friedli.info/gentoo-overlay/postfix_exporter-0.3.0-vendor.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="systemd"

DEPEND="systemd? ( sys-apps/systemd )"

RDEPEND="acct-user/postfix_exporter"

RESTRICT="test"

src_compile() {
	ego build -tags "$(usex systemd '' 'nosystemd')" -v -o bin/${PN} || die
}

src_install() {
	dobin "bin/${PN}"
	dodoc {CHANGELOG,README}.md
	local dir
	for dir in /var/{lib,log}/${PN}; do
		keepdir "${dir}"
		fowners postfix_exporter:postfix_exporter "${dir}"
	done
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}-1.confd ${PN}
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotated" "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
}
