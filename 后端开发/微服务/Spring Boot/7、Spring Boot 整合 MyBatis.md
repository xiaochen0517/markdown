# Spring Boot 整合 MyBatis

## 1、导入包

```xml
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>2.1.3</version>
</dependency>
```

## 2、配置文件

```properties
spring.datasource.username=xxx
spring.datasource.password=xxx
spring.datasource.url=jdbc:mysql://localhost:3306/xxx
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

## 3、 `MyBatis` 配置

```properties
# 数据类所在的包
mybatis.type-aliases-package=com.lxc.pojo
# 映射xml文件所在位置
mybatis.mapper-locations=classpath:mybatis/mapper/*.xml
```

## 4、目录结构

![image-20200810142107529](photo\14、整合MyBatis目录结构（7）.png).

## 5、 `Mapper` 类注解

```java
@Mapper
@Repository
```

## 6、测试

![image-20200810142356493](photo\15、测试结果（7）.png)