# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for the reposilite maven repo server"
KEYWORDS="~amd64"

ACCT_USER_ID=-1
# drone goes first, to make it the primary group
ACCT_USER_GROUPS=( reposilite docker )

acct-user_add_deps
