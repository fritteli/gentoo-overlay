# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-group
DESCRIPTION="Group used for the mautrix signal Matrix bridge"
KEYWORDS="~amd64"

# If you want this to persist across multiple machines, pick a real number!
ACCT_GROUP_ID="-1"
