## Spring IOC

#### ApplicationContext

- ClassPathXmlApplicationContext：可以访问在类路径下的配置文件
- FileSystemXmlApplicationContext：可以访问在磁盘任意路径下的配置文件
- AnnotationConfigApplicationContext：用于读取注解创建容器

#### 核心容器接口

- ApplicationContext：在构建核心容器时，创建对象采取的策略是采用立即架在的方式（单例对象适用）
- BeanFactory：在构建核心容器时，创建对象的策略是采用延迟架在的方式（多例对象适用）

#### spring对bean的管理细节

一、创建bean的三种方式

- 使用默认构造函数创建

  - 在spring的配置文件中使用bean标签，配以id和class属性之后，且没有其他属性和标签时。采用的方式就是默认构造函数创建bean对象，此时如果类中没有默认构造函数，则对象无法创建。

  - ```xml
    <bean id="myService" class="com.lxc.service.impl.MyServiceImpl"></bean>
    ```

- 使用普通工厂中的方法创建对象

  - 使用某个类的方法创建对象，并存入spring容器

  - ```xml
    <bean id="inFactory" class="com.lxc.factory.InstanceFactory"></bean>
        <bean id="myService1" factory-bean="inFactory" factory-method="getMyService"></bean>
    ```

- 使用工厂中的静态方法创建对象

  - 使用某个类中的静态方法创建对象，并存入spring容器

  - ```xml
    <bean id="myService2" class="com.lxc.factory.StaticFactory" factory-method="getMyService"></bean>
    ```

二、bean的作用范围

- bean标签的scope属性
  - 作用：用于指定bean的作用范围
  - 取值
    - singleton：单例，默认值
    - prototype：多例
    - request：作用于web应用的请求范围
    - session：作用于web应用的会话范围
    - global-session：作用于集群环境的会话范围（全局会话范围），当不是集群环境时，则为session

三、bean的生命周期

- 单例对象

  - 创建：当容器创建时对象创建
  - 生存：容器存在，对象就一致存在
  - 死亡：容器销毁，对象死亡

- 多例对象

  - 创建：当使用对象时创建
  - 生存：在使用过程中
  - 死亡：当对象长时间不用，且没有别的对象引用时，由java的垃圾回收机制自动回收

- bean生命周期方法

  - init-method属性：创建bean时执行

  - destroy-method属性：销毁bean前执行

  - ```xml
    <bean id="myService" class="com.lxc.service.impl.MyServiceImpl"
              init-method="init" destroy-method="destroy"></bean>
    ```

#### Spring中的依赖注入

- 依赖注入：Dependency Injection

- 将依赖关系交给spring来维护

- 可以注入的数据：

  - 基本类型和string
  - 其他bean类型
  - 复杂类型和集合类型

- 注入的方式

  - 使用构造函数提供
    - 使用标签：constructor-arg
    - 标签出现的位置：bean标签的内部
    - 属性
      - type：用户指定要注入的数据的数据类型
      - index：用于指定要注入的数据给构造函数中指定索引位置的参数赋值，参数从0开始
      - name：用于指定给构造函数中指定名称的参数赋值
      - value：用于提供基本类型和string类型的数据
      - ref：用于指定其他的bean类型数据，指的就是在spring的ioc核心容器中出现过的bean对象
    - 优势：
      - 在获取bean对象时，注入的数据是必须的操作，否则对象无法创建成功
    - 劣势
      - 改变了bean对象的实例化方式，即便在创建对象是用不到这些数据，也必须提供
  - 使用set方法提供
    - 使用标签：property
    - 属性
      - name：用于指定注入时所调用的set方法名称
      - value：用于提供基本类型和string类型的数据
      - ref：用于指定其他的bean类型数据，指的就是在spring的ioc核心容器中出现过的bean对象
    - 优势
      - 创建对象时没有明确的限制，可以直接使用默认构造函数
    - 弊端
      - 如果有某个成员必须有值，则获取对象时可能set方法没有执行

  - 使用注解提供  

- 复杂类型的注入

  - 用于给list结构集合注入的标签
    - list、array、set
  - 用于给map结构集合注入的标签
    - map、props
  - 结构相同，标签可以互换

#### 配置pom.xml

```xml
 <dependencies>
        <dependency>
          <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>5.2.3.RELEASE</version>
        </dependency>
</dependencies>
```

#### 配置bean.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="myService" class="com.lxc.service.impl.MyServiceImpl"></bean>

</beans>
```

#### 执行代码

```java
ApplicationContext context = new ClassPathXmlApplicationContext("bean.xml");
        MyService myService = (MyService) context.getBean("myService");
        myService.findAll();
```
