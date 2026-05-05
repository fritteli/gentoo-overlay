# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

MY_P="beszel-${PV}"
DESCRIPTION="Beszel Hub - Simple, lightweight server monitoring"
HOMEPAGE="https://www.beszel.dev/ https://github.com/henrygd/beszel/"

# How to create the vendor tarball:
# https://wiki.gentoo.org/wiki/Writing_go_Ebuilds#Vendor_tarball
#
# How to create the site tarball:
# - Checkout the repo at the correct tag into the dir ${MY_P}
# cd ${MY_P}/internal/site
# npm install
# npm run build
# cd ../../..
# tar --auto-compress -cf ${MY_P}-site.tar.xz ${MY_P}/internal/site/dist
# Upload to mirror
SRC_URI="https://github.com/henrygd/beszel/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://gentoo-overlay.friedli.info/${MY_P}-vendor.tar.xz
	https://gentoo-overlay.friedli.info/${MY_P}-site.tar.xz"

S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" AGPL-3 Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-user/beszel-hub
	acct-group/beszel"

BDEPEND=">=dev-lang/go-1.26.0"

src_compile() {
	cd internal/cmd/hub
	ego build -ldflags "-w -s"
}

src_install() {
	newbin "${S}/internal/cmd/hub/hub" ${PN}

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
