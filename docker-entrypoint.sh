#!/bin/bash -e

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
