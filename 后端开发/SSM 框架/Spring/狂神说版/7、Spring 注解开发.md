# Spring 注解开发

### 1、环境配置

#### 1.1、导入约束

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">
</beans>
```

#### 1.2、配置注解支持

```xml
<context:component-scan base-package="com.lxc"/>
<context:annotation-config/>
```

### 2、注解解析

- 示例

```java
@Component
public class Users {
    @Value("张三")
    private String name;
}
```

> 简单属性可以使用 `@Value` 注入

### 3、衍生注解

- 三层 `mvc` 框架
  - `dao` 层：`@Repository`
  - `service` 层：`@Service`
  - `controller` 层：`@Controller`

- `@Scope` 此注解可设置单例模式或原型模式