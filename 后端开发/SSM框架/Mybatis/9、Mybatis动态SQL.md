# Mybatis动态SQL

概念：根据指定的条件动态地生成SQL语句

## 1、`if`

- 接口

```java
List<Blog> findBlogTitle(@Param("title") String title,@Param("author") String author);
```

- 配置SQL

```xml
<select id="findBlogTitle" resultType="Blog">
    select * from blog where author = #{author}
    <if test="title != null">
        and title like #{title}
    </if>
</select>
```

- 测试

```java
@Test
public void test2(){
    BlogMapper mapper = sqlSession.getMapper(BlogMapper.class);
    List<Blog> blogs = mapper.findBlogTitle("%Java%", "用户");
    for (Blog b:blogs){
        logger.info(b);
    }
}
```

- 结果

![image-20200518185650795](photo\6、Mybatis动态SQL（1）.png)

## 2、`trim (where, set)`

### 2.1、`where`

```xml
<select id="findBlogIf" resultType="Blog">
    select * from blog where author = #{author}
    <if test="title != null">
        and title = #{title}
    </if>
    <if test="views != null">
        and views > #{views}
    </if>
</select>
```

在上面的SQL语句中，若where后的条件中author值也不确定是否存在时，则可以将上述SQL修改为：

```xml
<select id="findBlogIf" resultType="Blog">
    select * from blog where
    <if test="author != null">
        author = #{author}
    </if>
    <if test="title != null">
        and title = #{title}
    </if>
    <if test="views != null">
        and views > #{views}
    </if>
</select>
```

但是当三个条件都不满足时，SQL语句会变成下面的样子：

```sql
select * from blog where
```

这时就可以使用where标签来解决这个问题：

```xml
<select id="findBlogIf" resultType="Blog">
    select * from blog
    <where>
        <if test="author != null">
            author = #{author}
        </if>
        <if test="title != null">
            and title = #{title}
        </if>
        <if test="views != null">
            and views > #{views}
        </if>
    </where>
</select>
```

这时，当条件都不成立时的SQL语句：`select * from blog`；当第一个条件成立时的SQL语句：`select * from blog where author = #{author}`；

但是当第一个条件不成立，第二个条件成立会怎么样呢？

这时，Mybatis会将第二条件前的and关键字去掉，SQL语句就会变成这个样子：``select * from blog where title = #{title}`

### 2.2、`set`

- SQLMapper

```xml
<update id="updateBlogSet" parameterType="map">
    update blog
    <set>
        <if test="title != null">
            title = #{title},
        </if>
        <if test="author != null">
            author = #{author},
        </if>
    </set>
    where id = #{id}
</update>
```

- 测试代码

```java
@Test
public void test5(){
    BlogMapper mapper = sqlSession.getMapper(BlogMapper.class);
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("author", "用户1");
    map.put("title", "Mybatis哈哈哈2");
    map.put("id", "5eb4a48eccd741b7b2f42d64605e0371");

    int result = mapper.updateBlogSet(map);
    if (result > 0){
        logger.info("成功修改");
    }
    sqlSession.commit();
}
```

- 执行的sql语句

```sql
update blog SET title = ?, author = ? where id = ? 
```

> `set`标签会自动添加`set`关键字和自动去除多余的逗号。

## 3、`choose (when, otherwise)`

`choose`标签就相当于`Java`中的`switch...case...`，其中`when`的作用于`case`的作用相同，`otherwise`和`default`作用相同。

```xml
<select id="findBlogChoose" resultType="Blog">
    select * from blog where author = #{author}
    <choose>
        <when test="title != null">
            and title = #{title}
        </when>
        <when test="views != null">
            and views > #{views}
        </when>
        <otherwise>
            and id = '3abc0612f8cd42d6a165816ea9570ffd'
        </otherwise>
    </choose>
</select>
```

## 4、foreach

### 4.1、include

```xml
<sql id="updateBlogSet-if">
    <if test="title != null">
        title = #{title},
    </if>
    <if test="author != null">
        author = #{author},
    </if>
</sql>

<update id="updateBlogSet" parameterType="map">
    update blog
    <set>
        <include refid="updateBlogSet-if"/>
    </set>
    where id = #{id}
</update>
```

> 使用`include`可以将`sql语句`提取到`sql标签`外部，方便代码复用和提高可阅读性。

### 4.2、ForEach

- 接口

```java
List<Blog> findBlogForEach(List<String> list);
```

- sql

```xml
<select id="findBlogForEach" resultType="Blog">
    select * from blog where id in
    <foreach collection="list" item="item" index="index"
             open="(" separator="," close=")">
        #{item}
    </foreach>
</select>
```

> - collection：需要遍历的list
> - item：遍历出的值
> - index：元素的下标
> - open：遍历前添加内容
> - separator：每个值之间的分隔
> - close：遍历后添加内容

- 测试

```java
@Test
public void test6(){
    BlogMapper mapper = sqlSession.getMapper(BlogMapper.class);
    List<String> list = new ArrayList<String>();
    list.add("5eb4a48eccd741b7b2f42d64605e0371");
    list.add("acbb093620bf4941b441e07cd3043c92");

    List<Blog> blogs = mapper.findBlogForEach(list);
    for (Blog b:blogs){
        logger.info(b);
    }
}
```