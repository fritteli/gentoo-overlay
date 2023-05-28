# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_PN="GeoIP2-python"

DESCRIPTION="MaxMind GeoIP2 API"
HOMEPAGE="https://github.com/maxmind/GeoIP2-python"
SRC_URI="https://github.com/maxmind/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	>=dev-python/requests-2.24.0[${PYTHON_USEDEP}]
	>=dev-python/maxminddb-2.0.0[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${PV}"
