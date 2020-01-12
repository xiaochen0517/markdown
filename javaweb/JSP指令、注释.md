## JSP指令

#### 作用

- 用于配置JSP页面，导入资源文件

#### 格式

- ```jsp
  <%@ 指令名称 属性名1=属性值1 ...%>
  ```

#### 分类

- page：配置jsp页面

  - contentType等同于response.setContentType()
    - 设置响应体的mime类型以及字符集
    - 设置当前jsp页面的编码（只有高级开发工具可以生效，其余需要pageEncodeing属性）
  - language：语言
  - buffer：缓冲区
  - import：导包（推荐一包一行）
  - errorPage：当前页面发生异常自动跳转到指定页面
  - idErrorPage：标识当前页面是否为异常跳转页面
    - 为true是可以使用exception

- include：页面导入资源文件，包含页面

  - ```jsp
    <%@ include file="要包含的文件名"%>
    ```

- taglib：导入资源

  - ```jsp
    <%@ taglib prefix="前缀" uri=""%>
    ```

## 注释

- HTML注释
  - \<!-- --\>：只能注释html代码
- jsp注释（推荐）
  - <%-- --%>：可以注释所有

