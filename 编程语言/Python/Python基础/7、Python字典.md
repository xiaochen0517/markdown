# Python字典

## 一、创建方法

- 字典中的数据是以键值对形式出现，字典数据和数据顺序没有关系，即字典不支持下标，后期无论数据如何变化，只要按照对应的键的名字查找数据即可

- 特点：

  - 符号为大括号
  - 数据为键值对的形式出现
  - 各个键值之间使用冒号隔开
  - 各个键值对之间使用逗号隔开

- 示例：

  - ```python
    # 有数据字典
    d1 = {'name':'Tom', 'age':20, 'gender':'男'}
    
    # 空字典
    d2 = {}
    d3 = dict()
    ```

  - 冒号前为键，冒号后为值

## 二、字典常见操作

### 2.1增加

- 语法：`字典序列[key] = value`

> 注意：如果key存在则是修改这个key的值；如果key不存在则会新增此键值对

- 示例：

  - ```python
    d1 = {'name':'Tom', 'age':20, 'gender':'男'}
    
    d1['email'] = '123@gmail.com'
    
    # {'name': 'Tom', 'age': 20, 'gender': '男', 'email': '123@gmail.com'}
    print(d1)
    
    d1['name'] = 'jack'
    
    # {'name': 'jack', 'age': 20, 'gender': '男', 'email': '123@gmail.com'}
    print(d1)
    ```

> 注意：字典为可变类型

### 2.2删除

- `del()` `del`：删除字典或删除字典中指定键值对
- `clear()`：清空字典

### 2.3修改

- 语法：`字典序列[key] = value`

### 2.4查

#### 2.4.1`key`值查找

- 语法：`字典序列[key]`

> 注意：如果当前查找的`key`存在，则返回对应的值；否则会报错

#### 2.4.2`get()`

- 语法：

  - ```
    字典序列.get(key, 默认值)
    ```

  - 注意：如果当前查找的`key`不存在则返回第二个参数（默认值），如果省略第二个参数，则返回`None`

- 示例：

  - ```python
    d1 = {'name':'Tom', 'age':20, 'gender':'男'}
    print(d1.get('name')) # Tom
    print(d1.get('aa', 'defvalue')) # defvalue
    print(d1.get('aa')) # None
    ```

#### 2.4.3`keys()`

- 获取字典中的所有`key`

- 语法：`字典序列.keys()`

- 示例：

  - ```python
    d1 = {'name':'Tom', 'age':20, 'gender':'男'}
    print(d1.keys()) # dict_keys(['name', 'age', 'gender'])
    print(type(d1.keys())) # <class 'dict_keys'>
    ```

- 使用`for`循环遍历

  - ```python
    for key in d1.keys():
        print('key = %s, value = %s' % (key, d1[key]))
    
    """
    key = name, value = Tom
    key = age, value = 20
    key = gender, value = 男
    """
    ```

#### 2.4.4`values()`

- 获取字典中的所有`value`
- 语法：`字典序列.values()`
- 用法同`keys()`

#### 2.4.5`items()`

- 将字典中键值对组成元组

- 语法：`字典序列.items()`

- 示例：

  - ```python
    print(d1.items())  
    # dict_items([('name', 'Tom'), ('age', 20), ('gender', '男')])
    ```

