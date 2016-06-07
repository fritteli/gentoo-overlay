# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PHP_EXT_NAME="geoip"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README ChangeLog"
MY_PV="1.1.0"

USE_PHP="php7-0"

inherit eutils php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension to map IP address to geographic places"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/geoip-1.4.0"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-patch-to-svn-r337409.patch"
)

# apply patches in unpack phase, or else the php7.0 dir won't get patched
src_prepare() {
	local slot
	local p
	for slot in $(php_get_slots) ; do
		cd "${WORKDIR}/${slot}"
		for p in "${PATCHES[@]}" ; do
			epatch "${p}"
		done
	done

	php-ext-source-r2_src_prepare
}
