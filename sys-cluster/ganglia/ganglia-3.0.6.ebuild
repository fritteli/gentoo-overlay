# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Ganglia is a scalable distributed monitoring system for high-performance computing systems such as clusters and grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
SRC_URI="mirror://sourceforge/ganglia/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="test minimal"

DEPEND="!minimal? ( net-analyzer/rrdtool )
	test? ( >=dev-libs/check-0.8.2 )"
RDEPEND="!minimal? ( net-analyzer/rrdtool )"

src_compile() {
	econf \
		--enable-gexec \
		$(use_with !minimal gmetad) || die

	emake || die
}

src_install() {
	einstall || die

	insinto /etc
	doman mans/{gmetric.1,gmond.1,gstat.1}
	doman gmond/gmond.conf.5
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	newinitd ${FILESDIR}/gmond.rc gmond

	if ! use minimal; then
		doins gmetad/gmetad.conf
		doman mans/gmetad.1
		keepdir /var/lib/ganglia/rrds
		fowners nobody:nobody /var/lib/ganglia/rrds
		newinitd ${FILESDIR}/gmetad.rc gmetad
	fi
}

pkg_postinst() {
	echo
	einfo "This package doesn't include a configuration file for gmond."
	einfo "You could generate a default template by running:"
	echo
	einfo "  /usr/sbin/gmond -t > /etc/gmond.conf"
	echo
	einfo "and customize it from there or provide your own."
	echo
}
