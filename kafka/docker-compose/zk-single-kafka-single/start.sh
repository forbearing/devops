#!/usr/bin/env bash

chown -R 1001:1001 zookeeper kafka
docker-compose up -d
