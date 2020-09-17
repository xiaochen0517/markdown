# Spring Cloud Hystrix

## 1、概述

`Hystrix` 是一个用于处理分布式系统的延迟和容错的开源库，在分布式系统中许多依赖不可避免的会调用失败，比如超时、异常等， `Hystrix` 能够保证在一个依赖出现问题时，不会导致整体服务的失败，避免级联故障，以提高分布式系统的稳定性。 

### 1.1、服务雪崩

复杂分布式系统结构中的应用程序有数十个依赖关系，每个依赖关系在某些时候将不可避免的失败。

多个微服务之间调用时，服务 `A` 调用 `B` 和 `C` ，服务 `B` 和 `C` 又调用其他的微服务，这就是 ==扇出== 。如果多个扇出的链路上某个微服务的调用响应时间过长或者不可用，对服务 `A` 的调用就会占用越来越多的系统资源，进而引起系统崩溃，就是所谓的雪崩效应。

对于高流量的应用来说，单一的后端依赖可能会导致所有服务器中的资源在几秒钟内饱和。导致服务之间的延迟增加，备份队列，线程和其他系统资源的紧张，导致整个系统发生更多的级联故障。

当发现一个模块的某个实例失败后，这时，这个模块依然还会接收流量，然后这个有问题的模块还调用了其他的模块，这样就会发生级联故障，或者叫雪崩。

### 1.2、断路器

==断路器== 本身是一个开关装置，当某个服务单元发生故障之后，通过断路器的故障监控（类似熔断保险丝），向调用方返回一个符合预期的、可处理的备选响应 `FallBack` ，而不是在长时间的等待或者抛出调用方无法处理的异常，这样就保证了服务调用方的线程不会被长时间、不必要的占用，从而避免了故障在分布式系统中蔓延，乃至雪崩。

### 1.3、可以做什么

- 服务降级
- 服务熔断
- 实时监控
- 服务限流
- 服务隔离

## 2、使用

### 2.2、项目搭建

- 消费者 `80` 
- 服务提供者 `8001` 
- 服务治理 `7001` 

![image-20200915171046248](Photo\34、Hystrix 测试项目搭建（8）.png).

### 2.1、服务降级

#### 2.1.1、`maven` 坐标

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
</dependency>
```

#### 2.2.2、服务提供者

- 主启动类注解

```java
@EnableCircuitBreaker
```

- 业务类

```java
@HystrixCommand(fallbackMethod = "fallbackError", commandProperties = {
    @HystrixProperty(name = "execution.isolation.thread.timeoutInMilliseconds", value = "3000")
}) // 设置 fallback 方法，设置超时时间
public String paymentError(Integer id) {
    int time = 5;
    try {
        TimeUnit.SECONDS.sleep(time);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    return "线程：" + Thread.currentThread().getName() + " 方法名：paymentError id：" + id + " 耗时"+time+"秒";
}

public String fallbackError(Integer id){
    return "线程：" + Thread.currentThread().getName() + " 方法名：fallbackError id：" + id + " 服务降级";
}
```

- 测试

![image-20200915172125227](Photo\35、Hystrix 服务提供者服务降级测试（8）.png).

#### 2.2.3、消费者

- 主启动类注解

```java
@EnableHystrix
```

- `controller` 类配置

```java
@GetMapping("/payerr/{id}")
@HystrixCommand(fallbackMethod = "fallbackError", commandProperties = {
    @HystrixProperty(name = "execution.isolation.thread.timeoutInMilliseconds", value = "1500")
})
public String paymentError(@PathVariable("id") Integer id) {
    String result = orderHystrixService.paymentError(id);
    log.info(result);
    return result;
}
public String fallbackError(Integer id){
    return "80消费者服务降级";
}
```

- 测试

![image-20200915172358843](Photo\36、Hystrix 消费者服务降级测试（8）.png).

#### 2.2.4、全局服务降级方法

在类上添加注解

```java
@DefaultProperties(defaultFallback = "defFallback") // 设置此类全局 fallback 方法
```

在方法上添加注解

```java
@HystrixCommand
```

测试

![image-20200915173733938](Photo\37、Hystrix 服务降级全局方法（8）.png).

### 2.2、服务熔断

#### 2.2.1、概述

熔断机制是应对雪崩效应的一种微服务链路保护机制。当扇出链路的某个微服务出错不可用或者响应时间太长时，会进行服务的降级，进而熔断该节点微服务的调用，快速返回错误的响应信息。

当检测到该节点微服务调用响应正常后，恢复调用链路。

在  `Spring Cloud` 框架中，熔断及时通过 `Hystrix` 实现。`Hystrix` 会监控微服务间调用的状况，当失败的调用到一定阈值，缺省是 5 秒内 20 次调用失败，就会启动熔断机制。熔断机制的注解是 `@HystrixCommand` 。

#### 2.2.2、服务类配置

```java
@HystrixCommand(fallbackMethod = "circuitBreakerFallbackError", commandProperties = {
    @HystrixProperty(name = "circuitBreaker.enabled", value = "true"), // 开启断路器
    @HystrixProperty(name = "circuitBreaker.requestVolumeThreshold", value = "10"), // 失败请求超过多少次会触发断路
    @HystrixProperty(name = "circuitBreaker.sleepWindowInMilliseconds", value = "10000"), // 在开启断路后多久再次尝试恢复
    @HystrixProperty(name = "circuitBreaker.errorThresholdPercentage", value = "60") // 失败率达到多少启动断路器
})
public String circuitBreakerFallback(Integer id){
    if (id < 0){
        throw new RuntimeException("id 不可小于 0");
    }
    return "线程：" + Thread.currentThread().getName() + " 方法名：circuitBreakerFallback id：" + id;
}
public String circuitBreakerFallbackError(Integer id){
    return "id不可小于0 id：" + id;
}
```

#### 2.2.3、测试熔断

使用 `id` 大于等于0访问此接口。

![image-20200916112450622](Photo\38、Hystrix 服务熔断前正常请求（8）.png).

使用 `id` 小于0访问接口

![image-20200916112602206](Photo\39、Hystrix 服务熔断前错误请求（8）.png).

在多次使用错误 `id` 访问接口后，触发服务熔断后再次使用正确 `id` 访问时，会直接进入 `fallback` 方法中，之后渐渐恢复。

![image-20200916112924070](Photo\40、Hystrix 服务熔断后正确请求（8）.png).

#### 2.2.4、熔断类型

熔断打开：请求不再进行调用当前服务，内部设置时钟一般为 `MTTR` （平均故障处理时间），当打开时长达所设时间则进入半熔断状态。

熔断打开：熔断关闭不会对服务进行熔断

熔断半开：部分请求根据规则调用当前服务，如果请求成功且符合规则则认为当前服务恢复正常，关闭熔断。

![](Photo\41、Hystrix 服务熔断流程图（8）.png)

#### 2.2.5、断路器打开后执行

- 当再次请求调用时，将不会使用主逻辑，而是直接调用降级 `fallback` 。通过断路器，实现了自动的发现错误并将降级逻辑切换为主逻辑，减少响应延迟效果。
- 当断路器打开，对主逻辑进行熔断后， `hystrix` 启动一个休眠时间窗，在这个时间窗内，降级逻辑将临时的成为主逻辑。当休眠时间结束时，断路器将进入半开状态，释放一次请求到原来的主逻辑中，如果此次请求正常返回，那么断路器将会关闭，若请求依然有问题，断路器会继续打开，时间窗重新计时。

## 3、服务监控 `HystrixDashboard` 

### 3.1、概述

`Hystrix` 除了隔离依赖服务的调用以外， `Hystrix` 还提供了准实时的调用监控 `Hystrix Dashboard` ， `Hystrix` 会持续地记录所有通过 `Hystrix` 发起的请求的执行信息，并以统计报表和图形的形式展示给用户，包括每秒执行多少请求及成功数、失败数等。 `Netflix` 通过 `hystrix-metrics-event-stream` 项目实现类对以上指标的监控。 `Spring Cloud` 也提供了 `Hystrix Dashboard` 的整合，对监控内容转化成可视化界面。









