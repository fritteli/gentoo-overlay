# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=MIKO
DIST_VERSION=1.26
inherit perl-module

DESCRIPTION="String::Util -- String processing utilities"
SLOT="0"
LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )" # Artistic or GPL1+
KEYWORDS="~amd64 ~arm ~x86 ~x86-solaris"
IUSE=""

DEPEND="dev-perl/Module-Build
"