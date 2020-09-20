# `Python`递归与`lambda`表达式

## 一、递归

### 1.1递归的特点

- 函数内部自己调用自己
- 必须有出口

### 1.2示例

```python
def numFunc(num):
    if num == 1:
        return 1
    return num + numFunc(num - 1)


print(numFunc(3))  # 6
```

- 图示

![](photo\递归示意图.png).

## 二、lambda表达式

## 2.1应用场景

如果一个函数有一个返回值，并且只有一句代码，可以使用lambda表达式

### 2.2语法

```python
lambda 参数列表:表达式
```

### 2.3参数形式

#### 2.3.1无参数

```python
(lambda: 100)()
```

#### 2.3.2一个参数

```python
(lambda a: a)('hello world')
```

#### 2.3.3默认参数

```python
(lambda a, b, c=100:a+b+c)(10,20)
```

#### 2.3.4可变参数：`*args`

```python
(lambda *args:args)(10,20,30)
```

#### 2.3.5可变参数：`**kwargs`

```python
(lambda **kwargs: kwargs)(name='tom', age=20)
```

> - lambda表达式的参数可有可无，函数的参数在lambda表达式中完全适用
> - lambda表达式能接收任何数量的参数但只能返回一个表达式的值

### 2.4示例

```python
print((lambda a, b: a + b)(10, 20))  # 30

lam1 = lambda: 200
print(lam1())  # 200
```

> 注意：直接打印lambda表达式，输出的是此lambda的内存地址

### 2.5高级应用

#### 2.5.1带判断的lambda

```python
fn1 = lambda a, b: a if a > b else b
print(fn1(100, 200))  # 200
```

#### 2.5.2排序

```python
student = [

    {'name': 'tom', 'age': 20},
    {'name': 'jack', 'age': 16},
    {'name': 'rose', 'age': 25},
]

student.sort(key=lambda x: x['age'])
print(student)  # [{'name': 'jack', 'age': 16}, {'name': 'tom', 'age': 20}, {'name': 'rose', 'age': 25}]
```

