# Spring Cloud Zookeeper

## 1、概述



## 2、服务器安装

### 2.1资源准备

[`Zookeeper` 下载地址](http://mirror.bit.edu.cn/apache/zookeeper/) 

> 需要预先配置 `jdk1.8` 

### 2.2、安装

#### 2.2.1、解压文件

```shell
tar zxvf [Zookeeper压缩包]
```

#### 2.2.2、修改配置文件

打开解压目录 `apache-zookeeper-3.5.8-bin/conf` 将 `zoo_sample.cfg` 复制一份

```shell
cp zoo_sample.cfg zoo.cfg
```

修改 `zoo.cfg` 

```shell
# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial 
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between 
# sending a request and getting an acknowledgement
syncLimit=5
# 此处可以修改到一个已存在的文件夹，或者将此文件夹创建出来
dataDir=/tmp/zookeeper
# 服务端口号
clientPort=7001
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1
```

#### 2.2.3、启动 `zookeeper` 

进入解压根目录的 `bin` 文件夹

```bash
[root@xxx bin]# ./zkServer.sh start
ZooKeeper JMX enabled by default
Using config: /root/apache-zookeeper-3.5.8-bin/bin/../conf/zoo.cfg
Starting zookeeper ... STARTED
```

查看启动状态

```bash
[root@xxx bin]# ./zkServer.sh status
ZooKeeper JMX enabled by default
Using config: /root/apache-zookeeper-3.5.8-bin/bin/../conf/zoo.cfg
Client port found: 7001. Client address: localhost.
Mode: standalone
```

启动 `zkCli` 

```bash
[root@xxx bin]# ./zkCli.sh -server localhost:7001
Connecting to localhost:7001
WATCHER::
WatchedEvent state:SyncConnected type:None path:null
[zk: localhost:7001(CONNECTED) 0] 
```

> 在配置文件中修改端口号后，启动 `zkCli` 时必须在参数中标明端口号

## 3、微服务配置

### 3.1、导入 `jar` 包

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-zookeeper-discovery</artifactId>
</dependency>
```

此 `maven` 坐标会导入 `zookeeper 3.5.3` 的 `jar` 包，若服务器端使用的为 `3.5.x` 版本以下时，会导致 `jar` 包冲突产生错误，此时就需要将微服务中的 `jar` 包版本降低。

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-zookeeper-discovery</artifactId>
    <exclusions>
        <exclusion>
            <groupId>org.apache.zookeeper</groupId>
            <artifactId>zookeeper</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>org.apache.zookeeper</groupId>
    <artifactId>zookeeper</artifactId>
    <version>3.4.14</version>
</dependency>
```

### 3.2、配置 `yaml` 

#### 3.2.1、生产者

```yaml
server:
  port: 8003

spring:
  application:
    # 服务名
    name: cloud-provider-payment8003
  cloud:
    zookeeper:
      # 要连接的 Zookeeper 服务器地址
      connect-string: androidzy.cn:7001
```

#### 3.2.2、消费者

```yaml
server:
  port: 80

spring:
  application:
    # 服务名
    name: cloud-consumer-order80
  cloud:
    zookeeper:
      # 要连接的 Zookeeper 服务器地址
      connect-string: androidzy.cn:7001
```

### 3.3、`Controller` 类

#### 3.3.1、生产者

```java
@RestController
public class ClientController {

    @Value("${server.port}")
    private int port;

    @GetMapping("/payment/status")
    public Map<String, Object> status(){
        Map<String, Object> map = new HashMap<>();
        map.put("port", port);
        map.put("uuid", UUID.randomUUID().toString());
        return map;
    }
}
```

#### 3.3.2、消费者

```java
@RequestMapping("/order")
@RestController
public class OrderController {

    private static final String URL = "http://cloud-provider-payment8003";

    @Resource
    private RestTemplate restTemplate;

    @GetMapping("/status")
    public Map<String, Object> status(){
        return restTemplate.getForObject(URL+"/payment/status", Map.class);
    }

}
```

## 4、相关信息查看

### 4.1、查看服务注册信息

#### 4.1.1、查看服务注册列表

```shell
[zk: localhost:7001(CONNECTED) 3] ls /services
[cloud-consumer-order80, cloud-provider-payment8003]
```

#### 4.1.2、查看某服务详细信息

```shell
[zk: localhost:7001(CONNECTED) 6] get /services/cloud-consumer-order80/74d8245c-96c4-43d4-9eca-0b7c05d13a9e
{"name":"cloud-consumer-order80","id":"74d8245c-96c4-43d4-9eca-0b7c05d13a9e","address":"MoChenYa-PC","port":80,"sslPort":null,"payload":{"@class":"org.springframework.cloud.zookeeper.discovery.ZookeeperInstance","id":"application-1","name":"cloud-consumer-order80","metadata":{"instance_status":"UP"}},"registrationTimeUTC":1598239573121,"serviceType":"DYNAMIC","uriSpec":{"parts":[{"value":"scheme","variable":true},{"value":"://","variable":false},{"value":"address","variable":true},{"value":":","variable":false},{"value":"port","variable":true}]}}
```

格式化

```json
{
	"name": "cloud-consumer-order80",
	"id": "74d8245c-96c4-43d4-9eca-0b7c05d13a9e",
	"address": "MoChenYa-PC",
	"port": 80,
	"sslPort": null,
	"payload": {
		"@class": "org.springframework.cloud.zookeeper.discovery.ZookeeperInstance",
		"id": "application-1",
		"name": "cloud-consumer-order80",
		"metadata": {
			"instance_status": "UP"
		}
	},
	"registrationTimeUTC": 1598239573121,
	"serviceType": "DYNAMIC",
	"uriSpec": {
		"parts": [{
			"value": "scheme",
			"variable": true
		}, {
			"value": "://",
			"variable": false
		}, {
			"value": "address",
			"variable": true
		}, {
			"value": ":",
			"variable": false
		}, {
			"value": "port",
			"variable": true
		}]
	}
}
```

### 4.2、连接测试

#### 4.2.1、生产者测试

![image-20200824113508811](Photo\24、Zookeeper 生产者测试（4）.png).

#### 4.2.2、消费者调用生产者

![image-20200824113601238](Photo\25、Zookeeper 消费者调用生产者测试（4）.png).