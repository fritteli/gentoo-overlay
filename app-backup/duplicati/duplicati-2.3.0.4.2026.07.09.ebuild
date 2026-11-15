# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="10.0"
NUGETS="
aliyun.oss.sdk.netcore@2.14.1
alphavss.native.netcore@2.0.3
alphavss@2.0.3
artalk.xmpp@1.0.5
avalonia.angle.windows.natives@2.1.25547.20250602
avalonia.buildservices@11.3.2
avalonia.controls.colorpicker@11.3.13
avalonia.desktop@12.0.2
avalonia.diagnostics@11.3.13
avalonia.freedesktop.atspi@12.0.2
avalonia.freedesktop@12.0.2
avalonia.harfbuzz@12.0.2
avalonia.native@12.0.2
avalonia.remote.protocol@11.3.13
avalonia.remote.protocol@12.0.2
avalonia.skia@12.0.2
avalonia.themes.fluent@12.0.2
avalonia.themes.simple@11.3.13
avalonia.win32@12.0.2
avalonia.x11@12.0.2
avalonia@11.3.13
avalonia@12.0.2
awssdk.core@4.0.0.21
awssdk.core@4.0.3.17
awssdk.core@4.0.3.3
awssdk.identitymanagement@4.0.2.6
awssdk.s3@4.0.6.4
awssdk.secretsmanager.caching@2.0.0
awssdk.secretsmanager@4.0.0.1
awssdk.secretsmanager@4.0.4.9
azure.core@1.44.1
azure.core@1.46.2
azure.core@1.49.0
azure.identity@1.17.0
azure.security.keyvault.secrets@4.8.0
azure.storage.blobs@12.24.1
azure.storage.common@12.23.0
bouncycastle.cryptography@2.6.2
cocol@1.8.4
communitytoolkit.highperformance@8.2.1
coverlet.collector@6.0.4
dnsclient@1.8.0
docker.dotnet.x509@3.125.15
docker.dotnet@3.125.15
docker.dotnet@3.125.5
duplicati.streamutil@1.0.5
fluentftp@52.1.0
glob@1.1.3
google.api.commonprotos@2.17.0
google.api.gax.grpc@4.11.0
google.api.gax.grpc@4.8.0
google.api.gax@4.11.0
google.apis.admin.directory.directory_v1@1.68.0.3428
google.apis.auth@1.67.0
google.apis.auth@1.68.0
google.apis.auth@1.69.0
google.apis.auth@1.70.0
google.apis.calendar.v3@1.68.0.3430
google.apis.core@1.67.0
google.apis.core@1.68.0
google.apis.core@1.69.0
google.apis.core@1.70.0
google.apis.drive.v3@1.68.0.3428
google.apis.gmail.v1@1.68.0.3427
google.apis.groupssettings.v1@1.68.0.2366
google.apis.hangoutschat.v1@1.68.0.3393
google.apis.keep.v1@1.69.0.3729
google.apis.peopleservice.v1@1.69.0.3785
google.apis.tasks.v1@1.68.0.3435
google.apis@1.67.0
google.apis@1.68.0
google.apis@1.69.0
google.apis@1.70.0
google.cloud.iam.v1@3.2.0
google.cloud.location@2.2.0
google.cloud.secretmanager.v1@2.6.0
google.protobuf@3.31.1
grpc.auth@2.71.0
grpc.core.api@2.71.0
grpc.net.client@2.71.0
grpc.net.common@2.71.0
handlebars.net@2.1.6
harfbuzzsharp.nativeassets.linux@8.3.1.3
harfbuzzsharp.nativeassets.macos@8.3.1.3
harfbuzzsharp.nativeassets.webassembly@8.3.1.3
harfbuzzsharp.nativeassets.win32@8.3.1.3
harfbuzzsharp@8.3.1.3
jose-jwt@5.2.0
jsonsignature@1.0.0
mailkit@4.16.0
megaapiclient@1.10.4
meziantou.framework.win32.credentialmanager@1.7.4
microcom.runtime@0.11.4
microsoft.applicationinsights@2.22.0
microsoft.aspnetcore.authentication.jwtbearer@10.0.0
microsoft.aspnetcore.hostfiltering@2.3.0
microsoft.bcl.asyncinterfaces@6.0.0
microsoft.bcl.asyncinterfaces@8.0.0
microsoft.codecoverage@17.14.1
microsoft.data.sqlite.core@9.0.4
microsoft.data.sqlite@9.0.4
microsoft.extensions.apidescription.server@10.0.0
microsoft.extensions.caching.abstractions@10.0.0
microsoft.extensions.caching.abstractions@8.0.0
microsoft.extensions.caching.memory@10.0.0
microsoft.extensions.caching.memory@8.0.1
microsoft.extensions.configuration.abstractions@10.0.0
microsoft.extensions.configuration.abstractions@2.2.0
microsoft.extensions.configuration.binder@10.0.0
microsoft.extensions.configuration.binder@2.2.0
microsoft.extensions.configuration@10.0.0
microsoft.extensions.configuration@2.2.0
microsoft.extensions.dependencyinjection.abstractions@10.0.0
microsoft.extensions.dependencyinjection.abstractions@2.2.0
microsoft.extensions.dependencyinjection.abstractions@6.0.0
microsoft.extensions.dependencyinjection.abstractions@7.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.2
microsoft.extensions.dependencyinjection@10.0.0
microsoft.extensions.dependencyinjection@2.2.0
microsoft.extensions.dependencyinjection@7.0.0
microsoft.extensions.diagnostics.abstractions@10.0.0
microsoft.extensions.diagnostics@10.0.0
microsoft.extensions.http@10.0.0
microsoft.extensions.logging.abstractions@10.0.0
microsoft.extensions.logging.abstractions@2.2.0
microsoft.extensions.logging.abstractions@6.0.0
microsoft.extensions.logging.abstractions@6.0.4
microsoft.extensions.logging.abstractions@7.0.0
microsoft.extensions.logging.abstractions@8.0.0
microsoft.extensions.logging.abstractions@8.0.2
microsoft.extensions.logging.abstractions@8.0.3
microsoft.extensions.logging.configuration@2.2.0
microsoft.extensions.logging.console@2.2.0
microsoft.extensions.logging@10.0.0
microsoft.extensions.logging@2.2.0
microsoft.extensions.logging@7.0.0
microsoft.extensions.options.configurationextensions@10.0.0
microsoft.extensions.options.configurationextensions@2.2.0
microsoft.extensions.options@10.0.0
microsoft.extensions.options@2.2.0
microsoft.extensions.options@7.0.0
microsoft.extensions.options@8.0.2
microsoft.extensions.primitives@10.0.0
microsoft.extensions.primitives@2.2.0
microsoft.extensions.primitives@7.0.0
microsoft.extensions.primitives@8.0.0
microsoft.identity.client.extensions.msal@4.76.0
microsoft.identity.client@4.76.0
microsoft.identitymodel.abstractions@6.35.0
microsoft.identitymodel.abstractions@8.14.0
microsoft.identitymodel.jsonwebtokens@8.14.0
microsoft.identitymodel.logging@8.14.0
microsoft.identitymodel.protocols.openidconnect@8.0.1
microsoft.identitymodel.protocols@8.0.1
microsoft.identitymodel.tokens@8.0.1
microsoft.identitymodel.tokens@8.14.0
microsoft.io.recyclablememorystream@3.0.0
microsoft.net.test.sdk@17.14.1
microsoft.openapi@2.3.0
microsoft.testing.extensions.telemetry@1.5.3
microsoft.testing.extensions.trxreport.abstractions@1.5.3
microsoft.testing.extensions.vstestbridge@1.5.3
microsoft.testing.platform.msbuild@1.5.3
microsoft.testing.platform@1.5.3
microsoft.testplatform.objectmodel@17.12.0
microsoft.testplatform.objectmodel@17.14.1
microsoft.testplatform.testhost@17.14.1
microsoft.visualstudio.threading@16.3.52
microsoft.visualstudio.validation@15.3.15
microsoft.win32.systemevents@10.0.0
mimekit@4.16.0
minio@6.0.0
mono.unix@7.1.0-final.1.21458.1
newtonsoft.json@10.0.2
newtonsoft.json@13.0.1
newtonsoft.json@13.0.3
ngettext@0.6.7
nunit3testadapter@5.0.0
nunit@4.3.2
otp.net@1.4.0
polly@7.1.1
portable.bouncycastle@1.9.0
sharpaescrypt@2.0.3
sharpcompress@0.40.0
sharpziplib@1.3.3
sharpziplib@1.4.2
skiasharp.nativeassets.linux@3.119.4-preview.1.1
skiasharp.nativeassets.macos@3.119.4-preview.1.1
skiasharp.nativeassets.webassembly@3.119.4-preview.1.1
skiasharp.nativeassets.win32@3.119.4-preview.1.1
skiasharp@3.119.4-preview.1.1
smblibrary.win32@1.5.4
smblibrary@1.5.4
sqlite-net-pcl@1.7.335
sqlite-net-pcl@1.9.172
sqlitepclraw.bundle_e_sqlite3@2.1.10
sqlitepclraw.bundle_green@2.1.10
sqlitepclraw.bundle_green@2.1.2
sqlitepclraw.core@2.1.10
sqlitepclraw.lib.e_sqlite3@2.1.10
sqlitepclraw.provider.e_sqlite3@2.1.10
ssh.net@2020.0.2
ssh.net@2024.2.0
ssh.net@2025.1.0
sshnet.agent@2024.2.0.1
sshnet.security.cryptography@1.3.0
swashbuckle.aspnetcore.swagger@10.0.1
swashbuckle.aspnetcore.swaggergen@10.0.1
swashbuckle.aspnetcore.swaggerui@10.0.1
swashbuckle.aspnetcore@10.0.1
system.clientmodel@1.1.0
system.clientmodel@1.7.0
system.codedom@10.0.0
system.codedom@7.0.0
system.commandline.namingconventionbinder@2.0.0-beta4.22272.1
system.commandline@2.0.0-beta4.22272.1
system.componentmodel.annotations@4.5.0
system.diagnostics.eventlog@10.0.0
system.directoryservices@9.0.7
system.drawing.common@10.0.0
system.drawing.common@7.0.0
system.identitymodel.tokens.jwt@8.0.1
system.identitymodel.tokens.jwt@8.14.0
system.io.filesystem.accesscontrol@5.0.0
system.io.hashing@6.0.0
system.io.hashing@7.0.0
system.io.pipelines@10.0.0
system.management@10.0.0
system.management@7.0.2
system.memory.data@1.0.2
system.memory.data@6.0.0
system.memory.data@8.0.1
system.reactive@6.0.0
system.security.cryptography.pkcs@10.0.0
system.security.cryptography.protecteddata@4.5.0
system.security.principal.windows@5.0.0
system.serviceprocess.servicecontroller@10.0.0
tencent.qcloud.cos.sdk@5.4.11
testcontainers.container.abstractions@1.5.4
testcontainers@3.4.0
tmds.dbus.protocol@0.92.0
uplink.net.linux@2.14.3623
uplink.net.mac@2.13.3484
uplink.net.win@2.14.3623
uplink.net@2.14.3623
vanara.core@4.1.2
vanara.core@5.0.0
vanara.pinvoke.cryptography@5.0.0
vanara.pinvoke.gdi32@5.0.0
vanara.pinvoke.kernel32@5.0.0
vanara.pinvoke.ntdsapi@5.0.0
vanara.pinvoke.security@5.0.0
vanara.pinvoke.shared@4.1.2
vanara.pinvoke.shared@5.0.0
vanara.pinvoke.user32@5.0.0
vanara.pinvoke.vssapi@5.0.0
vanara.security@5.0.0
vaultsharp@1.17.5.1
websocket.client@5.2.0
zstdsharp.port@0.8.5
"

inherit check-reqs dotnet-pkg

DESCRIPTION="Backup client that securely stores encrypted, incremental, compressed backups"
HOMEPAGE="https://duplicati.com/
	https://github.com/duplicati/duplicati/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	P_STABILITY="canary"
	EGIT_REPO_URI="https://github.com/${PN}/${PN}"
else
	P_FRONT_V="$(ver_cut 1-4)"
	P_BACK_V="$(ver_cut 5-7)"

	P_STABILITY="stable"
	P_REAL_V="${P_FRONT_V}_${P_STABILITY}_${P_BACK_V//./-}"

	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${P_REAL_V}.tar.gz
		-> ${PN}-${P_REAL_V}.gh.tar.gz"
	S="${WORKDIR}/${PN}-${P_REAL_V}"

	KEYWORDS="~amd64"
fi

# Create the ngclient web content:
# Make sure <srcroot> is named like ${PN}-${P_REAL_V}, i.e.
# duplicati-2.2.0.3_stable_2026-01-06. Then, run these commands:
# $ cd <srcroot>/Duplicati/Server/webroot/ngclient
# $ npm install
# $ mv node_modules/@duplicati/ngclient/* .
# $ rm node_modules
# Edit index.html: set <base href="/ngclient/">
# Make sure to remove index.html~ afterwards.
# $ cd <srcroot>/..
# $ tar --auto-compress -cf duplicati-${P_FRONT_V}.dist.tar.xz <srcroot>/Duplicati/Server/webroot/ngclient

SRC_URI+=" ${NUGET_URIS}
	https://gentoo-overlay.friedli.info/duplicati-${P_FRONT_V}-site.tar.xz"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0/${P_STABILITY}"
RESTRICT="test"  # TODO: Re-enable.

CHECKREQS_DISK_BUILD="3G"
DOTNET_PKG_PROJECTS=(
	Executables/Duplicati.CommandLine
	Executables/Duplicati.Server
)
DOTNET_PKG_BAD_PROJECTS=(
	Duplicati/WindowsService/Duplicati.WindowsService.csproj
	Executables/Duplicati.WindowsService/Duplicati.WindowsService.csproj
)

DOCS=( README.ja-JP.md README.md README.zh-CN.md SECURITY.md changelog.txt )

pkg_setup() {
	check-reqs_pkg_setup
	dotnet-pkg_pkg_setup
}

src_unpack() {
	dotnet-pkg_src_unpack

	if [[ -n "${EGIT_REPO_URI}" ]] ; then
		git-r3_src_unpack
	fi
}

src_prepare() {
	dotnet-pkg_src_prepare

	local -a bad_tests=(
		Duplicati/UnitTest/CompactDisruptionTests.cs
	)
	local bad_test=""
	for bad_test in "${bad_tests[@]}" ; do
		if [[ -e "${S}/${bad_test}" ]] ; then
			rm "${S}/${bad_test}" || eerror "failed to remove test ${bad_test}"
		else
			ewarn "Test file ${bad_test} does not exist"
		fi
	done
}

src_test() {
	dotnet-pkg-base_test Duplicati/UnitTest/Duplicati.UnitTest.csproj
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/Duplicati.CommandLine" duplicati
	dotnet-pkg-base_dolauncher "/usr/share/${P}/Duplicati.Server" duplicati-server

	einstalldocs
}
