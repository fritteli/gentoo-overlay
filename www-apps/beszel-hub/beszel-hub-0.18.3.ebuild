# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd toolchain-funcs

MY_P="beszel-${PV}"
DESCRIPTION="Beszel Hub - Simple, lightweight server monitoring"
HOMEPAGE="https://www.beszel.dev/"

# How to create the site tarball:
# - Checkout the repo at the correct tag
# cd internal/site
# npm install
# npm build
# cd ../..
# tar --auto-compress -cf ${MY_P}-site.tar.xz internal/site/dist
# Upload to mirror
SRC_URI="https://github.com/henrygd/beszel/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gentoo-overlay.friedli.info/${MY_P}-vendor.tar.xz"

S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" AGPL-3 Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {

	cd internal/hub
	ego build -ldflags "-w -s"
}
