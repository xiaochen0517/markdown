## ServletContext

#### 概念

- 代表整个web应用，可以和程序的容器（服务器）来通信。

#### 获取ServletContext

- 通过request对象获取
- 通过HttpServlet获取
- 无论通过那种方式获取到的ServletContext都是同一个对象

#### 功能

- 获取MIME类型

  - 在互联网通信中定义的一种文件数据类型

  - 格式：大类型/小类型、text/html、image/jpeg

  - 获取：String getMimeType(String file)

  - ```java
    //获取ServletContext
    ServletContext sc = this.getServletContext();
    //定义文件名
    String filename = "a.jpg";
    //使用文件名获取mime类型
    String mimeType = sc.getMimeType(filename);
    System.out.println(mimeType);
    ```

- 域对象：共享数据

  - setAttribute(String name, Object value)

  - getAttribute(String name)

  - removeAttribute(String name)

  - ServletContext对象的范围：所有用户的请求数据

  - ```java
    //testcontext1
    ServletContext sc = this.getServletContext();
            sc.setAttribute("msg", "hahaha");
    
    //testcontext2
    ServletContext sc = this.getServletContext();
            String msg = (String) sc.getAttribute("msg");
            System.out.println(msg);
    ```

- 获取文件的真实路径

  - getRealPath("")：获取真实路径

  - web目录下的文件会在getRealPath方法获取到的路径下

  - src目录下的文件会在getRealPath方法获取的路径下的WEB-INF下的classes下

  - ```java
    ServletContext sc = this.getServletContext();
    System.out.println(sc.getRealPath(""));
    ```
