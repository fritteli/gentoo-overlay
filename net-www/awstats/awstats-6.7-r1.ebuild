# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/awstats/awstats-6.7-r1.ebuild,v 1.1 2007/12/15 09:43:26 hollow Exp $

inherit eutils webapp versionator depend.apache

DESCRIPTION="AWStats is short for Advanced Web Statistics."
HOMEPAGE="http://awstats.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="cgi geoip"

RESTRICT="mirror"

SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

RDEPEND=">=dev-lang/perl-5.6.1
	>=media-libs/libpng-1.2
	virtual/perl-Time-Local
	dev-perl/URI
	geoip? ( dev-perl/Geo-IP )"

want_apache

pkg_setup() {
	if ! use cgi; then
		ewarn "You have not enabled the cgi USE flag."
		ewarn "This means you need to generate static"
		ewarn "HTML statistics instead of using awstats.pl"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-6.3-gentoo.diff

	# change default installation directory
	for file in tools/* wwwroot/cgi-bin/*; do
		if [[ -f "${file}" ]]; then
			sed \
				-e "s#/usr/local/awstats/wwwroot/cgi-bin#${MY_CGIBINDIR}#g" \
				-e "s#/usr/local/awstats/wwwroot/icon#${MY_HTDOCSDIR}/icon#g" \
				-e "s#/usr/local/awstats/wwwroot/plugins#${MY_HOSTROOTDIR}/plugins#g" \
				-e "s#/usr/local/awstats/wwwroot/classes#${MY_HTDOCSDIR}/classes#g" \
				-e "s#/usr/local/awstats/wwwroot#${MY_HTDOCSDIR}#g" \
				-i "${file}" || die "sed ${file} failed"
		fi
	done

	# set the logpath
	if use apache2; then
		logpath="apache2/access_log"
	else
		logpath="awstats_log"
	fi

	# set default values for directories
	sed \
		-e "s|^\(LogFile=\).*$|\1\"/var/log/${logpath}\"|" \
		-e "s|^\(SiteDomain=\).*$|\1\"localhost\"|" \
		-e "s|^\(DirIcons=\).*$|\1\"/awstats/icon\"|" \
		-e "s|^\(DirCgi=\).*$|\1\"/cgi-bin\"|" \
		-i "${S}"/wwwroot/cgi-bin/awstats.model.conf || die "sed failed"
}

src_install() {
	webapp_src_preinst

	dohtml -r docs/*.html docs/*.xml docs/*.css docs/*.js docs/images
	dodoc README.TXT docs/COPYING.TXT docs/LICENSE.TXT
	newdoc wwwroot/cgi-bin/plugins/example/example.pm example_plugin.pm
	docinto xslt
	dodoc tools/xslt/*

	webapp_postinst_txt en "${FILESDIR}"/postinst-en-r1.txt

	keepdir /var/lib/awstats

	# Copy the app's main files
	if use cgi; then
		exeinto "${MY_CGIBINDIR}"
		doexe "${S}"/wwwroot/cgi-bin/*.pl
	fi

	exeinto "${MY_HTDOCSDIR}"/classes
	doexe "${S}"/wwwroot/classes/*.jar

	# install language files, libraries and plugins
	mkdir -p "${D}${MY_CGIBINDIR}"
	for dir in lang lib plugins; do
		cp -R "${S}/wwwroot/cgi-bin/${dir}" "${D}${MY_CGIBINDIR}"
	done

	# install the app's www files
	mkdir -p "${D}${MY_HTDOCSDIR}"
	for dir in icon css js; do
		cp -R "${S}/wwwroot/${dir}" "${D}${MY_HTDOCSDIR}"
	done

	# copy configuration file
	insinto /etc/awstats
	doins "${S}"/wwwroot/cgi-bin/awstats.model.conf

	# create the data directory for awstats
	mkdir -p "${D}/${MY_HOSTROOTDIR}/datadir"

	# install command line tools
	cd "${S}"/tools
	dobin awstats_buildstaticpages.pl awstats_exportlib.pl \
		awstats_updateall.pl logresolvemerge.pl \
		maillogconvert.pl awstats_configure.pl
	newbin urlaliasbuilder.pl awstats_urlaliasbuilder.pl

	webapp_src_install

	# fix perms
	for dir in lang lib plugins; do
		chmod 0755 "${D}${MY_CGIBINDIR}/${dir}"
	done
	for dir in icon css js; do
		chmod 0755 "${D}${MY_HTDOCSDIR}/${dir}"
	done
}

pkg_postinst() {
	elog
	elog "The AWStats-Manual is available either inside"
	elog "the /usr/share/doc/${PF} - folder, or at"
	elog "http://awstats.sourceforge.net/docs/index.html ."
	elog
	ewarn "Copy the /etc/awstats/awstats.model.conf to"
	ewarn "/etc/awstats/awstats.<yourdomain>.conf and edit it."

	if use geoip ; then
		einfo
		einfo "Add the following line to /etc/awstats/awstats.<yourdomain>.conf"
		einfo "to enable GeoIP plugin:"
		einfo "LoadPlugin=\"geoip GEOIP_STANDARD /usr/share/GeoIP/GeoIP.dat\" "
		einfo
	fi

	webapp_pkg_postinst
}
