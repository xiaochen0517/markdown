# Python面向对象

## 一、类

### 1.1定义类

Python2中类分为：经典类和新式类

- 语法

```python
# 经典类
class 类名:
    代码
    ......
# 新式类
class 类名(object):
    代码
    ......
```

> 注意：类名要满足标识符命名规则，同时遵循==大驼峰命名习惯==

### 1.2创建对象

对象又名示例

- 语法

```python
对象名 = 类名()
```

- 示例

```python
class Human:
    def speak(self):
        print('Human speaking')


human = Human()

human.speak()  # Human speaking
```

### 1.3self

self指的是调用该函数的对象

- 示例

```python
class Human:
    def speak(self):
        print('Human speaking')
        print(self)


human = Human()

human.speak()  # Human speaking
print(human)

"""
<__main__.Human object at 0x00000227FD205400>
<__main__.Human object at 0x00000227FD205400>
"""
```

## 二、对象属性

### 2.1在类外添加对象属性

- 语法

```
对象名.属性名 = 值
```

- 示例

```python
Human.width = 100
Human.height = 100
```

### 2.2在类外获取对象属性

- 语法

```
对象名.属性名
```

- 示例

```python
print(f"width = {human.width}")
print(f"height = {human.height}")
```

### 2.3在类中获取对象属性

- 语法

```python
self.属性名
```

- 示例

```python
class Human:
    def speak(self):
        print('Human speaking')
        print(f"width = {self.width}")
        print(f"height = {self.height}")
```

## 三、魔法方法

在Python中，`__xx__()`的函数叫做魔法方法，指的是具有特殊功能的函数

### 3.1`__init__()`

- 作用：==初始化对象==

```python
class Human:
    def __init__(self):
        print('init function')

    def speak(self):
        print('Human speaking')
        print(self)


human = Human()

# init function
```

> 注意：
>
> - `__init__()`方法，在创建一个对象时默认被调用，不需要手动调用
> - `__init__(self)`中的self参数，不需要开发者传递对象，python解释器会自动把当前的对象引用传递过去

### 3.2带参数的`__init__()`

```python
class Human:
    def __init__(self, width, height):
        print('init function')
        self.width = width
        self.height = height

    def speak(self):
        print('Human speaking')
        print(f"width={self.width},height={self.height}")


human = Human(100, 200)
human.speak()

"""
init function
Human speaking
width=100,height=200
"""
```

### 3.3`__str__()`

当使用`print`输出对象时，默认打印对象的内存地址。如果定义了`__str__()`方法，那么就会打印从这个方法中`return`的数据

- 示例

```python
class Human:
    def __str__(self):
        return "Human"


human = Human()
print(human)  # Human
```

### 3.4`__del__()`

当删除对象时，Python解释器也会默认调用`__del__()`方法

```python
class Human:
    def __init__(self, width, height):
        print('init function')
        self.width = width
        self.height = height

    def __del__(self):
        print('Human delete')


human = Human(100, 200)  # init function
del human  # Human delete
```

## 四、继承

### 4.1继承的概念

Python面向对象的继承指的是多个类之间的所属关系，即子类默认继承父类中的所有属性和方法

- 示例

```python
class Human(object):
    def __init__(self, width, height):
        print('init function')
        self.width = width
        self.height = height

    def speak(self):
        print('Human speaking')
        print(f"width={self.width},height={self.height}")

    def __str__(self):
        return "Human"

    def __del__(self):
        print('Human delete')


class Jack(Human):
    pass


jack = Jack(100,200)
jack.speak()

"""
init function
Human speaking
width=100,height=200
Human delete
"""
```

> 所有类默认继承object类，object类是顶级类或基类；其他子类叫做派生类。

### 4.2多继承

- 语法

```python
class 类名(父类1, 父类2):
    pass
```

> 注意：当一个类有多个父类时，默认使用第一个父类的同名属性和方法

### 4.3子类重写父类同名属性和方法

在子类中重新编写父类中已有的属性和方法

- 示例

```python
class Human(object):
    def __init__(self, width, height):
        print('init function')
        self.width = width
        self.height = height

    def speak(self):
        print('Human speaking')
        print(f"width={self.width},height={self.height}")

    def __str__(self):
        return "Human"

    def __del__(self):
        print('Human delete')


class Jack(Human):
    def __init__(self):
        self.width = 100
        self.height = 100

    def speak(self):
        print('Jack speaking')
        print(f"width={self.width},height={self.height}")


jack = Jack()
jack.speak()

"""
Jack speaking
width=100,height=100
Human delete
"""
```

- 查看类结构

```python
print(Jack.__mro__)  # (<class '__main__.Jack'>, <class '__main__.Human'>, <class 'object'>)
```

### 4.4子类调用父类同名属性和方法

```python
class Human(object):
    def __init__(self, width, height):
        print('init function')
        self.width = width
        self.height = height

    def speak(self):
        print('Human speaking')
        print(f"width={self.width},height={self.height}")

    def __str__(self):
        return "Human"

    def __del__(self):
        print('Human delete')


class Jack(Human):
    def __init__(self):
        self.width = 100
        self.height = 100

    def speak(self):
        print('Jack speaking')
        print(f"width={self.width},height={self.height}")

    def humanSpeak(self):
        Human.__init__(self, self.width, self.height)
        Human.speak(self)


jack = Jack()
jack.humanSpeak()

"""
init function
Human speaking
width=100,height=100
Human delete
"""
```

### 4.5`super()`调用父类

```python
class Jack(Human):
    def __init__(self):
        self.width = 100
        self.height = 100

    def speak(self):
        print('Jack speaking')
        print(f"width={self.width},height={self.height}")

    def humanSpeak(self):
        super().__init__(self.width, self.height)
        super().speak()
```

### 4.6私有属性和方法

设置私有权限的方法：在属性名和方法名前加两个下划线`__`

### 4.7获取和修改私有属性值

在Python中，一般定义函数名`get_xx`用来获取私有属性，定义`set_xx`用来修改私有属性值。

- 示例

```python
class Father(object):
    def __init__(self):
        self.__a = 0

    def set_a(self, a):
        self.__a = a

    def get_a(self):
        return self.__a


father = Father()
father.set_a(100)
print(father.get_a())  # 100
```

## 五、多态

### 5.1使用多态步骤

- 定义父类，并提供公共方法
- 定义子类，并重写父类方法
- 传递子类对象给调用者，可以看到不同子类执行效果不同

### 5.2示例

```python
class Human(object):
    def work(self):
        pass

    pass


class Jack(Human):
    def work(self):
        print('Jack start work')


class Rose(Human):
    def work(self):
        print('Rose start work')


class Boss(object):
    def startWork(self, human):
        human.work()


jack = Jack()
rose = Rose()

boss = Boss()
boss.startWork(jack)  # Jack start work
boss.startWork(rose)  # Rose start work
```

## 六、类属性和实例属性

### 6.1设置和访问类属性

- 类属性就是类对象所拥有的属性，它被该类的所有实例对象所共有
- 类属性可以使用类对象或实例对象访问

```python
class Class(object):
    a = 100


print(Class.a)  # 100
cl = Class()
print(cl.a)  # 100
```

> 类属性的优点
>
> - 记录的某项数据始终保持一致时，则定义类属性。
> - 实例属性要求每个对象为其单独开辟一份内存空间开记录数据，而类属性为全类共有的，仅占用一份内存，更加节省内存空间

### 6.2修改类属性

类属性只能通过类对象修改，不能使用实例对象修改，如果通过实例对象修改类属性，表示的是创建了一个实例属性。

## 七、类方法和静态方法

### 7.1类方法

#### 7.1.1类方法特点

- 需要使用装饰器`@classmethod`开标识其为类方法，对于类方法，第一个参数必须是类对象，一般以`cls`作为第一个参数

#### 7.1.2类方法使用场景

- 当方法中需要使用类对象（如访问私有类属性等）时，定义类方法
- 类方法一般和类属性配合使用

```python
class Class(object):
    __a = 100

    @classmethod
    def get_a(cls):
        return cls.__a


cl = Class()
print(cl.get_a())  # 100
```

### 7.2静态方法

#### 7.2.1静态方法特点

- 需要通过装饰器`@staticmethod`来修饰，静态方法既不需要传递类对象也不需要传递示例对象（形参没有self/cls）
- 静态方法也能够通过实例对象和类对象去访问

#### 7.2.2静态方法使用场景

- 当方法中既不需要使用实例对象（如实例对象，实例属性），也不需要使用类对象（如类属性、类方法、创建实例等）时，定义静态方法
- 取消不需要的参数传递，有利于减少不必要的内存占用和性能消耗

**示例：**

```python
class c1(object):
    @staticmethod
    def showc1():
        print('静态方法')


c1.showc1()
c = c1()
c.showc1()
```

