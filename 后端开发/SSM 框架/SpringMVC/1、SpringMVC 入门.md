# SpringMVC 入门

## 1、Spring MVC 概述

### 1.1、什么是 Spring MVC

`Spring MVC` 属于 `SpringFrameWork` 的后续产品，已经融合在`Spring Web Flow`里面。`Spring` 框架提供了构建 `Web` 应用程序的全功能 `MVC` 模块。使用 `Spring` 可插入的 `MVC` 架构，从而在使用 `Spring` 进行 `WEB` 开发时，可以选择使用 `Spring` 的 `Spring MVC` 框架或集成其他 `MVC` 开发框架，如 `Struts1` (现在一般不用)， `Struts 2` (一般老项目使用)等等。

### 1.2、Spring MVC 的特点

- 轻量级，简单易学
- 高效，基于请求响应的 MVC 框架
- 与 Spring 兼容性好，无缝结合
- 约定优于配置
- 功能强大
- 简洁灵活

## 2、中心控制器

 `spring` 的 `web` 框架围绕 `DispatcherServlet` 设计。

`DispatcherServlet` 作用是将请求分发到不同的处理器。

`DispatcherServlet` 是一个实际的 `Servlet` ，继承自 `HttpServlet` 基类

![](photo\1、DispatcherServlet结构图（1）.jpg)

当发起请求时被前置的控制器拦截到请求，根据请求参数生成代理请求，找到对应的实际控制器，控制器处理请求，创建数据模型，访问数据库，将模型返回到中心控制器，控制器使用模型与视图渲染视图结果，将结果返回中心控制器，再将结果返回给请求者

![](https://docs.spring.io/spring/docs/4.3.24.RELEASE/spring-framework-reference/html/images/mvc.png)

## 3、MVC 快速配置

### 3.1、导入依赖

```xml
<properties>
    <spring.version>5.2.7.RELEASE</spring.version>
</properties>

<dependencies>
    <!-- https://mvnrepository.com/artifact/junit/junit -->
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13</version>
        <scope>test</scope>
    </dependency>
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/javax.servlet/servlet-api -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>servlet-api</artifactId>
        <version>2.5</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/javax.servlet.jsp/jsp-api -->
    <dependency>
        <groupId>javax.servlet.jsp</groupId>
        <artifactId>jsp-api</artifactId>
        <version>2.2</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/javax.servlet.jsp.jstl/jstl -->
    <dependency>
        <groupId>javax.servlet.jsp.jstl</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>
</dependencies>
```

### 3.2、配置文件

spring.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <!--bean名称映射器-->
    <bean class="org.springframework.web.servlet.handler.BeanNameUrlHandlerMapping"/>
    <!--controller处理适配器-->
    <bean class="org.springframework.web.servlet.mvc.SimpleControllerHandlerAdapter"/>

    <!--路径前后缀-->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" id="InternalResourceViewResolver">
        <!--前缀-->
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <!--后缀-->
        <property name="suffix" value=".jsp"/>
    </bean>

    <!--将controller交给spring管理，id为访问路径-->
    <bean id="/hello" class="com.lxc.controller.HelloController"/>

</beans>
```

### 3.3、配置 `controller`

HelloController.java

```java
public class HelloController implements Controller {
    public ModelAndView handleRequest(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        // 创建视图模型
        ModelAndView mav = new ModelAndView();
        // 添加数据
        mav.addObject("msg", "hello world");
        // 设置转发路径，结合配置中的前后缀
        mav.setViewName("hello");
        // 返回到浏览器
        return mav;
    }
}
```

### 3.4、 `jsp` 页面

hello.jsp

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello</title>
</head>
<body>
${msg}
</body>
</html>
```

### 3.5、 `web.xml` 配置

```xml
<servlet>
    <servlet-name>dispatcherServlet</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
    <servlet-name>dispatcherServlet</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

### 3.6、 `404` 问题

`File->Project Structure->Artifacts->(选中指定模块或项目)`

> 在 `WEB-INF` 中新建目录 `lib` 将 `Artifacts` 中的 `jar` 包添加到 `lib` 目录中
