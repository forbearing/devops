#!/usr/bin/env bash

mkdir -p zookeeper kafka
chown -R 1001:1001 zookeeper kafka
docker-compose up -d
