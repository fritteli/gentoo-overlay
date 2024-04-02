# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd

DESCRIPTION="A Matrix-WhatsApp puppeting bridge."
HOMEPAGE="https://docs.mau.fi/bridges/go/whatsapp/index.html"
SRC_URI="https://github.com/mautrix/whatsapp/releases/download/v${PV}/mautrix-whatsapp-amd64 -> ${P}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-user/mautrix-whatsapp-bin"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}" "${S}/mautrix-whatsapp"
}

src_compile() {
	:
}

src_install() {
	exeinto /opt/mautrix-whatsapp
	doexe mautrix-whatsapp

	insinto /opt/mautrix-whatsapp
	doins "${FILESDIR}/example-config.yaml"

	systemd_dounit "${FILESDIR}"/mautrix-whatsapp.service

	fowners mautrix-whatsapp-bin:mautrix-whatsapp-bin /opt/mautrix-whatsapp/mautrix-whatsapp
	fowners mautrix-whatsapp-bin:mautrix-whatsapp-bin /opt/mautrix-whatsapp/example-config.yaml
	fperms 0640 /opt/mautrix-whatsapp/example-config.yaml
}
