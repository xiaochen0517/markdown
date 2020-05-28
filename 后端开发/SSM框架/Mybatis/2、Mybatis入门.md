# Mybatis入门

## 1、配置`pom.xml`

### 1.1、导入`dependency`

#### 1.1.1、`jdbc`包

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.18</version>
</dependency>
```

#### 1.1.2、`mybatis`

```xml
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.2</version>
</dependency>
```

#### 1.1.3、`junit`

```xml
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
    <scope>test</scope>
</dependency>
```

### 1.2、解决`maven`项目`build`时资源过滤问题

```xml
<build>
    <resources>
        <resource>
            <directory>src/main/java</directory>
            <includes>
                <include>**/*.properties</include>
                <include>**/*.xml</include>
            </includes>
            <filtering>false</filtering>
        </resource>
        <resource>
            <directory>src/main/resources</directory>
            <includes>
                <include>**/*.properties</include>
                <include>**/*.xml</include>
            </includes>
            <filtering>false</filtering>
        </resource>
    </resources>
</build>
```

## 2、`Mybatis`配置文件

### 2.1、头部约束

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
```

### 2.2、配置部分（`configuration`）

#### 2.2.1、连接配置

```xml
<environments default="development"> <!--default默认配置，值为配置id-->
    <environment id="development">
        <transactionManager type="JDBC"/>
        <!--datasource源-->
        <dataSource type="POOLED">
            <!--驱动类-->
            <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
            <!--连接地址-->
            <property name="url" value="jdbc:mysql://localhost:3306/school?useUnicode=true&amp;characterEncoding=utf8&amp;useSSL=true&amp;serverTimezone=Asia/Shanghai"/>
            <!--用户名-->
            <property name="username" value="root"/>
            <!--密码-->
            <property name="password" value="xxxxxx"/>
        </dataSource>
    </environment>
</environments>
```

#### 2.2.2、`mapper`配置

```xml
<mappers>
    <mapper resource="com/lxc/dao/UsersDao.xml"/>
</mappers>
```

## 3、持久层编写

- 包结构

```
- com.lxc
	- dao
		- UsersDao.java
		- UsersDao.xml
	- pojo
		- Users.java
	- utils
		- MybatisUtils.java
```

### 3.1、工具类

- MybatisUtils.java

```java
public class MybatisUtils {

    private static SqlSessionFactory ssf;

    static {
        try{
            String xml = "mybatis-config.xml";
            InputStream is = Resources.getResourceAsStream(xml);
            // 导入配置文件，获取SqlSessionFactory
            ssf = new SqlSessionFactoryBuilder().build(is);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static SqlSession getSqlSession(){
        // 使用SqlSessionFactory获取SqlSession
        return ssf.openSession();
    }
}
```

### 3.2、`bean`类

```java
public class Users {
    private int id;
    private String username;
    private String password;
    private String tel;
    private Date birthday;

    public Users() {
    }

    public Users(int id, String username, String password, String tel, Date birthday) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.tel = tel;
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return "Users{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", tel='" + tel + '\'' +
                ", birthday=" + birthday +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }
}
```

### 3.3、`UsersDao`

- UsersDao.java

```java
public interface UsersDao {
    List<Users> findUsersList();
}
```

### 3.4、`UsersDao.xml`

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--namespace：命名空间，指定接口的全限定类名-->
<mapper namespace="com.lxc.dao.UsersDao">
    <!--需要执行的sql操作，id：接口方法，resultType：返回的数据类型的全限定类名-->
    <select id="findUsersList" resultType="com.lxc.pojo.Users">
        select * from Users;
    </select>
</mapper>
```

## 4、测试类

```java
@Test
public void findUsersListTest(){
    // 获取SqlSession
    SqlSession sqlSession = MybatisUtils.getSqlSession();
    // 获取mapper
    UsersDao mapper = sqlSession.getMapper(UsersDao.class);
    // 执行方法，获取返回数据
    List<Users> usersList = mapper.findUsersList();
    // 打印数据
    for (Users users : usersList){
        System.out.println(users);
    }
}
```



> 附

参考连接：https://mybatis.org/mybatis-3/zh/getting-started.html

