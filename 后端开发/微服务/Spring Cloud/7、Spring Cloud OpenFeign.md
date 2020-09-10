# Spring Cloud OpenFeign

## 1、概述

`Feign` 是一个声明式的 `WebService` 客户端。使用 `Feign` 能让编写 `WebService` 客户端更加简单。

它的使用方式是定义一个服务接口然后在其上添加注释。 `Feign` 也支持可拔插式的编码器和解码器，`Spring Cloud` 对 `Feign` 进行了封装，支持 `Spring MVC` 标准注解和 `HttpMessageConverters` ，也可以与 `Eureka` 和 `Ribbon` 组合使用以支持负载均衡。

### 1.1、`Feign` 能干什么？

`Frign` 旨在使编写 `Java Http` 客户端变更简便。

前面在使用 `Ribbon` + `RestTemplate` 时，利用 `RestTemplate` 对 `http` 请求的封装处理，形成了一套模板化的调用方法。但是在实际开发中，由于对服务依赖的调用可能不止一处，往往一个接口会被多处调用，所以通常都会针对每个微服务自行封装一些客户端类来包装这些依赖服务的调用。所以， `Feign` 在此基础上做了进一步封装，由他来帮助我们定义和实现依赖服务接口的定义。此时我们需创建一个接口并使用注解的方式来配置它，即可完成对服务提供方的接口绑定，简化了使用 `Spring Cloud Ribbon` 时，自动封装服务调用客户端的开发量。

### 1.2、 `Feign` 集成 `Ribbon` 

利用 `Ribbon` 维护了 `Payment` 的服务列表信息，并且通过轮询实现类客户端的负载均衡。而与 `Ribbon` 不同的是，通过 `Feign` 只需要定义服务绑定接口且以声明式的方法，就可以简单的实现服务调用。

### 1.3、 `Feign` 与 `OpenFeign` 对比

| `Feign`                                                      | `OpenFeign`                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| 为 `Spring Cloud` 组件中的一个轻量级的 `RESTful` 风格的 `HTTP` 服务客户端 。其中内置了 `Ribbon` ，实现客户端负载均衡。<br>使用 `Feign` 的注解定义接口，调用这个接口就可以调用服务注册中心的服务。 | 是 `Spring Cloud` 在 `Feign` 的基础上支持了 `Spring MVC` 的注解。`OpenFeign` 可以解析 `Spring MVC` 和 `@RequestMapping` 注解下的接口，并通过动态代理的方式产生实现类，实现负载均衡及调用其他服务。 |

## 2、使用

使用接口 + 注解的方式使用 `OpenFeign` 

### 2.1、配置

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

```yaml
server:
  port: 80

spring:
  application:
    name: cloud-order-service

eureka:
  client:
    service-url:
      defaultZone: http://eureka7001.com:7001/eureka, http://eureka7002.com:7002/eureka
    # 是否将自己注册到 Eureka Server
    register-with-eureka: true
    # 是否从 Eureka Server 抓取已有的注册信息，默认为 true。集群必须为 true 才可以配合 ribbon 使用负载均衡
    fetch-registry: true
```

在主启动类中打开 `OpenFeign` 

```java
@EnableFeignClients
```

### 2.2、业务接口类

```java
@Component
@FeignClient("CLOUD-PAYMENT-SERVICE") // 指定要访问哪一个服务提供者
public interface PaymentFrignService {

    @PostMapping("/payment/add")
    public CommonResult add(@RequestBody Payment payment);

    @GetMapping("/payment/find/{id}")
    public CommonResult<Payment> findPaymentById(@PathVariable("id") Long id);

}
```

### 2.3、`Controller` 类

```java
@RequestMapping("/user")
@RestController
@Slf4j
public class PaymentController {

    @Resource
    private PaymentFrignService service;

    @Value("${server.port}")
    private int port;

    @GetMapping("/add")
    public CommonResult add(@RequestBody Payment payment) {
        CommonResult comm = service.add(payment);
        return comm;
    }

    @GetMapping("/find/{id}")
    public CommonResult<Payment> findPaymentById(@PathVariable("id") Long id) {
        CommonResult<Payment> paymentById = service.findPaymentById(id);
        return paymentById;
    }

}
```

### 2.4、测试

![image-20200904145805444](Photo\32、OpenFeign 使用测试（7）.png).

## 3、其他功能

### 3.1、超时控制

若服务提供者某一接口处理时间超过 `1s` 时，`OpenFeign` 会直接报错 `500` ，可以通过调整超时设置避免。

```yaml
ribbon:
  # 执行超时
  ReadTimeout: 5000
  # 连接超时
  ConnectTimeout: 5000
```

> 单位 `ms` 

### 3.2、日志功能

#### 3.2.1、配置

```java
@Configuration
public class FeignConfig {


    @Bean
    Logger.Level feignLoggerLevel(){
        return Logger.Level.FULL;
    }

}
```

```yaml
logging:
  level:
    # feign 日志监控哪一个接口
    com.lxc.springcloud.service.PaymentFrignService: debug
```

#### 3.2.2、测试

![image-20200904154909902](Photo\33、OpenFeign 日志测试（7）.png)