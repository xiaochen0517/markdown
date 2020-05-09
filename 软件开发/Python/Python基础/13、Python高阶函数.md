# Python高阶函数

==把函数作为参数传入==，这样的函数称为高阶函数，高阶函数是函数式编程的体现。函数式编程就是指这种高度抽象的编程范式

## 一、语法

```python
def 函数名(方法参数名):
    return 方法参数名()

# 调用
函数名(函数名)
```

> 在将函数作为参数传入时，不加括号

## 二、示例

```python
def numFunc(a, b, f):
    return f(a) + f(b)


print(numFunc(-10, -12, abs))
```

## 三、内置高阶函数

### 3.1`map()`

`map(func,lst)`，将传入的函数变量`func`作用到`lst`变量的每个元素中，并将结果组成新的列表`(Python2)/迭代器(Python3)`返回

- 示例

```python
list1 = [1, 2, 3, 4, 5, 6, 7]


def func(a):
    return a ** 2


print(map(func, list1))  # <map object at 0x00000181C065F580>
print(list(map(func, list1)))  # [1, 4, 9, 16, 25, 36, 49]
```

### 3.2`reduce()`

`reduce(func, lst)`，其中`func`必须有两个参数。每次`func`计算的结果继续和序列的下一个元素做累积计算

> 注意：`reduce()`传入的参数`func`必须接受2个参数

- 示例

```python
import functools

list1 = [1, 2, 3, 4, 5, 6, 7]

def func1(a, b):
    return a + b


print(functools.reduce(func1, list1))  # 28
```

### 3.3`filter()`

`filter(func, lst)`函数用于过滤序列，过滤掉不符合条件的元素，返回一个`filter`对象

- 示例

```python
list1 = [1, 2, 3, 4, 5, 6, 7]

def func2(a):
    return a % 2 == 0


print(list(filter(func2, list1)))  # [2, 4, 6]
```

