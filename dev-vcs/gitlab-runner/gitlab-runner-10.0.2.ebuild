# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit golang-build golang-vcs-snapshot user

EGO_PN="gitlab.com/gitlab-org/gitlab-runner"

GITLAB_COMMIT="413da38a"

MY_PV="v${PV/_/-}"

DESCRIPTION="Official GitLab CI Runner written in Go"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/repository/archive.tar.gz?ref=v${PV} -> ${P}.tar.gz
	!docker-build? (
		https://${PN}-downloads.s3.amazonaws.com/${MY_PV}/docker/prebuilt-x86_64.tar.xz -> ${P}-prebuilt-x86_64.tar.xz
		https://${PN}-downloads.s3.amazonaws.com/${MY_PV}/docker/prebuilt-arm.tar.xz -> ${P}-prebuilt-arm.tar.xz
	)"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE="docker-build"

DEPEND="dev-go/gox
	dev-go/go-bindata
	docker-build? ( >=app-emulation/docker-1.5 )"

RESTRICT="mirror test"

MY_USER="gitlab_runner"
MY_HOME_DIR="/var/lib/gitlab-runner"

pkg_setup() {
	# add required user
	enewgroup ${MY_USER}
	enewuser ${MY_USER} -1 /bin/bash "${MY_HOME_DIR}" ${MY_USER}
}

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
	dobin src/${EGO_PN}/out/binaries/gitlab-runner
	dodoc src/${EGO_PN}/README.md src/${EGO_PN}/CHANGELOG.md

	# rc script
	newinitd "${FILESDIR}/${PN}-10.0.2.init" "${PN}"

	# conf.d file
	local conffile="${PN}-10.0.2.conf"
	cp "${FILESDIR}/${conffile}" "${T}" || die
	sed -i \
		-e "s|@USER@|${MY_USER}|" \
		-e "s|@HOME@|${MY_HOME_DIR}|" \
		"${T}/${conffile}" \
		|| die "failed to filter ${conffile}"

	newconfd "${T}/${conffile}" "${PN}"

	# config dir
	local config_dir="/etc/${PN}"
	diropts -m750
	dodir "${config_dir}"
	fowners -R ${MY_USER}:${MY_USER} "${config_dir}" "${MY_HOME_DIR}"
}
