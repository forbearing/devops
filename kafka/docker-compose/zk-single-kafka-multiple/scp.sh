#!/usr/bin/env bash

ssh root@10.250.21.11 'mkdir -p /opt/kafka'
ssh root@10.250.21.12 'mkdir -p /opt/kafka'
ssh root@10.250.21.13 'mkdir -p /opt/kafka'


scp kafka01/docker-compose.yaml root@10.250.21.11:/opt/kafka
scp kafka02/docker-compose.yaml root@10.250.21.12:/opt/kafka
scp kafka03/docker-compose.yaml root@10.250.21.13:/opt/kafka

scp kafka01/start.sh root@10.250.21.11:/opt/kafka
scp kafka01/start.sh root@10.250.21.12:/opt/kafka
scp kafka01/start.sh root@10.250.21.13:/opt/kafka

scp kafka01/cleanup.sh root@10.250.21.11:/opt/kafka
scp kafka01/cleanup.sh root@10.250.21.12:/opt/kafka
scp kafka01/cleanup.sh root@10.250.21.13:/opt/kafka
