# Spring Cloud Consul

## 1、概述

### 1.1、什么是 `Consul` 

`Consul` 是一套开源的分布式服务发现和配置管理系统，由 `HashiCorp` 公司使用 `Go` 语言开发

提供了微服务系统中的服务治理、配置中心、控制总线等功能。这些功能中的每一个都可以根据需要单独使用，也可以一起使用以构建全方位的服务网格，总之 `Consul` 提供了一种完整的服务网格解决方案。

### 1.2、优点

它具有很多优点，包括基础 `raft` 协议，比较简洁；支持健康检查，同时支持 `HTTP` 和 `DNS` 协议；支持跨数据中心的 `WLAN` 集群；提供图形界面跨平台，支持 `Linux` 、`Mac` 、`Windows` 。



## 2、使用

### 2.1、安装 `Consul` 

[下载地址](https://www.consul.io/downloads) 

下载解压后在命令行中执行命令 `consul agent -dev` 

访问 `127.0.0.1:8500` 

![image-20200824143721256](Photo\26、Consul 安装完成（5）.png).

### 2.2、微服务配置

#### 2.2.1、导入包

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-consul-discovery</artifactId>
</dependency>
```

#### 2.2.2、配置 `yaml` 

```yaml
server:
  port: 8004

spring:
  application:
    # 服务名
    name: cloud-provider-payment8004
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: ${spring.application.name}
```

#### 2.2.3、测试

![image-20200824144030110](Photo\27、Consul 服务注册（5）.png).

接口测试

![image-20200824144133427](Photo\28、Consul 接口测试（5）.png).















