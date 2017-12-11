#!/usr/bin/env bash
set -e

if [ "$1" = "apachectl" ]; then

  # start php-fpm daemon in background
  #${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties 2>&1 1>${INTERNAL_ZOOKEEPER_LOGS_PATH}/zookeeper.log &
  echo "test"
fi

exec "$@"
