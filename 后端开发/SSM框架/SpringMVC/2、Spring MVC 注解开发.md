# Spring MVC 注解开发

## 1、配置文件

### 1.1、 项目配置

#### 1.1.1、 `servlet` 配置

`web.xml`

```xml
<servlet>
    <servlet-name>dispatcherServlet</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
    <servlet-name>dispatcherServlet</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

#### 1.1.2、资源过滤配置

`pom.xml`

```xml
    <build>
        <resources>
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>false</filtering>
            </resource>
            <resource>
                <directory>src/main/resources</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>false</filtering>
            </resource>
        </resources>
    </build>
```

### 1.2、 `spring` 配置文件

#### 1.2.1、扫描配置

```xml
<!--需要扫描的包-->
<context:component-scan base-package="com.lxc.controller"/>

<!--不处理静态资源-->
<mvc:default-servlet-handler/>

<!--注解支持-->
<mvc:annotation-driven/>
```

#### 1.2.2、视图解析配置

```xml
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" id="internalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/jsp/"/>
    <property name="suffix" value=".jsp"/>
</bean>
```

## 2、代码注解

```java
// 直接返回String，不进行视图解析
// @RestController
@Controller
public class HelloController {

    /**
     * 使用 @RequestMapping 指定访问路径，若在类上添加此注解则表示嵌套关系，类在前方法在后
     */
    @RequestMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("msg", "Hello Spring MVC");
        return "hello";
    }
}
```

