# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.20.3.ebuild,v 1.10 2008/02/04 05:00:22 jer Exp $
EAPI="1"

DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="accessibility cdr cups dvdr esd ldap mono"

S=${WORKDIR}

RDEPEND="
	>=dev-libs/glib-2.14.4
	>=x11-libs/gtk+-2.12.4
	>=dev-libs/atk-1.20.0
	>=x11-libs/pango-1.18.4

	>=dev-libs/libxml2-2.6.30
	>=dev-libs/libxslt-1.1.22

	>=media-libs/audiofile-0.2.6-r1
	esd? ( >=media-sound/esound-0.2.38 )
	>=x11-libs/libxklavier-3.2
	>=media-libs/libart_lgpl-2.3.19

	>=dev-libs/libIDL-0.8.9
	>=gnome-base/orbit-2.14.10

	>=x11-libs/libwnck-2.20.3
	>=x11-wm/metacity-2.20.2

	>=gnome-base/gnome-keyring-2.20.3
	>=gnome-extra/gnome-keyring-manager-2.20.0

	>=gnome-base/gnome-vfs-2.20.1

	>=gnome-base/gnome-mime-data-2.18.0

	>=gnome-base/gconf-2.20.1
	net-libs/libsoup:2.2

	>=gnome-base/libbonobo-2.20.3
	>=gnome-base/libbonoboui-2.20.0
	>=gnome-base/libgnome-2.20.1.1
	>=gnome-base/libgnomeui-2.20.1.1
	>=gnome-base/libgnomecanvas-2.20.1.1
	>=gnome-base/libglade-2.6.2

	>=gnome-extra/bug-buddy-2.20.1
	>=gnome-base/control-center-2.20.1

	>=gnome-base/eel-2.20.0
	>=gnome-base/nautilus-2.20.0

	>=media-libs/gstreamer-0.10.14
	>=media-libs/gst-plugins-base-0.10.14
	>=media-libs/gst-plugins-good-0.10.6
	>=gnome-extra/gnome-media-2.20.1
	>=media-sound/sound-juicer-2.20.1
	>=media-video/totem-2.20.3

	>=media-gfx/eog-2.20.4

	>=www-client/epiphany-2.20.3
	>=app-arch/file-roller-2.20.3
	>=gnome-extra/gcalctool-5.20.2

	>=gnome-extra/gconf-editor-2.20.0
	>=gnome-base/gdm-2.20.3
	=x11-libs/gtksourceview-1.8*
	>=app-editors/gedit-2.20.4

	>=app-text/evince-2.20.2

	>=gnome-base/gnome-desktop-2.20.3
	>=gnome-base/gnome-session-2.20.3
	>=gnome-base/gnome-applets-2.20.1
	>=gnome-base/gnome-panel-2.20.3
	>=gnome-base/gnome-menus-2.20.3
	>=x11-themes/gnome-icon-theme-2.20.0
	>=x11-themes/gnome-themes-2.20.2
	=gnome-extra/deskbar-applet-2*

	>=x11-themes/gtk-engines-2.12.2
	>=x11-themes/gnome-backgrounds-2.20.0

	>=x11-libs/vte-0.16.12
	>=x11-terms/gnome-terminal-2.18.4

	>=gnome-extra/gucharmap-1.10.2
	>=gnome-base/libgnomeprint-2.18.2
	>=gnome-base/libgnomeprintui-2.18.1

	>=gnome-extra/gnome-utils-2.20.0.1

	>=gnome-extra/gnome-games-2.20.2
	>=gnome-base/librsvg-2.18.2

	>=gnome-extra/gnome-system-monitor-2.20.2
	>=gnome-base/libgtop-2.20.1

	>=x11-libs/startup-notification-0.9

	>=gnome-extra/gnome2-user-docs-2.20.1
	>=gnome-extra/yelp-2.20.0
	>=gnome-extra/zenity-2.20.1

	>=net-analyzer/gnome-netstatus-2.12.1
	>=net-analyzer/gnome-nettool-2.20.0

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.20.0 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.20.0 )

	>=gnome-extra/gtkhtml-3.16.3
	>=mail-client/evolution-2.12.2
	>=gnome-extra/evolution-data-server-1.12.3
	>=gnome-extra/evolution-webcal-2.12.0

	>=net-misc/vino-2.20.1

	>=app-admin/gnome-system-tools-2.14.0
	>=app-admin/system-tools-backends-1.4.2
	>=gnome-extra/fast-user-switch-applet-2.18.0

	>=app-admin/pessulus-2.16.3
	ldap? (
		>=app-admin/sabayon-2.20.1
		>=net-im/ekiga-2.0.11
		)

	>=gnome-extra/gnome-screensaver-2.20.0
	>=x11-misc/alacarte-0.11.3
	!ppc64? ( >=gnome-extra/gnome-power-manager-2.20.0 )
	>=gnome-base/gnome-volume-manager-2.17.0

	accessibility? (
		>=gnome-extra/libgail-gnome-1.20.0
		>=gnome-base/gail-1.20.2
		>=gnome-extra/at-spi-1.20.1
		>=app-accessibility/dasher-4.6.1
		>=app-accessibility/gnome-mag-0.14.10
		>=app-accessibility/gnome-speech-0.4.17
		>=app-accessibility/gok-1.3.7
		>=app-accessibility/orca-2.20.3 )
	cups? ( >=net-print/gnome-cups-manager-0.31-r2 )

	mono? ( >=app-misc/tomboy-0.8.2 )"

# Development tools
#   scrollkeeper
#   pkgconfig
#   intltool
#   gtk-doc
#   gnome-doc-utils

pkg_postinst() {

	elog "Note that to change windowmanager to metacity do: "
	elog " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	elog "of course this works for all other window managers as well"
	elog
	elog "To take full advantage of GNOME's functionality, please emerge"
	elog "gamin, a File Alteration Monitor."
	elog "Make sure you have inotify enabled in your kernel ( >=2.6.13 )"
	elog
	elog "Make sure you rc-update del famd and emerge --unmerge fam if you"
	elog "are switching from fam to gamin."
	elog
	elog "If you have problems, you may want to try using fam instead."
	elog
	elog
	elog "Add yourself to the plugdev group if you want"
	elog "automounting to work."
	elog
}
