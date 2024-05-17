# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

MY_PN="duplicati"
MY_PV="2.0.8.1"
MY_BUILDTYPE="beta"
MY_BUILDDATE="2024-05-07"

MY_BASE_PV="${MY_PV}-${MY_PV}_${MY_BUILDTYPE}"

MY_PV_1="v${MY_BASE_PV}_${MY_BUILDDATE}"
MY_PV_2="${MY_PN}-${MY_BASE_PV}_${MY_BUILDDATE//-/}"

DESCRIPTION="A backup client that securely stores encrypted, incremental, compressed backups."
HOMEPAGE="https://www.duplicati.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/${MY_PV_1}/${MY_PV_2}.noarch.rpm -> ${P}.rpm"

RDEPEND=">=dev-lang/mono-5.10"
DEPEND="dev-dotnet/gtk-sharp:3"

S="${WORKDIR}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/001-${PN}-2.0.5.1_beta20200118-bash-path.patch"
)

src_prepare() {
	eapply ${PATCHES}
	eapply_user
	mv "${S}/usr/share/doc/duplicati" "${S}/usr/share/doc/${P}"
}

src_install() {
	cp -R "${S}/usr/" "${D}/" || die "install failed"
	fperms 0755 /usr/bin/duplicati
	fperms 0755 /usr/bin/duplicati-cli
	fperms 0755 /usr/bin/duplicati-server
}
