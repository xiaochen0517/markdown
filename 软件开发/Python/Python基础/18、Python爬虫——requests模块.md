# Python爬虫——requests模块

## 一、下载request模块

### 1.1使用pip命令下载

- `pip install requests`

### 1.2使用Pycharm下载

- 打开`File`->`Settings`->`Project:项目名`->`Project Interpreter`->点击右侧加号->搜索`requests`->点击`Install Package`

## 二、使用详解

### 2.1发送请求

#### 2.1.1发送get请求

- 语法

```python
import requests

requests.get(请求地址)  # 返回一个Response对象
```

- 实例

```python
import requests

url = "http://www.baidu.com"
req = requests.get(url)
print(req)
```

- 运行结果：`<Response [200]>`

#### 2.1.2发送post请求

- 语法

```python
import requests

requests.post(请求地址, data={请求体字典})
```

- 示例

```python
import requests

query_data = {"inputtext": "你好啊",
              "type": "AUTO"}

url = "http://m.youdao.com/translate"

res = requests.post(url, data=query_data)

print(res)  # <Response [200]>
```

### 2.2获取响应

#### 2.2.1获取response内容

- 语法：`response.text`
- 解决乱码：`response.encoding = "utf-8"`

```python
res.encoding = "utf-8"
print(res.text)
```

#### 2.2.2获取response二进制字节流

- 语法：`response.content.decode()`
- 作用：将`response`的二进制字节流（`response.content`）转换为`str`类型

#### 2.2.3获取网页正确解码后源码的方式

- `response.content.decode()`
- `response.content.decode("gbk")`
- `response.text`

#### 2.2.4其他方法

| 语法                     | 描述                  |
| ------------------------ | --------------------- |
| response.requeset.url    | 发送请求的url地址     |
| response.url             | response响应的url地址 |
| response.request.headers | 请求头                |
| response.headers         | 响应请求              |



### 2.3发送带header的请求

- 使用字典来设置header
- 语法：`requests.get(url, headers=headers)`

### 2.4使用超时参数

- 语法：`requests.get(url, timeout=【时间（秒）】)`

### 2.5使用retrying模块

#### 2.5.1下载

- `pip install retrying`

#### 2.5.2使用语法

```python
from retrying import retry
@retry(stop_max_attempt_number=【次数】)
```

#### 2.5.3示例

```python
from retrying import retry


@retry(stop_max_attempt_number=3)
def a():
    print("hello")
    raise ValueError("this is test")


a()
```

### 2.6处理cookie

#### 2.6.1请求时携带cookie的方法

- 将cookie放在headers中

```python
headers = {"User-Agent":"......", "Cookie":"cookie 字符串"}
```

- cookie字典传给cookies参数

```python
requests.get(url, cookies=cookie_dict)
```

- 先发送post请求，获取cookie，带上cookie请求后登录后的页面
  - `session = requests.session()` `session`具有的方法和`requests`一样
  - `session.post(url,data,headers)` 服务器设置在本地的`cookie`会保存在`session`中
  - `session.get(url)` 再次请求时会携带保存在`session`中的`cookie`