# Spring 整合 MyBatis

## 1、数据源配置

### 1.1、导入 `properties` 文件

```xml
<context:property-placeholder location="classpath:jdbc.properties"/>
```

### 1.2、配置数据源

```xml
<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
    <property name="driverClassName" value="${jdbc.driver}"/>
    <property name="url" value="${jdbc.url}"/>
    <property name="username" value="${jdbc.username}"/>
    <property name="password" value="${jdbc.password}"/>
</bean>
```

## 2、SqlSessionFactory

```xml
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <property name="dataSource" ref="dataSource" />
    <property name="configLocation" value="classpath:mybatis.xml"/>
    <property name="mapperLocations" value="classpath:com/lxc/dao/*.xml"/>
</bean>
```

## 3、SqlSessionTemplate

```xml
<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
    <constructor-arg index="0" ref="sqlSessionFactory"/>
</bean>
```

## 4、接口实现类

```java
public class UserServiceImpl implements UserService {

    @Autowired
    @Setter
    private SqlSessionTemplate sqlSession;

    public List<User> findAllUsers() {
        UserDao mapper = sqlSession.getMapper(UserDao.class);
        return mapper.findAllUsers();
    }
}
```

## 5、实现类注入Spring

```xml
<bean id="userService" class="com.lxc.service.UserServiceImpl">
    <property name="sqlSession" ref="sqlSession"/>
</bean>
```

## 6、`mybatis` 配置文件

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>

    <typeAliases>
        <package name="com.lxc.pojo"/>
    </typeAliases>
    
</configuration>
```

## 7、测试

```java
ApplicationContext context = new ClassPathXmlApplicationContext("bean.xml");
UserService userService = context.getBean("userService", UserService.class);
List<User> allUsers = userService.findAllUsers();
for (User u : allUsers){
    System.out.println(u);
}
```



