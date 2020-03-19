# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit dotnet autotools base
inherit dotnet autotools

SLOT="2"
DESCRIPTION="gtk bindings for mono"
LICENSE="GPL-2"
HOMEPAGE="http://www.mono-project.com/GtkSharp"
KEYWORDS="~amd64 ~arm64 ~ppc ~x86"
SRC_URI="http://download.mono-project.com/sources/gtk-sharp212/${P}.tar.gz"
IUSE="debug"

RESTRICT="test"

RDEPEND="
	>=dev-lang/mono-3.0
	x11-libs/pango
	>=dev-libs/glib-2.31
	dev-libs/atk
	x11-libs/gtk+:2
	gnome-base/libglade
	dev-perl/XML-LibXML
	!dev-dotnet/gtk-sharp-gapi
	!dev-dotnet/gtk-sharp-docs
	!dev-dotnet/gtk-dotnet-sharp
	!dev-dotnet/gdk-sharp
	!dev-dotnet/glib-sharp
	!dev-dotnet/glade-sharp
	!dev-dotnet/pango-sharp
	!dev-dotnet/atk-sharp"
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
