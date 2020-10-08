#!/bin/sh
# $DOCKER_REPOSILITE_CONFIG_FILE contains path to the config file

if [[ -z "${DOCKER_REPOSILITE_CONFIG_FILE}" ]] ; then
	echo "DOCKER_REPOSILITE_CONFIG_FILE not set!"
	exit 1
fi

. "${DOCKER_REPOSILITE_CONFIG_FILE}"

docker_args="--environment=REPOSILITE_OPTS='${REPOSILITE_OPTS}'"
docker_args="${docker_args} --environment=JAVA_OPTS='${JAVA_OPTS}'"

for p in ${DOCKER_PUBLISH} ; do
	docker_args="${docker_args} --publish=${p}"
done

docker_args="${docker_args} ${DOCKER_REPOSILITE_EXTRA_ARGS}"

docker run \
  --mount type=bind,source=/etc/reposilite/reposilite.cdn,target=/app/reposilite-host.cdn
  --volume=/var/lib/reposilite-data:/app/data \
  ${docker_args} \
  --restart=always \
  --detach=false \
  --name=reposilite \
  dzikoysk/reposilite:<VERSION>
