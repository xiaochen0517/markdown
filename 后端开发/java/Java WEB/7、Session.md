## Session

#### 概念

- 服务器端会话技术，在一次会话中多次请求间共享数据，将数据保存在服务器端的对象中。HttpSession

#### 快速入门

- 使用HttpSession：
  - Object getAttribute(String name)
  - void setAttribute(String name, Object value)
  - void removeAttribute(String name)
- 获取HttpSession对象
  - request.getSession();

#### 原理

- 依赖Cookie在服务器储存数据

#### 浏览器关闭后session不同

- 为JSESSIONID设置过期时间

- ```java
  Cookie cookie = new Cookie("JSESSIONID", session.getId());
  cookie.setMaxAge(60*60);
  resp.addCookie(cookie);
  ```

#### 服务器重启Session钝活化

- 钝化
  - 在服务器正常关闭之前，将session对象序列化到硬盘中
- 活化
  - 子啊服务器启动后，将session文件转化为内存中的session对象即可
- Tomcat会自动完成此操作

#### session销毁

- 服务器关闭
- session对象调用invalidate()方法
- session默认时效时间为30分钟
  - 配置方法：web.xml
  - session-timeout

#### session的特点

- 用于储存一次会话的多次请求的数据
- 可以储存任何类型、任意大小的数据
- 数据存储在服务器端
- 数据相对安全

> session:主菜
>
> cookie：甜点