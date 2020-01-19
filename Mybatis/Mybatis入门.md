## Mybatis入门

#### 什么是框架

- 框架（Framework）是整个或部分系统的可重用设计，表现为一组抽象构建及构件实例间交互的方法；另一种定义认为，框架是可被应用开发者定制的应用骨架。前者是从应用方面而后者是从目的方面给出的定义。
- 简而言之，框架其实就是某种应用的半成品，就是一组组件，供你选用完成你自己的系统。简单说就是使用别人搭建好的舞台，你来做表演。而且，框架一般是成熟的，不断升级的软件。

#### 三层架构

- 表现层：用于展示数据
- 业务层：处理业务需求
- 持久层：数据库交互

#### 持久层技术解决方案

- JDBC技术：
  - Connection
  - PreparedStatement
  - ResultSet
- Spring的JdbcTemplate
  - spring中对jdbc的简单封装
- Apache的DBUtils
  - 和Spring的JdbcTemplate很像，也是对Jdbc的封装
- 以上都不是框架
  - JDBC是规范
  - Spring和JdbcTemplate和Apache的DBUtils都只是工具类

#### Mybatis概述

- mybatis是一个优秀的基于java的持久层框架，它内部丰庄路jdbc，使开发者只需要关注sql语句本身，而不需要花费精力去处理加载驱动，创建连接、创建statement等繁杂的过程。
- mybatis通过xml或者注解的方式将要执行的各种statement配置起来，并通过java对象和statement中sql的动态参数进行映射生成最终执行的sql语句，最后由mybatis框架执行sql语句并将结构映射为java对象并返回。
- 采用ORM实现解决了实体和数据库映射的问题，对jdbc进行了封装，屏蔽了jdbc api底层访问细节，使我们不用与jdbc api打交道，就可以完成对数据库的持久化操作。
- ORM
  - object relational mappging对象关系映射

#### Mybatis入门

- mybatis环境搭建
  - 创建maven工程并导入坐标
  - 创建实体类和dao的接口
  - 创建mybatis的主配置文件
  - 创建映射配置文件