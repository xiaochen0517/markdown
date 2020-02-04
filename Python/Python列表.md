# Python列表

## 1.使用格式

```python
[数据1, 数据2, 数据3, 数据4, ......]
```

- 列表可以一次性存储多个数据，且可以为不同数据类型

## 2.列表的常用操作

### 2.1查找

#### 2.1.1下标

```python
name_list = ['tom', 'lily', 'rose']

print(name_list[0]) # tom
print(name_list[1]) # lily
```

#### 2.1.2函数

- `index()`：返回指定数据所在位置的下标

  - 语法：`列表序列.index(数据, 开始位置下标, 结束位置下标)`

  - 示例

    - ```python
      name_list = ['tom', 'lily', 'rose']
      print(name_list.index('lily', 0, 2)) # 1
      ```

    - 数据不存在则会报错

- `count()`：统计指定数据在当前列表中出现的次数

  - 语法：`列表序列.count(数据)`

- `len()`：访问列表长度，即列表中数据的个数

  - 语法：`len(列表序列)`

#### 2.1.3判断数据是否存在

- `in`：判断数据在某个列表序列是否存在，返回`bool`值

  - 示例

  - ```python
    name_list = ['tom', 'lily', 'rose']
    print('lily' in name_list) # True
    ```

- `not in`：判断指定数据不在某个列表序列中，返回`bool`值

  - 用法同`in`

### 2.2增加

- 增加指定数据到列表中

- `append()`：列表结尾追加数据

  - 语法：`列表序列.append(数据)`

  - 示例：

    - ```python
      name_list = ['tom', 'lily', 'rose']
      name_list.append('jack')
      print(name_list) # ['tom', 'lily', 'rose', 'jack']
      ```

- `extend()`：列表结尾追加数据，如果数据是一个序列，则将这个序列的数据逐一添加到列表

  - 语法：`列表序列.extend(数据)`

  - 示例

    - 单个数据

    - ```python
      name_list = ['tom', 'lily', 'rose']
      name_list.extend('jack')
      print(name_list) # ['tom', 'lily', 'rose', 'j', 'a', 'c', 'k']
      ```

    - 多个数据

    - ```python
      name_list = ['tom', 'lily', 'rose']
      name_list.extend(['jack', 'alice'])
      print(name_list) # ['tom', 'lily', 'rose', 'jack', 'alice']
      ```

- `insert()`：指定位置新增数据

  - 语法：`列表序列.insert(位置下标, 数据)`

  - 示例：

    - ```python
      name_list = ['tom', 'lily', 'rose']
      name_list.insert(1, 'jack')
      print(name_list) # ['tom', 'jack', 'lily', 'rose']
      ```

    - 下标超过列表长度会直接插入到最后的位置

    - 下标为`-1`时会插入倒数第二位，以此类推

### 2.3删除

- `del`

  - 语法：`del 列表`

  - 示例：

    - 删除列表

    - ```python
      name_list = ['tom', 'lily', 'rose']
      del name_list
      print(name_list) # Error: name 'name_list' is not defined
      ```

    - 删除指定数据

    - ```python
      name_list = ['tom', 'lily', 'rose']
      del name_list[0]
      print(name_list) # ['lily', 'rose']
      ```

- `pop()`：删除指定下标的数据（默认为最后一个）

  - 语法：`列表序列.pop(下标)`

  - 示例：

    - ```python
      name_list = ['tom', 'lily', 'rose']
      del_list = name_list.pop(0)
      print(del_list) # tom
      print(name_list) # ['lily', 'rose']
      ```

- `remove()`：移除列表中某个数据的第一个匹配项

  - 语法：`列表序列.remove(数据)`

  - 示例：

    - ```python
      name_list = ['tom', 'lily', 'rose']
      name_list.remove('tom')
      print(name_list) # ['lily', 'rose']
      ```

- `clear()`：清空列表

  - 语法：`列表序列.clear()`

  - 示例：

    - ```python
      name_list = ['tom', 'lily', 'rose']
      name_list.clear()
      print(name_list) # []
      ```

### 2.4修改

- 修改指定下标的数据

  - 语法：`列表序列[下标] = '新数据'`

- 逆置：`reverse()`

  - 语法：`列表序列.reverse()`

- 排序：`sort()`

  - 语法：`列表序列.sort(key=None, reverse=False)`

  - 注意：`reverse`表示排序规则，`reverse=True`降序，`reverse=False`升序（默认）

  - 示例：

    - ```python
      num_list = [3,4,1,8,6,0,5,7,6,2,9]
      num_list.sort()
      print(num_list) # [0, 1, 2, 3, 4, 5, 6, 6, 7, 8, 9]
      ```

### 2.5赋值

- `copy()`
  - 语法：`变量 = 列表序列.copy()`

## 3.列表的循环遍历

### 3.1`while`

- 示例：

- ```python
  name_list = ['tom', 'lily', 'rose']
  
  i = 0
  while i < len(name_list):
      print(name_list[i])
      i += 1
  """    
  tom
  lily
  rose
  """
  ```

### 3.2`for`

- 示例

- ```python
  name_list = ['tom', 'lily', 'rose']
  
  for name in name_list:
      print(name)
  """
  tom
  lily
  rose
  """
  ```

## 4.列表嵌套

- 用法示例
  - 定义嵌套列表
  - `name_list = [['张三', '李四', '王五'], ['tom', 'lily', 'rose']]`
  - 获取其中的数据
  - `print(name_list[0][1]) # 李四`

