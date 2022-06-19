# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A markup language for GTK user interface files."
HOMEPAGE="https://gitlab.gnome.org/jwestman/blueprint-compiler"
SRC_URI="https://gitlab.gnome.org/jwestman/${PN}/-/archive/${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

RDEPEND=">=dev-lang/python-3:*"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
