# Servlet（server applet）

#### 概念

- 运行在服务器端的程序
  - Servlet就是一个接口，定义了Java类被浏览器访问到（tomcat识别）的规则。
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
  - 查找web.xml文件，是否有对应的\<url-pattern\>标签体内容。
  - 如果有，则找到对应的\<servlet-class\>全类名。
  - tomcat会将字节码文件加载进内存，并且创建其对象。
  - 调用service方法

- Servlet生命周期
  - init()：在servlet被创建时执行，只会执行一次。
    - init方法只会执行一次，Servlet为
    - 创建Servlet有两种状态
      - 启动服务器创建Servlet
      - 在访问时创建
      - 使用\<load-on-startup\>修改
      - 当值为负数时表示在访问时创建
      - 当值为0或正整数时表示在启动服务器时创建
  - service()：提供服务，每一次访问就会执行。
  - destroy()：在服务器关闭时执行。
  - getServletConfig()：获取ServletConfig对象
  - getServletInfo()：获取Servlet信息

#### Servlet3.0

- 支持注解配置。可以不需要web.xml
- 步骤
  - 创建JavaEE项目，选择Servlet3.0以上版本，不创建web.xml。
  - 定义类，实现Servlet接口
  - 复写方法
  - 再类上使用@WebServlet注解，进行配置

```java
@WebServlet("/demo")
```

#### IDEA与Tomcat的相关配置

- idea会为每个tomcat项目单独创建一份配置文件。
  - 路径再启动服务器控制台打印：VersionLoggerListener.log CATALINA_BASE:
- 工作空间项目 与 tomcat部署的web项目。
  - tomcat真正访问的是“tomcat部署的web项目”，“tomcat部署的web项目”对应着“工作空间项目”的web目录下的所有资源。
  - WEB-INF目录下的资源不能被浏览器直接访问。
  - 在代码中添加断点，使用debug启动进行调试。

#### Servlet体系结构

Servlet--接口

​	|

GenericServlet--抽象类，将Servlet接口中的方法默认空实现，继承此类只需要重写service方法。

​	|

HttpServlet--抽象类，对http协议的一种封装，简化操作。

- 定义类继承HttpServlet
- 复写doGet、doPost方法

#### Servlet配置

- urlpartten：Servlet访问路径
  - 一个Servlet可以定义多个访问路径
  - 路径定义规则
    - /xxx：单层路径
    - /xxx/xxx：多层路径
    - /xxx/*：使用通配符
    - *.do：后缀