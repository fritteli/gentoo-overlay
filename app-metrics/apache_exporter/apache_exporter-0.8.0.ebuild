# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit golang-build golang-vcs-snapshot systemd

EGO_PN="github.com/Lusitaniae/apache_exporter"
EGIT_COMMIT="v${PV/_rc/-rc.}"
APACHE_EXPORTER_COMMIT="712a679"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="Prometheus exporter for apache metrics"
HOMEPAGE="https://github.com/Lusitaniae/apache_exporter"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.12
	>=dev-util/promu-0.3.0"

RDEPEND="acct-user/apache_exporter"

src_prepare() {
	default
	sed -i -e "s/{{.Revision}}/${APACHE_EXPORTER_COMMIT}/" src/${EGO_PN}/.promu.yml || die
}

src_compile() {
	pushd src/${EGO_PN} || die
	mkdir -p bin || die
	GOPATH="${S}" GOCACHE="${T}"/go-cache promu build -v --prefix apache_exporter || die
	popd || die
}

src_install() {
	pushd src/${EGO_PN} || die
	dobin apache_exporter/apache_exporter
	dodoc README.md
	systemd_dounit "${FILESDIR}/${PN}.service"
	insinto /etc/sysconfig/apache_exporter
	doins "${FILESDIR}/sysconfig.apache_exporter"
	popd || die
	keepdir /var/log/apache_exporter
	fowners apache_exporter:apache_exporter /var/log/apache_exporter
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
