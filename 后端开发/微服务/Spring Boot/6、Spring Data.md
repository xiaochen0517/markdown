# Spring Data

## 1、概述

`Spring Data` 是一个用于简化数据库访问，并支持云服务的开源框架。其主要目标是使得数据库的访问变得方便快捷，并支持 `map-reduce` 框架和云计算数据服务。此外，它还支持基于关系型数据库的数据服务，如 `Oracle` `RAC` 等。对于拥有海量数据的项目，可以用 `Spring Data` 来简化项目的开发，就如 `Spring Framework` 对 `JDBC` 、 `ORM` 的支持一样， `Spring Data` 会让数据的访问变得更加方便

## 2、使用

### 2.1、导入 `maven` 

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jdbc</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-jdbc</artifactId>
</dependency>
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <scope>runtime</scope>
</dependency>
```

### 2.2、配置文件

```yaml
spring:
  datasource:
    username: xxxx
    password: xxxx
    url: jdbc:mysql://localhost:3306/school?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    driver-class-name: com.mysql.cj.jdbc.Driver
```

> 在配置文件中写入数据库连接信息

### 2.3、测试

 ```java
@RestController
public class JdbcController {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @RequestMapping("/userlist")
    public List<Map<String, Object>> test1(){
        String sql = "select * from user";
        List<Map<String, Object>> maps = jdbcTemplate.queryForList(sql);
        return maps;
    }

    @RequestMapping("/adduser")
    public String addUser(){
        String sql = "insert into user(username, password) values ('wangwu', '123456')";
        int update = jdbcTemplate.update(sql);
        return ""+update;
    }

}
 ```

## 3、自定义数据源 `DruidDataSource` 

### 3.1、概述

`Druid` 连接池是阿里巴巴开源的数据库连接池项目。 `Druid` 连接池为监控而生，内置强大的监控功能，监控特性不影响性能。功能强大，能防 `SQL` 注入，内置 `Loging` 能诊断 `Hack` 应用行为。

### 3.2、导入依赖

```xml
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid-spring-boot-starter</artifactId>
    <version>1.1.23</version>
</dependency>
```

> 在导入  `druid` 时，同时导入 `log4j` 的 `jar` 包

```xml
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.17</version>
</dependency>
```

### 3.3、配置文件

#### 3.3.1、创建 `class` 读取配置文件

- `DruidConfig.java` 

```java
@Configuration
public class DruidConfig {

    @Bean
    @ConfigurationProperties(prefix = "spring.datasource.druid") // 读取配置文件指定属性
    public DataSource druidDataSource() {
        return new DruidDataSource();
    }

    @Bean
    public ServletRegistrationBean registrationBean(){
        ServletRegistrationBean<StatViewServlet> bean = new ServletRegistrationBean<>(new StatViewServlet(), "/druid/*");
        HashMap<String, String> initParameters = new HashMap<>();
        // 设置监控后台登录密码
        initParameters.put("loginUsername", "root");
        initParameters.put("loginPassword", "root");
        initParameters.put("allow", "");

        bean.setInitParameters(initParameters);
        return bean;
    }

    @Bean
    public FilterRegistrationBean webStartFilter(){
        // 设置文件过滤，避免监控后台无样式
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        filterRegistrationBean.setFilter(new WebStatFilter());
        Map<String, String> initParams = new HashMap<>();
        initParams.put("exclusions", "*.js,*.css,/druid/*");
        filterRegistrationBean.setInitParameters(initParams);
        return filterRegistrationBean;
    }
}
```

#### 3.3.2、 `yaml` 配置文件

```yaml
spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource

    druid:
      #数据源配置，初始化大小、最小、最大
      initialSize: 5
      minIdle: 5
      maxActive: 20
        #连接等待超时时间
      maxWait: 60000
        #配置隔多久进行一次检测(检测可以关闭的空闲连接)
      timeBetweenEvictionRunsMillis: 60000
        #配置连接在池中的最小生存时间
      minEvictableIdleTimeMillis: 300000
      validationQuery: SELECT 1 FROM DUAL
      testWhileIdle: true
      testOnBorrow: false
      testOnReturn: false
        # 打开PSCache，并且指定每个连接上PSCache的大小
      poolPreparedStatements: true
      maxPoolPreparedStatementPerConnectionSize: 20
        # 配置监控统计拦截的filters，去掉后监控界面sql无法统计，'wall'用于防火墙
      filters: stat,wall,log4j
        # 通过connectProperties属性来打开mergeSql功能；慢SQL记录
      connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=5000

      url: jdbc:mysql://localhost:3306/
      username: xxxxx
      password: xxxxx
      driver-class-name: com.mysql.cj.jdbc.Driver
```

### 3.4、测试

![image-20200804113129824](E:\PerFile\notes\markdown\后端开发\微服务\Spring Boot\photo\12、测试结果1（6）.png)

![image-20200804113013282](photo\13、测试结果2（6）.png)

 

