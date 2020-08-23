# Spring MVC 数据接收发送处理

## 1、转发重定向

### 1.1、传统方式

#### 1.1.1、转发

```java
@RequestMapping("/d")
public void hello3(HttpServletRequest req, HttpServletResponse resp){
    try {
        req.getRequestDispatcher("/WEB-INF/jsp/success.jsp").forward(req, resp);
    } catch (ServletException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

#### 1.1.2、重定向

```java
@RequestMapping("/c")
public void hello2(HttpServletRequest req, HttpServletResponse resp){
    try {
        resp.sendRedirect("/index.jsp");
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### 1.2、 `Spring MVC` 方式

#### 1.2.1、转发

```java
@RequestMapping("/a")
public String hello(Model model) {
    model.addAttribute("msg", "Hello Spring MVC");
    return "hello";
}
```

以上的方式本质上也属于转发，也可以使用关键词进行转发并不通过解析器添加前后缀。

```java
@RequestMapping("/f")
public String hello5(HttpServletRequest req, HttpServletResponse resp){
    return "forward:/WEB-INF/jsp/success.jsp";
}
```

#### 1.2.2、重定向

```java
@RequestMapping("/e")
public String hello4(HttpServletRequest req, HttpServletResponse resp){
    return "redirect:/index.jsp";
}
```

## 2、数据处理

### 2.1、处理提交数据

#### 2.1.1、请求数据键名与参数名相同

若当请求数据的键名与参数名相同时 `Spring MVC` 会直接将数据赋值到参数中。

地址： `http://localhost:8080/hello/g?name=zhangsan` 

```java
@RequestMapping("/g")
public String hello6(String name){
    System.out.println(name);
    return "success";
}
```

#### 2.1.2、请求数据键名与参数名不同

可以在参数上使用注解 `@RequestParam(KeyName)` 指定键名向参数中进行赋值。

地址： `http://localhost:8080/hello/g?username=zhangsan` 

```java
@RequestMapping("/g")
public String hello6(@RequestParam("username") String name){
    System.out.println(name);
    return "success";
}
```

> 在实际开发过程中无论是否键名与参数名相同否，都添加此注解。

#### 2.1.3、接收参数为对象

当接收参数为对象时， `Spring MVC` 会将请求的数据键名与对象的属性名对比，若相同则会赋值到对象属性中，不同则为 `null` 。

地址： `http://localhost:8080/hello/h?name=zhangsan&sex=man` 

```java
@RequestMapping("/h")
public String hello7(User user){
    System.out.println(user);
    return "success";
}
```

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class User implements Serializable {

    private String username;
    private String sex;

}
```

### 2.2、数据显示到前端

#### 2.2.1、使用 `ModelAndView` 

```java
@RequestMapping("/i")
public ModelAndView hello8(){
    ModelAndView mv = new ModelAndView();
    // 添加数据
    mv.addObject("msg", "hello world");
    // 设置视图
    mv.setViewName("/WEB-INF/jsp/success.jsp");
    return mv;
}
```

#### 2.2.2、使用 `ModelMap` 

`ModelMap` 继承了 `LinkedHashMap` 除了自身特性之外，还继承了 `LinkedHashMap` 的方法和特性。

基础用法同 `Model` 相同。

#### 2.2.3、使用 `Model` 

```java
@RequestMapping("/a")
public String hello(Model model) {
    // 添加数据
    model.addAttribute("msg", "Hello Spring MVC");
    // 设置视图
    return "hello";
}
```

## 3、乱码问题解决

### 3.1、请求乱码

#### 3.1.1、创建过滤器

```java
public class EncodingFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        chain.doFilter(req,resp);
    }

    public void destroy() {
    }
}
```

#### 3.1.2、配置过滤器

```xml
<filter>
    <filter-name>encodingFilter</filter-name>
    <filter-class>com.lxc.filter.EncodingFilter</filter-class>
</filter>

<filter-mapping>
    <filter-name>encodingFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

#### 3.1.3、直接使用 `Spring MVC` 自带过滤器

```xml
<filter>
    <filter-name>encodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
</filter>

<filter-mapping>
    <filter-name>encodingFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

> 直接使用 `Spring VMC` 过滤器无需手动创建

### 3.2、响应乱码

#### 3.2.1、使用注解解决

```java
@RequestMapping(produces = "application/json;charset=UTF-8")
```

#### 3.2.2、使用配置文件

```xml
<mvc:annotation-driven>
    <mvc:message-converters register-defaults="true">
        <bean class="org.springframework.http.converter.StringHttpMessageConverter">
            <constructor-arg value="UTF-8"/>
        </bean>
        <bean class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter">
            <property name="objectMapper">
                <bean class="org.springframework.http.converter.json.Jackson2ObjectMapperFactoryBean">
                    <property name="failOnEmptyBeans" value="false"/>
                </bean>
            </property>
        </bean>
    </mvc:message-converters>
</mvc:annotation-driven>
```

