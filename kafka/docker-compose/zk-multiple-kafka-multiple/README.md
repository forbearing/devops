### 增加 kafka 节点

1. 拷贝一份 kafka docker-compose
2. 修改 KAFKA_BROKER_ID
3. 修改 KAFKA_CFG_ADVERTISED_LISTENERS, 改成自己的 ip 地址

### 增加 zookeeper 节点

1. 修改 ZOO_SERVER_ID 必须和其他 zookeeper 节点的 ID 不同且必须连续,如果不连续需要在 ZOO_SERVERS 中加上 ID 号
2. 修改 ZOO_SERVERS, 加上当前 zookeeper ip地址和端口号
3. 所有 kafka 节点修改 KAFKA_CFG_ZOOKEEPER_CONNECT, 加上当前 zookeeper 节点

