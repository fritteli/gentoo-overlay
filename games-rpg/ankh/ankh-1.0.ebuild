inherit eutils games
DESCRIPTION="Ankh a Adventure like Monkey Island"
HOMEPAGE="http://www.ankh-game.de/ankh.html"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND="app-arch/bzip2
	app-arch/tar
	app-arch/unzip"

RDEPEND="sys-libs/glibc
	virtual/opengl
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	amd64? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			x11-drivers/nvidia-legacy-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="no"
dir=${GAMES_PREFIX_OPT}/ankh
Ddir=${D}/${dir}

src_install() {
	cdrom_get_cds data/Ankh.tar.gz
	insinto "${dir}"
	exeinto "${dir}"
	einfo "Unpacking common.zip from Disk..."
	unzip -qo "${CDROM_ROOT}"/data/common.zip -d "$Ddir"
	einfo "Unpacking bin-x86.tar.gz from Disk..."
	tar xzf "${CDROM_ROOT}"/data/bin-x86.tar.gz -C "$Ddir"
	einfo "Unpacking libs-x86.tar.gz from Disk..."
	tar xzf "${CDROM_ROOT}"/data/libs-x86.tar.gz -C "$Ddir"
	einfo "Unpacking Ankh.tar.gz from Disk..."
	tar xzf "${CDROM_ROOT}"/data/Ankh.tar.gz -C "$Ddir"

	find "${Ddir}" -exec touch '{}' \;
	# Argh the Program saves the settings in his install dir :(
	# so we have to set some dir to be writeable by the group
	chmod g+w "${Ddir}"/media/     # the settings are saved here
	chmod g+w "${Ddir}"/bin/release # the log-files are saved here
	dosym "${dir}"/Ankh /usr/games/bin/ankh

	prepgamesdirs
	make_desktop_entry ankh "Ankh" "${dir}"/Ankh.xpm
}
