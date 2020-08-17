# Spring Boot 集成 Swagger

## 1、概述

Swagger 是一个规范和完整的框架，用于生成、描述、调用和可视化 RESTful 风格的 Web 服务。

总体目标是使客户端和文件系统作为服务器以同样的速度来更新。文件的方法、参数和模型紧密集成到服务器端的代码，允许 API 来始终保持同步。Swagger 让部署管理和使用功能强大的 API 从未如此简单。

作用：

- 接口的文档在线自动生成

- 功能测试

## 2、使用

### 2.1、导包

```xml
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-boot-starter</artifactId>
    <version>3.0.0</version>
</dependency>
```

### 2.2、配置文件

```java
@Configuration
@EnableOpenApi
public class SwaggerConfig {
}
```

### 2.3、配置 `Swagger` 页面信息

```java
@Bean
public Docket getDocket(){
    return new Docket(DocumentationType.SWAGGER_2)
        .apiInfo(apiInfo());
}

private ApiInfo apiInfo() {
    // 作者信息
    Contact contact = new Contact(
        "陌尘",
        "http://baidu.com/",
        "2827075398@qq.com");
    // 页面信息
    return new ApiInfo(
        "陌尘的 Swagger Api",
        "Api Documentation",
        "1.0",
        "urn:tos",
        contact,
        "Spring Boot",
        "http://www.androidzy.cn/",
        new ArrayList());
}
```

### 2.4、相关配置

#### 2.4.1、扫描配置

```java
new Docket(DocumentationType.SWAGGER_2)
    .select()
    // basePackage("xxx") 扫描指定包下的接口
    // any() 扫描所有接口
    // none() 不扫描
    // withClassAnnotation() 扫描使用类注解的接口
    // withMethodAnnotation() 扫描使用方法注解的接口
    .apis(RequestHandlerSelectors.basePackage("com.lxc.controller"))
    // 扫描那些路径的接口，可用通配符
    .paths(PathSelectors.ant("/lxc/*"))
    .build();
```

#### 2.4.2、开关 `Swagger` 

```java
new Docket(DocumentationType.SWAGGER_2)
    // true 默认，打开；false 关闭
    .enable(false);
```

配置文件

```properties
springfox.documentation.swagger.v2.enabled=false
springfox.documentation.swagger-ui.enabled=false
```

