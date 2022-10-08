# url:
#   https://support.huaweicloud.com/pwp-kafka/kafka-pwp-003.html
#   https://www.cnblogs.com/lkxed/p/kafka-perf-test-tools.html

# 1.kafka-producer-perf-test.sh 支持测试的性能包括: 吞吐量(throughout), 最大延迟(max-latency), 
#   平均延迟(avg-latency); kafka-consumer-perf-test.sh 同时支持吞吐量指标, 还提供了一些消费者
#   端特有的指标,但没有直接提供时延信息.

kafka-producer-perf-test.sh
    --topic             指定生产的消息发往的 topic
    --num-records       指定生产的消息总数
    --payload-delimeter 如果通过 --payload-file 指定了从文件中获取消息内容，那么这个参数
                        的意义是指定文件的消息分隔符，默认值为 \n，即文件的每一行视为一条消息；
                        如果未指定 --payload-file 则此参数不生效
    --throughput        限制每秒发送的最大的消息数，设为 -1 表示不限制
    --producer-props    直接指定 Producer 配置，格式为 NAME=VALUE，例如 bootstrap.server=127.0.0.1:9092，
                        通过此种方式指定的配置优先级高于 --producer.config
    --producer-config   指定 Producer 的配置文件，格式参照官方的 config/producer.properties
    --print-metrics     在测试结束后打印更详尽的指标，默认为 false
    --transactional-id  指定事务 ID，测试并发事务的性能时需要，只有在 --transaction-duration-ms > 0 时生效，
                        默认值为 performance-producer-default-transactional-id
    --transactional-duration-ms     指定事务持续的最长时间，超过这段时间后就会调用 commitTransaction 
                                    来提交事务，只有指定了 > 0 的值才会开启事务，默认值为 0
    --record-size       指定每条消息的大小，单位是字节，和 --payload-file 两个中必须指定一个，但不能同时指定
    --payload-file      指定消息的来源文件，只支持 UTF-8 编码的文本文件，文件的消息分隔符通过 
                        --payload-delimeter 指定，和 --record-size 两个中必须指定一个，但不能同时指定



kafka-consumer-perf-test.sh
    --bootstrap-server  指定 broker 地址，必选，除非用 --broker-list 代替（不建议）
    --topic             指定消费的 topic，必选
    --consumer.config   指定 Consumer 配置文件
    --date-format       指定用于格式化 *.time 的规则，默认为 yyyy-MM-dd HH:mm:ss:SSS
    --fetch-size        指定一次请求消费的大小，默认为 1048576 即 1 MB
    --from-latest       如果 Consumer 没有已经建立的 offset，则指定从 log 中最新的位点开始
                        消费，而不是从最早的位点开始消费
    --group             指定 ConsumerGroup ID，默认为 perf-consumer-40924
    --hide-header       指定后不输出 header 信息
    --messages          指定消费的消息数量，必选
    --num-fetch-threads 指定 fetcher 线程的数量
    --print-metrics     指定打印 metrics 信息
    --reporting-interval    指定打印进度信息的时间间隔，默认为 5000 即 5 秒
    --show-detailed-stats   指定每隔一段时间（由 --reporting-interval 指定）输出显示详细的状态信息
    --socket-buffer-size    指定 TCP 的 RECV 大小，默认为 2097152 即 2 MB
    --threads           指定消费的线程数，默认为 10
    --timeout           指定允许的最大超时时间，即每条消息返回的最大时间间隔，默认为 10000 即 10 秒


# ===== Producer
export BOOTSTRAP_SERVER="kafka01:9092,kafka02:9092,kafka03:9092"
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic perf-test --create --partitions 3 --replication-factor 2     
kafka-producer-perf-test.sh --topic perf-test --num-records 1000 --record-size 1024 --throughput -1 --producer-props bootstrap.servers=kafka01:9092,kafka02:9092,kafka03:9092 compression.type=lz4
# 1000 records sent, 1447.178003 records/sec (1.41 MB/sec), 89.72 ms avg latency, 581.00 ms max latency, 83 ms 50th, 145 ms 95th, 147 ms 99th, 581 ms 99.9th.
# 1000 records sent, 3424.657534 records/sec (3.34 MB/sec), 13.61 ms avg latency, 255.00 ms max latency, 13 ms 50th, 20 ms 95th, 255 ms 99th.
# 成功消费了 1000 条消息，吞吐量为 3424.657534 条/秒 (或 3.34 MB/秒)，平均时延为 13.61 ms，最大时延为 255.00 ms，50 % 的消息延时在 13 ms 内，95 % 的消息延时在 20 ms 内，99 % 的消息延时在 255 毫秒内。

# ===== Consumer
export BOOTSTRAP_SERVER="kafka01:9092,kafka02:9092,kafka03:9092"
kafka-consumer-perf-test.sh --bootstrap-server kafka01:9092,kafka02:9092,kafka03:9092 --topic perf-test --messages 1000000 --threads 8 --reporting-interval 1000 --show-detailed-stats
kafka-consumer-perf-test.sh --bootstrap-server $BOOTSTRAP_SERVER --topic perf-test --messages 1000000 --reporting-interval 1000 --show-detailed-stats

kafka-run-class.sh kafka.tools.EndToEndLatency $BOOTSTRAP_SERVER test-rep-one 10000 1 1024

# project1
export BOOTSTRAP_SERVER="10.250.21.11:9092,10.250.21.12:9092,10.250.21.13:9092"
kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --topic perf-test --create --partitions 3 --replication-factor 2
kafka-producer-perf-test.sh --topic perf-test --num-records 10000  --throughput 10000 --record-size 120 --producer-props bootstrap.servers=$BOOTSTRAP_SERVER
kafka-consumer-perf-test.sh --broker-list $BOOTSTRAP_SERVER --messages 5000000 --topic perf-test --group g1 --threads 1
