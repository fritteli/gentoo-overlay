#!/bin/sh
# $RUNNER_CONFIG_FILE contains path to the config file

if [[ -z "${RUNNER_CONFIG_FILE}" ]] ; then
	echo "RUNNER_CONFIG_FILE not set!"
	exit 1
fi

. "${RUNNER_CONFIG_FILE}"

docker_args=""

for var in "${!DRONE_@}" ; do
	docker_args="${docker_args} --env=${var}=${!var}"
done

for p in ${DOCKER_PUBLISH} ; do
	docker_args="${docker_args} --publish=${p}"
done

docker_args="${docker_args} ${DOCKER_DRONE_EXTRA_ARGS}"

docker run \
  --volume=/run/docker.sock:/var/run/docker.sock \
  ${docker_args} \
  --restart=always \
  --detach=false \
  --name=drone-runner \
  drone/drone-runner-docker:<VERSION>
