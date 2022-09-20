# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the drone.io docker runner"
KEYWORDS="~amd64"

ACCT_USER_ID=-1
# drone goes first, to make it the primary group
ACCT_USER_GROUPS=( drone-runner-docker docker )

acct-user_add_deps
