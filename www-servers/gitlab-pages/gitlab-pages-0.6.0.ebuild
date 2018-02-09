# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="gitlab.com/gitlab-org/gitlab-pages/..."

EGIT_COMMIT="15c938ca"
MY_PV="v${PV/_/-}"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.bz2?ref=${MY_PV} -> ${P}.tar.bz2"

EGO_BUILD_FLAGS="-ldflags '-X main.VERSION=${PV} -X main.REVISION=${EGIT_COMMIT}'"

inherit eutils golang-build golang-vcs-snapshot user

DESCRIPTION="Simple HTTP server written in Go made to serve GitLab Pages with CNAMEs and SNI"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-pages"

KEYWORDS="~amd64 ~x86 ~arm ~arm64"
LICENSE="MIT"
SLOT="0/${PVR}"

DEPEND=">=dev-lang/go-1.8.3"

RESTRICT="test mirror"

MY_USER="gitlab_pages"

pkg_setup() {
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 -1 -1 ${MY_USER}
}

src_compile() {
	# silly golang-build_src_compile doesn't work. some crap about
	# escaping ...
	ego_pn_check
	set -- env GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go build -v -work -x -ldflags "-X main.VERSION=${PV} -X main.REVISION=${EGIT_COMMIT}" "${EGO_PN}"
	echo "$@"
	"$@" || die
}

src_install() {
	# silly golang-build_src_install doesn't work. some crap about
	# escaping ...
	ego_pn_check
	set -- env GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x -ldflags "-X main.VERSION=${PV} -X main.REVISION=${EGIT_COMMIT}" "${EGO_PN}"
	echo "$@"
	"$@" || die
	golang_install_pkgs

	dobin bin/*
	dodoc src/${EGO_PN%/*}/README.md src/${EGO_PN%/*}/CHANGELOG

	# rc script
	local rcscript="${PN}-0.3.2.init"

	cp "${FILESDIR}/${rcscript}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|g" \
		"${T}/${rcscript}" \
		|| die "failed to filter ${rcscript}"

	newinitd "${T}/${rcscript}" "${PN}"
	newconfd "${FILESDIR}/${PN}-0.3.2.conf" "${PN}"
}
