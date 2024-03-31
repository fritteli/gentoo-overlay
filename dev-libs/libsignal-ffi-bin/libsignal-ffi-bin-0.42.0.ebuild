# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libsignal-ffi prebuilt binary package"
HOMEPAGE="homepage field in Cargo.toml inaccessible to cargo metadata"
SRC_URI="https://gentoo-overlay.friedli.info/libsignal_ffi-${PV}.a -> ${P}.a"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"

MY_TARGET_NAME="libsignal_ffi-${PV}.a"

src_unpack() {
	cp "${DISTDIR}/${P}.a" "${S}/"
}

src_prepare() {
	mv "${P}.a" "${MY_TARGET_NAME}"
	eapply_user
}

src_compile() {
	:
}

src_install() {
	dolib.a "${MY_TARGET_NAME}"
	dosym -r /usr/lib64/"${MY_TARGET_NAME}" /usr/lib64/libsignal_ffi.a
}
