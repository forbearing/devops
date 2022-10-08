export BOOTSTRAP_SERVER="kafka01:9092,kafka02:9092,kafka03:9092"

kafka-run-class.sh kafka.tools.DumpLogSegments --files /usr/local/kafka/data/first-0/00000000000000000000.index
kafka-run-class.sh kafka.tools.DumpLogSegments --files /usr/local/kafka/data/first-0/00000000000000000000.log
kafka-run-class.sh kafka.tools.DumpLogSegments --files /usr/local/kafka/data/first-0/00000000000000000000.timeindex
kafka-run-class.sh kafka.tools.EndToEndLatency $BOOTSTRAP_SERVER test-rep-one 10000 1 1024
    # 端到端延迟测试
