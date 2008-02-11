# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib distutils

MY_P="${P/m/M}"
DESCRIPTION="Open source video player"
HOMEPAGE="http://www.getmiro.com/"
SRC_URI="http://ftp.osuosl.org/pub/pculture.org/miro/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

#TODO: This is simply rewritten from setup.cfg. Adding version requirements is strongly recommended.
DEPEND=">=dev-lang/python-2.4
	>=dev-python/pysqlite-2
	dev-libs/nss
	>=dev-libs/boost-1.34.1-r1
	dev-python/gnome-python-extras
	dev-python/dbus-python
	>=dev-python/pyrex-0.9.6.4
	sys-libs/db
	media-libs/xine-lib
	media-libs/libfame
	dev-util/pkgconfig
	doc? ( dev-util/devhelp )"

S="${WORKDIR}/${MY_P}/platform/gtk-x11"

pkg_postinst() {
	distutils_pkg_postinst

        if ! built_with_use dev-lang/python berkdb; then
		eerror ""
                eerror "You must reemerge dev-lang/python with \"berkdb\" flag set."
		eerror "Otherwise Miro won't run."
		eerror ""
        fi
        if has_version ">=dev-lang/python-2.5" &&
                ! built_with_use dev-lang/python sqlite ; then
		eerror ""
                eerror "You should reemerge dev-lang/python with \"sqlite\" flag set."
		eerror "This will improve Miro's speed."
		eerror ""
        fi
        if has_version ">=dev-libs/openssl-0.9.8f" ; then
		ewarn ""
                ewarn "Versions of openssl >= 0.9.8f can cause Miro segfaulting"
		ewarn ""
        fi
	
	MOZSETUP="/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/mozsetup.py"
	elog ""
	elog "To increase the font size of the main display area, add:"
	elog "user_pref(\"font.minimum-size.x-western\", 15);"
	elog ""
	elog "to the following file:"
	elog "${MOZSETUP}"
	elog ""
}
