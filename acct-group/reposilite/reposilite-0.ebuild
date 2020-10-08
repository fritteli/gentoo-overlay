# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-group
DESCRIPTION="Group used for the reposilite maven repo server"
KEYWORDS="~amd64"

# If you want this to persist across multiple machines, pick a real number!
ACCT_GROUP_ID="-1"
