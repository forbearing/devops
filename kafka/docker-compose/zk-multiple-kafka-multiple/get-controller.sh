#!/usr/bin/env bash

docker exec -it $(docker ps | grep '/zookeeper' | awk '{print $1}') zkCli.sh get /kafka/controller
