# Mybatis概述

## 1、什么是`Mybatis`

![](https://mybatis.org/images/mybatis-logo.png)

`MyBatis` 是一款优秀的**持久层框架**，它支持自定义` SQL`、存储过程以及高级映射。`MyBatis` 免除了几乎所有的` JDBC` 代码以及设置参数和获取结果集的工作。MyBatis 可以通过简单的 XML 或注解来配置和映射原始类型、接口和` Java POJO`（`Plain Old Java Objects`，普通老式` Java` 对象）为数据库中的记录。

- 相关连接
  - [maven](https://mvnrepository.com/search?q=mybatis)
  - [中文文档](https://mybatis.org/mybatis-3/zh/index.html)
  - [github](https://github.com/mybatis/mybatis-3)

## 2、持久层

持久化是将程序数据在**持久状态**和**瞬时状态**间转换的机制。

即瞬时数据（比如内存中的数据，是不能永久保存的）持久化为持久数据（比如持久化至数据库中，能够长久保存）。

## 3、为什么需要`Mybatis`

- 简化`JDBC`操作
- 简单易学
- 解除`sql`与代码的耦合
- 提供映射标签，支持对象与数据库的`orm`字段关系映射
- 提供对象关系映射标签，支持对象关系组建维护
- 提供`xml`标签，支持编写动态`sql`

