# ZooKeeper的一个命令行客户端

ls /kafka/brokers/ids
ls /kafka/brokers/topics
get /kafka/brokers/ids/0
get /kafka/controller
    有一个 brokerid, 用来记录那个 broker 是 leader
create /zk_test mydata1


0.在交互式环境中，可以使用TAB键补全，或列出可用的命令、路径。就像bash一样。
  ZooKeeper的命令很少很简单，大致分为几个类型：
    create:         在树中的某个位置创建一个节点。
    delete:         删除一个节点
    exists:         测试一个节点是否存在
    get data        读取节点数据
    set data        向节点中写入数据
    get children    检索某节点的子节点列表
    sync            等待要传播的数据
    注意，这只是命令的功能类型，并不意味着它们就是命令。

1.创建 znode
    create [-s] [-e] path data acl
        -s：创建的是带序列号的节点，序列号用0填充节点路径。
        -e：创建的是临时节点。
        path：znode的路径，ZooKeeper中没有相对路径，所有路径都必须以'/'开头。
        data：znode携带的数据。
        acl：这个节点的ACL。
    create /zk_test mydata1
        # 其中/zk_test是节点名称，mydata1是该节点携带的数据。
    create /zk_test/child_node1 "mydata2"
        # 创建一个子节点
    create -s /test1 222
        # 创建一个带序列号的znode
        # 注意，创建了带序列号的znode后，以后只能使用带序列号的路径 /test10000000003
        # 来引用这个znode，而不能用/test1来引用
    create -e /test2 333
        # 创建一个临时znode
        # 临时znode在会话退出时会自动删除，所以不能在临时节点上创建子节点。
        # 另外，虽然临时节点属于某会话，但所有客户端都可以查看、引用它

2.查看节点的数据和状态信息
    get /zk_test
    get /zk_test/child_node1
        # 获取节点数据、状态信息
    stat /zk_test
        # 如果只是要获取节点的状态信息，可以使用stat命令

3.查看子节点
    ls /
    ls /zk_test
        # ls 命令查看某节点下的子节点

4.修改节点数据
    set /zk_test "mydata2"
        # set 命令用于修改节点

5.删除节点
    delete /zk_test
        # Node not empty: /zk_test
        # delete可以删除节点。注意，它不会递归删除，所以要删除一个包含子节点的节点，需要先删除所有子节点
    create /test
    create /test/hello 2323
    create /test/hello/hello1 23233
    rmr /test
    deleteall /test
        # rmr 命令可以递归删除节点，所以也会删除节点中的所有子节点。
        # deleteall 新版本用 deleteall 替代 rmr

6.history和redo
    history
    redo 13
        # history命令可以列出最近操作的10条命令历史，并给出每个历史命令的编号。
        # redo命令可以根据历史命令的编号重新调用这些命令。

7.connect和close
    connect 192.168.100.21:2181
    connect 10.250.21.11:2181
    close
        # connect命令用于连接其它ZooKeeper服务器，
        # close用于关闭当前连接。就像ssh到其它服务器，然后exit一样。
        # 需要注意，当connect到其它服务器后，当前的连接就会断开，当前会话中的临时znode就会被删除

8:quit
    # quit命令退出ZooKeeper的交互式命令行
