# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="6.0"

inherit git-r3 dotnet-pkg

EGIT_REPO_URI="https://github.com/GtkSharp/GtkSharp"
#EGIT_BRANCH="master"
#EGIT_COMMIT="964cb9c31506adf7c1c68fe8a6ac8c8076237f3a"
EGIT_COMMIT="96f30862e9eea764ea1119c34d401b1c71e7ac57"

MY_PN="GtkSharp"
MY_P="${MY_PN}-${PV}"
SLOT="3"
DESCRIPTION="gtk bindings for mono"
LICENSE="GPL-2"
HOMEPAGE="https://github.com/GtkSharp/GtkSharp"
KEYWORDS="~amd64 ~arm64 ~ppc ~x86"

DOTNET_PKG_PROJECTS=( "${S}/Source" )

RDEPEND="
	${DOTNET_PKG_RDEPS}
	x11-libs/gtk+:3
"

BDEPEND="
	${DOTNET_PKG_BDEPS}
"

DEPEND="
	${RDEPEND}
	>=dev-lang/mono-6.12
	app-accessibility/at-spi2-core
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango
"

pkg_setup() {
	dotnet-pkg-base_setup
}

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	dotnet-pkg_src_unpack
}

src_configure() {
	dotnet-pkg-base_restore_tools
}

src_compile() {
	ewarn "!!!"
	ewarn "!!!BAD!!! Hardcoded DOTNET_ROOT in ebuild. How can I fix that?!"
	ewarn "!!!"
	DOTNET_ROOT=/opt/dotnet-sdk-bin-6.0 edotnet cake build.cake
}

src_install() {
	mv BuildOutput "${DOTNET_PKG_OUTPUT}"
	dotnet-pkg_src_install
}
