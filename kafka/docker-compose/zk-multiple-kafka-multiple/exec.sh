#!/usr/bin/env bash


case $1 in
kafka|kf)
    docker exec -it $(docker ps | grep '/kafka' | awk '{print $1}') bash
    ;;
zookeeper|zoo)
    docker exec -it $(docker ps | grep '/zookeeper' | awk '{print $1}') bash
    ;;
kfcfg)
    docker exec -it $(docker ps | grep '/kafka' | awk '{print $1}') cat /opt/bitnami/kafka/config/server.properties > /tmp/server.properties
    ;;
zoocfg)
    docker exec -it $(docker ps | grep '/zookeeper' | awk '{print $1}') cat /opt/bitnami/zookeeper/conf/zoo.cfg > /tmp/zoo.cfg
    ;;
*)
    echo "Usage: $(basename $0) zookeeper|kafka"
esac
