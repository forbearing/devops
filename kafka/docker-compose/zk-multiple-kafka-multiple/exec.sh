#!/usr/bin/env bash


case $1 in
kafka|kf)
    docker exec -it $(docker ps | grep 9092 | awk '{print $1}') bash
    ;;
zookeeper|zoo)
    docker exec -it $(docker ps | grep 2181 | awk '{print $1}') bash
    ;;
*)
    echo "Usage: $(basename $0) zookeeper|kafka"
esac
