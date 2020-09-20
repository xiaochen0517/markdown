# Request&Response

#### 请求流程

- tomcat服务器根据url中的路径，创建对应的Servlet对象。
- 创建request和response对象，将请求消息数据封装到Request中。
- 将Request和response传递给service方法，并调用。
- 将方法中设置的response对象的消息数据进行响应。
#### request和response的原理
  - request和response由服务器创建。
  - request用来获取请求消息，response用来设置响应消息。

#### request对象继承结构
- ServletRequest：接口
- HttpServletRequest：接口
- RequestFacade：类

#### Request
- 获取请求消息
   - 获取请求行
     - String getMethod()：获取请求方式
     - String getContextPath()：获取虚拟目录
     - String getServletPath()：获取Servlet路径
     - String getQueryString()：获取get方式请求参数
     - String getRequestURI()：获取请求uri
     - StringBuffer getRequestURL()：获取url
     - String getProtocol()：获取协议及协议版本
     - String getRemoteAddr()：获取客户机IP地址
     
   - 获取请求头
   
     - String getHeader(String name)：通过名称获取请求头的值
   
     - Enumeration\<String\> getHeaderNames()：获取所有的请求头名称
   
     - ```java
       /**
                * 获取请求头
                */
               Enumeration<String> enumerations = req.getHeaderNames();
               while (enumerations.hasMoreElements()){
                   String name = enumerations.nextElement();
                   System.out.println(name + "---->" + req.getHeader(name));
               }
       ```
   
   - 获取请求体
   
     - 只有post请求方式才有请求体。
     - 步骤
       - 获取流对象
         - BufferedReader getReader()：获取字符输入流，只能操作字符数据。
         
         - ```java
           BufferedReader reader = req.getReader();
                   char[] chars = new char[1024];
                   int len = 0;
           
                   while ((len = reader.read(chars)) != -1){
                       System.out.println(new String(chars, 0, len));
                   }
                   reader.close();
           ```
         
         - ServletInputStream getInputStream()：获取字节输入流，可以操作所有类型的数据。
         
       - 再从流对象中获取数据
     
   - 其他方法
   
     - 获取请求参数
   
       - String getParameter(String name)：根据参数名称获取参数值
   
       - ```java
         System.out.println("username--"+req.getParameter("username"));
                 System.out.println("password--"+req.getParameter("password"));
                 System.out.println("commit--"+req.getParameter("commit"));
         ```
   
       - String[] getParameterValues(String name)：根据参数名称获取参数值的数组
   
       - ```java
         String[] checkboxs = req.getParameterValues("checkbox");
         for (String checkbox:checkboxs)
             System.out.println(checkbox);
         ```
   
       - Enumeration\<String\> getParameterNames()：获取所有请求参数的名称
   
       - ```java
         Enumeration<String> keynames = req.getParameterNames();
         while (keynames.hasMoreElements()){
             String key = keynames.nextElement();
             String value = req.getParameter(key);
             System.out.println(key +"--"+ value);
         
         }
         ```
   
       - Map<String, String[]> getParameterMap()：获取所有参数的map集合
   
       - ```java
         Map<String, String[]> mapStrs = req.getParameterMap();
         Set<String> keys = mapStrs.keySet();
         for (String key : keys) {
             String[] values = mapStrs.get(key);
             for (String value : values) {
                 System.out.println(key + "--" + value);
             }
         }
         ```
   
     - 请求转发
   
       - 一种在服务器内部的资源跳转方式
       - 获取请求转发器RequestDispatcher getRequestDispatcher(String path)
       - 转发forward(ServletRequest request, ServletResponse response)
       - 浏览器路径不发生变化
       - 只能访问当前服务器内部资源
       - 浏览器只发送一次请求
   
     - 共享数据
   
       - 域对象：一个有作用范围的对象，可以再范围内共享数据。
       - request域2：代表一次请求的范围，一般用于请求转发的多个资源中共享数据。
       - void setAttribute(String name,Object obj)：储存数据
       - Object getAttribute(String name)：通过键获取值
       - void removeAttribute(String name)：通过键移除数据
   
     - 获取ServletContext
   
       - ServletContext getServletContext()：获取ServletContext
   
   - 解决中文乱码
   
     - ```java
       req.setCharacterEncoding("utf-8");
       ```

- BeanUtils工具类，简化数据封装

  - 用于封装JavaBean
  - JavaBean：标准的Java类
  - 类必须被public修饰
  - 必须提供空参的构造器
  - 成员变量必须使用private修饰
  - 提供公共的setter和getter方法
  - JavaBean功能
  - 数据封装
  - 方法
    - setProperty()
    - getProperty()
    - populate(Object obj, Map map):将map集合中的键值对信息，封装到对应的JavaBean对象中。

- Response

  - 设置响应行

    - 设置状态码：setStatus(int sc)

  - 设置响应头

    - setHeader(String name, String value)

  - 设置响应体

    - 获取输出流
      - 字符输出流
        - PrintWriter getWriter()
      - 字节输出流
        - ServletOutputStream getOutputStream()
    - 使用输出流

  - 重定向（redirect）

    - ```java
      resp.setStatus(302);
      resp.setHeader("location", "testresp2");
      ```

    - 重定向会发送两次请求

    - 重定向可以访问外部网站

    - 路径

      - 相对路径
        - 通过相对路径不可以确定唯一资源
      - 绝地路径
        - 通过绝对路径可以确定唯一资源
        - 客户端使用：需要加虚拟目录
          - 建议动态获取：req.getContextPath()
        - 服务器：不需要虚拟目录
    
  - 服务器输出字符数据到浏览器
  
    - ```java
      //解决中文乱码
      resp.setCharacterEncoding("utf-8");
      resp.setHeader("content-type", "text/html;charset=utf-8");
      
      PrintWriter pw = resp.getWriter();
      pw.write("Hello World!");
      ```
  
  - 服务器输出字节流数据到浏览器
  
    - ```java
      resp.setContentType("text/html;charset=utf-8");
      
      ServletOutputStream os = resp.getOutputStream();
      os.write("你好啊".getBytes());
      ```