## Spring概述

#### spring是什么

- Spring是分层的Java SE/EE应用full-stack轻量级开源框架，以Ioc（Inverse Of Control：反转控制）和AOP（Aspect Oriented Programming：面向切面编程）为内核，提供了展现层SpringMVC和持久层nengSpring JDBC以及业务层事务管理等众多的企业级应用技术，还能整合开源世杰众多著名的第三方框架和类库，逐渐成为使用最多的JavaEE企业应用开源框架

#### spring的优势

- 方便解耦，简化开发
- AOP编程的支持
- 声明式事务的支持
- 方便程序的测试
- 方便集成各种框架
- 降低JavaEE API的使用难度

#### spring体系结构

![](photo/spring概述/spring-overview.png).

#### 程序的耦合

- 耦合：程序间的依赖关系
  - 类之间的依赖
  - 方法间的依赖
- 解耦
  - 降低程序间的依赖关系
- 实际开发中：
  - 编译期不依赖，运行时依赖
- 解耦的思路
  - 使用反射创建对象，避免使用new关键字
  - 读取配置文件来获取创建对象的全限定类名

#### Bean

- 在计算机英语中，有可重用组件的含义
- JavaBean：用java语言编写的可重用组件
  - JavaBean > 实体类
- 流程
  - 需要一个配置文件来配置service和dao配置的内容，唯一标识是全限定类名
  - 通过读取配置文件中配置的内容，使用反射创建对象
  - 配置文件可以为xml和properties

#### 控制反转

- 控制反转（Inversion of Control，缩写为**IoC**），是[面向对象编程](https://baike.baidu.com/item/面向对象编程)中的一种设计原则，可以用来减低计算机代码之间的[耦合度](https://baike.baidu.com/item/耦合度)。其中最常见的方式叫做依赖注入（Dependency Injection，简称DI），还有一种方式叫“依赖查找”（Dependency Lookup）。通过控制反转，对象在被创建的时候，由一个调控系统内所有对象的外界实体将其所依赖的对象的引用传递给它。也可以说，依赖被注入到对象中。
- 作用：消减计算机程序的耦合（解除代码中的依赖关系）