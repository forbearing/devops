# vi /etc/profile.d/kafka.sh

# JAVA_HOME
export JAVA_HOME="/usr/java/jdk1.8.0_281-amd64/"
export PATH=$PATH:$JAVA_HOME/bin

## HADOOP_HOME
#export HADOOP_HOME=opt/module/hadoop-3.1.3
#export PATH=$PATH:$HADOOP_HOME/bin
#export PATH=$PATH:$HADOOP_HOME/sbin

# KAFKA_HOME
export KAFKA_HOME="/usr/local/kafka"
export PATH=$PATH:$KAFKA_HOME/bin

# Zookeeper HOME
export ZOOKEEPER_HOME="/usr/local/zookeeper"
export PATH=$PATH:$ZOOKEEPER_HOME/bin

# Kafka efak
export KE_HOME="/usr/local/efak"
export PATH=$PATH:$KE_HOME/bin
