#!/bin/bash -e

# download fat-jar from s3
aws --endpoint-url $ENDPOINT_URL s3 cp $APP_PATH $ASSEMBLY_NAME

if [ "$1" = 'idle' ]; then
  exec tail -f /dev/null
fi

if [ "$1" = 'master' ]; then
  start-master.sh
  exec tail -f logs/$(ls logs)
fi

if [ "$1" = 'worker' ]; then
  start-slave.sh spark://${MASTER_HOSTNAME:-master}:7077
  exec tail -f logs/$(ls logs)
fi

exec "$@"
