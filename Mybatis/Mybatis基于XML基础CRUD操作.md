## Mybatis基于XML基础CRUD操作

#### UserDao.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.lxc.dao.UserDao">
    <select id="findAll" resultType="com.lxc.domain.User">
        select * from user;
    </select>
    <insert id="addUser" parameterType="com.lxc.domain.User">
        insert into user (`name`,`gender`,`age`,`address`,`qq`,`email`)
        values
        (#{name},#{gender},#{age},#{address},#{qq},#{email});
    </insert>
    <update id="updateUser" parameterType="com.lxc.domain.User">
        update user set `name`=#{name},`gender`=#{gender},`age`=#{age},
        `address`=#{address},`qq`=#{qq},`email`=#{email}
        where `id` = #{id};
    </update>
    <select id="findUser" parameterType="java.lang.Integer" resultType="com.lxc.domain.User">
        select * from user where `id`=#{id};
    </select>
    <delete id="deleteUser" parameterType="java.lang.Integer">
        delete from user where `id`=#{id};
    </delete>
</mapper>
```

#### UserDao.java

```java
public interface UserDao {

    List<User> findAll();

    int addUser(User user);

    int updateUser(User user);

    User findUser(int id);

    int deleteUser(int id);

}
```

#### mybatis.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <environments default="mysql">
        <environment id="mysql">
            <transactionManager type="JDBC"></transactionManager>
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
                <property name="url"
                          value="jdbc:mysql://127.0.0.1:3306/study1?useUnicode=true&amp;characterEncoding=utf8&amp;useSSL=false"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <mapper resource="dao/UserDao.xml"></mapper>
    </mappers>
</configuration>
```

#### 测试类

```java
public class MyTest1 {

    private SqlSession session;
    private InputStream is;
    private UserDao userDao;

    @Before
    public void init() {
        try {
            is = Resources.getResourceAsStream("mybatis.xml");
            SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
            SqlSessionFactory sqlSessionFactory = builder.build(is);
            session = sqlSessionFactory.openSession();
            userDao = session.getMapper(UserDao.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @After
    public void destroy() {
        try {
            session.commit();
            session.close();
            is.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void Test1() {
        List<User> users = userDao.findAll();
        for (User u : users) {
            System.out.println(u.toString());
        }
    }

    @Test
    public void Test2(){
        User user = new User();
        user.setName("测试");
        user.setGender("男");
        user.setAge(23);
        user.setAddress("上海");
        user.setQq("741852");
        user.setEmail("456@123.com");
        int i = userDao.addUser(user);
        System.out.println(i);
    }

    @Test
    public void Test3(){
        User user = userDao.findUser(56);
        user.setName("测试1");
        int i = userDao.updateUser(user);
        System.out.println(i);
    }

    @Test
    public void Test4(){
        int i = userDao.deleteUser(56);
        System.out.println(i);
    }

}
```

