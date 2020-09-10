# Spring Cloud Eureka

## 1、概述

### 1.1、服务治理

`Spring Cloud` 封装了 `Netflix` 公司开发的 `Eureka` 模块来实现服务治理

在传统的 `rpc` 远程调用框架中，管理每个服务与服务之间依赖关系比较复杂，管理比较复杂，所以需要使用服务治理，管理服务与服务之间的依赖关系，可以实现服务调用、负载均衡、容错等，实现服务发现与注册。

### 1.2、服务注册与发现

`Eureka` 采用了 `C/S` 的设计架构，`Eureka Server` 作为服务注册功能的服务器，他是服务注册中心。而系统中的其他服务，使用 `Eureka` 的客户端连接到 `Eureka Server` 并维持心跳连接。这样系统的维护人员就可以通过 `Eureka Server` 来监控系统中各个微服务是否正常运行。

在服务注册与发现中，有个一注册中心。当服务器启动时，会把当前自己服务器的信息，比如服务地址通讯地址等以别名的方式注册到注册中心上。另一方（消费者|服务提供者），以该别名的方式去注册中心上获取到实际的服务器通讯地址，然后再实现本地 `RPC` 调用 `RPC` 远程调用框架核心设计思想。在于注册中心，因为使用注册中心管理每个服务于服务之间的一个依赖关系（服务治理概念）。在任何 `rpc` 远程框架中，都会有一个注册中心（存放服务地址相关信息）。

![image-20200823133930894](Photo\15、Eureka 组成结构（3）.png)

### 1.3、`Eureka Server & Eureka Client` 组件

#### 1.3.1、`Eureka Server` 

主要功能为提供服务注册服务

各个微服务节点通过配置启动后，会在 `Eureka` 中进行注册，这样 `Eureka Server` 中的服务注册表中将会储存所有可用的服务节点的信息，服务节点的信息可以在界面中看到。

#### 1.3.2、`Eureka Client` 

主要作用为通过注册中心进行访问

是一个 `Java` 客户端，用于简化 `Eureka Server` 的交互，客户端同时也具备一个内置的、使用轮询（`round-robin` ）负载算法的负载均衡器。在应用启动后，将会向 `Eureka Server` 发送心跳（默认周期为30秒）。如果 `Eureka Server` 在多个心跳周期内没有接受到某个节点的心跳，`Eureka Server` 会将服务注册表中将这个服务节点移出（默认为90秒）。

## 2、快速入门

### 2.1、`Eureka Server` 配置

#### 2.1.1、新建项目

新建 `maven` 项目 `cloud-eureka-server7001` 

![image-20200823143347284](Photo\16、Eureka 快速入门新建项目（3）.png).

#### 2.1.2、配置 `pom.xml` 

```xml
<dependencies>
    <!-- Eureka -->
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    <!-- pojo -->
    <dependency>
        <groupId>com.lxc.springcloud</groupId>
        <artifactId>cloud-api-commons</artifactId>
        <version>${project.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <scope>runtime</scope>
        <optional>true</optional>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
    </dependency>
    <dependency>
        <groupId>log4j</groupId>
        <artifactId>log4j</artifactId>
    </dependency>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

#### 2.1.3、配置 `application.yaml` 

```yaml
server:
  port: 7001
eureka:
  instance:
    hostname: localhost
  client:
    # 是否向注册中心注册自己
    register-with-eureka: false
    # false 表示自己为注册中心，维护实例，不需要检索服务
    fetch-registry: false
    service-url:
      # 与 Eureka Server 交互的地址查询服务和注册服务都需要依赖这个地址
      defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka/
```

#### 2.1.4、主启动类

```java
@SpringBootApplication
@EnableEurekaServer
public class EurekaMain7001 {

    public static void main(String[] args) {
        SpringApplication.run(EurekaMain7001.class, args);
    }

}
```

> 添加注解 `@EnableEurekaServer` 开启 `Eureka Server` 

#### 2.1.5、测试

![image-20200823143841981](Photo\17、Eureka Server 注解测试（3）.png)



### 2.2、`Eureka Client` 配置

#### 2.2.1、配置 `pom.xml` 

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

#### 2.2.2、配置 `yaml` 

- 配置 `Eureka Server` 中显示的 `Application Name` 

```yaml
spring:
  application:
    name: cloud-payment-service
```

- 配置 `eureka client` 

```yaml
eureka:
  client:
    service-url:
      defaultZone: http://localhost:7001/eureka
    # 是否将自己注册到 Eureka Server
    register-with-eureka: true
    # 是否从 Eureka Server 抓取已有的注册信息，默认为 true。集群必须为 true 才可以配合 ribbon 使用负载均衡
    fetch-registry: true
```

#### 2.2.3、主启动测试

在主启动类上添加 `@EnableEurekaClient` 注解

**测试：** 

![image-20200823150038076](Photo\18、Eureka Client 注解测试（3）.png)

## 3、集群及负载均衡

### 3.1、`Eureka` 集群

#### 3.1.1、修改 `host` 文件

```host
127.0.0.1 eureka7001.com
127.0.0.1 eureka7002.com
```

#### 3.1.2、配置 `yaml` 文件

`Eureka` 集群要做到相互注册

- 7001

```yaml
server:
  port: 7001
eureka:
  instance:
    hostname: eureka7001.com
  client:
    # 是否向注册中心注册自己
    register-with-eureka: false
    # false 表示自己为注册中心，维护实例，不需要检索服务
    fetch-registry: false
    service-url:
      # 将 7001 在 7002 中注册，有多个需要注册的 server 时，地址之间用逗号隔开
      defaultZone: http://eureka7002.com:7002/eureka/
```

- 7002

```yaml
server:
  port: 7002
eureka:
  instance:
    hostname: eureka7002.com
  client:
    # 是否向注册中心注册自己
    register-with-eureka: false
    # false 表示自己为注册中心，维护实例，不需要检索服务
    fetch-registry: false
    service-url:
      defaultZone: http://eureka7001.com:7001/eureka/
```

#### 3.1.3、将消费者模块注册

```yaml
eureka:
  client:
    service-url:
      defaultZone: http://eureka7001.com:7001/eureka, http://eureka7002.com:7002/eureka
    # 是否将自己注册到 Eureka Server
    register-with-eureka: true
    # 是否从 Eureka Server 抓取已有的注册信息，默认为 true。集群必须为 true 才可以配合 ribbon 使用负载均衡
    fetch-registry: true
```

> 每个注册中心的地址都需要填写

### 3.2、生产者集群

只需要修改端口号，或者使用不同 `ip` 即可实现集群

```yaml
server:
  port: 8002 # 修改port即可


spring:
  application:
    name: cloud-payment-service

eureka:
  client:
    service-url:
      defaultZone: http://eureka7001.com:7001/eureka, http://eureka7002.com:7002/eureka
    # 是否将自己注册到 Eureka Server
    register-with-eureka: true
    # 是否从 Eureka Server 抓取已有的注册信息，默认为 true。集群必须为 true 才可以配合 ribbon 使用负载均衡
    fetch-registry: true
```

### 3.3、负载均衡

在消费者 `config` 类中`resttemplate` 方法上添加 `@LoadBalanced` 注解即可。

```java
@Bean
@LoadBalanced
public RestTemplate getRestTemplate(){
    return new RestTemplate();
}
```

### 3.4、测试

在使用负载均衡后，由于使用的时轮询算法，所以刷新时会在 `8001` 和 `8002` 之间切换。

![image-20200823171219078](Photo\19、Eureka 集群负载均衡测试 1（3）.png).



![image-20200823171308329](Photo\20、Eureka 集群负载均衡测试 2（3）.png).

## 4、信息完善与自我保护

### 4.1、微服务信息完善

配置 `yaml` 修改 `Status` 显示内容

```yaml
instance:
# 微服务 id
instance-id: provider-payment8001
# 鼠标移入显示 ip 地址
prefer-ip-address: true
```

效果：

![image-20200823172556521](Photo\21、Eureka 微服务信息完善 1（3）.png)

![image-20200823172634775](Photo\22、Eureka 微服务信息完善 2（3）.png).

### 4.2、`Eureka` 自我保护

#### 4.2.1、概述

保护模式主要用于一组客户端和 `Eureka Server` 之间存在网络分区场景下的保护。

**为什么会产生自我保护机制？** 

为了防止 `Eureka Client` 可以正常运行，但是与 `Eureka Server` 网络不通的情况下， `Eureka Server` 不会立刻将 `Eureka Client` 服务删除。

**什么是自我保护模式？** 

默认情况下，如果 `Eureka Server` 在一定时间内（默认为90秒）没有接受到某个微服务实例的心跳， `Eureka Server` 将会注销该实例。但是当网络分区故障发生（延时、卡顿、拥挤）时，微服务与 `Eureka Server` 之间无法正常通行，此时微服务本身是处于健康状态不应该注销该服务。`Eureka` 使用“自我保护模式”来解决这个问题，当 `Eureka Server` 在短时间内丢失过多的客户端时，这个节点就会进入自我保护模式。

#### 4.2.2、关闭自我保护

- 服务端配置

```yaml
eureka:
  server:
  	# 关闭自我保护
    enable-self-preservation: false
    # 间隔多少毫秒清理一次无用服务
    eviction-interval-timer-in-ms: 2000
```

- 客户端配置

```yaml
eureka:
  instance:
    # 向服务器发送心跳的间隔
    lease-renewal-interval-in-seconds: 1
    # 服务端在接收到最后一次心跳后的等待上限，超时会删除服务
    lease-expiration-duration-in-seconds: 2
```

![image-20200823183220594](Photo\23、Eureka 关闭自我保护显示消息（3）.png)

> 此时，使用 `DeBug` 模式打开客户端，在暂停客户端后服务器会将服务及时删除，而在打开自我保护的情况下则不会删除。

## 5、服务发现

在主启动类中添加 `@EnableDiscoveryClient` 注解

```java
@Slf4j
@SpringBootTest(classes = PaymentMain8001.class)
public class TestClass {
    @Resource
    private DiscoveryClient discoveryClient;

    @Test
    public void test2() {
        List<String> services = discoveryClient.getServices();
        for (String service : services) {
            log.info("service ===> " + service.toString());
        }

        List<ServiceInstance> instances = discoveryClient.getInstances("CLOUD-PAYMENT-SERVICE");
        for (ServiceInstance instance : instances) {
            log.info("-------------");
            log.info("InstanceId ==> "+instance.getInstanceId());
            log.info("Host ==> "+instance.getHost());
            log.info("Scheme ==> "+instance.getScheme());
            log.info("ServiceId ==> "+instance.getServiceId());
            log.info("Metadata ==> "+instance.getMetadata().toString());
            log.info("Port ==> "+instance.getPort()+"");
            log.info("Uri ==> "+instance.getUri().toString());
        }
    }

}
```

**结果：** 

```shell
: service ===> cloud-payment-service
: service ===> cloud-order-service
: -------------
: InstanceId ==> provider-payment8002
: Host ==> 192.168.238.1
: Scheme ==> http
: ServiceId ==> CLOUD-PAYMENT-SERVICE
: Metadata ==> {management.port=8002}
: Port ==> 8002
: Uri ==> http://192.168.238.1:8002
: -------------
: InstanceId ==> provider-payment8001
: Host ==> 192.168.238.1
: Scheme ==> http
: ServiceId ==> CLOUD-PAYMENT-SERVICE
: Metadata ==> {management.port=8001}
: Port ==> 8001
: Uri ==> http://192.168.238.1:8001
```









