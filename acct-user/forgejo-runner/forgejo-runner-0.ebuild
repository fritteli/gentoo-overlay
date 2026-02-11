# Copyright 2026-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the forgejo-runner"
KEYWORDS="~amd64"

ACCT_USER_ID=-1
# forgejo-runner goes first, to make it the primary group
ACCT_USER_GROUPS=( forgejo-runner docker )
ACCT_USER_HOME=/var/lib/forgejo-runner
ACCT_USER_HOME_PERMS=0750

acct-user_add_deps
