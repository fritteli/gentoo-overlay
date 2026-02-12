# Copyright 2026-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the forgejo-runner"
KEYWORDS="~amd64 ~arm64"
IUSE="docker"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( forgejo-runner )
ACCT_USER_HOME=/var/lib/forgejo-runner
ACCT_USER_HOME_PERMS=0750

pkg_setup() {
	use docker && ACCT_USER_GROUPS+=( docker )
}

acct-user_add_deps
