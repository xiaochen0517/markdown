# Python爬虫——数据提取

## 一、json格式

### 1.1json字符串转python数据格式

- `json.loads()`
  - 将json字符转换为Python类型
  - `json.loads(json字符串)`

### 1.2python数据格式转json字符串

- `json.dumps`
  - 把python类型转换为json字符串
  - `json.dumps({})`
  - `json.dumps(ret1, ensure_ascii=False, indent=2)`
    - `ensure_ascii`：是否将中文转换为ASCII码，默认为True
    - `indent`：让下一行在上一行的基础上空指定位置

## 二、xpath和lxml

### 2.1xpath

一门从html中提取数据的语言

#### 2.1.1xpath语法

- xpath helper插件：帮助我们从`elements`中定位数据
- 选择节点（标签）
  - `/`：选中指定的标签
  - `//`：从任意节点开始选择，相当于通配符`*`
- 筛选：`@`
  - 定位元素：`【标签名】[@此标签下的属性名=属性中的值]`
    - 例如：`//div[@class='classname']/ul/li`
  - 获取属性值：`@属性名`
    - 例如：`//div/ul/li/a/@herf`

- 获取标签中的文本：`/text()`
  - `a//text()`获取a标签以及a标签下所有元素中的文本

### 2.2lxml

#### 2.2.1安装

- 安装：`pip install lxml`

#### 2.2.2使用

```python
from lxml import etree
element = etree.HTML("html字符串")
element.xpath("xpath语法")
```

#### 2.2.3示例

- 有道翻译

```python
import requests
from lxml import etree


url = "http://www.youdao.com/w/{}/"

word = input('请输入要翻译的内容：')

response = requests.get(url.format(word))

element = etree.HTML(response.content.decode())

xpath = element.xpath("//div[@id='webTransToggle']//div[@class='title']/span/text()")

xpath = [i.strip() for i in xpath]

print(xpath)
```

