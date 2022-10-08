kafka-reassign-partitions.sh --bootstrap-server kafka01:9092 --topics-to-move-json-file topics-to-move.json --broker-list "0,1,2,3" --generate
    # 生成一个要均衡的计划
    # 
    #Current partition replica assignment
    #{"version":1,"partitions":[{"topic":"first","partition":0,"replicas":[0,1,2],"log_dirs":["any","any","any"]},{"topic":"first","partition":1,"replicas":[1,2,0],"log_dirs":["any","any","any"]},{"topic":"first","partition":2,"replicas":[2,0,1],"log_dirs":["any","any","any"]}]}
    #
    #Proposed partition reassignment configuration
    #{"version":1,"partitions":[{"topic":"first","partition":0,"replicas":[3,1,0],"log_dirs":["any","any","any"]},{"topic":"first","partition":1,"replicas":[0,3,1],"log_dirs":["any","any","any"]},{"topic":"first","partition":2,"replicas":[1,0,3],"log_dirs":["any","any","any"]}]}

kafka-reassign-partitions.sh --bootstrap-server kafka01:9092 --reassignment-json-file increase-replication-factor.json --execute
    # 执行副本计划
    #
    #Current partition replica assignment

    #{"version":1,"partitions":[{"topic":"first","partition":0,"replicas":[0,1,2],"log_dirs":["any","any","any"]},{"topic":"first","partition":1,"replicas":[1,2,0],"log_dirs":["any","any","any"]},{"topic":"first","partition":2,"replicas":[2,0,1],"log_dirs":["any","any","any"]}]}

    #Save this to use as the --reassignment-json-file option during rollback
    #Successfully started partition reassignments for first-0,first-1,first-2

kafka-reassign-partitions.sh --bootstrap-server kafka01:9092 --reassignment-json-file increase-replication-factor.json --verify
    # 验证副本计划
    #
    #Status of partition reassignment:
    #Reassignment of partition first-0 is complete.
    #Reassignment of partition first-1 is complete.
    #Reassignment of partition first-2 is complete.

    #Clearing broker-level throttles on brokers 0,1,3
    #Clearing topic-level throttles on topic first


kafka-reassign-partitions.sh --bootstrap-server kafka01:9092 --reassignment-json-file manually-adjust-partitions-replication-factor.json --execute
kafka-reassign-partitions.sh --bootstrap-server kafka01:9092 --reassignment-json-file manually-adjust-partitions-replication-factor.json --verify
