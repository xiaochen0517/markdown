# Mybatis配置解析

## 1、环境配置（environments）

Mybatis可以配置多种环境，但每个SqlsessionFactory实例只能选择一种环境

### 1.1、事务管理器（transactionManager）

Mybatis中有两种事务管理器

- JDBC：使用JDBC的提交和回滚设施，默认配置
- MANAGED：无任何作用

### 1.2、数据源（dataSource）

Mybatis有三种数据源配置

- UNPOOLED：每次请求都打开连接和关闭。
- POOLED：使用池进行连接数据库
- JNDI：这个数据源实现是为了能在如 EJB 或应用服务器这类容器中使用，容器可以集中或在外部配置数据源

## 2、属性（properties）

这些属性可以在外部进行配置，并可以进行动态替换。你既可以在典型的 Java 属性文件中配置这些属性，也可以在 properties 元素的子元素中设置。

- 配置文件

```properties
driver=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/school?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=Asia/Shanghai
username=root
password=xxxxxx
```

- Mybatis配置文件引入

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>

    <!--引入properties文件-->
    <properties resource="db.properties"/>

    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <!--驱动类-->
                <property name="driver" value="${driver}"/>
                <!--连接地址-->
                <property name="url" value="${url}"/>
                <!--用户名-->
                <property name="username" value="${username}"/>
                <!--密码-->
                <property name="password" value="${password}"/>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <mapper resource="com/lxc/dao/UsersMapper.xml"/>
    </mappers>
</configuration>
```

> 在Mybatis配置文件中使用${key}​的格式引入properties文件中的数据
>
> 在外部文件中的配置优先级高于在xml中properties标签下的配置

## 3、类型别名

类型别名可为 Java 类型设置一个缩写名字。 它仅用于 XML 配置，意在降低冗余的全限定类名书写。

- Mybatis-config.xml

```xml
<typeAliases>
    <typeAlias type="com.lxc.pojo.Users" alias="Users"/>
</typeAliases>
```

- UsersMapper.xml

```xml
<select id="findUsersList" resultType="Users">
    select * from Users;
</select>
```

使用package扫描包

```xml
<typeAliases>
    <package name="com.lxc.pojo"/>
</typeAliases>
```

> 此方式会自动扫描包下的所有JavaBean，会将注解@Alias("name")中的值作为别名，若没有注解则会将类首字母小写的非限定类名作为别名

> 自带别名，请查看文档

## 4、映射器（mappers）

### 4.1、类路径资源引用

```xml
<mappers>
    <mapper resource="com/lxc/dao/UsersMapper.xml"/>
</mappers>
```

### 4.2、接口实现类全限定类名

```xml
<mappers>
  <mapper class="com.lxc.dao.UsersMapper"/>
</mappers>
```

### 4.3、使用包名扫描

```xml
<mappers>
    <package name="com.lxc.dao"/>
</mappers>
```

> 方式二和方式三注意点：
>
> - 接口和Mapper配置文件必须同名
> - 接口和Mapper配置文件必须在同一包下

## 5、生命周期和作用域

**SqlSessionFactoryBuilder：**

- 唯一作用：创建`SqlSessionFactory`

**SqlSessionFactory：**

- 一旦被创建就应该在应用的运行期间一直存在。
- 使用单例模式或静态单例模式

**SqlSession：**

- 连接到连接池的请求
- 作用域为方法