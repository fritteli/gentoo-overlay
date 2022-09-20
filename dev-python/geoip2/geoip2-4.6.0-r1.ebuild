# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit distutils-r1

DESCRIPTION="MaxMind GeoIP2 API"
HOMEPAGE="https://github.com/maxmind/GeoIP2-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	>=dev-python/requests-2.24.0[${PYTHON_USEDEP}]
	>=dev-python/maxminddb-2.0.0[${PYTHON_USEDEP}]
"
