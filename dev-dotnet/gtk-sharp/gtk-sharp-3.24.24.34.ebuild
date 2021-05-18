# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit dotnet autotools base
inherit dotnet autotools

MY_PN="GtkSharp"
MY_P="${MY_PN}-${PV}"
SLOT="3"
DESCRIPTION="gtk bindings for mono"
LICENSE="GPL-2"
HOMEPAGE="https://github.com/GtkSharp/GtkSharp"
KEYWORDS="~amd64 ~arm64 ~ppc ~x86"
SRC_URI="https://github.com/GtkSharp/GtkSharp/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
IUSE="debug"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

CDEPEND="
	|| (
		dev-dotnet/dotnetcore-sdk
		dev-dotnet/dotnetcore-sdk-bin
	)
	dev-util/msbuild
"

RDEPEND="
	>=dev-lang/mono-6.12
	x11-libs/gtk+:3
"
#	x11-libs/pango
#	>=dev-libs/glib-2.31
#	dev-libs/atk
#	dev-perl/XML-LibXML
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/automake:1.11"

src_unpack() {
	mkdir "${T}"/the_registry
	default
}

src_prepare() {
	eautoreconf
	_elibtoolize
	eapply_user
}

src_configure() {
	econf	--disable-static \
		--disable-maintainer-mode \
		$(use_enable debug)
}

src_compile() {
	MONO_REGISTRY_PATH="${T}/the_registry" emake
}

src_install() {
	default
	dotnet_multilib_comply
	sed -i "s/\\r//g" "${D}"/usr/bin/* || die "sed failed"
	dodir /etc/mono/registry || die "failed to create registry dir"
	insinto /etc/mono/registry
	doins -r "${T}"/the_registry/* || die "failed to install to registry"
}
