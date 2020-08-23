# Spring 简介

## 1、概述

`Spring`框架是由于软件开发的复杂性而创建的。`Spring`使用的是基本的`JavaBean`来完成以前只可能由EJB完成的事情。然而，`Spring`的用途不仅仅限于服务器端的开发。从简单性、可测试性和松耦合性角度而言，绝大部分`Java`应用都可以从`Spring`

- 目的：解决企业应用开发的复杂性

- 功能：使用基本的`JavaBean`代替`EJB`，并提供了更多的企业应用功能

- 范围：任何`Java`应用

`Spring`是一个轻量级控制反转(`IoC`)和面向切面(`AOP`)的容器框架。

## 2、相关地址

- [文档](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/overview.html#overview)
- [源码](https://repo.spring.io/release/org/springframework/spring/)

- [GitHub](https://github.com/spring-projects/spring-framework)

## 3、相关 `Jar` 包

```xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
```

## 4、`Spring` 七大模块

![](photo\1、Spring简介（1）.gif)..