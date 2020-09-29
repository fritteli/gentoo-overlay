# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit dotnet autotools base
inherit dotnet autotools

SLOT="3"
DESCRIPTION="gtk bindings for mono"
LICENSE="GPL-2"
HOMEPAGE="http://www.mono-project.com/GtkSharp"
KEYWORDS="~amd64 ~arm64 ~ppc ~x86"
SRC_URI="https://ftp.gnome.org/pub/GNOME/sources/gtk-sharp/2.99/${P}.tar.xz"
IUSE="debug"

RESTRICT="test"

RDEPEND="
	>=dev-lang/mono-6.6
	x11-libs/pango
	>=dev-libs/glib-2.31
	dev-libs/atk
	x11-libs/gtk+:3
	dev-perl/XML-LibXML"
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
