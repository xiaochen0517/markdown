# Mybatis缓存

## 1、简介

### 1.1、什么是缓存

缓存就是将查询的结果暂存在内存中，再次查询相同的数据时直接从缓存中读取，从而加快查询速度。

### 1.2、为什么使用缓存

减少和数据库的交互次数，减少系统开销提升查询效率。

> 进程查询且不经常改变的数据可以使用缓存技术。

## 2、Mybatis缓存

- `Mybatis`中可以非常方便的定制和配置缓存，缓存可以极大的提高查询的效率。
- `Mybatis`中的默认缓存：一级缓存和二级缓存
  - 默认开启一级缓存，也成为本地缓存
  - 耳机缓存需要手动开启和配置，是基于`namespace`级别的缓存
  - `Mybatis`定义了缓存接口`Cache`，可以通过实现此接口来定义二级缓存

### 2.1、一级缓存

- 一级缓存也叫本地缓存：	
  - 与数据库同一次会话期间查询到的数据会放在本地缓存中
  - 以后如果需要获取相同的数据，会直接获取缓存中的数据

#### 2.1.1、测试一级缓存

- 接口

```java
List<Blog> findBlogCache(@Param("id") String id);
```

- sql

```xml
<select id="findBlogCache" resultType="Blog">
    select * from blog where id = #{id}
</select>
```

- 测试

```java
@Test
public void test7(){
    BlogMapper mapper = sqlSession.getMapper(BlogMapper.class);

    List<Blog> blogs = mapper.findBlogCache("5eb4a48eccd741b7b2f42d64605e0371");
    for (Blog b:blogs){
        logger.info(b);
    }
    logger.info("----------------------");
    List<Blog> blogs2 = mapper.findBlogCache("5eb4a48eccd741b7b2f42d64605e0371");
    for (Blog b:blogs2){
        logger.info(b);
    }
}
```

- 结果

![image-20200521082502109](photo\7、Mybatis缓存（1）.png)

> 可以使用`SqlSession`的`clearCache`方法手动清空缓存

> 一级缓存的生命周期为`SqlSession`开启到`SqlSession`结束

#### 2.1.2、一级缓存特点

- 映射语句文件中的所有 `select` 语句的结果将会被缓存。
- 映射语句文件中的所有 `insert`、`update` 和 `delete` 语句会刷新缓存。
- 缓存会使用最近最少使用算法（`LRU`,` Least Recently Used`）算法来清除不需要的缓存。
- 缓存不会定时进行刷新（也就是说，没有刷新间隔）。
- 缓存会保存列表或对象（无论查询方法返回哪种）的 1024 个引用。
- 缓存会被视为读/写缓存，这意味着获取到的对象并不是共享的，可以安全地被调用者修改，而不干扰其他调用者或线程所做的潜在修改。

> 来源：[Mybatis官方文档](https://mybatis.org/mybatis-3/zh/sqlmap-xml.html#cache)

### 2.2、二级缓存

#### 2.2.1、二级缓存概述

- 二级缓存也称为全局缓存。
- 基于`namespace`级别的缓存，一个命名空间对应一个二级缓存
- 特点
  - 一个会话查询一条数据，数据会被放在当前的一级缓存中
  - 如果会话关闭了，这个会话对应的一级缓存就会保存到二级缓存中
  - 新的会话查询数据时就可以从二级缓存中获取内容
  - 不同`mapper`查询出的数据会放在自己对应的缓存中

#### 2.2.2、开启二级缓存

- 开启全局缓存

```xml
<!--    设置-->
<settings>
    <setting name="logImpl" value="LOG4J"/>
    <setting name="mapUnderscoreToCamelCase" value="true"/>
    <!--显式地开启全局缓存-->
    <setting name="cacheEnabled" value="true"/>
</settings>
```

- 在指定Mapper.xml中开启二级缓存

```xml
<!--开启二级缓存-->
<cache/>
```

> 自定义参数
>
> - `eviction`：缓存清除策略
>   - `LRU` – 最近最少使用：移除最长时间不被使用的对象。
>   - `FIFO` – 先进先出：按对象进入缓存的顺序来移除它们。
>   - `SOFT` – 软引用：基于垃圾回收器状态和软引用规则移除对象。
>   - `WEAK` – 弱引用：更积极地基于垃圾收集器状态和弱引用规则移除对象。
> - `flushInterval`：刷新间隔，单位为毫秒
> - `size`：引用数目可以被设置为任意正整数，默认值为1024
> - `readOnly`：只读可以被设置为boolean值，只读的缓存会给所有调用者返回缓存对象的相同实例。 因此这些对象不能被修改。可读写的缓存会（通过序列化）返回缓存对象的拷贝。 速度上会慢一些，但是更安全，因此默认值是 false

#### 2.2.3、测试二级缓存

- 测试

```java
@Test
public void test2(){
    SqlSession sqlSession1 = MybatisUtils.getSqlSession();
    BlogMapper mapper1 = sqlSession1.getMapper(BlogMapper.class);

    List<Blog> blogs = mapper1.findBlogCache("5eb4a48eccd741b7b2f42d64605e0371");
    for (Blog b:blogs){
        logger.info(b);
    }

    sqlSession1.close();
    logger.info("----------------------");
    SqlSession sqlSession2 = MybatisUtils.getSqlSession();
    BlogMapper mapper2 = sqlSession2.getMapper(BlogMapper.class);
    List<Blog> blogs2 = mapper2.findBlogCache("5eb4a48eccd741b7b2f42d64605e0371");
    for (Blog b:blogs2){
        logger.info(b);
    }
    sqlSession2.close();
}
```

- 结果

![image-20200521092120769](E:\PerFile\notes\markdown\后端开发\Mybatis\photo\8、Mybatis缓存（2）.png)

> 错误：`Error serializing object.  Cause: java.io.NotSerializableException: com.xxx.xxx`

将`JavaBean`类实现`Serializable`接口即可

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Blog implements Serializable {
    private String id;
    private String title;
    private String author;
    private Date createTime;
    private String views;
}
```

### 2.3、自定义缓存

#### 2.3.1、导入`jar`包

```xml
<!-- https://mvnrepository.com/artifact/org.mybatis.caches/mybatis-ehcache -->
<dependency>
    <groupId>org.mybatis.caches</groupId>
    <artifactId>mybatis-ehcache</artifactId>
    <version>1.2.1</version>
</dependency>
```

#### 2.3.2、使用自定义缓存

```xml
<!--开启二级缓存-->
<cache type="org.mybatis.caches.ehcache.EhcacheCache"/>
```

#### 2.3.3、`ehcache`配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="http://ehcache.org/ehcache.xsd">

    <!-- 磁盘缓存位置 -->
    <diskStore path="java.io.tmpdir/ehcache"/>

    <!-- 默认缓存 -->
    <defaultCache
            maxEntriesLocalHeap="10000"
            eternal="false"
            timeToIdleSeconds="120"
            timeToLiveSeconds="120"
            maxEntriesLocalDisk="10000000"
            diskExpiryThreadIntervalSeconds="120"
            memoryStoreEvictionPolicy="LRU">
        <persistence strategy="localTempSwap"/>
    </defaultCache>

    <!-- helloworld缓存 -->
    <cache name="HelloWorldCache"
           maxElementsInMemory="1000"
           eternal="false"
           timeToIdleSeconds="5"
           timeToLiveSeconds="5"
           overflowToDisk="false"
           memoryStoreEvictionPolicy="LRU"/>
</ehcache>
```

参数介绍：

- `name`：缓存名称
- `maxElementsInMemory`：缓存最大数目
- `maxElementsOnDisk`：硬盘最大缓存数目
- `eternal`：对象是否永久有效，设置此项后`timeout`将不起作用
- `overflowToDisk`：当系统宕机时，是否将缓存保存到磁盘
- `timeToIdleSeconds`：设置对象在失效前允许闲置的时间，单位秒
- `timeToLiveSeconds`：设置对象在失效前允许存活的时间
- `diskPersistent`：是否缓存虚拟机重启期数据
- `diskSpoolBufferSizeMB`：设置DiskStore（磁盘缓存）的缓存区大小，默认为30MB
- `diskExpiryThreadIntervalSeconds`：磁盘失效线程运行时间间隔，默认为120秒
- `clearOnFlush`：内存缓存数量最大时是否清除
- `memoryStoreEvictionPolicy`：到达指定限制时，指定策略清理内存
  - `FIFO`：`first in first out` 先进先出
  - `LFU`：`Less Frequently Used` 最少被使用的，最优先被清理
  - `LRU`：`Least Recently Used` 移出最长时间不被使用的对象