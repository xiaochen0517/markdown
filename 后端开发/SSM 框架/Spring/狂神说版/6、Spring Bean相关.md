# Spring Bean相关

## 1、Bean 作用域

| Scope                                                        | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [singleton](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/core.html#beans-factory-scopes-singleton) | (Default) Scopes a single bean definition to a single object instance for each Spring IoC container. |
| [prototype](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/core.html#beans-factory-scopes-prototype) | Scopes a single bean definition to any number of object instances. |
| [request](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/core.html#beans-factory-scopes-request) | Scopes a single bean definition to the lifecycle of a single HTTP request. That is, each HTTP request has its own instance of a bean created off the back of a single bean definition. Only valid in the context of a web-aware Spring `ApplicationContext`. |
| [session](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/core.html#beans-factory-scopes-session) | Scopes a single bean definition to the lifecycle of an HTTP `Session`. Only valid in the context of a web-aware Spring `ApplicationContext`. |
| [application](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/core.html#beans-factory-scopes-application) | Scopes a single bean definition to the lifecycle of a `ServletContext`. Only valid in the context of a web-aware Spring `ApplicationContext`. |
| [websocket](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/web.html#websocket-stomp-websocket-scope) | Scopes a single bean definition to the lifecycle of a `WebSocket`. Only valid in the context of a web-aware Spring `ApplicationContext`. |

### 1.1、单例模式（默认）

![](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/images/singleton.png)

```xml
<bean id="usersc" class="com.lxc.popj.Users" c:name="李四" c:age="25" scope="singleton"/>
```

### 1.2、原型模式

![](https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/images/prototype.png)

```xml
<bean id="usersc" class="com.lxc.popj.Users" c:name="李四" c:age="25" scope="singleton"/>
```

## 2、Bean 自动装配

### 2.1、`xml` 配置

- 示例

```xml
<bean id="dog" class="com.lxc.popj.Dog"/>
<bean id="cat" class="com.lxc.popj.Cat"/>

<bean id="man" class="com.lxc.popj.Man" autowire="byName">
    <property name="name" value="张三"/>
</bean>
```

- `autowire` 值
  - `byName` ：`spring` 会在容器中寻找和 `set` 法后名称相同的beanid进行注入
  - `byType` ：`spring` 会在容器中寻找 `set` 方法类型相同的值进行注入

### 2.2、注解实现

#### 2.2.1、简单实现

- 导入约束

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

- 配置 `bean` 注解支持

```xml
<context:annotation-config/>

<bean id="dog" class="com.lxc.popj.Dog"/>
<bean id="cat" class="com.lxc.popj.Cat"/>

<bean id="man" class="com.lxc.popj.Man"/>
```

- 在类中使用注解

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Man {
    @Autowired
    private Cat cat;
    @Autowired
    private Dog dog;
    private String name;
}
```

> 注解 `@Autowired` 也可以添加在 `set` 方法上，在属性上使用注解后 `set` 方法就可以省略

#### 2.2.2、注解详解

- `Autowired` 注解

```java
public @interface Autowired {
    boolean required() default true;
}
```

> 若显式地将此值改为 `false` 时，则表示此属性可以为 `null`
>
> 此注解使用的方式为 `byType`

- `Qualifier` 注解
  - 此注解和 `Autowired` 搭配使用，可以指定一个值实现 `byName`

```java
@Autowired
@Qualifier("dog1")
private Dog dog;
```

- `Resource` 注解
  - 此注解会使用 `byName` 和 `byType` 两种方式来装配 `Bean` ，若两种方式都失败则会报错
  - `name` 指定注入的 `bean` 名称
  - `type` 指定注入的 `bean` 类型

```java
@Resource(type = Cat.class)
private Cat cat;

@Resource(name = "dog11")
private Dog dog;
```

