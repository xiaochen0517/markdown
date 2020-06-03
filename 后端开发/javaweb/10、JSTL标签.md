## JSTL标签

#### 概念

- javaserver pages tag library jsp标准标签库

- 是由apache组织提供的开源的免费的jsp标签

#### 作用

- 用于简化和替换jsp页面上的java代码

#### 使用步骤

- 导入jar包
- 引入标签库：taglib指令：\<%@ taglib %\>
- 使用标签

#### 常用JSTL标签

- if：if

  - 属性：test，接收boolean表达式
    - 若表达式为true，则显示if标签内的内容。
    - 一般结合el表达式使用。

- choose：switch

  - ```jsp
    <%
        request.setAttribute("num", 2);
    %>
    
    <c:choose>
        <c:when test="${num == 1}">1</c:when>
        <c:when test="${num == 2}">2</c:when>
    
        <c:otherwise>other</c:otherwise>
    </c:choose>
    ```

- foreach：for

  - 完成重复操作
    - 属性
      - begin：开始值
      - end：结束值
      - var：临时变量
      - step：步长
      - varStatus：循环状态
        - index：容器中元素的索引，0开始
        - count：循环次数，1开始
      
    - 示例
    
      - ```jsp
        <c:forEach begin="1" end="10" var="i" step="1">
            ${i}<br>
        </c:forEach>
        ```
  - 遍历容器
    - 属性
      - items：容器对象
      - var：容器中元素的临时变量
      - varStatus：循环状态
           - index：容器中元素的索引，0开始
        - count：循环次数，1开始
      
    - 示例
    
      - ```jsp
        <%
            List<String> list = new ArrayList<>();
            list.add("aaa");
            list.add("bbb");
            list.add("ccc");
        
            request.setAttribute("list", list);
        %>
        
        <c:forEach items="${list}" var="str" varStatus="s">
            ${str}<br>
        </c:forEach>
        ```

