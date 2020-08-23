# IOC 控制反转

**控制反转**（`Inversion of Control`，缩写为**IoC**），是面向对象编程中的一种设计原则，可以用来减低计算机代码之间的耦合度。其中最常见的方式叫做**依赖注入**（`Dependency Injection`，简称**DI**），还有一种方式叫“依赖查找”（`Dependency Lookup`）。通过控制反转，对象在被创建的时候，由一个调控系统内所有对象的外界实体将其所依赖的对象的引用传递给它。也可以说，依赖被注入到对象中。

## 1、简单示例

### 1.1、原先的操作

- `dao`层接口类

```java
public interface UserDao {
    void findUser();
}
```

- `dao`层接口实现类

```java
public class UserDaoDefImpl implements UserDao{
    public void findUser() {
        System.out.println("UserDaoDefImpl -- run");
    }
}
```

- `service`层接口类

```java
public interface UserDaoService {
    void findUserDaoService();
}
```

- `service`层接口实现类

```java
public class UserDaoServiceImpl implements UserDaoService{

    private UserDao userDao = new UserDaoDefImpl();

    public void findUserDaoService() {
        userDao.findUser();
    }
}
```

> 此处我们在实现`dao`层接口实现类的方法时，需要在代码中`new`出指定的实现类，才可以实现指定的方法。
>
> 这时，我们需要修改实现类时，则需要将`UserDaoDefImpl`修改为其他实现类。

![image-20200526161455092](photo\2、IOC控制反转（1）.gif).

### 1.2、使用方法注入

- 修改service层接口类

```java
public interface UserDaoService {

    void setUserDao(UserDao userDao);

    void findUserDaoService();
}
```

- 修改service层接口实现类

```java
public class UserDaoServiceImpl implements UserDaoService {

    private UserDao userDao = null;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public void findUserDaoService() {
        userDao.findUser();
    }
}
```

- 测试类

```java
public class UserDaoTest {
    public static void main(String[] args) {
        UserDaoService uds = new UserDaoServiceImpl();
        uds.setUserDao(new UserDaoMySQLImpl());
        uds.findUserDaoService();
    }
}
```

> - 在原来的情况下，程序是主动创建对象，控制权在程序员手中
> - 使用set方法注入之后，程序不再具有主动性，而是变成了被动接受对象

![image-20200526161651627](photo\3、IOC控制反转（2）.gif).

## 2、使用 `Spring `实现 `IOC`

### 2.1、简单测试

- 导入 `jar` 包

```xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
```

- 编写类

```java
public class Hello {

    private String str;

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    @Override
    public String toString() {
        return "Hello{" +
                "str='" + str + '\'' +
                '}';
    }
}
```

- `spring `配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <!--将Hello交给spring容器管理
		此bean等价于Hello hello = new Hello();
		id相当于变量名，class为new的对象
	-->
    <bean id="hello" class="com.lxc.Hello">
        <!--为属性设置值，本质是使用seter方法进行赋值的-->
        <property name="str" value="Hello World!!"/>
    </bean>

</beans>
```

- 测试类

```java
public class Test1 {
    public static void main(String[] args) {
        ClassPathXmlApplicationContext con = new ClassPathXmlApplicationContext("beans.xml");
        Hello hello = (Hello) con.getBean("hello");
        System.out.println(hello);
    }
}
```

- 结果

```
Hello{str='Hello World!!'}
```

### 2.2、实现 `IOC`

- `spring` 配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="defImpl" class="com.lxc.dao.UserDaoDefImpl"/>
    <bean id="mySQLImpl" class="com.lxc.dao.UserDaoMySQLImpl"/>
    <bean id="oracleImpl" class="com.lxc.dao.UserDaoOracleImpl"/>

    <bean id="serviceImpl" class="com.lxc.service.UserDaoServiceImpl">
        <!--ref可以引用一个已经配置到的bean将此bean赋值到指定的属性中-->
        <property name="userDao" ref="defImpl"/>
    </bean>

</beans>
```

- 测试类

```java
public class UserDaoTest {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        UserDaoService userDaoService = (UserDaoService) context.getBean("serviceImpl");
        userDaoService.findUserDaoService();
    }
}
```

