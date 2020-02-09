# Python模块和包

## 一、模块

Python模块（Module），是一个Python文件，以.py结尾，包含了Python对象定义和Python语句

模块能定义函数、类和变量，模块里也可能是包含可执行的代码。

### 1.1导入模块

#### 1.1.1导入模块的方式

- `import 模块名`
- `from 模块名 import 功能名`
- `from 模块名 import *`
- `import 模块名 as 别名`
- `from 模块名 import 功能名 as 别名`

#### 1.1.2导入方式详解

- `import`

```python
# 导入
import 模块名
import 模块名1, 模块名2...

# 调用
模块名.功能名()
```

- `from...import...`

```python
from 模块名 import 功能1, 功能2, 功能3...
```

- `from ... import *`

```python
from 模块名 import *
```

#### 1.1.3as定义别名

```python
import 模块名 as 别名

from 模块名 import 功能 as 别名
```

### 1.2制作模块

在Python中，每个Python文件都可以作为一个模块，模块的名字就是文件的名字。也就是说自定模块必须符合标识符命名规则。

#### 1.2.1定义模块

新建Python文件，命名为`my_module1.py`，并定义`testA`函数

```python
def testA(a, b):
    return a + b
```

#### 1.2.2测试模块

```python
if __name__ == '__main__':
    print(testA(13, 15))
```

#### 1.2.3使用模块

```python
import my_module1

print(my_module1.testA(13, 14))
```

### 1.3模块定位顺序

当导入一个模块，Python解释器对模块位置的搜索顺序是：

- 当前目录
- shell变量PYTHONPATH下的每个目录
- 查看默认路径，UNIX下，默认路径一般为`/usr/local/lib/python/`

模块搜索路径储存在system模块的sys.path变量中。变量里包含当前目录，PYTHONPATH和由安装过程决定的默认目录。

> 注意：
>
> - 自己的文件名不要和已有模块名重复，否则导致模块功能无法使用
> - 使用`from 模块名 import 功能`时，如果功能名字重复，调用到的是最后定义或导入的功能

### 1.4`__all__`

如果一个模块文件中有`__all__`变量，当使用`from xxx import *`导入时，只能导入这个列表中的元素

- my_module模块代码

```python
__all__ = ['testA']


def testA(a, b):
    return a + b


def testB():
    print('testB')
```

- 使用模块

```python
from my_module1 import *

print(testA(13, 14))
# testB() 无法使用不在__all__变量中的方法
```

## 二、包

包将有联系的模块组织在一起，即放到同一个文件夹下，并且在这个文件夹创建一个名字为`__init__.py`文件，那么这个文件夹就称之为包。

### 2.1制作包

`New`->`Python Package`->输入包名->`OK`->新建功能模块

> 注意：在新建好包后，包内部会自动创建`__init__.py`文件，这个文件控制着包的导入行为

### 2.2示例

- 新建包`mypackage`
- 新建包内模块：`my_module1`和`my_module2`
- 代码如下

```python
# my_module1
print(1)


def info_module1():
    print('my_module1')
    
# my_module2
print(2)


def info_module2():
    print('my_module2')
```

### 2.2导入包

#### 2.2.1方法一

```python
import 包名.模块名

包名.模块名.目标
```

#### 2.2.2方法二

> 注意：必须在`__init__.py`文件中添加`__all__ = []`，控制允许导入的模块列表

```python
from 包名 import 模块名

模块名.目标
```

