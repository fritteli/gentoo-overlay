# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{8..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python MaxMind DB reader extension"
HOMEPAGE="https://github.com/maxmind/MaxMind-DB-Reader-python"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-libs/libmaxminddb
"
