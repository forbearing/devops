#!/usr/bin/env bash

#KAFKA_DIR="/opt/kafka/"
KAFKA_DIR="/data/kafka/"

ALL_NODE=(
10.250.21.11
10.250.21.12
10.250.21.13
10.250.21.14
10.250.21.15)


for node in "${ALL_NODE[@]}"; do
    ssh root@$node "mkdir -p $KAFKA_DIR" &
done
wait

scp kafka01/docker-compose.yaml root@10.250.21.11:$KAFKA_DIR
scp kafka02/docker-compose.yaml root@10.250.21.12:$KAFKA_DIR
scp kafka03/docker-compose.yaml root@10.250.21.13:$KAFKA_DIR
scp kafka04/docker-compose.yaml root@10.250.21.14:$KAFKA_DIR
scp kafka05/docker-compose.yaml root@10.250.21.15:$KAFKA_DIR


for node in "${ALL_NODE[@]}"; do
    for file in \
        setup.sh \
        exec.sh \
        zkServer.sh \
        get-controller.sh \
        get-all-brokers.sh; do

        scp $file root@$node:$KAFKA_DIR

    done &
done
wait
