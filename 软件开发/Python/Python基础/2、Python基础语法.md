# Python基础语法

## 1.注释

注释分为单行注释和双行注释

### 1.1单行注释

```python
# 注释内容
```

### 1.2多行注释

```python
"""
1
2
3
"""

'''
1
2
3
'''
```

## 2.变量

### 2.1语法

```python
变量名 = 值
```

- 变量名自定义，需要满足**标识符**命名规则

### 2.2标识符

- 标识符命名规则是Python中定义各种名字的时候的统一规范，如下：
  - 由数字、字母、下划线组成
  - 不能数字开头
  - 不能使用内置关键字
  - 严格区分大小写

#### 2.2.1关键字

```python
False     None   True   and     as     assert    break     class
continue  def     del    elif   else   except   finally     for
from     global   if   import   in      is      lambda     nonlocal
not       or     pass   raise  return   try      while     with
yield
```

#### 2.2.2命名习惯

- 见名知义
- 大驼峰：每个单词首字母都大写，`MyName`
- 小驼峰：首单词小写以后的单词首字母大写，`myName`
- 下划线：单词使用下划线分割，`my_name`

### 2.3使用变量

```python
my_name = 'Tom'
print(my_name)
```

## 3.数据类型

### 3.1数值

#### 3.1.1整数`int`

```python
num = 1
```

#### 3.1.2浮点数`float`

```python
num = 1.1
```

### 3.2布尔型

#### 3.2.1真`True`

```python
boolv = True
```

#### 3.2.2假`False`

```python
boolv = False
```

### 3.3字符串`str`

```python
strv = 'Hello Word'
```

### 3.4列表`list`

```python
listv = [1,2,3]
```

### 3.5元组`tuple`

```python
typlev = (1,2,3)
```

### 3.6集合`set`

```python
setv = {1,2,3}
```

### 3.7字典`dict`

```python
dictv = {'name': 'Tom', 'age': 18}
```

## 4.格式化输出

### 4.1格式化符号

格式符号|转换
--|:-:
%s|字符串（浮点和整数）
%d|有符号的十进制整数
%f|浮点数
%c|字符
%u|无符号十进制整数
%o|八进制整数
%x|十六进制整数（小写ox）
%X|十六进制整数（大写ox）
%e|科学计数法（小写'e'）
%E|科学计数法（大写'E'）
%g|%f和%e的简写
%G|%f和%E的简写

### 4.2使用格式化符号

```python
age = 18
print('my age is %d' % age)
```

- 输出：`my age is 18`

#### 4.2.1浮点数保留小数点位数

- 直接使用`%f`默认保留6位小数

- 语法：`%.【保留位数值】f`

- 示例

  - ```python
    floatv = 1.1
    print('my float is %.3f' % floatv)
    ```

  - 结果：`my float is 1.100`

#### 4.2.2整数前补0

- 语法：`%0【位数】d`

  - 输出时不足指定位数时在值前补0，输出超过指定位数时原样输出

- 示例

  - ```python
    studentId = 1
    print('my student id is %03d' % studentId)
    ```

  - 结果`my student id is 001`

#### 4.2.3多个格式化符号输出

- 语法：`print('... %s ... %d ...' % ([first value], [second value]))`

- 示例

  - ```python
    name = 'Tom'
    age = 20
    print('my name is %s and I\'m %d years old' % (name, age))
    ```

  - 结果：`my name is Tom and I'm 20 years old`

### 4.3使用`f''`格式化字符串

> `f''`格式化字符串是`Python3.6`中新增的格式化方法

- 语法：`f'...{【变量名】}'`

- 示例：

  - ```python
    name = 'Tom'
    print(f'my name is {name}')
    ```

  - 结果：`my name is Tom`

## 5.转义字符

- `\n`：换行
- `\t`：制表符，一个`tab`键（4个空格）的距离
- `print()`去除自动换行：`print('...', end='')`

## 6.输入

### 6.1语法

```python
input('提示信息')
```

### 6.2输入的特点

- 当程序执行到`input`时，将等待用户输入，输入完成后继续向下执行
- 在`Python`中，`input`接收用户输入后，一般会储存到一个变量，方便使用
- 在`Python`中，`input`会把接收到的任意用户输入的数据都当做字符串处理

### 6.3示例

- 代码

```python
ps = input('input your password:')
print(f'The password you entered is {ps}')
```

- 运行结果

```json
input your password:123456
The password you entered is 123456
```

## 7.数据类型转换

### 常用函数

函数|说明
--|--
int(x[,base])|将x转换为一个整数
float(x)|将x转换为一个浮点数
complex(real[,imag])|创建一个复数，real为实部，imag为虚部
str(x)|将对象x转换为字符串
repr(x)|将对象x转换为表达式字符串
eval(str)|用来计算在字符串中有效Python表达式，并返回一个对象
ruple(s)|将序列s转换为一个元组
list(s)|将序列s转换为一个列表
chr(x)|将一个整数转换为一个Unicode字符
ord(x)|将一个字符转换为它的ASCII整数值
hex(x)|将一个整数转换为一个十六进制字符串

## 8.运算符

### 8.1运算符的分类

- 算数运算符
- 赋值运算符
- 复合赋值运算符
- 比较运算符
- 逻辑运算符

### 8.2算数运算符

运算符|描述
--|--
+|加
-|减
*|乘
/|除
//|整除
%|取余
**|指数
()|小括号提高运算优先级

> 注意：

- 混合运算优先级顺序：`()`高于`**`高于`*` `/` `// ` `%`高于`+` `-`

### 8.3赋值运算符

- 符号：`=`

#### 8.3.1单个变量赋值

```python
num = 1
```

#### 8.3.2多个变量赋值

```python
num1, num2, num3 = 1, 2, 3
```

#### 8.3.3多变量赋相同值

```python
a = b = 1
```

### 8.4复合赋值运算符

运算符|描述|示例|等价于
--|--|--|--
+=|加法赋值运算符|c+=a|c=c+a
-=|减法赋值运算符|c-=a|c=c-a
*=|乘法赋值运算符|c*=a|c=c*a
/=|除法赋值运算符|c/=a|c=c/a
//=|整除赋值运算符|c//=a|c=c//a
%=|取余赋值运算符|c%=a|c=c%a
**=|幂赋值运算符|c**=a|c=c**a

> 注意：

- 复合运算符会先计算`=`号右侧的值再进行复合运算

### 8.5比较运算符

- 比较运算符也称为关系运算符

运算符|描述
--|--
==|等于
!=|不等于
>|大于
<|小于
>=|大于等于
<=|小于等于

> 注意：

- 比较运算符返回的值为布尔型

### 8.6逻辑运算符

运算符|逻辑表达式|描述
--|--|--
and|x and y|逻辑与：若x为False，返回False，否则返回y的值
or|x or y|逻辑或：若x为True，返回True，否则返回y
not|not x|逻辑非：若x为True，返回False。若为False，返回 True

> 注意：

- 在整数和浮点数中，0表示`False`其余所有皆为`True`