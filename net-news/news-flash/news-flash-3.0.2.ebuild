# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	adler32@1.2.0
	aes@0.7.5
	aho-corasick@1.1.1
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	ammonia@3.3.0
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.5.0
	anstyle@1.0.3
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	anyhow@1.0.75
	arc-swap@1.6.0
	article_scraper@1.1.7
	ashpd@0.6.2
	async-broadcast@0.5.1
	async-channel@1.9.0
	async-compression@0.4.3
	async-executor@1.5.3
	async-fs@1.6.0
	async-global-executor@2.3.1
	async-io@1.13.0
	async-lock@2.8.0
	async-process@1.8.0
	async-recursion@1.0.5
	async-signal@0.2.1
	async-std@1.12.0
	async-task@4.4.1
	async-trait@0.1.73
	atomic-waker@1.1.2
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.13.1
	base64@0.21.4
	bigdecimal@0.4.1
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.4.0
	block@0.1.6
	block-buffer@0.9.0
	block-buffer@0.10.4
	block-modes@0.8.1
	block-padding@0.2.1
	blocking@1.4.0
	brotli@3.3.4
	brotli-decompressor@2.3.4
	bumpalo@3.14.0
	bytemuck@1.14.0
	byteorder@1.4.3
	bytes@1.5.0
	bytesize@1.3.0
	cairo-rs@0.18.2
	cairo-sys-rs@0.18.2
	cc@1.0.83
	cfg-expr@0.15.5
	cfg-if@1.0.0
	chrono@0.4.31
	cipher@0.3.0
	clap@4.4.5
	clap_builder@4.4.5
	clap_derive@4.4.2
	clap_lex@0.5.1
	color-backtrace@0.6.0
	color_quant@1.1.0
	colorchoice@1.0.0
	concurrent-queue@2.3.0
	cookie@0.16.2
	cookie_store@0.16.2
	core-foundation@0.9.3
	core-foundation-sys@0.8.4
	cpufeatures@0.2.9
	crc-any@2.4.3
	crc32fast@1.3.2
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	crunchy@0.2.2
	crypto-common@0.1.6
	data-encoding@2.4.0
	debug-helper@0.3.13
	deflate@0.8.6
	deranged@0.3.8
	derivative@2.2.0
	des@0.7.0
	destructure_traitobject@0.2.0
	diesel@2.1.2
	diesel_derives@2.1.2
	diesel_migrations@2.1.0
	diesel_table_macro_syntax@0.1.0
	diffus@0.10.0
	diffus-derive@0.10.0
	digest@0.9.0
	digest@0.10.7
	dirs@4.0.0
	dirs@5.0.1
	dirs-sys@0.3.7
	dirs-sys@0.4.1
	either@1.9.0
	encoding_rs@0.8.33
	entities@1.0.1
	enum-as-inner@0.5.1
	enumflags2@0.7.8
	enumflags2_derive@0.7.8
	equivalent@1.0.1
	errno@0.3.3
	errno-dragonfly@0.1.2
	escaper@0.1.1
	event-listener@2.5.3
	event-listener@3.0.0
	exr@1.71.0
	eyre@0.6.8
	failure@0.1.8
	failure_derive@0.1.8
	fastrand@1.9.0
	fastrand@2.0.1
	fdeflate@0.3.0
	feed-rs@1.3.0
	feedbin_api@0.1.8
	feedly_api@0.4.8
	feedly_api@0.5.1
	fever_api@0.2.11
	field-offset@0.3.6
	flate2@1.0.27
	flume@0.11.0
	fnv@1.0.7
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	form_urlencoded@1.2.0
	futf@0.1.5
	futures@0.3.28
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-lite@1.13.0
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	gdk-pixbuf@0.18.0
	gdk-pixbuf-sys@0.18.0
	gdk4@0.7.3
	gdk4-sys@0.7.2
	generic-array@0.14.7
	getrandom@0.1.16
	getrandom@0.2.10
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gif@0.11.4
	gif@0.12.0
	gimli@0.28.0
	gio@0.18.2
	gio-sys@0.18.1
	glib@0.18.2
	glib-macros@0.18.2
	glib-sys@0.18.1
	gloo-timers@0.2.6
	gobject-sys@0.18.0
	graphene-rs@0.18.1
	graphene-sys@0.18.1
	greader_api@0.3.4
	gsk4@0.7.3
	gsk4-sys@0.7.3
	gtk4@0.7.3
	gtk4-macros@0.7.2
	gtk4-sys@0.7.3
	h2@0.3.21
	half@2.2.1
	hard-xml@1.27.0
	hard-xml-derive@1.27.0
	hashbrown@0.12.3
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.3.3
	hex@0.4.3
	hostname@0.3.1
	html2pango@0.5.0
	html5ever@0.26.0
	http@0.2.9
	http-body@0.4.5
	httparse@1.8.0
	httpdate@1.0.3
	humantime@2.1.0
	hyper@0.14.27
	hyper-rustls@0.24.1
	hyper-tls@0.5.0
	iana-time-zone@0.1.57
	iana-time-zone-haiku@0.1.2
	idna@0.2.3
	idna@0.3.0
	idna@0.4.0
	image@0.23.14
	image@0.24.7
	indenter@0.3.3
	indexmap@1.9.3
	indexmap@2.0.1
	instant@0.1.12
	io-lifetimes@1.0.11
	ipconfig@0.3.2
	ipnet@2.8.0
	ipnetwork@0.20.0
	itertools@0.10.5
	itoa@1.0.9
	javascriptcore6@0.2.0
	javascriptcore6-sys@0.2.0
	jetscii@0.5.3
	jpeg-decoder@0.1.22
	jpeg-decoder@0.3.0
	js-sys@0.3.64
	kv-log-macro@1.0.7
	lazy_static@1.4.0
	lebe@0.5.2
	libadwaita@0.5.3
	libadwaita-sys@0.5.3
	libc@0.2.148
	libm@0.2.7
	libsqlite3-sys@0.26.0
	libxml@0.2.16
	libxml@0.3.3
	linked-hash-map@0.5.6
	linkify@0.9.0
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.7
	locale_config@0.3.0
	lock_api@0.4.10
	log@0.4.20
	log-mdc@0.1.0
	log4rs@1.2.0
	lru-cache@0.1.2
	mac@0.1.1
	magic-crypt@3.1.12
	malloc_buf@0.0.6
	maplit@1.0.2
	markup5ever@0.11.0
	markup5ever_rcdom@0.2.0
	match_cfg@0.1.0
	matches@0.1.10
	md-5@0.9.1
	md5@0.7.0
	memchr@2.6.3
	memoffset@0.7.1
	memoffset@0.9.0
	migrations_internals@2.1.0
	migrations_macros@2.1.0
	mime@0.3.17
	mime_guess@2.0.4
	miniflux_api@0.4.0
	miniz_oxide@0.3.7
	miniz_oxide@0.4.4
	miniz_oxide@0.7.1
	mio@0.8.8
	native-tls@0.2.11
	new_debug_unreachable@1.0.4
	newsblur_api@0.1.2
	nextcloud_news_api@0.1.1
	nix@0.26.4
	num-bigint@0.4.4
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.3.2
	num-rational@0.4.1
	num-traits@0.2.16
	num_cpus@1.16.0
	obfstr@0.4.3
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	object@0.32.1
	once_cell@1.18.0
	opaque-debug@0.3.0
	openssl@0.10.57
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.93
	opml@1.1.5
	option-ext@0.2.0
	ordered-float@2.10.0
	ordered-stream@0.2.0
	pango@0.18.0
	pango-sys@0.18.0
	parking@2.1.1
	parking_lot@0.11.2
	parking_lot@0.12.1
	parking_lot_core@0.8.6
	parking_lot_core@0.9.8
	percent-encoding@2.3.0
	phf@0.10.1
	phf_codegen@0.10.0
	phf_generator@0.10.0
	phf_shared@0.10.0
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	piper@0.2.1
	pkg-config@0.3.27
	png@0.16.8
	png@0.17.10
	polling@2.8.0
	ppv-lite86@0.2.17
	precomputed-hash@0.1.1
	proc-macro-crate@1.3.1
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.67
	psl-types@2.0.11
	publicsuffix@2.2.3
	qoi@0.4.1
	quick-error@1.2.3
	quick-xml@0.27.1
	quote@1.0.33
	r2d2@0.8.10
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_chacha@0.3.1
	rand_core@0.5.1
	rand_core@0.6.4
	rand_hc@0.2.0
	rand_pcg@0.2.1
	random_color@0.6.1
	rayon@1.8.0
	rayon-core@1.12.0
	rc-writer@1.1.10
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex@1.9.5
	regex-automata@0.3.8
	regex-syntax@0.7.5
	reqwest@0.11.20
	resolv-conf@0.7.0
	ring@0.16.20
	rust-embed@6.8.1
	rust-embed@8.0.0
	rust-embed-impl@6.8.1
	rust-embed-impl@8.0.0
	rust-embed-utils@7.8.1
	rust-embed-utils@8.0.0
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.37.23
	rustix@0.38.14
	rustls@0.21.7
	rustls-pemfile@1.0.3
	rustls-webpki@0.101.6
	ryu@1.0.15
	same-file@1.0.6
	schannel@0.1.22
	scheduled-thread-pool@0.2.7
	scoped_threadpool@0.1.9
	scopeguard@1.2.0
	sct@0.7.0
	security-framework@2.9.2
	security-framework-sys@2.9.1
	semver@1.0.19
	serde@1.0.188
	serde-value@0.7.0
	serde_derive@1.0.188
	serde_json@1.0.107
	serde_repr@0.1.16
	serde_spanned@0.6.3
	serde_urlencoded@0.7.1
	serde_yaml@0.8.26
	sha1@0.10.6
	sha2@0.9.9
	sha2@0.10.8
	shellexpand@2.1.2
	signal-hook-registry@1.4.1
	simd-adler32@0.3.7
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.11.1
	socket2@0.4.9
	socket2@0.5.4
	soup3@0.5.0
	soup3-sys@0.5.0
	spin@0.5.2
	spin@0.9.8
	static_assertions@1.1.0
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.37
	synstructure@0.12.6
	system-deps@6.1.1
	target-lexicon@0.12.11
	temp-dir@0.1.11
	tempfile@3.8.0
	tendril@0.4.3
	termcolor@1.3.0
	thiserror@1.0.49
	thiserror-impl@1.0.49
	thread-id@4.2.0
	tiff@0.6.1
	tiff@0.9.0
	tiger@0.1.0
	time@0.3.29
	time-core@0.1.2
	time-macros@0.2.15
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.32.0
	tokio-macros@2.1.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-socks@0.5.1
	tokio-util@0.7.9
	toml@0.7.8
	toml_datetime@0.6.3
	toml_edit@0.19.15
	tower-service@0.3.2
	tracing@0.1.37
	tracing-attributes@0.1.26
	tracing-core@0.1.31
	trust-dns-proto@0.22.0
	trust-dns-resolver@0.22.0
	try-lock@0.2.4
	typemap-ors@1.0.0
	typenum@1.17.0
	uds_windows@1.0.2
	unicase@2.7.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	unicode-xid@0.2.4
	unsafe-any-ors@1.0.0
	untrusted@0.7.1
	url@2.4.1
	utf-8@0.7.6
	utf8parse@0.2.1
	uuid@1.4.1
	value-bag@1.4.1
	vcpkg@0.2.15
	version-compare@0.1.1
	version_check@0.9.4
	waker-fn@1.1.1
	walkdir@2.4.0
	want@0.3.1
	wasi@0.9.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.87
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-shared@0.2.87
	web-sys@0.3.64
	webkit6@0.2.0
	webkit6-sys@0.2.0
	webpki-roots@0.25.2
	weezl@0.1.7
	widestring@1.0.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.48.0
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@0.5.15
	winreg@0.50.0
	xdg-home@1.0.0
	xml-rs@0.8.19
	xml5ever@0.17.0
	xmlparser@0.13.5
	xmltree@0.10.3
	yaml-rust@0.4.5
	zbus@3.14.1
	zbus_macros@3.14.1
	zbus_names@2.6.0
	zune-inflate@0.2.54
	zvariant@3.15.0
	zvariant_derive@3.15.0
	zvariant_utils@1.0.1
"

declare -A GIT_CRATES=(
	[news-flash]="https://gitlab.com/news-flash/news_flash;1e1ae1d7a8750ba23053de7bef84110bca805725;news_flash-%commit%/"
)

inherit cargo meson xdg-utils

MY_PN="news_flash_gtk"
MY_PV="v.${PV}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Feed Reader written in GTK"
HOMEPAGE="https://gitlab.com/news-flash/news_flash_gtk"
SRC_URI="https://gitlab.com/${PN}/${MY_PN}/-/archive/${MY_PV}/${MY_P}.tar.bz2 -> ${P}.tar.bz2
${CARGO_CRATE_URIS}"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 GPL-3+ ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-libs/glib-2.70
	>=dev-libs/gobject-introspection-2.70
	>=gui-libs/gtk-4.12
	>=gui-libs/libadwaita-1.4.0
	>=net-libs/webkit-gtk-2.42:6"
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
