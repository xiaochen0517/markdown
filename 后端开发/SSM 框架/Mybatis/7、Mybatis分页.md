# Mybatis分页

- 减少数据处理量，提升用户体验与服务器性能。

## 1、使用`SQL`分页

- 接口

```java
List<Users> findUsersListLimit(Map<String, Object> map);
```

- `SQL`语句

```xml
<select id="findUsersListLimit" parameterType="map" resultType="users">
    select * from users limit #{startSize}, #{listSize};
</select>
```

- 测试

```java
@Test
public void findUsersListLimitTest(){
    // 获取mapper
    UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);

    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("startSize", 0);
    map.put("listSize", 5);
    // 执行方法，获取返回数据
    List<Users> usersList = mapper.findUsersListLimit(map);
    // 打印数据
    for (Users users : usersList){
        logger.info(users);
    }
}
```

- 结果

![image-20200517092441492](photo\4、Mybatis分页（1）.png)

## 2、`RowBounds`分页

- 接口

```java
List<Users> findUsersListRowBounds();
```

- `SQL`语句

```xml
<select id="findUsersListRowBounds" resultType="users">
    select * from users;
</select>
```

- 测试

```java
@Test
public void findUsersListRowBoundsTest(){
    RowBounds rowBounds = new RowBounds(0, 5);
    // 获取mapper
    List<Users> usersList = sqlSession.selectList("com.lxc.dao.UsersMapper.findUsersListRowBounds",
                                                  null, rowBounds);
    // 打印数据
    for (Users users : usersList){
        logger.info(users);
    }
}
```

- 结果

![image-20200517093524813](photo\5、Mybatis分页（2）.png)

## 3、`PageHelper`

- [文档](https://pagehelper.github.io/docs/howtouse/)

- 导入jar包

```xml
<!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
<dependency>
    <groupId>com.github.pagehelper</groupId>
    <artifactId>pagehelper</artifactId>
    <version>5.1.11</version>
</dependency>
```

- `Mybatis`配置文件配置

```xml
<plugins>
    <!-- com.github.pagehelper为PageHelper类所在包名 -->
    <plugin interceptor="com.github.pagehelper.PageInterceptor">
        <!-- 使用下面的方式配置参数，后面会有所有的参数介绍 -->
        <property name="helperDialect" value="mysql"/>
    </plugin>
</plugins>
```

- 接口

```java
List<Users> findUsersListPageHelper();
```

- `SQL`语句

```xml
<select id="findUsersListPageHelper" resultType="users">
    select * from users
</select>
```

> 因为`pageHelper`会在当前`sql`语句后添加分页，所以在sql语句后不可以加分号。

- 测试

```java
@Test
public void findUsersListPageHelperTest(){
    RowBounds rowBounds = new RowBounds(0, 5);
    // 获取mapper
    List<Users> usersList = sqlSession.selectList("com.lxc.dao.UsersMapper.findUsersListPageHelper",
                                                  null, rowBounds);
    // 打印数据
    for (Users users : usersList){
        logger.info(users);
    }
}
```

- 结果

![image-20200517093524813](photo\5、Mybatis分页（2）.png)