#!/usr/bin/env bash

case $1 in
status)
    docker exec -it $(docker ps | grep zookeeper | awk '{print $1}') zkServer.sh status
    ;;
esac
