# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for the apache_exporter prometheus plugin"
KEYWORDS="~amd64"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( apache_exporter )

acct-user_add_deps
