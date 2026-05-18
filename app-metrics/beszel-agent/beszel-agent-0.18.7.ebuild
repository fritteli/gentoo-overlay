# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

MY_P="beszel-${PV}"
DESCRIPTION="Beszel Agent - Simple, lightweight server monitoring"
HOMEPAGE="https://www.beszel.dev/ https://github.com/henrygd/beszel/"

# How to create the vendor tarball:
# https://wiki.gentoo.org/wiki/Writing_go_Ebuilds#Vendor_tarball
SRC_URI="https://github.com/henrygd/beszel/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://gentoo-overlay.friedli.info/${MY_P}-vendor.tar.xz"

S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" AGPL-3 Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="acct-user/beszel-agent
	acct-group/beszel"

BDEPEND=">=dev-lang/go-1.26.1"

src_compile() {
	cd internal/cmd/agent || die
	ego build -ldflags "-w -s"
}

src_install() {
	newbin "${S}/internal/cmd/agent/agent" ${PN}

	dodir /etc/${PN}
	keepdir /var/lib/${PN}

	insinto /etc/${PN}
	doins "${FILESDIR}/${PN}.env"

	fowners -R ${PN}:beszel /etc/${PN} /var/lib/${PN}
	fperms 0750 /etc/${PN} /var/lib/${PN}
	fperms 0600 /etc/${PN}/${PN}.env

	systemd_dounit "${FILESDIR}/${PN}.service"
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
}
