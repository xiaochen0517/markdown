#### MVC介绍

- M：Model，模型JavaBean
  - 完成具体的业务操作
- V：View，视图JSP
  - 展示数据
- C：Controller，控制器Servlet
  - 获取用户的输入
  - 调用模型
  - 将数据交给视图进行展示

- 优点
  - 耦合性低，方便维护，便于分工协作
  - 重用性高
- 缺点
  - 使得项目架构变得复杂

#### EL表达式

- 概念：Expression Language 表达式语言

- 作用：替换和简化jsp页面中java代码的编写
- 语法：${表达式}
- 注意
  - jsp默认支持el表达式
  - 忽略el表达式
    - page指令中添加isELIgnored为true
    - 在$符号前加\
- 使用
  - 运算
    - 运算符
      - 算术运算符
        - +-*（div）/（mod）
      - 比较运算符
        - \>  \<  \>=  \<=  ==  !=
      - 逻辑运算符
        - &&（and）||（or）！（not）
      - 空运算符
        - empty
        - 用于判断字符串、集合、数组对象是否为null并且长度是否为0
        - not empty：与empty相反
  - 获取值
    - el表达式只能从域对象中获取值
    - 语法：
      - ${域名称.键名}：从指定域中获取指定键的值
      - ${键名}：依次从最小的域中开始查找是否有对应的值
    - 域名称
      - pageScope --pageContext
      - requestScope--request
      - sessionScope--session
      - applicationScope--application
    - 获取对象
      - ${域名.键名.属性名}
    - 获取list集合
      - ${域名.键名[索引]}
    - 获取Map集合
      - ${域名.键名.key名称}
- 隐式对象
  - pageContext
    - 获取jsp其他八个对象
    - ${pageContext.request.contextPath}：动态获取虚拟目录