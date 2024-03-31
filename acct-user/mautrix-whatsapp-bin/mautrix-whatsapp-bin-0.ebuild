# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the mautrix-whatsapp Matrix bridge"
KEYWORDS="~amd64"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( mautrix-whatsapp-bin )
ACCT_USER_HOME=/opt/mautrix-whatsapp

acct-user_add_deps
