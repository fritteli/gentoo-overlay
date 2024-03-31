# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd

DESCRIPTION="A Matrix-Signal puppeting bridge."
HOMEPAGE="https://docs.mau.fi/bridges/go/signal/index.html"
SRC_URI="https://github.com/mautrix/signal/releases/download/v${PV}/mautrix-signal-amd64 -> ${P}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-user/mautrix-signal-bin"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}" "${S}/mautrix-signal"
}

src_compile() {
	:
}

src_install() {
	exeinto /opt/mautrix-signal
	doexe mautrix-signal

	insinto /opt/mautrix-signal
	doins "${FILESDIR}/example-config.yaml"

	systemd_dounit "${FILESDIR}"/mautrix-signal.service

	fowners mautrix-signal-bin:mautrix-signal-bin /opt/mautrix-signal/mautrix-signal
	fowners mautrix-signal-bin:mautrix-signal-bin /opt/mautris-signal/example-config.yaml
	fperms 0640 /opt/mautris-signal/example-config.yaml
}
