# JDBC

## 1、数据库驱动

![image-20200512091559248](photo\1、（13）数据库驱动.jpg).

## 2、JDBC

SUN公司为了简化开发人员对数据库的统一操作，提供了一个Java操作数据库的规范——JDBC。

这些规范的实现由数据库厂商实现，开发人员只需要掌握JDBC接口即可。

![image-20200512092145657](photo\2、（13）JDBC.jpg).

## 3、JDBC

### 3.1、示例

```java
public static void main(String[] args) throws ClassNotFoundException, SQLException {
    // 加载驱动
    Class.forName("com.mysql.cj.jdbc.Driver");
    // 用户信息和地址
    /**
         * 1、使用unicode编码
         * 2、使用utf8字符集
         * 3、使用ssl连接
         */
    String url = "jdbc:mysql://localhost:3306/jdbcstudy?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
    String username = "root";
    String passwd = "xxxx";
    // 连接数据库
    Connection connection = DriverManager.getConnection(url, username, passwd);
    // 获取执行sql的对象
    Statement statement = connection.createStatement();
    // 执行sql语句，获取返回结果
    String sql = "select * from users;";
    ResultSet resultSet = statement.executeQuery(sql);
    // 输出查询结果
    while (resultSet.next()){
        System.out.println(resultSet.getObject("id"));
        System.out.println(resultSet.getObject("name"));
        System.out.println(resultSet.getObject("password"));
        System.out.println(resultSet.getObject("email"));
        System.out.println(resultSet.getObject("birthday"));
    }
    // 释放连接
    resultSet.close();
    statement.close();
    connection.close();
}
```

### 3.2、流程详解

> 加载驱动

```java
// 加载驱动
// DriverManager.registerDriver(new Driver());
Class.forName("com.mysql.cj.jdbc.Driver");
```

> 连接url

```java
String url = "jdbc:mysql://localhost:3306/jdbcstudy?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
```

- 格式

```bash
jdbc:mysql://地址:端口号/数据库名?参数1&参数2&...
```

> 获取连接

```java
Connection connection = DriverManager.getConnection(url, username, passwd);
connection.setAutoCommit(); // 设置自动提交
connection.commit(); // 提交事务
connection.rollback(); // 回滚事务
```

> Statement SQL语句执行对象

```
// 获取statement
Statement statement = connection.createStatement();

statement.executeQuery(sql); // 执行查询，返回ResultSet
statement.execute(); // 可以执行所有sql语句
statement.executeUpdate(); // 插入、删除、更新语句，返回受影响的行数
```

> ResultSet查询结果集

```java
resultSet.getObject(); // 不确定数据类型时获取
resultSet.getString(); // 指定获取的数据类型
resultSet.getInt();
...
```

- 遍历数据

```java
resultSet.beforeFirst(); // 指针移动到开始
resultSet.afterLast(); // 指针移动到结尾
resultSet.previous(); // 指针向前移动
resultSet.next(); // 指针向后移动
```

> 释放连接

```java
// 释放连接
resultSet.close();
statement.close();
connection.close();
```

### 3.3、`statement`对象

用于向数据库发送SQL语句，对数据库进行增删改查。

#### 3.3.1、添加`create`

```java
Statement st = connection.createStatement();
String sql = "insert into user(...) values (...);";
int num = st.executeUpdate(sql);
if(num > 0){
    System.out.println("插入成功");
}
```

#### 3.3.2、删除`delete`

```java
Statement st = connection.createStatement();
String sql = "delete from user where id = 1;";
int num = st.executeUpdate(sql);
if(num > 0){
    System.out.println("删除成功");
}
```

#### 3.3.3、更新`update`

```java
Statement st = connection.createStatement();
String sql = "update user set name='' where id=1;";
int num = st.executeUpdate(sql);
if(num > 0){
    System.out.println("修改成功");
}
```

#### 3.3.4、查询`read`

```java
Statement st = connection.createStatement();
String sql = "select * from user";
ResultSet rs = st.executeQuery(sql);
while(rs.next()){
    // 获取返回的数据
}
```

### 3.4、工具类实现

- `jdbc.properties`

```properties
driver=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/jdbcstudy?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC
username=root
password=xxxx
```

- `JdbcUtils.java`

```java
public class JdbcUtils {

    private static String driver = null;
    private static String url = null;
    private static String username = null;
    private static String password = null;

    static {
        InputStream is = JdbcUtils.class.getClassLoader()
                .getResourceAsStream("jdbc.properties");
        Properties properties = new Properties();
        try {
            properties.load(is);
            driver = properties.getProperty("driver");
            url = properties.getProperty("url");
            username = properties.getProperty("username");
            password = properties.getProperty("password");

            Class.forName(driver);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    public static void close(Connection con, Statement st, ResultSet rs){
        try {
            if (con != null){
                con.close();
            }
            if (st != null){
                st.close();
            }
            if (rs != null){
                rs.close();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
```

- `main`

```java
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
try {
    connection = JdbcUtils.getConnection();
    statement = connection.createStatement();
    String sql = "insert into `users` (`name`, `password`, `email`, `birthday`)" +
        " values('lxc', '123456', '123@qq.com', '2000-05-17');";
    int i = statement.executeUpdate(sql);
    if (i > 0) {
        System.out.println("插入成功！");
    }
} catch (SQLException throwables) {
    throwables.printStackTrace();
} finally {
    JdbcUtils.close(connection, statement, resultSet);
}
```

### 3.5、PreparedStatement

步骤：

- 获取connection
- 预编译sql
- 传入参数
- 执行sql，获取返回值

```java
Connection connection = null;
PreparedStatement ps = null;
try {
    // 获取连接
    connection = JdbcUtils.getConnection();
    // 使用占位符代替需要传值的位置
    String sql = "insert into users (`username`, `password`, `birthday`) values (?,?,?);";
    // 预编译sql
    ps = connection.prepareStatement(sql);

    // 根据下标传值，从1开始
    ps.setString(1, "mochen");
    ps.setString(2, "123456");
    ps.setDate(3, new java.sql.Date(new Date().getTime()));

    // 执行sql
    int i = ps.executeUpdate();
    if (i > 0){
        System.out.println("插入成功！");
    }

} catch (SQLException throwables) {
    throwables.printStackTrace();
}finally {
    // 关闭连接
    JdbcUtils.close(connection, ps, null);
}
```

