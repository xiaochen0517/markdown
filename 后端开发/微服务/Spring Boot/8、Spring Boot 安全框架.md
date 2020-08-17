# Spring Boot 安全框架

## 1、 `Spring Security` 

### 1.1、概述

`Spring Security` 是一个能够为基于 `Spring` 的企业应用系统提供声明式的安全访问控制解决方案的安全框架。它提供了一组可以在 `Spring` 应用上下文中配置的 `Bean` ，充分利用了 `Spring IoC` ， `DI` （控制反转 `Inversion of Control  `, `DI:Dependency Injection` 依赖注入）和 `AOP` （面向切面编程）功能，为应用系统提供声明式的安全访问控制功能，减少了为企业系统安全控制编写大量重复代码的工作。

- `WebSecurityConfigurerAdapter` ：自定义 `Security` 策略
- `AuthenticationManagerBuilder` ：自定义认证策略
- `@EnableWebSecurity` ：开启 `WebSecurity` 模式

`Spring Security` 的两个主要目标是“认证”和”授权“（访问控制）

- `Authentication` ：认证
- `Authorization` ：授权

### 1.2、配置使用

#### 1.2.1、导入 `jar` 包

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

#### 1.2.2、配置类

```java
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    /**
     * 认证方法
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // 首页都可以访问，功能页需要权限
        http.authorizeRequests()
                .antMatchers("/").permitAll()
                .antMatchers("/level1/**").hasRole("vip1")
                .antMatchers("/level2/**").hasRole("vip2")
                .antMatchers("/level3/**").hasRole("vip3");
        // 开启登录功能
        http.formLogin();
        // 注销成功后跳转到主页
        http.logout().logoutSuccessUrl("/");
    }

    /**
     * 授权方法
     * @param auth
     * @throws Exception
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        /**
         * 版本为 spring boot 2.1.x 可以不用使用密码加密
         * 在 spring boot 2.1.x 之上版本需要使用密码加密
         * 加密方式 .passwordEncoder(new XXXPasswordEncoder())
         */
        auth.inMemoryAuthentication().passwordEncoder(new BCryptPasswordEncoder())
                .withUser("admin").password(new BCryptPasswordEncoder().encode("admin")).roles("vip1","vip2","vip3")
                .and().withUser("vip1").password(new BCryptPasswordEncoder().encode("admin")).roles("vip1")
                .and().withUser("vip2").password(new BCryptPasswordEncoder().encode("admin")).roles("vip1","vip2")
                .and().withUser("vip3").password(new BCryptPasswordEncoder().encode("admin")).roles("vip1","vip2","vip3");
    }
}
```

#### 1.2.3、整合 `thymeleaf` 

- 导入包

```xml
<dependency>
    <groupId>org.thymeleaf.extras</groupId>
    <artifactId>thymeleaf-extras-springsecurity5</artifactId>
    <version>3.0.4.RELEASE</version>
</dependency>
```

> 若 `spring boot` 版本为 `2.1.x` 则使用 `thymeleaf-extras-springsecurity4` 

- `index.html` 

```html
<!DOCTYPE html>
<!--导入相关约束-->
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/extras/spring-security">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>index</h1>
<!--若已登录则显示注销链接-->
<div sec:authorize="isAuthenticated()">
    <a th:href="@{/logout}">logout</a>
</div>

<!--未登录显示登录链接-->
<div sec:authorize="!isAuthenticated()">
    <a th:href="@{/login}">login</a>
</div>
<br>
<!--显示用户名以及权限-->
<div sec:authorize="isAuthenticated()">
    <div sec:authentication="name"></div>
    <div sec:authentication="principal.authorities"></div>
</div>
<br>
<!--有指定的权限则显示相关链接-->
<div sec:authorize="hasRole('vip1')">
    <a th:href="@{/level1/1}">1-1</a>
</div>
<br>
<div sec:authorize="hasRole('vip2')">
    <a th:href="@{/level2/1}">2-1</a>
</div>
<br>
<div sec:authorize="hasRole('vip3')">
    <a th:href="@{/level3/1}">3-1</a>
</div>
</body>
</html>
```

#### 1.2.4、自定义登录页

- `html`

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity5">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<form th:action="@{/login}" method="post">
    <input placeholder="Username" name="username" type="text">
    <input placeholder="Password" name="password" type="password">
    <input name="remember" type="checkbox">记住我
    <input type="submit">
</form>
</body>
</html>
```

- 配置

```java
// 开启登录功能
http.formLogin().loginPage("/tologin").loginProcessingUrl("/login");
// 注销成功后跳转到主页
http.logout().logoutSuccessUrl("/");
http.rememberMe().rememberMeParameter("remember");
```

### 1.3、解决任意接口跳转 `login` 界面

#### 1.3.1、 `spring boot` 小于 2.0

添加配置文件

```xml
security.basic.enabled=false
```

#### 1.3.2、 `spring boot` 大于 2.0

```java
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests().anyRequest().permitAll().and().logout().permitAll();
    }
}
```

### 1.4、解决自定义登录页后 `404` 错误

`spring security` 默认开启csrf跨域请求伪造，关闭此功能可以解决此错误（有安全隐患）。

将注销请求方法设置为 `post` 即可

## 2、 `Shiro` 

### 2.1、概述

`Apache Shiro`是一个强大且易用的Java安全框架,执行身份验证、授权、密码和会话管理。使用`Shiro`的易于理解的`API`,您可以快速、轻松地获得任何应用程序,从最小的移动应用程序到最大的网络和企业应用程序

三个核心组件：`Subject`, `SecurityManager `和 `Realms`.

- `Subject`：即“当前操作用户”。但是，在`Shiro`中，`Subject`这一概念并不仅仅指人，也可以是第三方进程、后台帐户（`Daemon Account`）或其他类似事物。它仅仅意味着“当前跟软件交互的东西”。`Subject`代表了当前用户的安全操作，SecurityManager则管理所有用户的安全操作

- `SecurityManager`：它是`Shiro`框架的核心，典型的`Facade`模式，`Shiro`通过`SecurityManager`来管理内部组件实例，并通过它来提供安全管理的各种服务。
- `Realm`： `Realm`充当了`Shiro`与应用安全数据间的“桥梁”或者“连接器”。也就是说，当对用户执行认证（登录）和授权（访问控制）验证时，Shiro会从应用配置的Realm中查找用户及其权限信息。从这个意义上讲，`Realm`实质上是一个安全相关的`DAO`：它封装了数据源的连接细节，并在需要时将相关数据提供给`Shiro`。当配置`Shiro`时，你必须至少指定一个`Realm`，用于认证和（或）授权。配置多个`Realm`是可以的，但是至少需要一个。

`Shiro`内置了可以连接大量安全数据源（又名目录）的`Realm`，如`LDAP`、关系数据库（`JDBC`）、类似`INI`的文本配置资源以及属性文件等。如果缺省的`Realm`不能满足需求，你还可以插入代表自定义数据源的自己的`Realm`实现。

[官网](http://shiro.apache.org/) 

![](http://shiro.apache.org/assets/images/apache-shiro-logo.png).

### 2.2、快速配置

#### 2.2.1、导入包

```xml
<dependency>
    <groupId>org.apache.shiro</groupId>
    <artifactId>shiro-spring-boot-web-starter</artifactId>
    <version>1.5.3</version>
</dependency>
```

#### 2.2.2、配置类

- `MyRealm.java` 

```java
public class MyRealm extends AuthorizingRealm {

    private Logger log = LoggerFactory.getLogger(MyRealm.class);

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        log.info("run --> doGetAuthorizationInfo");
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        log.info("run --> doGetAuthenticationInfo");
        return null;
    }
}
```

- `ShiroConfig.java` 

```java
@Configuration
public class ShiroConfig {

    /**
     * 此 Bean 的名称必须为 shiroFilterFactoryBean
     * @param manager
     * @return
     */
    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(@Qualifier("getDefaultWebSecurityManager") DefaultWebSecurityManager manager){
        ShiroFilterFactoryBean factoryBean = new ShiroFilterFactoryBean();
        factoryBean.setSecurityManager(manager);

        Map<String, String> filterMap = new LinkedHashMap<>();

        /**
         * anon：无需认证
         * authc：认证后可访问
         * user：拥有记住我功能可以访问
         * perms：拥有某个资源的权限可以访问
         * role：拥有某个角色的权限可以访问
         */
        // 拦截器可以使用通配符 参数：接口，认证策略
        filterMap.put("/add", "authc");
        filterMap.put("/delete", "authc");
        //filterMap.put("/*", "authc");

        factoryBean.setFilterChainDefinitionMap(filterMap);

        // 设置拦截之后跳转到登录页
        factoryBean.setLoginUrl("/tologin");

        return factoryBean;
    }

    /**
     * 创建管理器
     * @param myRealm
     * @return
     */
    @Bean
    public DefaultWebSecurityManager getDefaultWebSecurityManager(@Qualifier("getMyRealm") MyRealm myRealm){
        DefaultWebSecurityManager manager = new DefaultWebSecurityManager();
        manager.setRealm(myRealm);
        return manager;
    }

    @Bean
    public MyRealm getMyRealm(){
        return new MyRealm();
    }

}
```

#### 2.2.3、登录功能

- `Controller` 

```java
@RequestMapping("/login")
public String login(String username, String password, Model model){
    // 获取到当前用户
    Subject subject = SecurityUtils.getSubject();
    // 创建令牌
    UsernamePasswordToken token = new UsernamePasswordToken(username, password);

    try {
        // 开始登录
        subject.login(token);
        // 登录成功后返回主页
        return "index";
    }catch (UnknownAccountException e){ // 用户名不存在
        log.warn("用户名不存在");
        model.addAttribute("msg", "用户名不存在");
        return "login";
    }catch (IncorrectCredentialsException e){ // 密码错误
        log.warn("密码错误");
        model.addAttribute("msg", "密码错误");
        return "login";
    }
}
```

- `MyRealm` 认证部分

```java
@Override
protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
    log.info("run --> doGetAuthenticationInfo");
    String username = "root";
    String password = "123";
    UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
    if (!token.getUsername().equals(username)){
        return null; // 自动抛出 UnknownAccountException 异常
    }
    // shiro 认证密码
    return new SimpleAuthenticationInfo("",password,"");
}
```

### 2.3、整合 `MyBatis & druid` 

#### 2.3.1、导包

- `shiro` 

```xml
<dependency>
    <groupId>org.apache.shiro</groupId>
    <artifactId>shiro-spring-boot-web-starter</artifactId>
    <version>1.5.3</version>
</dependency>
```

- `druid` 

```xml
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid-spring-boot-starter</artifactId>
    <version>1.1.23</version>
</dependency>
```

- `log4j` 

```xml
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.17</version>
</dependency>
```

- `mybatis` 

```xml
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>2.1.3</version>
</dependency>
```

- `data-jdbc` 

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jdbc</artifactId>
</dependency>
```

- `jdbc` 

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-jdbc</artifactId>
</dependency>
```

- `thymeleaf` 

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
```

- `mysql-connector-java` 

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <scope>runtime</scope>
</dependency>
```

#### 2.3.2、 `log4j` 配置文件

```properties
log4j.rootLogger=INFO, stdout

log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d %p [%c] - %m %n

# General Apache libraries
log4j.logger.org.apache=WARN

# Spring
log4j.logger.org.springframework=WARN

# Default Shiro logging
log4j.logger.org.apache.shiro=INFO

# Disable verbose logging
log4j.logger.org.apache.shiro.util.ThreadContext=WARN
log4j.logger.org.apache.shiro.cache.ehcache.EhCache=WARN
```

#### 2.3.3、主配置文件

```yaml
mybatis:
  type-aliases-package: com.lxc.pojo
  mapper-locations: classpath:mapper/*.xml

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
      # 连接信息
      url: jdbc:mysql://localhost:3306/school?userUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
      username: xxx
      password: xxx
      driver-class-name: com.mysql.cj.jdbc.Driver
```

#### 2.3.4、配置类

- `DruidConfig` 

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

> `shrio` 配置文件同上

#### 2.3.5、目录结构

![image-20200813100741571](photo\16、java目录结构（8）.png).

![image-20200813100941306](photo\17、resources目录结构（8）.png).

#### 2.3.6、从数据库中获取用户

```java
@Override
protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
    log.info("run --> doGetAuthenticationInfo");

    UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
    // 从数据库获取用户名及密码
    User user = userService.findUserByUsername(token.getUsername());
    // 判断是否存在此用户
    if (user == null){ return null;}
    // 认证密码
    return new SimpleAuthenticationInfo("",user.getPassword(),"");
}
```

### 2.4、授权

#### 2.4.1、指定接口所需权限

```java
filterMap.put("/add", "perms[user:add]");
filterMap.put("/delete", "perms[user:delete]");
```

#### 2.4.2、数据库结构

![image-20200813105918003](photo\18、授权数据库结构（8）.png).

#### 2.4.3、授权

- 在登录认证功能中将 `user` 数据传递到授权功能中

![image-20200813110142855](photo\19、授权user传递（8）.png).

- 授权

```java
@Override
protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
    log.info("run --> doGetAuthorizationInfo");
    SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

    Subject subject = SecurityUtils.getSubject();
    // 获取到认证功能中传递的user
    User currentUser = (User) subject.getPrincipal();
    // 授权
    info.addStringPermission(currentUser.getPerms());
    return info;
}
```

### 2.5、整合 `thymeleaf` 

#### 2.5.1、导包

```xml
<dependency>
    <groupId>com.github.theborakompanioni</groupId>
    <artifactId>thymeleaf-extras-shiro</artifactId>
    <version>2.0.0</version>
</dependency>
```

#### 2.5.2、使用

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:shiro="http://www.thymeleaf.org/extras/thymeleaf-shiro">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>index</h1>

<p th:text="${msg}"></p>
<div th:if="${session.get('loginStatus')==null}">
    <a th:href="@{/tologin}">登录</a>
</div>

<div th:if="${session.get('loginStatus')=='true'}">
    <a th:href="@{/tologout}">注销</a>
</div>

<div shiro:hasPermission="user:add">
    <a th:href="@{/add}">add</a>
</div>

<div shiro:hasPermission="user:delete">
    <a th:href="@{/delete}">delete</a>
</body>
</html>
```



