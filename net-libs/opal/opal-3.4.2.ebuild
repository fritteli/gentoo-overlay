# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

DESCRIPTION="C++ class library normalising numerous telephony protocols"
HOMEPAGE="http://www.opalvoip.org/"
SRC_URI="mirror://sourceforge/opalvoip/${P}.tar.bz2
	doc? ( mirror://sourceforge/opalvoip/${P}-htmldoc.tar.gz )"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc java"

RDEPEND=">=dev-libs/ptlib-2.0.0
	>=media-video/ffmpeg-0.4.7
	media-libs/speex
	java? ( virtual/jdk )"

pkg_setup() {
	if use debug && ! built_with_use dev-libs/ptlib debug; then
		eerror "You need to build dev-libs/ptlib with USE=debug enabled."
		die "dev-libs/ptlib has to be built with USE=debug"
	fi

	if ! use debug && built_with_use dev-libs/ptlib debug; then
		eerror "You need to build dev-libs/ptlib without USE=debug."
		die "dev-libs/ptlib has not to be built with USE=debug"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# move files from ${P}-htmldoc.tar.gz
	use doc && mv ../html .

	epatch "${FILESDIR}"/${PN}-lpcini.patch
}

src_compile() {
	local makeopts

	filter-ldflags -Wl,--as-needed --as-needed

	# zrtp doesn't depend on net-libs/libzrtpcpp but on libzrtp from
	# http://zfoneproject.com/ that is not in portage
	econf \
		$(use_enable debug) \
		$(use_enable java) \
		--enable-plugins \
		--disable-localspeex \
		--disable-zrtp \
		|| die "econf failed"

	if use debug; then
		makeopts="debug"
	else
		makeopts="opt"
	fi

	emake ${makeopts} || die "emake failed"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		dohtml -r html/* docs/* || die "documentation installation failed"
	fi
}
