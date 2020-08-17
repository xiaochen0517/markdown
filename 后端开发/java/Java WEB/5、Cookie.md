## Cookie

#### 会话

- 一次会话中包含多次请求与响应
- 功能：共享数据
- 方式：
  - 客户端会话技术：Cookie
  - 服务器端会话技术：Session

#### Cookie

- 概念：客户端会话技术，将数据保存到客户端
- 步骤
  - 创建Cookie对象，绑定数据
    - new Cookie(String name, String value)
  - 发送Cookie对象
    - response.addCookie(Cookie cookie)
  - 获取Cookie，获取数据
    - request.getCookies()

- 实现原理
  - 基于响应头set-cookie和请求头cookie实现的
- 常用方法
  - setMaxAge：设置Cookie存活时间
  - setPath(String path)：设置Cookie的获取范围，若需要共享，则设置“/”
  - setDomain(String path)：参数为域名，同一域名的子域名Cookie共享

- 特点和作用
  - cookie储存数据在客户端浏览器
  - 浏览器对于单个cookie的大小有限制（4kb）数量限制（20个）
  - 一般用于存储少量的不太敏感的数据
  - 在不登录状态下，完成服务器对客户端的身份识别

