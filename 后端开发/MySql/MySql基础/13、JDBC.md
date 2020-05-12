# JDBC

## 1、数据库驱动

![image-20200512091559248](photo\1、（13）数据库驱动.jpg).

## 2、JDBC

SUN公司为了简化开发人员对数据库的统一操作，提供了一个Java操作数据库的规范——JDBC。

这些规范的实现由数据库厂商实现，开发人员只需要掌握JDBC接口即可。

![image-20200512092145657](photo\2、（13）JDBC.jpg).

## 3、JDBC示例

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
    String passwd = "23122918lxc";
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

