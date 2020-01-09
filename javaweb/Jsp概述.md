## JSP

#### 概念

- Java Server Pages：java服务器端界面
- 动态页面

#### 原理

- 本质为Servlet

#### jsp脚本

- 在jsp中定义java代码

- <% 代码 %>：相当与main方法

- <%! 代码 %>：在jsp转换后的java类的成员位置
- <%= 代码 %>：相当于输出语句，可以将内容输出到页面上

#### 内置对象

- 概念：在jsp页面中不需要获取和创建，就可以直接使用的对象
变量名|真实类型|作用
--|--|--
request|HttpServletRequest|一次请求访问的多个资源
response|HttpServletResponse|响应对象
out|JspWriter|输出对象，数据输入到页面上
pageContext|PageContext|当前页面共享数据
session|HttpSession|一次会话的多个请求间session
application|ServletContext|所用用户共享数据
page|Object|当前页面Servlet的对象 this
config|ServletConfig|Servlet的配置对象
exception|Throwable|异常对象