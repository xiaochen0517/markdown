# Java方式配置Spring

`Spring` 的配置可以完全使用 `Java` 的方式进行配置。

在 `Spring 4` 之后，成为了核心功能

### 1、使用注解

新建类，使用 `@Configuration` 注解

```java
@Configuration
public class SpringConfig {
}
```

### 2、创建 `bean`

```java
@Bean
public Users users(){
    return new Users();
}
```

> 方法名相当于 `bean` 的 `id`

### 3、注解扫描

```java
@ComponentScan("com.lxc.pojo")
```

### 4、测试

```java
@Test
public void test1(){
    ApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);
    Users users = context.getBean("users", Users.class);
    System.out.println(users);
}
```

