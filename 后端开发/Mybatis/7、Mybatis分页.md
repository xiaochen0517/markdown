# Mybatis分页

- 减少数据处理量，提升用户体验与服务器性能。

## 1、使用SQL分页

- 接口

```java
List<Users> findUsersListLimit(Map<String, Object> map);
```

- SQL语句

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

## 2、RowBounds分页

- 接口

```java
List<Users> findUsersListRowBounds();
```

- SQL语句

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