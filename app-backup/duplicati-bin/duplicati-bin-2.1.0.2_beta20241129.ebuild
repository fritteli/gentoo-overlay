# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ex. 2.1.0.2
MY_MAIN_PV="$(ver_cut 1-4)"
# ex. beta
MY_BUILDTYPE="$(ver_cut 5)"
# ex. 20241129
MY_BUILDDATE="$(ver_cut 6)"

# ex. 2024
MY_YEAR="${MY_BUILDDATE:0:4}"
# ex. 11
MY_MONTH="${MY_BUILDDATE:4:2}"
# ex. 29
MY_DAY="${MY_BUILDDATE:6:2}"

MY_PN="duplicati"
# ex. 2.1.0.2_beta_2024-11-29
MY_PV="${MY_MAIN_PV}_${MY_BUILDTYPE}_${MY_YEAR}-${MY_MONTH}-${MY_DAY}"
# ex. duplicati-2.1.0.2_beta_2024-11-29-linux-x64-gui
MY_P="${MY_PN}-${MY_PV}-linux-x64-gui"

DESCRIPTION="A backup client that securely stores encrypted, incremental, compressed backups."
HOMEPAGE="https://www.duplicati.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${MY_PV}/${MY_P}.zip -> ${P}.zip"

S="${WORKDIR}"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

BDEPEND="app-arch/unzip"

src_install() {
	my_source="${S}/duplicati"
	my_target="/opt/duplicati"

	mv "${S}/${MY_P}" "${my_source}"

	dodir "${my_target}"

	insinto /opt
	doins -r "${my_source}"

	exeinto "${my_target}"

	my_executables=( duplicati duplicati-aescrypt duplicati-autoupdater duplicati-backend-tester \
		duplicati-backend-tool duplicati-cli duplicati-recovery-tool duplicati-secret-tool \
		duplicati-server duplicati-server-util duplicati-service duplicati-snapshots )

	for f in ${my_executables[@]} ; do
		doexe "${my_source}/${f}"
		dosym "../..${my_target}/${f}" "${EPREFIX}/usr/bin/${f}"
	done
}
