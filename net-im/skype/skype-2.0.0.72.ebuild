# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-2.0.0.68.ebuild,v 1.3 2008/08/11 18:21:17 yngwin Exp $

EAPI=1

inherit eutils pax-utils qt4

DESCRIPTION="A P2P-VoiceIP client."
HOMEPAGE="http://www.skype.com/"

SFILENAME=${PN}_static-${PV}.tar.bz2
DFILENAME=${P}.tar.bz2
SRC_URI="!qt-static? ( http://download.skype.com/linux/${DFILENAME} )
	qt-static? ( http://download.skype.com/linux/${SFILENAME} )"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt-static"
RESTRICT="mirror strip"

DEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		>=app-emulation/emul-linux-x86-soundlibs-2.4
		app-emulation/emul-linux-x86-compat )
	x86? ( >=sys-libs/glibc-2.4
		>=media-libs/alsa-lib-1.0.11
		x11-libs/libXScrnSaver
		x11-libs/libXv
		qt-static? ( media-libs/fontconfig
				media-libs/freetype
				x11-libs/libICE
				x11-libs/libSM
				x11-libs/libXcursor
				x11-libs/libXext
				x11-libs/libXfixes
				x11-libs/libXi
				x11-libs/libXinerama
				x11-libs/libXrandr
				x11-libs/libXrender
				x11-libs/libX11 )
		!qt-static? ( || ( ( x11-libs/qt-gui:4 x11-libs/qt-dbus:4 )
					=x11-libs/qt-4.3*:4 )
				x11-libs/libX11
				x11-libs/libXau
				x11-libs/libXdmcp ) )"
RDEPEND="${DEPEND}"

QA_EXECSTACK="opt/skype/skype"

use qt-static && S="${WORKDIR}/${PN}_static-${PV}"
use !qt-static && QT4_BUILT_WITH_USE_CHECK="guiaccessibility dbus"

src_install() {
	# remove mprotect() restrictions for PaX usage - see Bug 100507
	pax-mark m "${S}"/skype

	exeinto /opt/${PN}
	doexe skype
	fowners root:audio /opt/skype/skype
	make_wrapper skype /opt/${PN}/skype /opt/${PN} /opt/${PN} /usr/bin

	insinto /opt/${PN}/sounds
	doins sounds/*.wav

	if ! use qt-static ; then
		insinto /etc/dbus-1/system.d
		newins "${FILESDIR}"/skype.debus.config skype.conf
	fi

	insinto /opt/${PN}/lang
	#
	#There have been some issues were lang is not updated from the .ts files
	#but if we have qt we can rebuild it
	#
	if ! use qt-static ; then
		lrelease lang/*.ts
	fi

	doins lang/*.qm

	insinto /opt/${PN}/avatars
	doins avatars/*.png

	insinto /opt/${PN}
	for X in 16 32 48
	do
		insinto /usr/share/icons/hicolor/${X}x${X}/apps
		newins "${S}"/icons/SkypeBlue_${X}x${X}.png ${PN}.png
	done

	dodoc README

	# insinto /usr/share/applications/
	# doins skype.desktop
	make_desktop_entry ${PN} "Skype VoIP" ${PN} "Network;InstantMessaging;Telephony"

	#Fix for no sound notifications
	dosym /opt/${PN} /usr/share/${PN}

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
	# doexe skype-callto-handler
}

pkg_postinst() {
	elog "If you have sound problems please visit: "
	elog "http://forum.skype.com/bb/viewtopic.php?t=4489"
	elog "These kernel options are reported to help"
	elog
	elog "Processor type and features --->"
	elog "-- Preemption Model (Preemptible Kernel (Low-Latency Desktop))"
	elog "-- Timer frequency (250 HZ)"
	elog
	ewarn "This release no longer uses the old wrapper because ${PN} now uses ALSA"
	ewarn

}
