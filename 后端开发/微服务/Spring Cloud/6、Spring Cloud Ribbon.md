# Spring Cloud Ribbon

## 1、概述

### 1.1、`Ribbon` 是什么？

`Spring Cloud Ribbon` 是基于 `Netflix Ribbon` 实现的一套客户端负载均衡的工具

简单来说， `Ribbon` 是 `Netflix` 发布的开源项目，主要功能是提供客户端的软件负载均衡算法和服务调用。 `Ribbon` 客户端组件提供一系列完善的配置项，如连接超时、重试等。简单地说，就是在配置文件中列出 `Load Balancer` 简称 `LB` 的所有的机器， `Ribbon` 会自动的帮助你基于某种规则（如简单轮询、随机连接等）去连接这些机器。很容易使用 `Ribbon` 实现自定义的负载均衡算法。

### 1.2、`LB Load Balance` 是什么？

它将用户的请求平摊的分配到多个服务上，从而达到系统的 `HA` （高可用）。常见的负载均衡软件有 `Nginx` 、`LVS` 、硬件 `F5` 等。

### 1.3、`Ribbon` 和 `Nginx` 的区别

`Nginx` 是服务器负载均衡，客户端所有的请求都会交给 `nginx` ，然后由 `nginx` 实现转发请求。即负载均衡是由服务端实现的。

`Ribbon` 本地负载均衡，在调用微服务接口时，会在注册中心上获取注册信息服务列表之后缓存到 `JVM` 本地，从而在本地是实现 `RPC` 远程服务调用技术。

#### 1.3.1、集中式 `LB` 

即在服务的消费方和提供方之间使用独立的 `LB` 设施（可以是硬件，如 `F5` ，也可以是软件，如 `nginx` ），由该设施负责把访问请求通过某种策略转发至服务的提供方。

#### 1.3.2、进程内 `LB` 

将 `LB` 逻辑集成到消费方，消费方从服务注册中心获取有哪些地址可使用，然后自己再从这些地址中选择一个合适的服务器。

`Ribbon` 属于进程内 `LB` ，它只是一个类库，集成于消费方进程，消费方通过它来获取到服务方的地址。

### 1.4、工作流程

- 选择 `Eureka Server` ，优先选择在同一区域内负载较少的 `server` 
- 根据用户指定的策略，从 `server` 获取到服务注册列表中选择一个地址

> 其中 `Ribbon` 提供了多种策略，如：轮询、随机和根据响应时间加权。

## 2、使用

### 2.1、引入 `Jar` 包

在 `spring-cloud-starter-netflix-eureka-client` 的包中已经引入了 `Ribbon` 的 `jar` 包。

![image-20200824162351996](Photo\29、Ribbon 已经被 Eureka 引入（6）.png)

### 2.2、`RestTemplate` 使用

#### 2.2.1、`get` 方式

- `getForObject` 

```java
@GetMapping("/find/{id}")
public CommonResult<Payment> find(@PathVariable("id") Long id){
    return restTemplate.getForObject(URL+"/payment/find/"+id, CommonResult.class);
}
```

- `getForEntity` 

```java
@GetMapping("/ent/find/{id}")
public CommonResult<Payment> findEnt(@PathVariable("id") Long id){
    ResponseEntity<CommonResult> ent = restTemplate.getForEntity(URL + "/payment/find/" + id, CommonResult.class);
    if (ent.getStatusCode().is2xxSuccessful()){
        return ent.getBody();
    }else{
        return new CommonResult<>(470, "操作失败");
    }
}
```

#### 2.2.2、`post` 方式

- `postForObject` 

```java
@GetMapping("/add")
public CommonResult<Payment> add(Payment payment){
    return restTemplate.postForObject(URL+"/payment/add", payment,CommonResult.class);
}
```

- `postForEntity` 

```java
@GetMapping("/ent/add")
public CommonResult<Payment> addEnt(Payment payment){
    ResponseEntity<CommonResult> ent = restTemplate.postForEntity(URL + "/payment/add", payment, CommonResult.class);
    if (ent.getStatusCode().is2xxSuccessful()){
        return ent.getBody();
    }else{
        return new CommonResult<>(470, "操作失败");
    }
}
```

## 3、负载均衡算法

### 3.1、`Ribbon` 已实现算法

- `RoundRobinRule` ：轮询算法
- `RandomRule` ：随机算法
- `RetryRule` ：先按照 `RoundRobinRule` 算法获取服务，若获取服务失败会在指定时间内重试，获取可用的服务。
- `WeightedResponseTimeRule` ：对 `RoundRobinRule` 扩展，响应速度越快权重越大
- `BestAvailableRule` ：先过滤有多次访问故障而处于断路器跳闸状态的服务，选择一个并发量最小的服务
- `AvailabilityFilteringRule` ：先过滤故障示例，再选择并发较小的实例
- `ZoneAvoidanceRule` 默认规则，复合判断 `server` 所在区域的性能和 `server` 的可用性选择服务器

### 3.2、替换默认规则

#### 3.2.1、配置 `bean` 

新建类

![image-20200824171759668](Photo\30、Ribbon 规则替换新建类（6）.png).

这个类需要新建在 `@ComponentScan` 注解扫描不到的包中，而主程序入口的 `@SpringBootApplication` 注解类上就存在 `@ComponentScan` 注解，所以需要将配置类新建在 `springcloud` 包之外的包中。

若将类新建在 `@ComponentScan` 注解扫描到的包中时，此配置会成为全局配置，即不可以使用 `@RibbonClient` 注解手动设置。

```java
@Configuration
public class LxcRibbonRule {

    @Bean
    public IRule myRule(){
        return new RandomRule();
    }
}
```

#### 3.2.2、配置注解

```java
// name：要访问的服务名 configuration：配置类
@RibbonClient(name = "CLOUD-PAYMENT-SERVICE", configuration = LxcRibbonRule.class)
```

#### 3.2.3、测试

![image-20200824171216433](Photo\31、Ribbon 规则替换后测试（6）.png)

> 替换为随机规则后，`8001` 与 `8002` 不再交替出现













