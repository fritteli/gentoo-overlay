# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-group
DESCRIPTION="Group used for the apache_exporter prometheus plugin"
KEYWORDS="~amd64"

# If you want this to persist across multiple machines, pick a real number!
ACCT_GROUP_ID="-1"
