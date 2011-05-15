# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ps3mediaserver/ps3mediaserver-1.20.412-r1.ebuild,v 1.1 2011/01/07 17:03:11 vapier Exp $

EAPI="2"

DESCRIPTION="DLNA compliant UPNP server for streaming media to Playstation 3"
HOMEPAGE="http://code.google.com/p/ps3mediaserver"
SRC_URI="http://ps3mediaserver.googlecode.com/files/pms-generic-linux-unix-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+transcode tsmuxer"

DEPEND=""
RDEPEND=">=virtual/jre-1.6.0
	tsmuxer? ( media-video/tsmuxer )
	transcode? ( media-video/mplayer[encode] )"

S=${WORKDIR}/pms-linux-${PV}

src_prepare() {
	rm linux/tsMuxeR* || die
	cat <<-EOF > ${PN}
	#!/bin/sh
	echo "Setting up ~/.${PN} based on /usr/share/${PN}/"
	if [ ! -e ~/.${PN} ] ; then
		mkdir -p ~/.${PN}
		cp -pPR /usr/share/${PN}/* ~/.${PN}/
	fi
	cd ~/.${PN}
	PMS_HOME=\$PWD
	EOF
	cat PMS.sh >> ${PN}
}

src_install() {
	dobin ${PN} || die
	insinto /usr/share/${PN}
	doins -r pms.jar *.conf linux plugins renderers || die
	use tsmuxer && { dosym /opt/bin/tsMuxeR /usr/share/${PN}/linux/ || die ; }
	dodoc CHANGELOG FAQ README
}

pkg_postinst() {
	ewarn "Don't forget to disable transcoding engines for software"
	ewarn "that you don't have installed (such as having the VLC"
	ewarn "transcoding engine enabled when you only have mencoder)."
}
