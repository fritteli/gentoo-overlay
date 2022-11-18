# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# See https://dist.nuget.org/index.json for available versions

DESCRIPTION="Nuget - .NET Package Manager"
HOMEPAGE="https://www.nuget.org/"
SRC_URI="https://dist.nuget.org/win-x86-commandline/v${PV}/nuget.exe -> ${P}.exe"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_compile() { :; }

src_install() {
	exeinto "/usr/bin"
	doexe "${FILESDIR}/nuget"
	insinto "/usr/lib/${PN}"
	newins "${DISTDIR}/${P}.exe" "nuget.exe"
}
