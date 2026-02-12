# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

MY_P="beszel-${PV}"
DESCRIPTION="Beszel Hub - Simple, lightweight server monitoring"
HOMEPAGE="https://www.beszel.dev/"

# How to create the site tarball:
# - Checkout the repo at the correct tag into the dir ${MY_P}
# cd ${MY_P}/internal/site
# npm install
# npm build
# cd ../../..
# tar --auto-compress -cf ${MY_P}-site.tar.xz ${MY_P}/internal/site/dist
# Upload to mirror
SRC_URI="https://github.com/henrygd/beszel/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://gentoo-overlay.friedli.info/${MY_P}-vendor.tar.xz
	https://gentoo-overlay.friedli.info/${P}-site.tar.xz"

S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" AGPL-3 Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-user/beszel-hub
	acct-group/beszel"

src_compile() {
	cd internal/cmd/hub
	ego build -ldflags "-w -s"
}

src_install() {
	newbin "${S}"/internal/cmd/hub/hub beszel-hub

	dodir /etc/beszel-hub
	keepdir /var/lib/beszel-hub

	insinto /etc/beszel-hub
	doins "${FILESDIR}"/beszel-hub.env

	fowners -R beszel-hub:beszel /etc/beszel-hub /var/lib/beszel-hub
	fperms 0750 /etc/beszel-hub /var/lib/beszel-hub
	fperms 0600 /etc/beszel-hub/beszel-hub.env

	systemd_dounit "${FILESDIR}"/beszel-hub.service
}
