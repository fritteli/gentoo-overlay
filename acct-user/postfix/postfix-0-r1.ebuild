# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for postfix daemon"
KEYWORDS="~amd64"

ACCT_USER_ID=207
ACCT_USER_GROUPS=( postfix mail dkimsocket )

acct-user_add_deps
