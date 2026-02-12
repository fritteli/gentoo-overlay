# Copyright 2026-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-group
DESCRIPTION="Group used for the forgejo-runner"
KEYWORDS="~amd64 ~arm64"

# If you want this to persist across multiple machines, pick a real number!
ACCT_GROUP_ID="-1"
