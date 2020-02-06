# Python函数

## 一、函数的作用

- 函数就是将一段具有独立功能的代码块整合到一个整体并命名，在需要的位置调用这个名称即可完成对应的需求

> 函数在开发过程中，可以更高效的实现代码重用

## 二、函数的使用

### 2.1定义

```python
def 函数名(参数):
    代码1
    代码2
    ......
    return 返回值
```

### 2.2函数调用

```python
函数名(参数)
```

> 注意：

- 在不同的需求中，参数可有可无
- 在Python中，函数必须先定义后使用

### 2.3示例

```python
# 定义函数
def add(a, b):
    return a + b

# 调用函数
print(add(10, 12))  # 22
```

> 注意：在Python中一定是先定义函数，后调用函数

## 三、函数的说明文档

### 3.1语法

- 定义函数的说明文档

```python
def 函数名(参数):
    """ 说明文档的位置 """
    代码
    ......
    return 返回值
```

- 查看函数的说明文档

```python
help(函数名)
```

> 注意：在`help`函数中只传入函数名，不加括号

### 3.2示例

```python
def add(a, b):
    """
    This is add method
    :param a: is int
    :param b: is int
    :return: a add b
    """
    return a + b


help(add)

"""
输出：
add(a, b)
    This is add method
    :param a: is int
    :param b: is int
    :return: a add b
"""
```

## 四、函数嵌套调用

```python
def test2():
    print('this is method test2')


def test1():
    print('this is method test1')
    test2()


test1()

"""
this is method test1
this is method test2
"""
```

## 五、变量作用域

- 变量作用域指的是变量的生效范围，主要分为两类：局部变量和全局变量

### 5.1局部变量

- 所谓局部变量是定义在函数体内部的变量，即只在函数体内部生效
- 局部变量的作用：在函数体内部，临时保存数据，即当函数调用完成后，则销毁局部变量

### 5.2全局变量

- 所谓全局变量，指的是在函数体内、外都能访问到的变量

## 六、函数多个返回值

- 语法：`return 数据1, 数据2`
- 示例：

```python
def a():
    return 1, 2


print(type(a()))  # <class 'tuple'>
```

> 注意：

- 在使用以上写法，返回多个数据时，默认为元组类型
- 同理，在`return`后可以返回列表或者字典，以返回多个值

## 七、函数参数

### 7.1关键字参数

- 函数调用，通过“键=值”的形式加以指定。可以让函数更加清晰、容易使用，同时也清除了参数的顺序需求

```python
def printInfo(name, age, gender):
    print(f"name = {name}, age = {age}, gender = {gender}")


printInfo(age=12, name='tom', gender='man')
```

> 注意：函数调用时，如果有位置参数时，位置参数必须在关键字参数的前面，但关键字参数之间不存在先后顺序

### 7.2缺省参数

- 缺省参数也叫默认参数，用于定义函数，为参数提供默认值，调用函数时可不传该默认参数的值（注意：所有位置参数必须出现在默认参数前，包括函数定义和调用）

```python
def printInfo(name, age, gender='man'):
    print(f"name = {name}, age = {age}, gender = {gender}")


# name = tom, age = 12, gender = man
printInfo('tom', 12)
# name = rose, age = 15, gender = women
printInfo('rose', 15, 'women')
```

> 注意：函数调用时，如果为缺省参数传值则修改默认参数值；否则使用这个默认值

### 7.3不定长参数

- 不定长参数也叫可变参数。用于不确定调用的时候会传递多少个参数（不传参也可以）的场景。此时，可用包裹（packing）位置参数，或者包裹关键字参数，来进行参数传递，会显得非常方便

#### 7.3.1包裹位置传递

```python
def userInfo(*args):
    print(args)


userInfo('tom', 12, 'man')  # ('tom', 12, 'man')
```

> 注意：传进的所有参数都会被`args`变量收集，它会根据传进的参数位置合并为一个元组，`args`是元组类型，这就是包裹位置传递

#### 7.3.2包裹关键字传递

```python
def userInfo(**kwargs):
    print(kwargs)


userInfo(name='tom', age=12, gender='man')  # {'name': 'tom', 'age': 12, 'gender': 'man'}
```

> 总结：无论是包裹位置传递还是包裹关键字传递，都是一个组包的过程

## 八、拆包和交换变量值

### 8.1拆包

#### 8.1.1元组

```python
tuple1 = (100, 200)
a, b = tuple1
print(a)  # 100
print(b)  # 200
```

#### 8.1.2字典

```python
dict1 = {'name': 'tom', 'age': 20}
a, b = dict1
print(a)  # 100
print(b)  # 200
print(dict1[a])  # tom
print(dict1[b])  # 20
```

> 注意：拆包字典的值为字典的`key`

### 8.2交换变量值

#### 8.2.1借助第三方变量存储数据

```python
# 定义变量
a = 10
b = 20

# 使用中间值
c = a
# 将b的值赋值给a
a = b
# 再将c中保存的a的值赋值给b
b = c

print(a)  # 20
print(b)  # 10
```

#### 8.2.2使用拆包语法交换

```python
# 定义变量
a = 10
b = 20

# 交换值
a, b = b, a
print(a)  # 20
print(b)  # 10
```

## 九、引用

### 9.1什么是引用

- 在python中，值是靠引用来传递的
- 我们可以用id()来平判断两个变量是否为同一个值的引用。可以将id值理解为储存变量值的内存地址

```python
a = 1
b = a

print(id(a))  # 140730039256736
print(id(b))  # 140730039256736
```

## 十、可变和不可变类型

所谓可变类型与不可变类型是指：数据能够直接进行修改，如果能直接修改那么就是可变，否则就是不可变

- 可变类型
  - 列表
  - 字典
  - 集合
- 不可变类型
  - 整型
  - 浮点型
  - 字符串
  - 元组