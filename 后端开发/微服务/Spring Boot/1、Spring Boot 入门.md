# Spring Boot 入门

## 1、 `Spring Boot` 概述

### 1.1、什么是 `Spring Boot` 

`Spring Boot` 是由 `Pivotal` 团队提供的全新框架，其设计目的是用来简化新 `Spring` 应用的初始搭建以及开发过程。该框架使用了特定的方式来进行配置，从而使开发人员不再需要定义样板化的配置。通过这种方式， `Spring Boot` 致力于在蓬勃发展的快速应用开发领域 `(rapid application development)` 成为领导者。

### 1.2、 `Spring Boot` 的优点

- 为所有 `Spring` 开发者更快的入门
- 开箱即用，提供各种默认配置来简化项目配置
- 内嵌式容器简化 `Web` 项目
- 没有冗余代码生成的 `XML` 配置的要求

## 2、微服务

### 2.1、什么是微服务

微服务是一种架构风格，它要求我们在开发一个应用时，这个应用必须构成一系列小服务的组合；可以通过 `http` 的方式进行互通。

### 2.2、单体应用架构

单体应用架构 `all in one` 是指，将一个应用中的所有应用服务都封装在一个应用中。

- 优点是易于开发和测试，方便部署；需要扩展时，只需要将 `war` 复制多份，然后放到多个服务器中，进行负载均衡即可。
- 缺点是如果需要修改某个地方的代码，需要停止整个服务，重新打包和部署；应用的维护和分工合作会变得十分困难。

### 2.3、微服务架构

微服务架构即是将每个功能元素独立出来，把独立出的功能元素的动态组合，进行开发部署。

微服务架构的优点：

- 节省了调用资源
- 每个功能元素的服务都是一个可以替换、可以独立升级的软件包

![](https://martinfowler.com/articles/microservices/images/sketch.png)

### 2.4、构建微服务

`Spring` 提供了构建大型分布式微服务的全套产品

- 构建功能独立的微服务应用单元，可以使用 `Spring Boot` 
- 大型分布式网络服务的调用，可以使用 `Spring Cloud` 
- 在分布式中进行流式数据计算、批处理，可以使用 `Spring Cloud Data Flow` 

## 3、 `Spring Boot` 简单实现

### 3.1、新建项目

`File -> New Project` 选中 `Spring Initializr` 

![image-20200709170520785](photo\1、新建项目（1）.png)

配置项目参数

![image-20200709170749224](photo\2、配置项目（2）.png).

### 3.2、配置 `controller` 

`com.lxc.springboot.controller.HelloController` 

```java
@RestController
public class HelloController {

    @RequestMapping("/hello")
    public String hello1(){
        return "hello world";
    }

}
```

测试结果

![image-20200709170945546](photo\3、测试结果（3）.png).