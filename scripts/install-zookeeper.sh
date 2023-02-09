#!/bin/sh
apt-get install openjdk-11-jdk -y
wget https://dlcdn.apache.org/kafka/3.3.1/kafka_2.13-3.3.1.tgz
tar -xzf kafka_2.13-3.3.1.tgz
cd kafka_2.13-3.3.1
bin/zookeeper-server-start.sh config/zookeeper.properties