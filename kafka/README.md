## References & Documents

- https://www.bilibili.com/video/BV1vr4y1677k/?p=4&spm_id_from=pageDriver&vd_source=d216123ebf907bdc4f2cc53a9cf171d9



- https://github.com/vran-dev/PrettyZoo
- https://zhuanlan.zhihu.com/p/103249714?utm_id=0         Kafka 概述：深入理解架构
- https://juejin.cn/post/7119388964728897573              「Kafka 专栏」- 001 Kafka 概述

- https://www.lixueduan.com/posts/kafka/01-install/       Kafka(Go)教程(一)---通过docker-compose 安装 Kafka
- https://www.topgoer.com/数据库操作/zookeeper/zookeeper命令行使用.html
- https://www.topgoer.com/数据库操作/zookeeper/基本操作测试.html
- https://www.modb.pro/db/178753                          Kafka性能测试揭秘



- http://www.jasongj.com/kafka/high_throughput/               Kafka设计解析（六）- Kafka高性能架构之道
- http://www.jasongj.com/tags/Kafka/                          Kafka 专题
- https://juejin.cn/post/6844903950009794567                  Kafka 系列（五）—— 深入理解 Kafka 副本机制
- https://forthe77.github.io/2019/03/25/one-zookeeper-deploy/ Zookeeper简介、三种搭建模式和配置文件详解
- https://www.cnblogs.com/f-ck-need-u/p/7576137.html#zk       骏马金龙 zookeeper 系列
- https://blog.csdn.net/qq_47658874/article/details/122730520     kafka3.1集群搭建（kraft模式）



- https://github.com/didi/KnowStreaming           
- https://github.com/nick-zh/docker-kafka-eagle               Kafka eagle for docker
- https://www.cnblogs.com/smartloli/p/15732794.html           kafka eagle 分布式模式
- https://docs.kafka-eagle.org/2.env-and-install/4.configure  kafka eagle 文档






1. 一定要先关闭 kafka 再关闭 zookeeper, 关闭 kafka 需要一些时间,稍等下, jps 可以查看 kafka 进程, 如果 jps 输出有 kafka, 说明 kafka 还在关闭状态, 如果 kafaka 没有完全关闭的时候直接关闭了 zookeeper 会导致 kafka 进程永远无法关闭, 只能 kill -9 关掉. 因为关掉了 kafka, zookeeper 无法停掉自己

2. 只有在 controler 节点执行 zkCli.sh 后查看 /kafka/brokers/ids 或者 /brokers/ids 能看到 ids 的内容,其他非 controller 节点都看不到 ids 内容

3. zkCli.sh 中查看 zookeeper 数据, 有 controller 的就是 controller, 只有该节点通过 ls /kafka/brokers/ids/ 才能查看到所有的 brokers
4. 如果 zookeeper 和 kafka 的任何一个开启了认证(SASL, SSL 或者 SASL_SSL) 则 zookeeper 和 kafka 必须同时开启 SASL, SSL 或者 SASL_SSL
5. 如果开启了 knowStreaming, 并且 kafka 和 zookeeper 设置了内存要求, 则可能会导致 kafka 起不来
6. ZOO_SERVERS: 0.0.0.0:2888:3888,10.250.21.12:2888:3888,10.250.21.13:2888:3888
    在当前节点需要将 ip 地址配置成 0.0.0.0





## eagle

- 如果 eagle 不是和 kafka, zookeeper 在同一个 network bridge, 需要把 kafka zookeeper 的 network mode 配置成 host, 并且 eagle 也要配置 network mode 为 host. 这样 eagle 才能监控到 kafka 和 zookeeper
- eagle 需要配置成 分布式模式才能监控多个 kafka 节点. 如果是 standalone 模式, 则只能监控当前的 kafka 节点.
- zookeeper 必须开启 metrics 借口, eagle 才能监控到 zookeeper
- 如果 eagle 迟迟打不开, 可能是你的 system.preperties 配置有问题


### NOTE:

- 如果修改了 docker-compose 文件, 需要删除构建的 eagle 镜像再重构, 因为 system-config.properties 会变化.

### eagle 迟迟打不开, 登录不进去的那问题

- conf/system-config.properties 不是 10.250.21.11:2181,10.250.21.12:2181,10.250.21.13/kafka
    而是 cluster1.zk.list=10.250.21.11:2181,10.250.21.12:2181,10.250.21.13/kafka

- 可能是我的 sqlite 的密码太短了
    ```properties
    efak.driver=org.sqlite.JDBC
    efak.url=jdbc:sqlite:/hadoop/kafka-eagle/db/ke.db
    efak.username=root
    efak.password=www.example.com
    # 我以前的 password 是 toor
    ```

- 如果还是打不开, 就讲 cluster1 设置为一个 zookeeper 节点, 不要同时设置三个 zookeeper 节点



### 在 cluster -> zk&kafka 只能展示当前 eagle 所在节点的 kafka 监控 cpu 和 memory. 无法显示其他节点的 kafka cpu 和 memory

- zookeeper, kafka, eagle 都需要 network mode 为 host

- 修改 KAFKA_HEAP_OPTS 的值为:`KAFKA_HEAP_OPTS: "-Xmx4096m -Xms4096m -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dcom.sun.management.jmxremote.host=0.0.0.0 -Dcom.sun.management.jmxremote.local.only=false -Djava.rmi.server.hostname=[10.250.21.11]"` 

- 每个节点的配置如下:

    ```properties
    # 只是开头的 rmi.server.hostname ip 地址不同而已
    KAFKA_HEAP_OPTS: "-Djava.rmi.server.hostname=10.250.21.11 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9999"
    KAFKA_HEAP_OPTS: "-Djava.rmi.server.hostname=10.250.21.12 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9999"
    KAFKA_HEAP_OPTS: "-Djava.rmi.server.hostname=10.250.21.13 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9999"
    KAFKA_HEAP_OPTS: "-Djava.rmi.server.hostname=10.250.21.14 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9999"
    KAFKA_HEAP_OPTS: "-Djava.rmi.server.hostname=10.250.21.15 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9999"
    ```

    

- 参考 issue: https://github.com/smartloli/EFAK/issues/321

- java.rmi.server.hostname 解释:

    - https://stackoverflow.com/questions/10173834/java-rmi-djava-rmi-server-hostname-localhost-still-opens-a-socket-listening-on

    - https://www.jianshu.com/p/b7790c9eabff

    - https://www.cnblogs.com/createyuan/p/11038958.html
        ```properties
        CATALINA_OPTS="$CATALINA_OPTS
        -Dcom.sun.management.jmxremote
        -Djava.rmi.server.hostname=192.168.3.225
        -Dcom.sun.management.jmxremote.port=9999
        -Dcom.sun.management.jmxremote.ssl=false
        -Dcom.sun.management.jmxremote.authenticate=false"
        ```

- 最终效果

    <img src="doc/pics/kafka_monitoring_2.png" alt="kafka_monitoring_2" style="zoom:50%;" />

### 在 cluster -> zk&kafka 不显示 zookeeper 的监控 cpu 和 memory

- 截图

    <img src="doc/pics/zookeeper_monitoring_1.png" alt="zookeeper_monitoring_1" style="zoom:50%;" />



### efak 错误 `Caused by: org.sqlite.SQLiteException: [SQLITE_ERROR] SQL error or missing database (no such function: from_unixtime)`

- 还未解决
- 参考 issue: https://github.com/smartloli/EFAK/issues/650

