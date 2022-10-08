#!/usr/bin/env bash

docker exec -it $(docker ps | grep 2181 | awk '{print $1}') zkCli.sh ls /kafka/brokers/ids
