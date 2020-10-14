# Spring Cloud GateWay

## 1、概述

`GetWay` 是在 `Spring` 生态系统之上构建的 `api` 网关服务，基于 `Spring 5, Spring Boot 2` 和 `Project Reactor` 等技术。

`GetWay` 旨在提供一种简单而有效的方式来对 `api` 进行路由，以及提供一些强大的过滤器功能，例如：熔断、限流、重试等。

`Spring Cloud Gateway` 作为 `Spring Cloud` 生态系统中的网关，目标是替代 `Zuul` ，在 `Spring Cloud 2.0` 以上版本中，没有对新版本 `Zuul 2.0` 以及最新高性能版本进行集成，仍然还是使用 `Zuul 1.x` 非 `Reactor` 模式的老版本。而为了提升网关的性能， `Spring Cloud Gateway` 是基于 `WebFlux` 框架，而 `WebFlux` 框架底层使用了高性能的 `Reactor` 模式通信框架 `Netty` 。

`Spring Cloud Gateway` 的目标提供统一的路由方式且基于 `Filter` 链的方式提供了网关的基本功能，例如：安全，监控/指标和限流。

特性：

- 基于 `Spring Framework5, Project Reactor` 和 `Spring Boot 2.0` 进行构建
- 动态路由：能够匹配任何请求属性
- 可以对路由制定 `Predicate` （断言）和 `Filter` （过滤器）
- 集成 `Hystrix` 的断路器功能
- 集成 `Spring Cloud` 服务发现功能
- 易于编写 `Predicate` （断言）和 `Filter` （过滤器）
- 请求限流功能
- 支持路径重写