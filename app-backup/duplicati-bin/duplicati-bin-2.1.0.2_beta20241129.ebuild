# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="duplicati"
MY_PV="2.1.0.2"
MY_BUILDTYPE="beta"
MY_BUILDDATE="2024-11-29"

MY_BASE_PV="${MY_PV}_${MY_BUILDTYPE}"

MY_PV_1="v${MY_BASE_PV}_${MY_BUILDDATE}"
MY_PV_2="${MY_PN}-${MY_BASE_PV}_${MY_BUILDDATE}"
MY_P="${MY_PN}-${MY_BASE_PV}_${MY_BUILDDATE}-linux-x64-gui"

DESCRIPTION="A backup client that securely stores encrypted, incremental, compressed backups."
HOMEPAGE="https://www.duplicati.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/${MY_PV_1}/${MY_P}.zip -> ${P}.zip"

S="${WORKDIR}"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

BDEPEND="app-arch/unzip"

src_install() {
	mv "${S}/${MY_P}" "${S}/duplicati"
	dodir /opt/duplicati
	insinto /opt
	doins -r "${S}/duplicati"
	exeinto /opt/duplicati

	my_executables=( duplicati duplicati-aescrypt duplicati-autoupdater duplicati-backend-tester \
		duplicati-backend-tool duplicati-cli duplicati-recovery-tool duplicati-secret-tool \
		duplicati-server duplicati-server-util duplicati-service duplicati-snapshots )

	for f in ${my_executables[@]} ; do
		doexe "${S}/duplicati/${f}"
		dosym "../../opt/duplicati/${f}" "${EPREFIX}/usr/bin/${f}"
	done
}
