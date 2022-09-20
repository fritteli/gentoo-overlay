# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11} )
inherit meson python-single-r1

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A markup language for GTK user interface files."
HOMEPAGE="https://gitlab.gnome.org/jwestman/blueprint-compiler"
SRC_URI="https://gitlab.gnome.org/jwestman/${PN}/-/archive/${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE+="${PYTHON_REQUIRED_USE}"

RESTRICT="mirror"

RDEPEND="${PYTHON_DEPS}"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
