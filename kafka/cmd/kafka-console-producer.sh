export BOOTSTRAP_SERVER="kafka01:9092,kafka02:9092,kafka03:9092"

kafka-console-producer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first
kafka-console-producer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first

kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first
kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic first --from-beginning
    # 消费包括所有历史数据
kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic __consumer_offsets --from-beginning
    # 消费系统主题
kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic __consumer_offsets --consumer.config /usr/local/kafka/config/consumer.properties --from-beginning
