#!/bin/bash

set -e

export DEFAULT_NATS_SERVER_VERSION=v2.1.8

export NATS_SERVER_VERSION="${NATS_SERVER_VERSION:=$DEFAULT_NATS_SERVER_VERSION}"

# check to see if nats-server folder is empty
if [ ! "$(ls -A $HOME/nats-server)" ]; then
    (
	mkdir -p $HOME/nats-server
	cd $HOME/nats-server
	wget https://github.com/nats-io/nats-server/releases/download/$NATS_SERVER_VERSION/nats-server-$NATS_SERVER_VERSION-linux-amd64.zip -O nats-server.zip
	unzip nats-server.zip
	cp nats-server-$NATS_SERVER_VERSION-linux-amd64/nats-server $HOME/nats-server/nats-server
	if [ "${TRAVIS_CPU_ARCH}" == "arm64" ]; then
	wget https://github.com/nats-io/nats-server/releases/download/$NATS_SERVER_VERSION/nats-server-$NATS_SERVER_VERSION-linux-arm64.zip -O nats-server.zip
	unzip nats-server.zip
	cp nats-server-$NATS_SERVER_VERSION-linux-arm64/nats-server $HOME/nats-server/nats-server
	fi
    )
else
  echo 'Using cached directory.';
fi
