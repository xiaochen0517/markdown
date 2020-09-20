# Python流程控制

## 1.if

### 1.1语法

```python
if 条件:
    条件成立时执行的代码1
    条件成立时执行的代码2
    ......
```

### 1.2示例

- 代码

```python
if True:
    print('hello')
    print('word')

if False:
    print('my name is')
    print('tom')
```

- 运行结果

```
hello
word
```

## 2.if...else...

### 语法

```python
if 条件:
    条件成立时执行的代码1
    条件成立时执行的代码2
    ......
else:
    条件不成立时执行的代码1
    条件不成立时执行的代码2
    ......
```

## 3.多重判断

```python
if 条件1:
    条件1成立时执行的代码1
    条件1成立时执行的代码2
    ......
elif 条件2:
    条件2成立时执行的代码1
    条件2成立时执行的代码2
    ......
else:
    条件不成立时执行的代码1
    条件不成立时执行的代码2
    ......
```

## 4.if嵌套

```python
if 条件1:
    条件1成立时执行的代码1
    条件1成立时执行的代码2
    ......
    if 条件2:
    条件2成立时执行的代码1
    条件2成立时执行的代码2
    ......
```

> 注意：条件2成立的前提是条件1成立

## 5.三目运算符

```python
条件成立返回的值 if 条件 else 条件不成立返回的值
```

- 示例

```python
a = 2
b = 5
c = a if 1>2 else b

# c为5
```

## 6.循环

### 6.1while循环

#### 6.1.1语法

```python
while 条件:
    条件成立时重复执行的代码1
    条件成立时重复执行的代码2
    ......
```

#### 6.1.2应用

- 代码

```python
a = 0
while a<5:
    print('hello a is %d' % a)
    a += 1
```

- 运行结果

```
hello a is 0
hello a is 1
hello a is 2
hello a is 3
hello a is 4
```

#### 6.1.4循环嵌套

```
while 条件1:
    条件1成立时重复执行的代码1
    条件1成立时重复执行的代码2
    ......
    while 条件2:
    	条件2成立时重复执行的代码1
    	条件2成立时重复执行的代码2
    	......
```

### 6.2for循环

#### 6.2.1语法

```python
for 临时变量 in 序列:
    重复执行的代码1
    重复执行的代码2
    ......
```

#### 6.2.2示例

- 代码

```python
str1 = 'str'
for i in str1:
    print(i)
```

- 运行结果

```
s
t
r
```

### 6.3`break`和`continue`

#### 6.3.1`break`

- 直接跳出循环

- 示例

  - ```python
    c = 0
    while c<10:
        if c == 5:
            print('break')
            break
        c += 1
        print(f'c is {c}')
        
    # 输出
    c is 1
    c is 2
    c is 3
    c is 4
    c is 5
    break
    ```

#### 6.3.2`continue`

- 跳过本次循环

- 示例

  - ```python
    c = 0
    while c<10:
        c += 1 #注意，将此行代码卸载continue后会进入死循环
        if c == 5:
            print('continue')
            continue
        print(f'c is {c}')
        
    # 输出
    c is 1
    c is 2
    c is 3
    c is 4
    continue
    c is 6
    c is 7
    c is 8
    c is 9
    c is 10
    ```

### 6.4`while...else...`和`for...else...`

- 语法

  - ```python
    while 条件:
        条件成立时重复执行的代码1
        条件成立时重复执行的代码2
        ......
    else:
        正常完成循环执行的代码
        ......
    ```

- 在循环中有`break`跳出语句时，`else`中的语句不会执行，`continue`则会正常执行