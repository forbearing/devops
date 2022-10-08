zookeeper-shell.sh localhost:2181 ls /brokers/ids
    # This command will give you the list of the active brokers between brackets:
zookeeper-shell.sh kafka01:2181,kafka02:2181,kafka03:2181 ls /kafka/brokers/ids
zookeeper-shell.sh kafka02:2181 get /kafka/brokers/ids/0

zookeeper-shell.sh localhost:2181 rmr /kafka                    # deleteall 代替 rmr
zookeeper-shell.sh localhost:2181 deleteall /kafka              # 删除所有元数据

# 查看 controller 节点
for item in kafka01:2181 kafka02:2181 kafka03:2181; do
    zookeeper-shell.sh "$item" ls /kafka/brokers/ids
done
for item in kafka01:2181 kafka02:2181 kafka03:2181; do
    zookeeper-shell.sh "$item" get /kafka/controller
done
