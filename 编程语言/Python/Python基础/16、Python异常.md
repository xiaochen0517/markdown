# Python异常

## 一、异常概述

当检测到错误时，解释器就无法继续执行，反而出现了一些错误提示，这就是所谓的“异常”

**实例：**

```python
open('test.txt', 'r')
```

![](photo\程序报错示例.png).

## 二、捕获异常

### 2.1捕获单个异常

#### 2.1.1语法

```python
try:
    可能发生错误的代码
except:
    如果出现异常执行的代码
```

#### 2.1.2示例

```python
try:
    open('test.txt', 'r')
except FileNotFoundError:
    print('打开文件异常')

# 打开文件异常
```

> 注意：
>
> - 如果尝试执行的代码的议程类型和要捕获的异常类型不一致，则无法捕获异常
> - 一般try下只放一行尝试执行的代码

### 2.2捕获多个异常

```python
try:
    print(1/0)
except (NameError, ZeroDivisionError):
    print('有错误')
```

### 2.3捕获异常描述信息

```python
try:
    print(1/0)
except (NameError, ZeroDivisionError) as result:
    print(result)
```

### 2.4捕获所有异常

Exception是所有程序异常类的父类

```python
try:
    print(1/0)
except Exception as result:
    print(result)
```

### 2.5异常的else

else表示的是如果没有异常要执行的代码

```python
try:
    print(1)
except Exception as result:
    print(result)
else:
    print('没有异常执行的代码')
```

### 2.6异常的finally

finally表示的是无论是否异常出现都要执行的代码，例如关闭文件

```python
try:
    f = open('test.txt', 'r')
except Exception as result:
    print(result)
else:
    print('没有异常执行的代码')
finally:
    f.close()
```

## 三、异常的传递

```python
import time

try:
    f = open('file/test.txt', 'r')
    try:
        while True:
            line = f.readline()
            if len(line) == 0:
                break
            print(line)
            time.sleep(3)
    except KeyboardInterrupt:
        print('程序意外终止')
except FileNotFoundError:
    print('打开文件异常')
```

## 四、自定义异常

在Python中，抛出自定义异常的语法为`raise 异常对象` 

```python
class PassWordError(Exception):
    def __init__(self, length, min_len):
        self.length = length
        self.min_len = min_len

    def __str__(self):
        return f"PassWordError length is {self.length}, not less than {self.min_len}"


def main():
    try:
        con = input('please input password: ')
        if len(con) < 6:
            raise PassWordError(len(con), 6)
    except Exception as result:
        print(result)
    else:
        print('input done')
```

