# Spring MVC 拦截器

## 1、概述

`Spring MVC` 的处理器拦截器类似于 `Servlet` 开发中的过滤器 `Filter` 用于对处理器进行预处理和后处理。开发者可以自定义一些连接器来实现特定的功能。

## 2、自定义拦截器

### 2.1、配置类

`MyInterceptor.java` 

```java
public class MyInterceptor implements HandlerInterceptor {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("preHandle");
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle");
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("afterCompletion");
    }
}
```

### 2.2、配置文件

`spring-mvc.xml` 

```xml
<mvc:interceptors>
    <mvc:interceptor>
        <mvc:mapping path="/**"/>
        <bean class="com.lxc.config.MyInterceptor"/>
    </mvc:interceptor>
</mvc:interceptors>
```

