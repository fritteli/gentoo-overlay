# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="Prometheus exporter for apache metrics"
HOMEPAGE="https://github.com/Lusitaniae/apache_exporter"
SRC_URI="https://github.com/Lusitaniae/apache_exporter/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo-overlay.friedli.info/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-group/apache_exporter
	acct-user/apache_exporter"
	RDEPEND="${DEPEND}"

src_compile() {
	ego build
}

src_install() {
	dobin apache_exporter
	dodoc README.md
	newinitd "${FILESDIR}"/apache_exporter.initd apache_exporter
	newconfd "${FILESDIR}"/apache_exporter.confd apache_exporter

	systemd_dounit "${FILESDIR}"/apache_exporter.service
	insinto /etc/sysconfig
	newins "${FILESDIR}/sysconfig.apache_exporter" apache_exporter

	keepdir /var/log/apache_exporter
	fowners -R ${PN}:${PN} /var/log/apache_exporter
}
