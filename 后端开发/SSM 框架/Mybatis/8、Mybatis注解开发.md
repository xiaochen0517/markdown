# Mybatis注解开发

## 1、使用注解开发

- 接口

```java
@Select("select * from users;")
List<Users> findUsersList();
```

- 配置文件绑定

```xml
<mappers>
    <package name="com.lxc.dao"/>
</mappers>
```

- 测试

```java
@Test
public void findUsersListTest(){
    // 获取mapper
    UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
    // 执行方法，获取返回数据
    List<Users> usersList = mapper.findUsersList();
    // 打印数据
    for (Users users : usersList){
        logger.info(users);
    }
}
```

## 2、CRUD

### 2.1、插入

- 接口

```java
@Insert("insert into users (`username`,`password`,`birthday`) values (#{username},#{password},#{birthday})")
int insertUsers(@Param("username") String un,@Param("password") String pwd,@Param("birthday") Date bd);
```

- 测试

```java
@Test
public void insertUsersTest(){
    // 获取mapper
    UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
    // 执行方法，获取返回数据
    int result = mapper.insertUsers("iron man", "123456", new Date());
    // 打印数据
    if (result > 0){
        logger.info("插入成功");
    }
    sqlSession.commit();
}
```

### 2.2、删除

- 接口

```java
@Delete("delete from users where id = #{id}")
int deleteUsers(int id);
```

- 测试

```java
@Test
public void deleteUsersTest(){
    // 获取mapper
    UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
    // 执行方法，获取返回数据
    int result = mapper.deleteUsers(2);
    // 打印数据
    if (result > 0){
        logger.info("删除成功");
    }
    sqlSession.commit();
}
```

### 2.3、修改

- 接口

```java
@Update("update users set username = #{username} where id = #{id}")
int updateUsers(@Param("id") int id, @Param("username") String username);
```

- 测试

```java
@Test
public void updateUsersTest(){
    // 获取mapper
    UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
    // 执行方法，获取返回数据
    int result = mapper.updateUsers(3, "Hulk");
    // 打印数据
    if (result > 0){
        logger.info("更新成功");
    }
    sqlSession.commit();
}
```

> 开启自动提交

```java
// 使用SqlSessionFactory获取SqlSession
ssf.openSession(true);
```

> @Param注解相关

- 基本类型的参数或者String类型，需要添加此注解
- 引用类型不需要添加
- 如果只有一个基本类型可以忽略