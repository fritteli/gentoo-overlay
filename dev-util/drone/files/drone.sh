#!/bin/sh
# $DRONE_CONFIG_FILE contains path to the config file

if [[ -z "${DRONE_CONFIG_FILE}" ]] ; then
	echo "DRONE_CONFIG_FILE not set!"
	exit 1
fi

. "${DRONE_CONFIG_FILE}"

publishes=""

for p in ${DOCKER_PUBLISH} ; do
	publishes="${publishes} --publish=${p}"
done

docker run \
  --volume=/var/lib/drone:/data \
  --env=DRONE_GITEA_SERVER=${DRONE_GITEA_SERVER} \
  --env=DRONE_GITEA_CLIENT_ID=${DRONE_GITEA_CLIENT_ID} \
  --env=DRONE_GITEA_CLIENT_SECRET=${DRONE_GITEA_CLIENT_SECRET} \
  --env=DRONE_RPC_SECRET=${DRONE_RPC_SECRET} \
  --env=DRONE_SERVER_HOST=${DRONE_SERVER_HOST} \
  --env=DRONE_SERVER_PROTO=${DRONE_SERVER_PROTO} \
  ${publishes} \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:<VERSION>
