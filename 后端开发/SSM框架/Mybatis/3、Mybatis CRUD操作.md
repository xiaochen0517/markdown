# Mybatis CRUD操作

## 1、`mapper.xml`详解

### 1.1、`namespace`属性

namespace中的包名要和绑定的接口的全限定类名

### 1.2、`select`标签

查询语句

- id：绑定接口中的方法名
- resultType：sql执行的返回值
- parameterType：参数的类型

**接口**

```java
Users findUsers(int id);
```

**绑定**

```xml
<select id="findUsers" parameterType="int" resultType="com.lxc.pojo.Users">
    select * from users where id = #{id};
</select>
```

**测试**

```java
@Test
public void findUsersTest(){
    // 获取mapper
    UsersDao mapper = sqlSession.getMapper(UsersDao.class);
    Users users = mapper.findUsers(13);
    System.out.println(users);
}
```

### 1.3、`insert`标签

**接口**

```java
int insertUsers(Users users);
```

**绑定**

```xml
<insert id="insertUsers" parameterType="com.lxc.pojo.Users">
    insert into users (`username`, `password`, `birthday`)
    values (#{username}, #{password}, #{birthday});
</insert>
```

**测试**

```java
@Test
public void insertUsersTest(){
    // 获取mapper
    UsersDao mapper = sqlSession.getMapper(UsersDao.class);
    Users users = new Users();
    users.setUsername("haha");
    users.setPassword("123456");
    users.setBirthday(new Date());

    int i = mapper.insertUsers(users);

    sqlSession.commit();
}
```

### 1.4、`update`标签

**接口**

```java
int updateUsers(Users users);
```

**绑定**

```xml
<update id="updateUsers" parameterType="com.lxc.pojo.Users">
    update users set username = #{username}, password = #{password} where id = #{id};
</update>
```

**测试**

```java
@Test
public void updateUsersTest(){
    // 获取mapper
    UsersDao mapper = sqlSession.getMapper(UsersDao.class);
    Users users = new Users();
    users.setId(13);
    users.setUsername("hehe");
    users.setPassword("123123");

    int i = mapper.updateUsers(users);
    if (i>0){
        System.out.println("更新成功");
    }

    sqlSession.commit();
}
```

### 1.5、`delete`标签

**接口**

```java
int deleteUsers(int id);
```

**绑定**

```xml
<delete id="deleteUsers" parameterType="int">
    delete from users where id = #{id};
</delete>
```

**测试**

```java
@Test
public void deleteUsersTest(){
    // 获取mapper
    UsersDao mapper = sqlSession.getMapper(UsersDao.class);

    int i = mapper.deleteUsers(13);
    if (i>0){
        System.out.println("删除成功");
    }

    sqlSession.commit();
}
```



> 增删改需要使用`sqlsession`提交事务

## 2、Map传递

在编写`sql`语句时直接取出`map`中的`key`即可

```xml
<insert id="insertUsersMap" parameterType="map">
    insert into users (`username`, `password`, `birthday`)
    values (#{un}, #{pw}, #{bd});
</insert>
```

> 模糊查询时需要在传参时添加通配符