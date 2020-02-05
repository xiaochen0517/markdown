# Python推导式

- 列表推导式
- 字典推导式
- 集合推导式

## 一、列表推导式

- 作用：用一个表达式创建一个有规律的列表或控制一个有规律的列表
- 列表推导式又叫列表生成式

### 1.1示例

```python
list1 = [i for i in range(10)]
print(list1)  # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### 1.2带if的列表推导式

- 示例

```python
list1 = [i for i in range(10) if i%2 == 0]
print(list1)  # [0, 2, 4, 6, 8]
```

> 类似于`mysql`中的`where`

### 1.3多个for循环实现列表推导式

- 示例

```python
list1 = [(i, j) for i in range(2) for j in range(3)]
print(list1)  # [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2)]
```

- 相当于嵌套for循环

## 二、字典推导式

- 字典推导式作用：快速合并列表为字典或提取字典中目标数据

### 2.1示例

#### 2.1.1创建字典

```python
dict1 = {i: i * 2 for i in range(5)}
print(dict1)  # {0: 0, 1: 2, 2: 4, 3: 6, 4: 8}
```

#### 2.1.2两个列表合并为一个字典

```python
list1 = ['name', 'age', 'gender']
list2 = ['Tom', 20, 'man']

dict1 = {list1[i]: list2[i] for i in range(len(list1))}
print(dict1)  # {'name': 'Tom', 'age': 20, 'gender': 'man'}
```

#### 2.1.3提取字典中目标数据

```python
counts = {'MBP': 268, 'HP': 125, 'DELL': 201, 'Lenovo': 199, 'acer': 99}

# 取出数量大于200的字典数据
cout1 = {key: value for key, value in counts.items() if value > 200}
print(cout1)  # {'MBP': 268, 'DELL': 201}
```

## 三、集合推导式

### 3.1示例

```python
list1 = [1, 2, 3, 4]
list2 = [i * 2 for i in list1]
print(list2)  # [2, 4, 6, 8]
```

> 注意：集合有数据去重功能