# SSM 整合

## 1、基础环境

新建空白 `maven` 工程，右键点击 项目-> `Add Frameworks Support` -> `Java EE` -> 选中 `Web Application` (版本需大于等于4.0) -> `OK` 

### 1.1、目录结构

![image-20200708154508506](photo\1、ssm整合目录结构（1）.png).

### 1.2、 `mybatis-config.xml` 框架

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
</configuration>
```

### 1.3、 `applicationContext.xml` 框架

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc.xsd">
</beans>
```

### 1.4、 `jdbc.properties` 框架

```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=
jdbc.username=
jdbc.password=
```

## 2、 `MyBatis` 配置

### 2.1、数据库 `URL` 

```url
jdbc:mysql://localhost:3306/school?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=Asia/Shanghai
```

> 若 `MySQL` 版本大于等于8.0，则需要在连接后加入时区参数。

### 2.2、配置别名

在文件 `mybatis-config.xml` 中的 `configuration` 标签下添加。

```xml
<typeAliases>
    <package name="com.lxc.pojo"/>
</typeAliases>
```

### 2.3、 `Mapper` 配置

在类 `UserMapper.java` 同级目录中新建文件 `UserMapper.xml` 。

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.lxc.dao.UserMapper">
    <select id="findAllUser" resultType="user">
        select * from user
    </select>

    <select id="findUser" resultType="user">
        select * from user where `id` = #{id}
    </select>
</mapper>
```

## 3、 `Spring` 配置

每一层分别使用一个配置文件进行配置

### 3.1、`spring-dao.xml ` 

负责 `Dao` 层

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd">

    <!--    导入jdbc配置文件-->
    <context:property-placeholder location="classpath:jdbc.properties"/>

    <!--    连接池-->
    <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
        <property name="driverClass" value="${jdbc.driver}"/>
        <property name="jdbcUrl" value="${jdbc.url}"/>
        <property name="user" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>

        <!--最大连接池数量-->
        <property name="maxPoolSize" value="30"/>
        <!--最小连接池数量-->
        <property name="minPoolSize" value="10"/>
        <!--关闭连接后不自动提交-->
        <property name="autoCommitOnClose" value="false"/>
        <!--获取连接超时时间-->
        <property name="checkoutTimeout" value="10000"/>
        <!--获取连接失败重试次数-->
        <property name="acquireRetryAttempts" value="2"/>
    </bean>

    <!--    创建SqlSessionFactory-->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="dataSource" ref="dataSource"/>
        <property name="configLocation" value="classpath:mybatis-config.xml"/>
    </bean>

    <!--    扫描dao层下的类和mapper-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"/>
        <property name="basePackage" value="com.lxc.dao"/>
    </bean>

</beans>
```

### 3.2、`spring-service.xml` 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd">

    <!--    扫描service层-->
    <context:component-scan base-package="com.lxc.service"/>

    <!--    创建事务管理器-->
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource"/>
    </bean>

</beans>
```

### 3.3、`spring-mvc.xml` 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <!--需要扫描的包-->
    <context:component-scan base-package="com.lxc.controller"/>

    <!--不处理静态资源-->
    <mvc:default-servlet-handler/>

    <!--注解支持-->
    <mvc:annotation-driven>
        <!--解决乱码问题-->
        <mvc:message-converters register-defaults="true">
            <bean class="org.springframework.http.converter.StringHttpMessageConverter">
                <constructor-arg value="UTF-8"/>
            </bean>
            <bean class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter">
                <property name="objectMapper">
                    <bean class="org.springframework.http.converter.json.Jackson2ObjectMapperFactoryBean">
                        <property name="failOnEmptyBeans" value="false"/>
                    </bean>
                </property>
            </bean>
        </mvc:message-converters>
    </mvc:annotation-driven>

    <!--    视图解析器-->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" id="internalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

</beans>
```

### 3.4、导入到主配置文件

```xml
<import resource="classpath:spring-dao.xml"/>
<import resource="classpath:spring-service.xml"/>
<import resource="classpath:spring-mvc.xml"/>
```

### 3.5、 `web.xml` 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">

    <servlet>
        <servlet-name>dispatcherServlet</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:applicationContext.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
        <servlet-name>dispatcherServlet</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <!--    乱码过滤-->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <!--    session配置-->
    <session-config>
        <session-timeout>15</session-timeout>
    </session-config>

</web-app>
```

## 4、代码测试

### 4.1、 `pojo` 

`User.java` 

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class User {
    private int id;
    private String username;
    private String password;
}
```

### 4.2、`Dao` 层

`UserMapper.java` 

```java
package com.lxc.dao;

public interface UserMapper {

    List<User> findAllUser();

    User findUser(int id);

}
```

`UserMapper.xml` 

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.lxc.dao.UserMapper">
    <select id="findAllUser" resultType="user">
        select * from user
    </select>

    <select id="findUser" resultType="user">
        select * from user where `id` = #{id}
    </select>
</mapper>
```

### 4.3、 `Service` 层

`UserService.java` 

```java
public interface UserService {

    List<User> findAllUser();

    User findUser(int id);

}
```

`UserServiceImpl.java` 

```java
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    public List<User> findAllUser() {
        return userMapper.findAllUser();
    }

    public User findUser(int id) {
        return userMapper.findUser(id);
    }
}
```

### 4.4、 `Controller` 层

```java
@RestController
@RequestMapping("/hello")
public class HelloController {

    @Autowired
    private UserService userService;

    @RequestMapping("/findall")
    public String hello1() throws JsonProcessingException {
        List<User> allUser = userService.findAllUser();
        return new ObjectMapper().writeValueAsString(allUser);
    }

    @RequestMapping("/find/{id}")
    public String hello2(@PathVariable("id") int id) throws JsonProcessingException {
        User user = userService.findUser(id);
        return new ObjectMapper().writeValueAsString(user);
    }

}
```

- 结果目录

![image-20200708171820059](photo\2、ssm整合完整目录结构（2）.png).