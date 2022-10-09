#!/usr/bin/env bash

docker exec -it $(docker ps | grep '/zookeeper'| awk '{print $1}') zkCli.sh ls /kafka/brokers/ids
