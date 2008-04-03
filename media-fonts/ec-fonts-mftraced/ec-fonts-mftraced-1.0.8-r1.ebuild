# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ec-fonts-mftraced/ec-fonts-mftraced-1.0.8.ebuild,v 1.9 2007/01/10 19:45:42 peper Exp $

DESCRIPTION="EC Fonts for Lilypond"
SRC_URI="http://lilypond.org/download/fonts/${P}.tar.gz"
HOMEPAGE="http://lilypond.org/"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86 sparc ~ppc amd64 ia64 alpha"
IUSE=""

RDEPEND=">=dev-scheme/guile-1.6.4
	virtual/ghostscript
	virtual/latex-base
	>=dev-lang/python-2.2.3-r1"

DEPEND="${RDEPEND}
	>=sys-devel/make-3.80
	>=app-text/mftrace-1.0.27
	>=media-gfx/potrace-1.5"

src_unpack() {
	unpack ${A} || die "unpack failed"
}

src_compile() {
	addwrite /dev/stderr
	addwrite /var/cache/fonts
	addwrite /usr/share/texmf
	addwrite /root/.PfaEdit

	# no need for econf.. this isn't an autoconf-generated configure
	./configure
	make all builddir=${S} prefix=${D}/usr/
}

src_install () {
	addwrite /dev/stderr
	addwrite /var/cache/fonts
	addwrite /usr/share/texmf
	addwrite /root/.PfaEdit

	make install builddir=${S} prefix=${D}/usr/
	mv ${D}/usr/share/doc/{${PN},${P}}
}

pkg_postinst() {
	texhash
}
