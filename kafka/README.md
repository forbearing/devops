1. 一定要先关闭 kafka 再关闭 zookeeper, 关闭 kafka 需要一些时间,稍等下, jps 可以查看 kafka 进程, 如果 jps 输出有 kafka, 说明 kafka 还在关闭状态, 如果 kafaka 没有完全关闭的时候直接关闭了 zookeeper 会导致 kafka 进程永远无法关闭, 只能 kill -9 关掉. 因为关掉了 kafka, zookeeper 无法停掉自己

2. 只有在 controler 节点执行 zkCli.sh 后查看 /kafka/brokers/ids 或者 /brokers/ids 能看到 ids 的内容,其他非 controller 节点都看不到 ids 内容

3. zkCli.sh 中查看 zookeeper 数据, 有 controller 的就是 controller, 只有该节点通过 ls /kafka/brokers/ids/ 才能查看到所有的 brokers
4. 如果 zookeeper 和 kafka 的任何一个开启了认证(SASL, SSL 或者 SASL_SSL) 则 zookeeper 和 kafka 必须同时开启 SASL, SSL 或者 SASL_SSL
5. 如果开启了 knowStreaming, 并且 kafka 和 zookeeper 设置了内存要求, 则可能会导致 kafka 起不来
6. ZOO_SERVERS: 0.0.0.0:2888:3888,10.250.21.12:2888:3888,10.250.21.13:2888:3888
    在当前节点需要将 ip 地址配置成 0.0.0.0