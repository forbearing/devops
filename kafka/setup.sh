#!/usr/bin/env bash

alias pssh="pssh -i -h ./hosts/all"
alias pscp="pscp -r -h ./hosts/all"

HOST="hosts/all"
ALL_NODE=(
10.250.21.11
10.250.21.12
10.250.21.13)

pscp -r -h $HOST pkgs/kafka_2.12-2.8.2.tgz pkgs/apache-zookeeper-3.7.1-bin.tar.gz /root
pscp -r -h $HOST systemd/kafka-zookeeper.service systemd/kafka.service /lib/systemd/system/
pscp -r -h $HOST config/kafka.sh /etc/profile.d/
pscp -r -h $HOST config/zoo.cfg /usr/local/zookeeper/conf/
pscp -r -h $HOST config/hosts.centos7 /etc/hosts

pssh -i -h $HOST tar -xf /root/kafka_2.12-2.8.2.tgz -C /usr/local/
pssh -i -h $HOST tar -xf /root/apache-zookeeper-3.7.1-bin.tar.gz -C /usr/local/
pssh -i -h $HOST ln -sf /usr/local/kafka_2.12-2.8.2 /usr/local/kafka
pssh -i -h $HOST ln -sf /usr/local/apache-zookeeper-3.7.1-bin /usr/local/zookeeper

scp config/server.properties_1 root@10.250.21.11:/usr/local/kafka/config/server.properties
scp config/server.properties_2 root@10.250.21.12:/usr/local/kafka/config/server.properties
scp config/server.properties_3 root@10.250.21.13:/usr/local/kafka/config/server.properties

ssh root@10.250.21.11 'mkdir -p /usr/local/zookeeper/data/; echo 1 >/usr/local/zookeeper/data/myid'
ssh root@10.250.21.12 'mkdir -p /usr/local/zookeeper/data/; echo 2 >/usr/local/zookeeper/data/myid'
ssh root@10.250.21.13 'mkdir -p /usr/local/zookeeper/data/; echo 3 >/usr/local/zookeeper/data/myid'



#pssh -i -h $HOST systemctl daemon-reload
#pssh -i -h $HOST systemctl enable --now zookeeper
#pssh -i -h $HOST systemctl enable --now kafka
