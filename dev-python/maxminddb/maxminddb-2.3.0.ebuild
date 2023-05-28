# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_PN="MaxMind-DB-Reader-python"

DESCRIPTION="Python MaxMind DB reader extension"
HOMEPAGE="https://github.com/maxmind/MaxMind-DB-Reader-python"
SRC_URI="https://github.com/maxmind/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> #${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-libs/libmaxminddb
"

S="${WORKDIR}/${MY_PN}-${PV}"
