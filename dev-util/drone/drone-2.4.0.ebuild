# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit go-module systemd
# see go.sum in the repo
EGO_SUM=(
"cloud.google.com/go v0.26.0/go.mod"
"docker.io/go-docker v1.0.0/go.mod"
"github.com/99designs/httpsignatures-go v0.0.0-20170731043157-88528bf4ca7e"
"github.com/99designs/httpsignatures-go v0.0.0-20170731043157-88528bf4ca7e/go.mod"
"github.com/Azure/azure-pipeline-go v0.2.1"
"github.com/Azure/azure-pipeline-go v0.2.1/go.mod"
"github.com/Azure/azure-storage-blob-go v0.7.0"
"github.com/Azure/azure-storage-blob-go v0.7.0/go.mod"
"github.com/Azure/go-ansiterm v0.0.0-20170929234023-d6e3b3328b78"
"github.com/Azure/go-ansiterm v0.0.0-20170929234023-d6e3b3328b78/go.mod"
"github.com/Azure/go-autorest/autorest v0.9.0"
"github.com/Azure/go-autorest/autorest v0.9.0/go.mod"
"github.com/Azure/go-autorest/autorest/adal v0.5.0/go.mod"
"github.com/Azure/go-autorest/autorest/adal v0.8.3"
"github.com/Azure/go-autorest/autorest/adal v0.8.3/go.mod"
"github.com/Azure/go-autorest/autorest/date v0.1.0/go.mod"
"github.com/Azure/go-autorest/autorest/date v0.2.0"
"github.com/Azure/go-autorest/autorest/date v0.2.0/go.mod"
"github.com/Azure/go-autorest/autorest/mocks v0.1.0/go.mod"
"github.com/Azure/go-autorest/autorest/mocks v0.2.0/go.mod"
"github.com/Azure/go-autorest/autorest/mocks v0.3.0"
"github.com/Azure/go-autorest/autorest/mocks v0.3.0/go.mod"
"github.com/Azure/go-autorest/logger v0.1.0"
"github.com/Azure/go-autorest/logger v0.1.0/go.mod"
"github.com/Azure/go-autorest/tracing v0.5.0"
"github.com/Azure/go-autorest/tracing v0.5.0/go.mod"
"github.com/BurntSushi/toml v0.3.1/go.mod"
"github.com/Microsoft/go-winio v0.4.11"
"github.com/Microsoft/go-winio v0.4.11/go.mod"
"github.com/alecthomas/template v0.0.0-20160405071501-a0175ee3bccc/go.mod"
"github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf/go.mod"
"github.com/asaskevich/govalidator v0.0.0-20180315120708-ccb8e960c48f"
"github.com/asaskevich/govalidator v0.0.0-20180315120708-ccb8e960c48f/go.mod"
"github.com/aws/aws-sdk-go v1.37.3"
"github.com/aws/aws-sdk-go v1.37.3/go.mod"
"github.com/beorn7/perks v0.0.0-20180321164747-3a771d992973"
"github.com/beorn7/perks v0.0.0-20180321164747-3a771d992973/go.mod"
"github.com/bmatcuk/doublestar v1.1.1"
"github.com/bmatcuk/doublestar v1.1.1/go.mod"
"github.com/buildkite/yaml v2.1.0+incompatible"
"github.com/buildkite/yaml v2.1.0+incompatible/go.mod"
"github.com/census-instrumentation/opencensus-proto v0.2.1/go.mod"
"github.com/cespare/xxhash/v2 v2.1.1"
"github.com/cespare/xxhash/v2 v2.1.1/go.mod"
"github.com/chzyer/logex v1.1.10/go.mod"
"github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod"
"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
"github.com/client9/misspell v0.3.4/go.mod"
"github.com/cncf/udpa/go v0.0.0-20191209042840-269d4d468f6f/go.mod"
"github.com/codegangsta/negroni v1.0.0"
"github.com/codegangsta/negroni v1.0.0/go.mod"
"github.com/containerd/containerd v1.3.4"
"github.com/containerd/containerd v1.3.4/go.mod"
"github.com/coreos/go-semver v0.2.0"
"github.com/coreos/go-semver v0.2.0/go.mod"
"github.com/davecgh/go-spew v1.1.0/go.mod"
"github.com/davecgh/go-spew v1.1.1"
"github.com/davecgh/go-spew v1.1.1/go.mod"
"github.com/dchest/authcookie v0.0.0-20120917135355-fbdef6e99866"
"github.com/dchest/authcookie v0.0.0-20120917135355-fbdef6e99866/go.mod"
"github.com/dchest/uniuri v0.0.0-20160212164326-8902c56451e9"
"github.com/dchest/uniuri v0.0.0-20160212164326-8902c56451e9/go.mod"
"github.com/dgrijalva/jwt-go v3.2.0+incompatible"
"github.com/dgrijalva/jwt-go v3.2.0+incompatible/go.mod"
"github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f"
"github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f/go.mod"
"github.com/docker/distribution v0.0.0-20170726174610-edc3ab29cdff/go.mod"
"github.com/docker/distribution v2.7.1+incompatible"
"github.com/docker/distribution v2.7.1+incompatible/go.mod"
"github.com/docker/engine v17.12.0-ce-rc1.0.20200309214505-aa6a9891b09c+incompatible"
"github.com/docker/engine v17.12.0-ce-rc1.0.20200309214505-aa6a9891b09c+incompatible/go.mod"
"github.com/docker/go-connections v0.3.0"
"github.com/docker/go-connections v0.3.0/go.mod"
"github.com/docker/go-units v0.3.3"
"github.com/docker/go-units v0.3.3/go.mod"
"github.com/drone/drone-go v1.4.1-0.20201109202657-b9e58bbbcf27"
"github.com/drone/drone-go v1.4.1-0.20201109202657-b9e58bbbcf27/go.mod"
"github.com/drone/drone-runtime v1.0.7-0.20190729202838-87c84080f4a1/go.mod"
"github.com/drone/drone-runtime v1.1.1-0.20200623162453-61e33e2cab5d"
"github.com/drone/drone-runtime v1.1.1-0.20200623162453-61e33e2cab5d/go.mod"
"github.com/drone/drone-ui v2.0.1+incompatible"
"github.com/drone/drone-ui v2.0.1+incompatible/go.mod"
"github.com/drone/drone-ui v2.1.0+incompatible"
"github.com/drone/drone-ui v2.1.0+incompatible/go.mod"
"github.com/drone/drone-ui v2.2.0+incompatible"
"github.com/drone/drone-ui v2.2.0+incompatible/go.mod"
"github.com/drone/drone-ui v2.2.1+incompatible"
"github.com/drone/drone-ui v2.2.1+incompatible/go.mod"
"github.com/drone/drone-ui v2.3.0+incompatible"
"github.com/drone/drone-ui v2.3.0+incompatible/go.mod"
"github.com/drone/drone-yaml v1.2.4-0.20200326192514-6f4d6dfb39e4"
"github.com/drone/drone-yaml v1.2.4-0.20200326192514-6f4d6dfb39e4/go.mod"
"github.com/drone/envsubst v1.0.3-0.20200709231038-aa43e1c1a629"
"github.com/drone/envsubst v1.0.3-0.20200709231038-aa43e1c1a629/go.mod"
"github.com/drone/funcmap v0.0.0-20210823160631-9e9dec149056"
"github.com/drone/funcmap v0.0.0-20210823160631-9e9dec149056/go.mod"
"github.com/drone/go-license v1.0.2"
"github.com/drone/go-license v1.0.2/go.mod"
"github.com/drone/go-login v1.0.4-0.20190311170324-2a4df4f242a2"
"github.com/drone/go-login v1.0.4-0.20190311170324-2a4df4f242a2/go.mod"
"github.com/drone/go-scm v1.15.2"
"github.com/drone/go-scm v1.15.2/go.mod"
"github.com/drone/signal v1.0.0"
"github.com/drone/signal v1.0.0/go.mod"
"github.com/dustin/go-humanize v1.0.0"
"github.com/dustin/go-humanize v1.0.0/go.mod"
"github.com/envoyproxy/go-control-plane v0.9.0/go.mod"
"github.com/envoyproxy/go-control-plane v0.9.4/go.mod"
"github.com/envoyproxy/protoc-gen-validate v0.1.0/go.mod"
"github.com/fatih/color v1.9.0/go.mod"
"github.com/fsnotify/fsnotify v1.4.7/go.mod"
"github.com/fsnotify/fsnotify v1.4.9"
"github.com/fsnotify/fsnotify v1.4.9/go.mod"
"github.com/ghodss/yaml v1.0.0"
"github.com/ghodss/yaml v1.0.0/go.mod"
"github.com/go-chi/chi v3.3.3+incompatible"
"github.com/go-chi/chi v3.3.3+incompatible/go.mod"
"github.com/go-chi/cors v1.0.0"
"github.com/go-chi/cors v1.0.0/go.mod"
"github.com/go-redis/redis v6.15.9+incompatible"
"github.com/go-redis/redis v6.15.9+incompatible/go.mod"
"github.com/go-redis/redis/v7 v7.4.0"
"github.com/go-redis/redis/v7 v7.4.0/go.mod"
"github.com/go-redis/redis/v8 v8.1.1/go.mod"
"github.com/go-redis/redis/v8 v8.11.0"
"github.com/go-redis/redis/v8 v8.11.0/go.mod"
"github.com/go-redsync/redsync/v4 v4.3.0"
"github.com/go-redsync/redsync/v4 v4.3.0/go.mod"
"github.com/go-sql-driver/mysql v1.4.0"
"github.com/go-sql-driver/mysql v1.4.0/go.mod"
"github.com/gogo/protobuf v0.0.0-20170307180453-100ba4e88506"
"github.com/gogo/protobuf v0.0.0-20170307180453-100ba4e88506/go.mod"
"github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b/go.mod"
"github.com/golang/groupcache v0.0.0-20200121045136-8c9f03a8e57e/go.mod"
"github.com/golang/mock v1.1.1/go.mod"
"github.com/golang/mock v1.3.1"
"github.com/golang/mock v1.3.1/go.mod"
"github.com/golang/protobuf v1.2.0/go.mod"
"github.com/golang/protobuf v1.3.1/go.mod"
"github.com/golang/protobuf v1.3.2/go.mod"
"github.com/golang/protobuf v1.3.3/go.mod"
"github.com/golang/protobuf v1.4.0-rc.1/go.mod"
"github.com/golang/protobuf v1.4.0-rc.1.0.20200221234624-67d41d38c208/go.mod"
"github.com/golang/protobuf v1.4.0-rc.2/go.mod"
"github.com/golang/protobuf v1.4.0-rc.4.0.20200313231945-b860323f09d0/go.mod"
"github.com/golang/protobuf v1.4.0/go.mod"
"github.com/golang/protobuf v1.4.2"
"github.com/golang/protobuf v1.4.2/go.mod"
"github.com/gomodule/redigo v1.8.2"
"github.com/gomodule/redigo v1.8.2/go.mod"
"github.com/google/btree v0.0.0-20180813153112-4030bb1f1f0c/go.mod"
"github.com/google/go-cmp v0.2.0/go.mod"
"github.com/google/go-cmp v0.3.0/go.mod"
"github.com/google/go-cmp v0.3.1/go.mod"
"github.com/google/go-cmp v0.4.0/go.mod"
"github.com/google/go-cmp v0.5.1/go.mod"
"github.com/google/go-cmp v0.5.6"
"github.com/google/go-cmp v0.5.6/go.mod"
"github.com/google/go-jsonnet v0.17.0"
"github.com/google/go-jsonnet v0.17.0/go.mod"
"github.com/google/gofuzz v0.0.0-20170612174753-24818f796faf/go.mod"
"github.com/google/wire v0.2.1"
"github.com/google/wire v0.2.1/go.mod"
"github.com/googleapis/gnostic v0.2.0/go.mod"
"github.com/gorilla/mux v1.7.4"
"github.com/gorilla/mux v1.7.4/go.mod"
"github.com/gosimple/slug v1.3.0"
"github.com/gosimple/slug v1.3.0/go.mod"
"github.com/gregjones/httpcache v0.0.0-20181110185634-c63ab54fda8f/go.mod"
"github.com/h2non/parth v0.0.0-20190131123155-b4df798d6542"
"github.com/h2non/parth v0.0.0-20190131123155-b4df798d6542/go.mod"
"github.com/hashicorp/errwrap v1.0.0"
"github.com/hashicorp/errwrap v1.0.0/go.mod"
"github.com/hashicorp/go-cleanhttp v0.5.0/go.mod"
"github.com/hashicorp/go-cleanhttp v0.5.1"
"github.com/hashicorp/go-cleanhttp v0.5.1/go.mod"
"github.com/hashicorp/go-multierror v1.1.0"
"github.com/hashicorp/go-multierror v1.1.0/go.mod"
"github.com/hashicorp/go-retryablehttp v0.5.4"
"github.com/hashicorp/go-retryablehttp v0.5.4/go.mod"
"github.com/hashicorp/golang-lru v0.5.0/go.mod"
"github.com/hashicorp/golang-lru v0.5.1"
"github.com/hashicorp/golang-lru v0.5.1/go.mod"
"github.com/hpcloud/tail v1.0.0/go.mod"
"github.com/imdario/mergo v0.3.6/go.mod"
"github.com/jmespath/go-jmespath v0.4.0"
"github.com/jmespath/go-jmespath v0.4.0/go.mod"
"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
"github.com/jmoiron/sqlx v0.0.0-20180614180643-0dae4fefe7c0"
"github.com/jmoiron/sqlx v0.0.0-20180614180643-0dae4fefe7c0/go.mod"
"github.com/joho/godotenv v1.3.0"
"github.com/joho/godotenv v1.3.0/go.mod"
"github.com/json-iterator/go v1.1.5/go.mod"
"github.com/kelseyhightower/envconfig v1.3.0"
"github.com/kelseyhightower/envconfig v1.3.0/go.mod"
"github.com/konsorten/go-windows-terminal-sequences v1.0.3"
"github.com/konsorten/go-windows-terminal-sequences v1.0.3/go.mod"
"github.com/kr/pretty v0.1.0/go.mod"
"github.com/kr/pretty v0.2.0"
"github.com/kr/pretty v0.2.0/go.mod"
"github.com/kr/pty v1.1.1/go.mod"
"github.com/kr/text v0.1.0"
"github.com/kr/text v0.1.0/go.mod"
"github.com/lib/pq v1.1.0"
"github.com/lib/pq v1.1.0/go.mod"
"github.com/mattn/go-colorable v0.1.4/go.mod"
"github.com/mattn/go-ieproxy v0.0.0-20190610004146-91bb50d98149"
"github.com/mattn/go-ieproxy v0.0.0-20190610004146-91bb50d98149/go.mod"
"github.com/mattn/go-isatty v0.0.4/go.mod"
"github.com/mattn/go-isatty v0.0.8/go.mod"
"github.com/mattn/go-isatty v0.0.11/go.mod"
"github.com/mattn/go-sqlite3 v1.9.0"
"github.com/mattn/go-sqlite3 v1.9.0/go.mod"
"github.com/matttproud/golang_protobuf_extensions v1.0.1"
"github.com/matttproud/golang_protobuf_extensions v1.0.1/go.mod"
"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742/go.mod"
"github.com/morikuni/aec v1.0.0"
"github.com/morikuni/aec v1.0.0/go.mod"
"github.com/natessilva/dag v0.0.0-20180124060714-7194b8dcc5c4"
"github.com/natessilva/dag v0.0.0-20180124060714-7194b8dcc5c4/go.mod"
"github.com/nbio/st v0.0.0-20140626010706-e9e8d9816f32"
"github.com/nbio/st v0.0.0-20140626010706-e9e8d9816f32/go.mod"
"github.com/nxadm/tail v1.4.4"
"github.com/nxadm/tail v1.4.4/go.mod"
"github.com/onsi/ginkgo v1.6.0/go.mod"
"github.com/onsi/ginkgo v1.10.1/go.mod"
"github.com/onsi/ginkgo v1.12.1/go.mod"
"github.com/onsi/ginkgo v1.14.1/go.mod"
"github.com/onsi/ginkgo v1.15.0"
"github.com/onsi/ginkgo v1.15.0/go.mod"
"github.com/onsi/gomega v1.7.0/go.mod"
"github.com/onsi/gomega v1.7.1/go.mod"
"github.com/onsi/gomega v1.10.1/go.mod"
"github.com/onsi/gomega v1.10.2/go.mod"
"github.com/onsi/gomega v1.10.5"
"github.com/onsi/gomega v1.10.5/go.mod"
"github.com/opencontainers/go-digest v1.0.0-rc1"
"github.com/opencontainers/go-digest v1.0.0-rc1/go.mod"
"github.com/opencontainers/image-spec v1.0.1"
"github.com/opencontainers/image-spec v1.0.1/go.mod"
"github.com/oxtoacart/bpool v0.0.0-20150712133111-4e1c5567d7c2"
"github.com/oxtoacart/bpool v0.0.0-20150712133111-4e1c5567d7c2/go.mod"
"github.com/petar/GoLLRB v0.0.0-20130427215148-53be0d36a84c/go.mod"
"github.com/peterbourgon/diskv v2.0.1+incompatible/go.mod"
"github.com/pkg/errors v0.8.0/go.mod"
"github.com/pkg/errors v0.9.1"
"github.com/pkg/errors v0.9.1/go.mod"
"github.com/pmezard/go-difflib v1.0.0"
"github.com/pmezard/go-difflib v1.0.0/go.mod"
"github.com/prometheus/client_golang v0.9.2"
"github.com/prometheus/client_golang v0.9.2/go.mod"
"github.com/prometheus/client_model v0.0.0-20180712105110-5c3871d89910/go.mod"
"github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4"
"github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4/go.mod"
"github.com/prometheus/common v0.0.0-20181126121408-4724e9255275"
"github.com/prometheus/common v0.0.0-20181126121408-4724e9255275/go.mod"
"github.com/prometheus/procfs v0.0.0-20181204211112-1dc9a6cbc91a"
"github.com/prometheus/procfs v0.0.0-20181204211112-1dc9a6cbc91a/go.mod"
"github.com/rainycape/unidecode v0.0.0-20150907023854-cb7f23ec59be"
"github.com/rainycape/unidecode v0.0.0-20150907023854-cb7f23ec59be/go.mod"
"github.com/robfig/cron v0.0.0-20180505203441-b41be1df6967"
"github.com/robfig/cron v0.0.0-20180505203441-b41be1df6967/go.mod"
"github.com/segmentio/ksuid v1.0.2"
"github.com/segmentio/ksuid v1.0.2/go.mod"
"github.com/sergi/go-diff v1.0.0/go.mod"
"github.com/sergi/go-diff v1.1.0"
"github.com/sergi/go-diff v1.1.0/go.mod"
"github.com/sirupsen/logrus v1.6.0"
"github.com/sirupsen/logrus v1.6.0/go.mod"
"github.com/spf13/pflag v1.0.3/go.mod"
"github.com/stretchr/objx v0.1.0/go.mod"
"github.com/stretchr/testify v1.2.2/go.mod"
"github.com/stretchr/testify v1.3.0/go.mod"
"github.com/stretchr/testify v1.4.0/go.mod"
"github.com/stretchr/testify v1.5.1/go.mod"
"github.com/stretchr/testify v1.6.1"
"github.com/stretchr/testify v1.6.1/go.mod"
"github.com/stvp/tempredis v0.0.0-20181119212430-b82af8480203"
"github.com/stvp/tempredis v0.0.0-20181119212430-b82af8480203/go.mod"
"github.com/unrolled/secure v0.0.0-20181022170031-4b6b7cf51606"
"github.com/unrolled/secure v0.0.0-20181022170031-4b6b7cf51606/go.mod"
"github.com/vinzenz/yaml v0.0.0-20170920082545-91409cdd725d"
"github.com/vinzenz/yaml v0.0.0-20170920082545-91409cdd725d/go.mod"
"github.com/yuin/goldmark v1.2.1/go.mod"
"go.opentelemetry.io/otel v0.11.0/go.mod"
"go.starlark.net v0.0.0-20201118183435-e55f603d8c79"
"go.starlark.net v0.0.0-20201118183435-e55f603d8c79/go.mod"
"golang.org/x/crypto v0.0.0-20180820150726-614d502a4dac/go.mod"
"golang.org/x/crypto v0.0.0-20181203042331-505ab145d0a9/go.mod"
"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
"golang.org/x/crypto v0.0.0-20191206172530-e9b2fee46413/go.mod"
"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9"
"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
"golang.org/x/exp v0.0.0-20190121172915-509febef88a4/go.mod"
"golang.org/x/lint v0.0.0-20181026193005-c67002cb31c3/go.mod"
"golang.org/x/lint v0.0.0-20190227174305-5b3e6a55c961/go.mod"
"golang.org/x/lint v0.0.0-20190313153728-d0100b6bd8b3/go.mod"
"golang.org/x/mod v0.3.0/go.mod"
"golang.org/x/net v0.0.0-20180724234803-3673e40ba225/go.mod"
"golang.org/x/net v0.0.0-20180826012351-8a410e7b638d/go.mod"
"golang.org/x/net v0.0.0-20180906233101-161cd47e91fd/go.mod"
"golang.org/x/net v0.0.0-20181005035420-146acd28ed58/go.mod"
"golang.org/x/net v0.0.0-20181201002055-351d144fa1fc/go.mod"
"golang.org/x/net v0.0.0-20190213061140-3a22650c66bd/go.mod"
"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
"golang.org/x/net v0.0.0-20190603091049-60506f45cf65/go.mod"
"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
"golang.org/x/net v0.0.0-20190923162816-aa69164e4478/go.mod"
"golang.org/x/net v0.0.0-20200520004742-59133d7f0dd7/go.mod"
"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
"golang.org/x/net v0.0.0-20201202161906-c7110b5ffcbb"
"golang.org/x/net v0.0.0-20201202161906-c7110b5ffcbb/go.mod"
"golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be/go.mod"
"golang.org/x/oauth2 v0.0.0-20181203162652-d668ce993890/go.mod"
"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod"
"golang.org/x/sync v0.0.0-20181108010431-42b317875d0f/go.mod"
"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9"
"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
"golang.org/x/sys v0.0.0-20180830151530-49385e6e1522/go.mod"
"golang.org/x/sys v0.0.0-20180909124046-d0be0721c37e/go.mod"
"golang.org/x/sys v0.0.0-20181005133103-4497e2df6f9e/go.mod"
"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
"golang.org/x/sys v0.0.0-20190422165155-953cdadca894/go.mod"
"golang.org/x/sys v0.0.0-20190904154756-749cb33beabd/go.mod"
"golang.org/x/sys v0.0.0-20191005200804-aed5e4c7ecf9/go.mod"
"golang.org/x/sys v0.0.0-20191010194322-b09406accb47/go.mod"
"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
"golang.org/x/sys v0.0.0-20191120155948-bd437916bb0e/go.mod"
"golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod"
"golang.org/x/sys v0.0.0-20200519105757-fe76b779f299/go.mod"
"golang.org/x/sys v0.0.0-20200615200032-f1bc736245b1/go.mod"
"golang.org/x/sys v0.0.0-20200803210538-64077c9b5642/go.mod"
"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
"golang.org/x/sys v0.0.0-20210112080510-489259a85091"
"golang.org/x/sys v0.0.0-20210112080510-489259a85091/go.mod"
"golang.org/x/text v0.3.0/go.mod"
"golang.org/x/text v0.3.2/go.mod"
"golang.org/x/text v0.3.3"
"golang.org/x/text v0.3.3/go.mod"
"golang.org/x/time v0.0.0-20181108054448-85acf8d2951c/go.mod"
"golang.org/x/time v0.0.0-20190308202827-9d24e82272b4"
"golang.org/x/time v0.0.0-20190308202827-9d24e82272b4/go.mod"
"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
"golang.org/x/tools v0.0.0-20181017214349-06f26fdaaa28/go.mod"
"golang.org/x/tools v0.0.0-20190114222345-bf090417da8b/go.mod"
"golang.org/x/tools v0.0.0-20190226205152-f727befe758c/go.mod"
"golang.org/x/tools v0.0.0-20190311212946-11955173bddd/go.mod"
"golang.org/x/tools v0.0.0-20190425150028-36563e24a262/go.mod"
"golang.org/x/tools v0.0.0-20190524140312-2c0ae7006135"
"golang.org/x/tools v0.0.0-20190524140312-2c0ae7006135/go.mod"
"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
"golang.org/x/tools v0.0.0-20201224043029-2b0845dc783e/go.mod"
"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1"
"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
"google.golang.org/appengine v1.1.0/go.mod"
"google.golang.org/appengine v1.3.0/go.mod"
"google.golang.org/appengine v1.4.0/go.mod"
"google.golang.org/appengine v1.6.6"
"google.golang.org/appengine v1.6.6/go.mod"
"google.golang.org/genproto v0.0.0-20180817151627-c66870c02cf8/go.mod"
"google.golang.org/genproto v0.0.0-20190819201941-24fa4b261c55"
"google.golang.org/genproto v0.0.0-20190819201941-24fa4b261c55/go.mod"
"google.golang.org/grpc v1.19.0/go.mod"
"google.golang.org/grpc v1.23.0/go.mod"
"google.golang.org/grpc v1.25.1/go.mod"
"google.golang.org/grpc v1.30.0"
"google.golang.org/grpc v1.30.0/go.mod"
"google.golang.org/protobuf v0.0.0-20200109180630-ec00e32a8dfd/go.mod"
"google.golang.org/protobuf v0.0.0-20200221191635-4d8936d0db64/go.mod"
"google.golang.org/protobuf v0.0.0-20200228230310-ab0ca4ff8a60/go.mod"
"google.golang.org/protobuf v1.20.1-0.20200309200217-e05f789c0967/go.mod"
"google.golang.org/protobuf v1.21.0/go.mod"
"google.golang.org/protobuf v1.23.0"
"google.golang.org/protobuf v1.23.0/go.mod"
"gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod"
"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15"
"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
"gopkg.in/fsnotify.v1 v1.4.7/go.mod"
"gopkg.in/h2non/gock.v1 v1.0.14"
"gopkg.in/h2non/gock.v1 v1.0.14/go.mod"
"gopkg.in/inf.v0 v0.9.1/go.mod"
"gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7"
"gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7/go.mod"
"gopkg.in/yaml.v2 v2.2.1/go.mod"
"gopkg.in/yaml.v2 v2.2.2/go.mod"
"gopkg.in/yaml.v2 v2.2.4/go.mod"
"gopkg.in/yaml.v2 v2.2.8/go.mod"
"gopkg.in/yaml.v2 v2.3.0"
"gopkg.in/yaml.v2 v2.3.0/go.mod"
"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
"gotest.tools v2.2.0+incompatible"
"gotest.tools v2.2.0+incompatible/go.mod"
"honnef.co/go/tools v0.0.0-20190102054323-c2f93a96b099/go.mod"
"honnef.co/go/tools v0.0.0-20190523083050-ea95bdfd59fc/go.mod"
"k8s.io/api v0.0.0-20181130031204-d04500c8c3dd/go.mod"
"k8s.io/apimachinery v0.0.0-20181201231028-18a5ff3097b4/go.mod"
"k8s.io/client-go v9.0.0+incompatible/go.mod"
"k8s.io/klog v0.1.0/go.mod"
"sigs.k8s.io/yaml v1.1.0/go.mod"
)

go-module_set_globals

MY_PV="${PV/_rc/-rc}"

DESCRIPTION="Drone CI - Automate Software Testing and Delivery"
HOMEPAGE="https://drone.io/ https://github.com/harness/drone"

if [[ ${PV} != 9999* ]] ; then
	SRC_URI="https://github.com/harness/drone/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}"
	KEYWORDS="~amd64 ~arm ~arm64"
	S="${WORKDIR}"
else
	EGIT_REPO_URI="https://github.com/harness/drone"
	inherit git-r3
	S="${WORKDIR}/${P}"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="enterprise mysql postgres sqlite"

RESTRICT="mirror"
RDEPEND="acct-user/drone
	sqlite? ( dev-db/sqlite:3 )
	mysql? ( >=dev-db/mysql-5.6 )
	postgres? ( >=dev-db/postgresql-9.6 )
"

src_compile() {
	pushd "${P}" || die

	if use enterprise ; then
		go build github.com/drone/drone/cmd/drone-server || die
	else
		go build -tags "oss nolimit" github.com/drone/drone/cmd/drone-server || die
	fi

	popd || die
}

src_install() {
	pushd "${P}" || die

	dosbin drone-server

	popd || die

	systemd_newunit "${FILESDIR}/${PN}.service-2.4.0" "${PN}.service"

	insinto "/etc/drone"
	newins "${FILESDIR}/app.ini-1.10.1" app.ini

	fowners drone:drone /etc/drone
	fperms 0700 /etc/drone
	fowners drone:drone /etc/drone/app.ini
	fperms 0600 /etc/drone/app.ini
}