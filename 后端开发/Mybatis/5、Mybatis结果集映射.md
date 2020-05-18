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

## 2、多表查询

### 2.1、多对一

#### 2.1.1、子查询

- Mapper.xml配置

```xml
<!--    查询所有的student信息-->
<select id="findStudents" resultMap="studentToTeacher">
    select * from student
</select>

<!--    结果映射-->
<resultMap id="studentToTeacher" type="Student">
    <result property="id" column="id"/>
    <result property="name" column="name"/>
    <!--        将子查询的结果映射到Teacher对象中-->
    <association property="teacher" column="tid" javaType="Teacher" select="findTeacher"/>
</resultMap>

<!--    子查询，查询所有的Teacher信息-->
<select id="findTeacher" resultType="Teacher">
    select * from teacher where id = #{tid}
</select>
```

#### 2.1.2、联表查询

```xml
<!--    将两个表中的所有信息全部查询到-->
<select id="findStudents2" resultMap="studentToTeacher2">
    select s.id sid, s.name sname, t.id tid, t.name tname
    from student s, teacher t
    where s.tid = t.id;
</select>

<!--    结果映射-->
<resultMap id="studentToTeacher2" type="Student">
    <result property="id" column="sid"/>
    <result property="name" column="sname"/>
    <!--        将制定的结果映射到Teacher对象中-->
    <association property="teacher" javaType="Teacher">
        <result property="id" column="tid"/>
        <result property="name" column="tname"/>
    </association>
</resultMap>
```

### 2.2、一对多

#### 2.2.1、联表查询

```xml
<!--    联表查询信息-->
<select id="findTeachers" resultMap="teacherToStudent">
    select t.id tid,t.name tname,s.id sid,s.name sname
    from student s, teacher t
    where s.tid = t.id and t.id = #{tid}
</select>

<!--    结果映射-->
<resultMap id="teacherToStudent" type="Teacher">
    <result property="id" column="tid"/>
    <result property="name" column="tname"/>
    <!--        将查询到的学生的信息映射到集合students中-->
    <collection property="students" ofType="Student">
        <result property="id" column="sid"/>
        <result property="name" column="sname"/>
    </collection>
</resultMap>
```

#### 2.2.2、子查询

```xml
<!--    查询teacher的信息-->
<select id="findTeachers2" resultMap="teacherToStudent2">
    select * from teacher where id = #{tid}
</select>

<!--    结果映射-->
<resultMap id="teacherToStudent2" type="Teacher">
    <!--        property：bean中的属性名，column：使用上一个查询的那个值进行子查询，
        javaType：返回的类型，ofType：泛型的类型，select：子查询id-->
    <collection property="students" column="id" javaType="ArrayList" ofType="Student" select="findStudent"/>
</resultMap>

<!--    子查询-->
<select id="findStudent" resultType="Student">
    select * from student where tid = #{tid}
</select>
```

> 关联：association
>
> 集合：collection

