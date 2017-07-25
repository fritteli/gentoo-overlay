# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit golang-build golang-vcs-snapshot

EGO_PN="gitlab.com/gitlab-org/gitlab-ci-multi-runner"

GITLAB_COMMIT="3df822b2"

DESCRIPTION="Official GitLab CI Runner written in Go"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci-multi-runner"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.gz?ref=v${PV} -> ${P}.tar.gz
	!docker-build? ( https://dev.gentoo.org/~mrueg/files/${P}-prebuilt-x86_64.tar.xz
		https://dev.gentoo.org/~mrueg/files/${P}-prebuilt-arm.tar.xz )"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE="docker-build"

DEPEND="dev-go/gox
	dev-go/go-bindata
	docker-build? ( >=app-emulation/docker-1.5 )"

RESTRICT="test"

src_prepare() {
	default
	pushd src/${EGO_PN} || die
	if ! use docker-build; then
		mkdir -p out/docker || die
		cp "${DISTDIR}"/${P}-prebuilt-x86_64.tar.xz out/docker/prebuilt-x86_64.tar.xz || die
		cp "${DISTDIR}"/${P}-prebuilt-arm.tar.xz out/docker/prebuilt-arm.tar.xz || die
		sed -i -e "s/docker info/echo false/" Makefile || die
	else
		einfo "You need to have docker running on your system during build time"
		einfo "$(docker info)"
	fi
	sed -i -e "s#./ci/version#echo ${PV}#"\
		-e "s/git rev-parse --short HEAD/echo ${GITLAB_COMMIT}/"\
		-e "/^LATEST_STABLE_TAG/d"\
		-e "s#git show-ref.*\$#echo gentoo)#"\
		-e "s#git describe.*\$#echo 0), 0)#"\
		Makefile || die
	popd || die
}

src_compile() {
	emake GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" RELEASE=true -C src/${EGO_PN} build_current
}

src_install() {
	newbin src/${EGO_PN}/out/binaries/gitlab-ci-multi-runner gitlab-runner
	dodoc src/${EGO_PN}/README.md src/${EGO_PN}/CHANGELOG.md
}
