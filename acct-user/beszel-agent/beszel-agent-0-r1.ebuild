# Copyright 2019-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the Beszel monitoring agent"
KEYWORDS="~amd64"
IUSE="docker"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( beszel )

pkg_setup() {
	use docker && ACCT_USER_GROUPS+=( docker )
}

acct-user_add_deps
