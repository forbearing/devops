kafka-topics.sh

1:选项
    --bootstrap-server      连接 kafka broker 主机名称和端口号
    --topic                 操作的 topic 名称
    --create                创建主题
    --delete                删除主题
    --alter                 修改主题
    --list                  查看所有主题
    --describe              查看主题详细描述
    --partitions            设置分区数
    --replication-factor    设置副本数
    --config                更新系统默认的配置



===== 2.示例

kafka-topics.sh --zookeeper 10.250.21.11:2181 --list
kafka-topics.sh --zookeeper 127.0.0.1:2181 --list
kafka-topics.sh --zookeeper 10.250.21.11:2181 --create --topic first --partitions 2 --replication-factor 2
    # 创建一个名为 first 的 topic，两个分区，两个副本
kafka-topics.sh --bootstrap-server 10.250.21.11:9092,10.250.21.12:9092,10.250.21.13:9092 --list
    # 查看主题, 同时指定多个 broker, 指定2-3个即可, 不用全部都指定
kafka-topics.sh --bootstrap-server 10.250.21.11:9092 --list   # 查看主题
kafka-topics.sh --bootstrap-server 10.250.21.11:9092,10.250.21.12:9092,10.250.21.13:9092 --topic first --create --partitions 1 --replication-factor 3   # 创建一个主题
kafka-topics.sh --bootstrap-server 10.250.21.11:9092,10.250.21.12:9092,10.250.21.13:9092 --topic first --delete   # 删除一个主题
kafka-topics.sh --bootstrap-server 10.250.21.11:9092,10.250.21.12:9092,10.250.21.13:9092 --topic first --alter --partitions 3   # 修改一个主题

export BOOTSTRAP_SERVER="10.250.21.11:9092,10.250.21.12:9092,10.250.21.13:9092"
export BOOTSTRAP_SERVER="kafka01:9092,kafka02:9092,kafka03:9092"
export BOOTSTRAP_SERVER="kafka01:9092"
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --list
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first --delete
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first --create --partitions 1 --replication-factor 3
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first --describe
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first --alter --partitions 3


kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic one --create --partitions 3 --replication-factor 3
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic two --create --partitions 3 --replication-factor 3
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic three --create --partitions 3 --replication-factor 3
