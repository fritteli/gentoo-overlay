#!/bin/sh
# $DRONE_CONFIG_FILE contains path to the config file

if [[ -z "${DOCKER_DRONE_CONFIG_FILE}" ]] ; then
	echo "DOCKER_DRONE_CONFIG_FILE not set!"
	exit 1
fi

. "${DOCKER_DRONE_CONFIG_FILE}"

docker_args=""

for var in "${!DRONE_@}" ; do
	docker_args="${docker_args} --env=${var}=${!var}"
done

for p in ${DOCKER_PUBLISH} ; do
	docker_args="${docker_args} --publish=${p}"
done

docker run \
  --volume=/var/lib/drone:/data \
  ${docker_args} \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:<VERSION>
