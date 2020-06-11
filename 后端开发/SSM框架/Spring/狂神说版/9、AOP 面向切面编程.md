# AOP 面向切面编程

## 1、 什么是 `AOP`

`AOP`为`Aspect Oriented Programming`的缩写，意为：面向切面编程，通过预编译方式和运行期间动态代理实现程序功能的统一维护的一种技术。`AOP`是`OOP`的延续，是软件开发中的一个热点，也是`Spring`框架中的一个重要内容，是函数式编程的一种衍生范型。利用`AOP`可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的耦合度降低，提高程序的可重用性，同时提高了开发的效率。

![](photo\4、AOP 面向切面编程（1）.jpg)

- 横切关注点:跨越应用程序多个模块的方法或功能。即是，与我们业务逻辑无关的，但是我们需要关注的部
  分，就是横切关注点。如日志，安全，缓存，事务等等....

- 切面(`ASPECT`) :横切关注点被模块化的特殊对象。即一个类。
- 通知(`Advice`) :切面必须要完成的工作。即，它是类中的一个方法。
- 目标(`Target`) :被通知对象。
- 代理(`Proxy`) :向目标对象应用通知之后创建的对象。
- 切入点(`PointCut`) :切面通知执行的“地点"的定义。
- 连接点`UointPoint`) :与切入点匹配的执行点。

## 2、使用 `spring` 实现 `AOP`

创建测试类

- `UserService.java`

```java
public interface UserService {
    void add();

    void sub();
}
```

- `UserServiceImpl.java`

```java
public class UserServiceImpl implements UserService {
    public void add() {
        System.out.println("add run");
    }

    public void sub() {
        System.out.println("sub run");
    }
}
```

- `bean.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop
        https://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="us" class="com.lxc.service.UserServiceImpl"/>
    <bean id="ba" class="com.lxc.log.LogBeforeAdvice"/>
    <bean id="aa" class="com.lxc.log.LogAfterAdvice"/>

</beans>
```

### 2.1、使用 `API` 接口实现

前置通知

```java
public class LogBeforeAdvice implements MethodBeforeAdvice {
    public void before(Method method, Object[] objects, Object o) throws Throwable {
        System.out.println("run method name->"+method.getName());
    }
}
```

后置通知

```java
public class LogAfterAdvice implements AfterReturningAdvice {
    public void afterReturning(Object o, Method method, Object[] objects, Object o1) throws Throwable {
        System.out.println("run method name->" + method.getName());
    }
}
```

`xml` 文件配置

```xml
<aop:config>
    <aop:pointcut id="pointcut1" expression="execution(* com.lxc.service.UserServiceImpl.*(..))"/>
    <aop:advisor advice-ref="aa" pointcut-ref="pointcut1"/>
    <aop:advisor advice-ref="ba" pointcut-ref="pointcut1"/>
</aop:config>
```

测试类

```java
@Test
public void test1(){
    ApplicationContext context = new ClassPathXmlApplicationContext("bean.xml");
    UserService userService = (UserService) context.getBean("us");
    userService.add();
}
```

### 2.2、使用自定义类实现

自定义通知类

```java
public class LogMyAdvice {

    public void before(){
        System.out.println("===前置通知===");
    }

    public void after(){
        System.out.println("===后置通知===");
    }

}
```

`xml` 配置文件

```xml
<bean id="ma" class="com.lxc.log.LogMyAdvice"/>

<aop:config>
    <aop:aspect ref="ma">
        <aop:pointcut id="pointcut1" expression="execution(* com.lxc.service.UserServiceImpl.*(..))"/>

        <aop:after method="after" pointcut-ref="pointcut1"/>
        <aop:before method="before" pointcut-ref="pointcut1"/>
    </aop:aspect>
</aop:config>
```

### 2.3、注解实现 `AOP`

通知类

```java
@Aspect
public class LogAnnoAdvice {

    @Before("execution(* com.lxc.service.UserServiceImpl.*(..))")
    public void before(){
        System.out.println("===前置通知===");
    }

    @After("execution(* com.lxc.service.UserServiceImpl.*(..))")
    public void after(){
        System.out.println("===后置通知===");
    }
}
```

xml 配置

```xml
<bean id="laa" class="com.lxc.log.LogAnnoAdvice"/>
<aop:aspectj-autoproxy/>
```

> `proxy-target-class="false"` 参数为 `false` 使用 `jdk` 实现 `aop` ，为 `true` 时使用 `cglib` 实现，默认值为 `false`