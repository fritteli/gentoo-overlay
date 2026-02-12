# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

MY_P="beszel-${PV}"
DESCRIPTION="Beszel Agent - Simple, lightweight server monitoring"
HOMEPAGE="https://www.beszel.dev/"
SRC_URI="https://github.com/henrygd/beszel/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://gentoo-overlay.friedli.info/${MY_P}-vendor.tar.xz"

S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" AGPL-3 Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-user/beszel-agent
	acct-group/beszel"

src_compile() {
	cd internal/cmd/agent
	ego build -ldflags "-w -s"
}

src_install() {
	newbin "${S}"/internal/cmd/agent/agent beszel-agent

	dodir /etc/beszel-agent
	keepdir /var/lib/beszel-agent

	insinto /etc/beszel-agent
	doins "${FILESDIR}"/beszel-agent.env

	fowners -R beszel-agent:beszel /etc/beszel-agent /var/lib/beszel-agent
	fperms 0750 /etc/beszel-agent /var/lib/beszel-agent
	fperms 0600 /etc/beszel-agent/beszel-agent.env

	systemd_dounit "${FILESDIR}"/beszel-agent.service
}
