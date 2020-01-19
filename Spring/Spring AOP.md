## Spring AOP

#### AOP概述

- 什么是aop
  - AOP：全称为Aspect Oriented Programming（面向切面编程）
  - 简单来说就是将程序中重复的代码抽取出来，在需要执行的时候，使用动态代理的技术，在不修改源码的基础上，对我们已有的方法进行增强

- aop的作用及优势
  - 作用：在程序运行期间，不修改源码对已有方法进行增强
  - 优势
    - 减少重复代码
    - 提高开发效率
    - 维护方便
- aop的实现方式
  - 使用动态代理技术

#### AOP相关术语

- Joinpoint（连接点）：
  - 连接点是指那些别拦截到的点，在spring中，这些点指定是方法，因为spring只支持方法类型的连接点
- Pointout（切入点）：
  - 切入点是指我们要对那些Joinpoint进行拦截的定义
- Advice（通知/增强）：
  - 通知是指拦截到Joninpoint之后要做的事情就是通知
  - 类型：前置通知，后置通知，异常通知，最终通知，环绕通知
- Introduction（引介）：
  - 引介是以一种特殊的通知在不修改类代码的前提下，Introduction可以在运行期为类动态的添加一些方法或Field
- Target（目标对象）：
  - 代理的目标对象
- Weaving（织入）：
  - 是指把增强应用到目标对象来创建新的代理对象的过程
- Proxy（代理）：
  - 一个类被AOP织入增强后，就会产生一个结果代理类
- Aspect（切面）：
  - 是切入点和通知（引介）的结合

#### Spring中基于XML的AOP配置步骤

- 把通知Bean也交给Spring来管理
- 使用aop:config标签表名开始AOP配置
- 使用aop:aspect标签开始配置切面
  - id：给切面提供唯一标志
  - ref：指定通知类的id
- 在sop:aspect标签的内部使用对应的标签来配置通知的类型
  - aop:before：前置通知
    - method：用于指定方法
    - pointcut：用于指定切入点表达式，指定对那些方法增强
  - aop:after-returning：后置通知
  - aop:after-throwing：异常通知
  - aop:after：最终通知
  - aop:around：环绕通知
- aop:poincut：切入点表达式，可以在通知中使用poincut-ref使用
  - 在aop:aspect标签内部只能当前切面使用
  - 在aop:aspect外时，则为所有切面可用，必须在aop:aspect之前
- spring框架提供了一个接口，ProceedingJoinPoint。该接口有一个方法proceed()，此方法就相当一明确调用切入点方法

#### 切入点表达式

- 关键字：execution(表达式)
- 表达式
  - 访问修饰符 返回值 包名.类名.方法名(参数列表)
  - 访问修饰符可以省略
  - 返回值可以使用通配符，标识任意返回值
  - 包名可以使用通配符标识任意包，有几级就需要写几个\*\.，可以使用\.\.表示当前包及其子包
  - 类名和方法名可以使用\*实现通配
  - 参数列表
    - 直接写数据类型
    - 可以使用通配符表示任意类型，但是必须有参数
    - 可以使用\.\.表示有无参数均可
  - 全通配
      - \* \*\.\.\*\.\*(\.\.)
- 实际开发中切入点表达式通常切到业务层实现类下的所有方法
- 示例
  - public void com.lxc.service.impl.UserServiceImpl.findUser()

#### bean.xml

```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop
        https://www.springframework.org/schema/aop/spring-aop.xsd">

    <!--    配置userservice-->
    <bean name="userService" class="com.lxc.service.impl.UserServiceImpl"></bean>

    <!--    配置logger类-->
    <bean name="logger" class="com.lxc.util.Logger"></bean>

    <!--    配置aop-->
    <aop:config>
        <!--        配置切面-->
        <aop:aspect id="logAspect" ref="logger">
            <!--            配置通知的类型以及切入点-->
            <aop:before method="initLogger"
                        pointcut="
                        execution(public void com.lxc.service.impl.UserServiceImpl.findUser())"
            ></aop:before>
        </aop:aspect>
    </aop:config>

</beans>
```

#### 环绕通知示例代码

```java
public Object aroundLogger(ProceedingJoinPoint pjp){
        Object o = null;
        try{
            System.out.println("前置通知");
            Object[] args = pjp.getArgs();
            o = pjp.proceed(args);
            System.out.println("后置通知");
        }catch (Throwable throwable) {
            throwable.printStackTrace();
            System.out.println("异常通知");
        } finally {
            System.out.println("最终通知");
        }
        return o;
}
```

