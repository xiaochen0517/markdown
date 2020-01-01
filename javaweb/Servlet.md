# Servlet（server applet）

#### 概念

- 运行在服务器端的小程序
  - Servlet就是一个借口，定义了Java类被浏览器访问到（tomcat识别）的规则。
  - 自定义类，实现Servlet接口，复写方法。
- 快速配置
  - 新建类，实现Servlet接口
  - 在web.xml中配置

```xml
<servlet>
        <servlet-name>mainclass</servlet-name>
        <servlet-class>com.lxc.MainClass</servlet-class>
    </servlet>

    <servlet-mapping>
        <servlet-name>mainclass</servlet-name>
        <url-pattern>/main</url-pattern>
    </servlet-mapping>
```

- 执行原理：
  - 当服务器 接收到客户端浏览器的请求会解析请求的URL路径，获取访问的Servlet资源路径。
  - 查找web.xml文件，是否有对应的<url-pattern>标签体内容。
  - 如果有，则找到对应的<servlet-class>全类名。
  - tomcat会将字节码文件加载进内存，并且创建其对象。
  - 调用service方法

