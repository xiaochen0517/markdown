# Python公共操作

- 运算符
- 公共方法
- 容器类型转换

## 一、运算符

| 运算符 | 描述           | 支持的容器类型           |
| ------ | -------------- | ------------------------ |
| +      | 合并           | 字符串、列表、元组       |
| *      | 复制           | 字符串、列表、元组       |
| in     | 元素是否存在   | 字符串、列表、元组、字典 |
| not in | 元素是否不存在 | 字符串、列表、元组、字典 |

- 示例：

  - ```python
    str1 = 'hello '
    str2 = 'world'
    
    list1 = [1, 2]
    list2 = [3, 4]
    
    tuple1 = (1, 2)
    tuple2 = (3, 4)
    
    # 字符串
    print(str1 + str2)  # hello world
    # 列表
    print(list1 + list2)  # [1, 2, 3, 4]
    # 元组
    print(tuple1 + tuple2)  # (1, 2, 3, 4)
    ```

## 二、公共方法

### 2.1常用公共方法

|           函数            |                             描述                             |
| :-----------------------: | :----------------------------------------------------------: |
|          `len()`          |                     计算容器中元素的个数                     |
|     `del` 或 `del()`      |                             删除                             |
|          `max()`          |                    返回容器中元素的最大值                    |
|          `min()`          |                     返回容器中元素最小值                     |
| `range(start, end, step)` |                    生成从start到end的数字                    |
|       `enumerate()`       | 函数用于将一个可遍历的数据对象（如列表、元组或字符串）组成一个索引序列，同时列出数据和数据下标，一般用在for循环中 |

### 2.2`len()`

```python
str1 = 'hello '
print(len(str1))  # 6
```

### 2.3`del`

```python
del str1
print(str1)  # NameError: name 'str1' is not defined
```

### 2.4`max()` `min()`

```python
s1 = "ahdfzjfsd"
print(max(s1))  # z
print(min(s1))  # a
```

### 2.5`range()`

- 特点：
  - 三个参数均为整数
  - 输出为一个可迭代对象
  - 输出的数据中包含开始值，不包含结束值
  - 省略开始值默认为0，省略步长默认为1

- 示例：

  - ```python
    val = range(0, 5, 1)
    for v in val:
        print(v, end=" ")
    
    # 输出： 0 1 2 3 4 
    ```

### 2.6`enumerate()`

- 语法

```python
enumerate(可遍历对象, start=0)
```

> 注意：`start`参数用来设置遍历数据的下标的起始值，默认值为0

- 示例

```python
list1 = ['a', 'b', 'c', 'd', 'e']

print(enumerate(list1))  # <enumerate object at 0x0000027ADC263740>

for v in enumerate(list1):
    print(v)

"""
(0, 'a')
(1, 'b')
(2, 'c')
(3, 'd')
(4, 'e')
"""

# 遍历第一个值为下标，第二个值为内容
for a, b in enumerate(list1):
    print(f"{a}---{b}")

"""
0---a
1---b
2---c
3---d
4---e
"""
```

## 三、容器类型转换

### 3.1`tuple()`

- 作用：将某个序列转换为元组

```python
list1 = [1, 2, 3, 4, 5, 6, 7]
s1 = {1, 2, 3, 4, 5, 6, 7}

print(tuple(list1))  # (1, 2, 3, 4, 5, 6, 7)
print(tuple(s1))  # (1, 2, 3, 4, 5, 6, 7)
```

### 3.2`list()`

- 作用：将某个序列转换成列表

```python
t1 = (1,2,3,4,5)
s1 = {1,2,3,4,5}

print(list(t1))  # [1, 2, 3, 4, 5]
print(list(s1))  # [1, 2, 3, 4, 5]
```

### 3.3`set()`

- 作用：将某个序列转换成集合

```python
list1 = [1, 2, 3, 4, 5]
t1 = (1, 2, 3, 4, 5)

print(set(list1))  # {1, 2, 3, 4, 5}
print(set(t1))  # {1, 2, 3, 4, 5}
```



