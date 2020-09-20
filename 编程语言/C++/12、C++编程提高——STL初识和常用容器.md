[TOC]

# C++编程提高——STL初识及常用容器

## 一、初识STL

### 1.1STL的诞生

- 长久以来，软件界一直希望建立一种可重复利用的东西
- C++的面向对象和泛型编程思想，目的就是复用性的提升
- 大多数情况下，数据结构和算法都未能有一套标准，导致被迫从事大量重复工作
- 为了建立数据结构和算法的一套标准，诞生了STL

### 1.2STL基本概念

- STL（Standard Template Library，标准模板库）
- STL从广义上分为：容器（container）算法（algorithm）迭代器（iterator）
- 容器和算法之间通过迭代器进行无缝连接
- STL几乎所有的代码都采用了模板类或者模板函数

### 1.3STL六大组件

STL大体分为六大组件，分别是：容器、算法、迭代器、仿函数、适配器（配接器）、空间配置器

- 容器：各种数据结构，如vector、list、deque、set、map等，用来存放数据
- 算法：各种常用的算法，如sort、find、copy、for_each等
- 迭代器：扮演了容器与算法之间的胶合剂
- 仿函数：行为类似函数，可作为算法的某种策略
- 适配器：用来修饰容器或者仿函数或迭代器
- 空间配置器：负责空间的配置与管理

### 1.4STL中容器、算法、迭代器

**容器：**存放数据的容器

**STL容器**就是将运用最广泛的一些数据结构实现出来

常用的数据结构：数组、链表、树、栈、队列、集合、映射表 等

这些容器分为**序列式容器**和**关联式容器**两种：

- **序列式容器：**强调值的排序，序列式容器中的每个元素均有固定的位置
- **关联式容器：**二叉树结构，各元素之间没有严格的物理上的顺序关系



**算法：**解决问题的办法

有限的步骤，解决逻辑或数学上的问题，这一门学科我们叫做**算法（Algorithms**）

算法分为：**质变算法**和**非质变算法**

**质变算法：**是指运算过程中会更改区间内的元素的内容，例如拷贝、替换、删除等

**非质变算法：**是指运算过程中不会更改区间内的元素内容，例如查找、计数、遍历、寻找极值等等



迭代器：容器和算法之间的粘合剂

提供一种方法，使之能够依序寻访某个容器所含的各个元素，而又无需暴露该容器的内部表示方式

每个容器都有自己专属的迭代器

迭代其使用方式非常类似指针，初学阶段我们可以先理解迭代器为指针

迭代器的种类：

| 种类           | 功能                                                     | 支持运算                                |
| -------------- | -------------------------------------------------------- | --------------------------------------- |
| 输入迭代器     | 对数据的只读访问                                         | 只读，支持++、==、!=                    |
| 输出迭代器     | 对数据的只写访问                                         | 只写，支持++                            |
| 前向迭代器     | 读写操作，并能向前推进迭代器                             | 读写，支持++、==、!=                    |
| 双向迭代器     | 读写操作，并能向前和向后操作                             | 读写，支持++、--                        |
| 随机访问迭代器 | 读写操作，可以以跳跃的方式访问任意数据，功能最强的迭代器 | 读写，支持++、--、[n]、-n、<、<=、>、>= |

常用的容器中迭代器种类为双向迭代器，和随机访问迭代器

### 1.5容器算法迭代器初识

#### 1.5.1vector存放内置数据类型

容器：`vector`

算法：`for_each`

迭代器：`vector<int>::iterator`

**示例：**

```c++
#include<iostream>
using namespace std;
#include<vector>
#include<algorithm> //标准算法头文件

void myPonit(int val) {
	cout << val << endl;
}

void test51() {
	//创建一个vector容器
	vector<int> v;
	//向容器中添加数据
	for (int i = 1; i <= 10; i++) {
		v.push_back(i * 10);
	}
	//起始迭代器，指向容器中的第一个元素
	vector<int>::iterator begin = v.begin();
	//结束迭代器，指向容器中最后一个元素的下一个位置
	vector<int>::iterator end = v.end();
	//使用起始迭代器和结束迭代器来遍历数组
	while (begin != end) {
		cout << *begin << endl;
		begin++;
	}

	cout << "second method --------------------" << endl;

	//使用for循环遍历数组
	for (vector<int>::iterator b = v.begin(); b < v.end(); b++) {
		cout << *b << endl;
	}

	cout << "third method --------------------" << endl;

	//使用标准算法中的for_each函数
	for_each(v.begin(), v.end(), myPonit);
}

int main() {
	test51();

	system("pause");
	return 0;
}
```

#### 1.5.2vector放置自定义数据类型

````c++
#include<iostream>
using namespace std;
#include<vector>
#include<string>
#include<algorithm>

class Person {
public:
	Person(string name, int age) {
		this->name = name;
		this->age = age;
	}

	string name;
	int age;
};

void test61() {
	vector<Person> v;

	for (int i = 0; i < 10; i++) {
		Person p("aa" + to_string(i), i * 2);
		v.push_back(p);
	}

	for (vector<Person>::iterator i = v.begin(); i < v.end(); i++) {
		cout << "name = " << i->name << " age = " << i->age << endl;
	}
}

void per(Person* p) {
	cout << "name = " << (*p).name << " age = " << (*p).age << endl;
}

void test62() {
	vector<Person*> v;
	
	Person p1("aa1", 11);
	v.push_back(&p1);
	Person p2("aa2", 12);
	v.push_back(&p2);
	Person p3("aa3", 13);
	v.push_back(&p3);
	Person p4("aa4", 14);
	v.push_back(&p4);
	Person p5("aa5", 15);
	v.push_back(&p5);

	for (vector<Person *>::iterator i = v.begin(); i < v.end(); i++) {
		cout << "name = " << (*(*i)).name << " age = " << (*(*i)).age << endl;
	}

	//使用标准算法
	for_each(v.begin(), v.end(), per);
}

int main() {
	test62();

	system("pause");
	return 0;
}
````

#### 1.5.3嵌套vector

```c++
#include<iostream>
#include<string>
#include<vector>
#include<algorithm>
using namespace std;

void test71() {
	vector<vector<int>> bv;

	vector<int> v1;
	vector<int> v2;
	vector<int> v3;
	vector<int> v4;
	vector<int> v5;

	for (int i = 0; i < 10; i++) {
		v1.push_back(10 + i);
		v2.push_back(20 + i);
		v3.push_back(30 + i);
		v4.push_back(40 + i);
		v5.push_back(50 + i);
	}

	bv.push_back(v1);
	bv.push_back(v2);
	bv.push_back(v3);
	bv.push_back(v4);
	bv.push_back(v5);

	for (vector<vector<int>>::iterator i = bv.begin(); i < bv.end(); i++) {
		for (vector<int>::iterator j = (*i).begin(); j < (*i).end(); j++) {
			cout << " data = " << *j;
		}
		cout << "\n" << endl;
	}
}

int main() {
	test71();

	system("pause");
	return 0;
}
```

## 二、`string`容器

### 2.1string基本概念

**本质：**

- string是C++风格的字符串，而string本质上是一个类

**string和char*区别：**

- char*是一个指针
- string是一个类，类内部封装了char*，管理这个字符串，是一个char\*型的容器

**特点：**

- string类内部封装了很多成员方法，如：查找find，拷贝copy，删除delete，替换replace，插入insert
- string管理char*所分配的内存，不用担心赋值越界和取值越界等，由类内部进行负责

### 2.2string构造函数

**构造函数原型：**

| 函数                         | 描述                                     |
| ---------------------------- | ---------------------------------------- |
| `string();`                  | 创建一个空字符串 如：`string str;`       |
| `string(const char * s);`    | 使用字符串s初始化                        |
| `string(const string& str);` | 使用一个string对象初始化另一个string对象 |
| `string(int n, char c);`     | 使用n个字符c初始化                       |

### 2.3string赋值操作

**函数原型：**

| 函数                                  | 描述                                   |
| ------------------------------------- | -------------------------------------- |
| string& operator=(const char* s);     | char*类型字符串，赋值给当前的字符串    |
| string& operator=(const string &s);   | 把字符串s赋给当前的字符串              |
| string& operator=(char c);            | 字符赋值给当前的字符串                 |
| string& assign(const char *s);        | 把字符串s赋值给当前的字符串            |
| string& assign(const char *s, int n); | 把字符串s的前n个字符赋值给当前的字符串 |
| string& assign(const string &s);      | 把字符串s赋值给当前字符串              |
| string& assign(int n, char c);        | 用n个字符c赋值给当前字符串             |

### 2.4string字符串拼接

函数原型：

| 函数                                             | 描述                                        |
| ------------------------------------------------ | ------------------------------------------- |
| string& operator+=(constr char* str);            | 重载+=操作符                                |
| string& operator+=(const char c);                | 重载+=操作符                                |
| string& operator+=(const string& str);           | 重载+=操作符                                |
| string& append(const char *s);                   | 把字符串s连接到当前字符串结尾               |
| string& append(const char *s, int n);            | 把字符串s的前n个字符连接到当前字符串结尾    |
| string& append(const string &s);                 | 同operator+=(const string& str)             |
| string& append(const string &s, int pos, int n); | 字符串s中从pos开始的n个字符连接到字符串结尾 |

### 2.5string查找和替换

| 函数                                                | 描述                                          |
| --------------------------------------------------- | --------------------------------------------- |
| int find(const string& str, int pos = 0) const;     | 查找str第一次出现位置，从pos开始查找          |
| int find(const char* s, int pos = 0) const;         | 查找s第一次出现位置，从pos开始查找            |
| int find(const char* s, int pos, int n) const;      | 从pos位置开始查找s的前n个字符第一次出现的位置 |
| int find(const char c, int pos = 0) const;          | 查找字符c第一次出现位置                       |
| int rfind(const string& str, int pos = npos) const; | 查找str最后一次位置，从pos开始查找            |
| int rfind(const char* s, int pos = npos) const;     | 查找s最后一次出现位置，从pos开始查找          |
| int rfind(const char* s, int pos, int n) const;     | 从pos查找s的前n个字符最后一次位置             |
| int rfind(const char c, int pos = 0) const;         | 查找字符c最后一次出现位置                     |
| string& replace(int pos, int n, const string& str); | 替换从pos开始n个字符为字符串str               |
| string& replace(int pos, int n, const char* s);     | 替换从pos开始的n个字符为字符串s               |

### 2.6string字符串比较

比较方式：

- 字符串比较是按照字符的ASCII码进行对比
- =返回0
- \>返回1
- <返回-1

**函数原型：**

| 函数                                 | 描述          |
| ------------------------------------ | ------------- |
| int compare(const string & s) const; | 与字符串s比较 |
| int compare(const char * s) const;   | 与字符串s比较 |

### 2.7字符存取

| 函数                       | 描述               |
| -------------------------- | ------------------ |
| char& operator[]\(int n\); | 通过[]方式取字符   |
| char& at(int n);           | 通过at方法获取字符 |

### 2.8string插入和删除

**函数原型：**

| 函数                                        | 描述                   |
| ------------------------------------------- | ---------------------- |
| string& insert(int pos, const char* s);     | 插入字符串             |
| string& insert(int pos, const string& str); | 插入字符串             |
| string& insert(int pos, int n, char c);     | 在指定位置插入n个字符c |
| string& erase(int pos, int n = npos);       | 删除从pos开始的n个字符 |

### 2.9获取string子串

函数原型：

- `string substr(int pos = 0, int n = npos) const;`：返回由pos开始的n个字符组成的字符串

## 三、vector容器

### 3.1vector基本概念

**功能：**

- vector数据结构和数组非常相似，也称为单端数组

**vector与普通数组的区别**

- 不同之处在于数组式静态空间，而vector动态拓展

**动态拓展：**

- 并不是在原空间之后续接新空间，而是找更大的内存空间，然后将原数据拷贝新空间，释放原空间

**图示：**

![](E:\PerFile\notes\markdown\C++\photo\vector容器示意图.png)

> vector容器的迭代器是支持随机访问的迭代器

### 3.2vector构造函数

**函数原型：**

| 函数                        | 描述                                      |
| --------------------------- | ----------------------------------------- |
| vector\<T\> v;              | 采用模板实现类实现，默认构造函数          |
| vector(v.begin(), v.end()); | 将v[begin(), end()]区间中的元素拷贝给本身 |
| vector(n, elem);            | 构造函数将n个elem拷贝给本身               |
| vector(const vector &vec);  | 拷贝构造函数                              |

### 3.3vector赋值操作

**函数原型：**

| 函数                                  | 描述                                   |
| ------------------------------------- | -------------------------------------- |
| vector& operator=(const vector &vec); | 重载等号操作符                         |
| assign(beg, end);                     | 将[beg, end)区间中的数据拷贝赋值给本身 |
| assign(n, elem);                      | 将n个elem拷贝赋值给本身                |

### 3.4vector容量和大小

**函数原型：**

| 函数                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| empty();               | 判断容器是否为空                                             |
| capacity();            | 容器的容量                                                   |
| size();                | 返回容器中元素的个数                                         |
| resize(int num);       | 重新指定容器的长度为num，若容器变长，则以默认值填充新位置。若容器变短，则末尾超出容器长度的元素被删除 |
| resize(int num, elem); | 重新指定容器的长度为num若容器变长，则以elem值填充新位置。若容器变短，则末尾超出容器长度的元素被删除 |

### 3.5vector插入和删除

**函数原型：**

| 函数                                             | 描述                                |
| ------------------------------------------------ | ----------------------------------- |
| push_back(ele);                                  | 尾部插入元素ele                     |
| pop_back();                                      | 删除最后一个元素                    |
| insert(const_iterator pos, ele);                 | 迭代器指向位置pos插入元素ele        |
| insert(const_iterator pos, int count, ele);      | 迭代器指向位置pos插入count个元素ele |
| erase(const_iterator pos);                       | 删除迭代器指向的元素                |
| erase(const_iterator start, const_iterator end); | 删除迭代器从start到end之间的元素    |
| clear();                                         | 删除容器中所有元素                  |

### 3.6vector数据存取

**函数原型：**

| 函数         | 描述                       |
| ------------ | -------------------------- |
| at(int idx); | 返回索引idx所指的数据      |
| operator[];  | 返回索引idx所指的数据      |
| front();     | 返回容器中第一个数据元素   |
| back();      | 返回容器中最后一个数据元素 |

### 3.7vector互换容器

**函数原型：**

- `swap(vec);`：将vec与本身的元素互换

> 使用`vector<T>(v).swap(v);`

### 3.8vector预留空间

功能描述：

- 减少vector在动态扩展容量时的扩展次数

函数原型：

- `reserve(int len);`：容器预留len个元素长度，预留位置不初始化，元素不可访问

## 四、deque容器

### 4.1deque容器基本概念

**功能：**

- 双端数组，可以对头端进行插入删除操作

**deque与vector区别：**

- vector对于头部的插入删除效率低，数据量越大，效率越低
- deque相对而言，对头部的插入删除速度比vector快
- vector访问元素时的速度会比deque快，与内部实现有关

**示意图：**

![](E:\PerFile\notes\markdown\C++\photo\deque容器示意图.png)

**deque内部工作原理：**

- deque内部有一个中控器，维护每段缓冲区中的内容，缓冲区中存放真实数据

- 中控器维护的是每个缓冲区的地址，使得使用deque时像一片连续的内存空间

**图示：**

![](E:\PerFile\notes\markdown\C++\photo\deque容器原理示意图.png)

> deque容器的迭代器也是支持随机访问的

### 4.2deque构造函数

**函数原型：**

| 函数                     | 描述                                       |
| ------------------------ | ------------------------------------------ |
| deque\<T\> deqT;         | 默认构造形式                               |
| deque(beg, end);         | 构造函数将[beg, end)区间中的元素拷贝给本身 |
| deque(n, elem);          | 构造函数将n个elem拷贝给本身                |
| deque(const deque &deq); | 拷贝构造函数                               |

### 4.3deque赋值操作

**函数原型：**

| 函数                                | 描述                               |
| ----------------------------------- | ---------------------------------- |
| deque& operator=(const deque &deq); | 重载等号操作符                     |
| assign(beg, end);                   | 将[beg, end)区间中的数据拷贝给本身 |
| assign(n, elem);                    | 将n个elem拷贝赋值给本身            |

### 4.4deque大小操作

**函数原型：**

| 函数                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| empty();               | 判断容器是否为空                                             |
| size();                | 返回容器中元素的个数                                         |
| resize(int num);       | 重新指定容器的长度为num，若容器变长，则以默认值填充新位置。若容器变短，则末尾超出容器长度的元素被删除 |
| resize(int num, elem); | 重新指定容器的长度为num若容器变长，则以elem值填充新位置。若容器变短，则末尾超出容器长度的元素被删除 |

### 4.5deque插入和删除

**函数原型：**

*两端插入操作：*

| 函数             | 描述                   |
| ---------------- | ---------------------- |
| push_back(elem)  | 在容器尾部添加一个数据 |
| push_front(elem) | 在容器头部添加一个数据 |
| pop_back()       | 删除容器最后一个数据   |
| pop_front()      | 删除容器第一个数据     |

*指定位置操作：*

| 函数                  | 描述                                              |
| --------------------- | ------------------------------------------------- |
| insert(pos, elem)     | 在pos位置插入一个elem元素的拷贝，返回新数据的位置 |
| insert(pos, n, elem)  | 在pos位置插入n个elem数据，无返回值                |
| insert(pos, beg, end) | 在pos位置插入[beg, end)区间的数据，无返回值       |
| clear()               | 清空容器的所有数据                                |
| erase(beg, end)       | 删除[beg, end)区间的数据，返回下一个数据的位置    |
| erase(pos)            | 删除pos位置的数据，返回下一个数据的位置           |

### 4.6deque数据存取

函数原型：

| 函数          | 描述                       |
| ------------- | -------------------------- |
| at(int idx)   | 返回索引idx所指的数据      |
| operator[idx] | 返回索引idx所指的数据      |
| front()       | 返回容器中第一个数据元素   |
| back()        | 返回容器中最后一个数据元素 |

### 4.7deque排序

- `sort(iterator beg, iterator end)`：对beg和end区间内元素进行排序

## 五、stack容器

### 5.1基本概念

概念：stack是一种先进后出(First In Last Out, FILO)的数据结构，它只有一个出口

![](E:\PerFile\notes\markdown\C++\photo\stack容器示意图.png)

栈中只有顶端的元素才可以被外界使用，因此栈不允许有遍历行为

栈中进入数据成为——入栈`push`

栈中弹出数据称为——出栈`pop`

### 5.2常用接口

构造函数：

- `stack<T> stk;`：stack采用模板类实现，stack对象的默认构造形式
- `stack(const stack & stk)`：拷贝构造函数

赋值操作：

- `stack& operator=(const stack &stk)`：重载等号操作符

数据存取：

- `push(elem)`：向栈顶添加元素
- `pop()`：从栈顶移出第一个元素
- `top()`：返回栈顶元素

大小操作：

- `empty()`：判断堆栈是否为空
- `size()`：返回栈的大小

## 六、queue容器

### 6.1queue基本概念

概念：Queue是一种先进先出(First In First Out,FIFO)的数据结构，有两个出口

![](E:\PerFile\notes\markdown\C++\photo\queue容器示意图.png)

队列容器允许从一段新增元素，从另一端移除元素

队列中只有队头和队尾可以被外界使用，因此队列不可以被遍历

队列中进数据称为——入队`push`

队列中出数据称为——出队`pop`

### 6.2容器常用接口

构造函数：

- `queue<T> que`：queue采用模板类实现，queue对象的默认构造形式
- `queue(const queue &que)`：拷贝构造函数

赋值操作：

- `queue& operator=(const queue &que)`：重载等号操作符

数据存取：

- `push(elem)`：往队尾添加元素
- `pop()`：从队头移除第一个元素
- `back()`：返回最后一个元素
- `front()`：返回第一个元素

大小操作：

- `empty()`：判断容器是否为空
- `size()`：返回容器的大小

## 七、list容器

### 7.1基本概念

功能：将数据进行链式存储

链表（list）是一种物理存储单元上非连续的存储结构，数据元素的逻辑顺序是通过链表中的指针链接实现的

链表的组成：链表由一系列结点组成

结点的组成：一个是储存数据元素的数据域，另一个是存储下一个结点地址的指针域

STL中的链表是一个双向循环链表

![](E:\PerFile\notes\markdown\C++\photo\List容器示意图.png)

由于链表储存方式并不是连续的内存空间，因此链表list中的迭代器只支持前移和后移，属于双向迭代器

list的优点：

- 采用动态储存分配，不会造成内存浪费和溢出
- 链表执行插入和删除操作十分方便，修改指针即可，不需要移动大量元素

list的缺点：

- 链表灵活，但是空间（指针域）和时间（遍历）额外耗费较大

List有一个重要的性质，插入操作和删除操作都不会造成原有list迭代器的失效，这在vector是不成立的

### 7.2构造函数

**函数原型：**

| 函数                      | 描述                                      |
| ------------------------- | ----------------------------------------- |
| list\<T\> lst;            | 采用模板实现类实现，默认构造函数          |
| list(v.begin(), v.end()); | 将v[begin(), end()]区间中的元素拷贝给本身 |
| list(n, elem);            | 构造函数将n个elem拷贝给本身               |
| list(const vector &vec);  | 拷贝构造函数                              |

### 7.3赋值操作

**函数原型：**

| 函数                             | 描述                               |
| -------------------------------- | ---------------------------------- |
| assign(beg, end);                | 将[beg, end)区间中的数据拷贝给本身 |
| assign(n, elem);                 | 将n个elem拷贝赋值给本身            |
| list& operator=(const list &lst) | 重载等号操作符                     |
| swap(lst)                        | 将lst与本身的元素互换              |

### 7.4容量和大小

**函数原型：**

| 函数                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| empty();               | 判断容器是否为空                                             |
| size();                | 返回容器中元素的个数                                         |
| resize(int num);       | 重新指定容器的长度为num，若容器变长，则以默认值填充新位置。若容器变短，则末尾超出容器长度的元素被删除 |
| resize(int num, elem); | 重新指定容器的长度为num若容器变长，则以elem值填充新位置。若容器变短，则末尾超出容器长度的元素被删除 |

### 7.5插入和删除

**函数原型：**

*两端插入操作：*

| 函数             | 描述                   |
| ---------------- | ---------------------- |
| push_back(elem)  | 在容器尾部添加一个数据 |
| push_front(elem) | 在容器头部添加一个数据 |
| pop_back()       | 删除容器最后一个数据   |
| pop_front()      | 删除容器第一个数据     |

*指定位置操作：*

| 函数                  | 描述                                              |
| --------------------- | ------------------------------------------------- |
| insert(pos, elem)     | 在pos位置插入一个elem元素的拷贝，返回新数据的位置 |
| insert(pos, n, elem)  | 在pos位置插入n个elem数据，无返回值                |
| insert(pos, beg, end) | 在pos位置插入[beg, end)区间的数据，无返回值       |
| clear()               | 清空容器的所有数据                                |
| erase(beg, end)       | 删除[beg, end)区间的数据，返回下一个数据的位置    |
| erase(pos)            | 删除pos位置的数据，返回下一个数据的位置           |
| remove(elem)          | 删除容器中所有与elem值匹配的元素                  |

### 7.6数据存取

**函数原型：**

| 函数     | 描述                       |
| -------- | -------------------------- |
| front(); | 返回容器中第一个数据元素   |
| back();  | 返回容器中最后一个数据元素 |

### 7.7翻转排序

- `reverse()`：反转链表

- `sort()`：对链表中的元素进行排序

## 八、set/multiset容器

### 8.1基本概念

**简介：**

- 所有元素都会在插入时自动被排序

**本质：**

- set/multiset属于关联式容器，底层结构是用二叉树实现

**set和multiset区别：**

- set不允许容器中有重复的元素
- multiset允许容器中有重复的元素

### 8.2set构造和赋值

**构造：**

- `set\<T\> st`：默认构造函数
- `set(const set &st)`：拷贝构造函数

**赋值：**

- `set& operator=(const set &st)`：重载等号操作符

### 8.3set大小和交换

**函数原型：**

| 函数     | 描述                 |
| -------- | -------------------- |
| size()   | 返回容器中元素的数目 |
| empty()  | 判断容器是否为空     |
| swap(st) | 交换两个集合容器     |

### 8.4set插入和删除

**函数原型：**

| 函数            | 描述                                           |
| --------------- | ---------------------------------------------- |
| insert(elem)    | 插入一个elem元素                               |
| clear()         | 清空容器的所有数据                             |
| erase(beg, end) | 删除[beg, end)区间的数据，返回下一个数据的位置 |
| erase(pos)      | 删除pos位置的数据，返回下一个数据的位置        |
| erase(elem)     | 删除容器中值为elem的元素                       |

### 8.5set查找和统计

**函数原型：**

- `find(key)`：查找key是否存在，若存在，返回该键的元素的迭代器；若不存在，返回set.end()
- `count(key)`：统计key的元素个数

### 8.6set和multiset区别

**区别：**

- set不可插入重复数据，而multiset可以
- set插入数据的同时会返回插入结果，表示插入是否成功
- multiset不会监测数据，因此可以插入重复数据

### 8.7pair对组的创建

**两种创建方式：**

- `pair<type, type> p (value1, value2)`
- `pair<type, type> p = make_pair(value1, value2)`

### 8.8set容器排序

- 利用仿函数，可以改变排序规则

## 九、map/multimap容器

### 9.1基本概念

**简介：**

- map中所有元素都是pair
- pair中第一个元素为key（键值），起到索引作用，第二个元素为value（实值）
- 所有元素都会根据元素的键值自动排序

本质：

- map/multimap属于关联式容器，底层结构使用二叉树实现

优点：

- 可以根据key值快速找到value值

map和multimap区别：

- map不允许容器中有重复的key值元素
- multimap允许容器中有重复key值元素

### 9.2map构造和赋值

函数原型：

构造：

- `map<T1, T2> mp`：map默认构造函数
- `map(const map & map)`：拷贝构造函数

赋值：

- `map& operator=(const map &mp)`重载等号操作符

### 9.3map大小和交换

**函数原型：**

| 函数     | 描述                 |
| -------- | -------------------- |
| size()   | 返回容器中元素的数目 |
| empty()  | 判断容器是否为空     |
| swap(st) | 交换两个集合容器     |

### 9.4map插入和删除

**函数原型：**

| 函数            | 描述                                           |
| --------------- | ---------------------------------------------- |
| insert(elem)    | 插入一个elem元素                               |
| clear()         | 清空容器的所有数据                             |
| erase(beg, end) | 删除[beg, end)区间的数据，返回下一个数据的位置 |
| erase(pos)      | 删除pos位置的数据，返回下一个数据的位置        |
| erase(key)      | 删除容器中值为key的元素                        |

### 9.5map查找和统计

**函数原型：**

- `find(key)`：查找key是否存在，若存在，返回该键的元素的迭代器；若不存在，返回set.end()
- `count(key)`：统计key的元素个数

### 9.6map容器排序

- 利用仿函数，可以改变排序规则