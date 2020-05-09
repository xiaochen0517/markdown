# Listener：监听器

概念：web三大组件之一

- 事件监听机制

  - 事件：一件事情
  - 事件源：事件发生的地方
  - 监听器：一个对象
  - 注册监听：将事件、事件源、监听器绑定在一起。当事件源上发生某个事件后，执行监听器代码。

- ServletContextListener：监听Servletconte对象的创建和销毁

  - void contextDestroy(ServletContextEvent sce)：被销毁之前会调用
  - void contextInitialized(ServletContextEvent sce)：对象创建后会调用

- 步骤

  - 定义类实现ServletContextListener接口

  - 复写方法

  - 配置

    - web.xml

      - ```xml
        <listener></listener>
        ```

    - 注解

      - @WebListener