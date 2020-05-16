# Mybatis结果集映射

## 1、属性名与字段不一致

### 1.1、添加别名

在查询语句中给字段添加和属性名同样的别名即可解决。

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Alias("name")
public class Users {
    private int id;
    private String username;
    private String pwd;
    private String tel;
    private Date birthday;
}
```

sql语句

```sql
select id,username,password pwd,tel,birthday from Users;
```

### 1.2、resultMap

使用resultMap属性解决问题

```xml
<resultMap id="userMap" type="name">
    <!--column：数据库中的字段 Property：javaBean中的属性名-->
    <result column="id" property="id"/>
    <result column="username" property="username"/>
    <result column="password" property="pwd"/>
    <result column="tel" property="tel"/>
    <result column="birthday" property="birthday"/>
</resultMap>

<!--需要执行的sql操作，id：接口方法 resultMap：指定resultMap的id-->
<select id="findUsersList" resultMap="userMap">
    select * from Users;
</select>
```



