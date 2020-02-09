[TOC]

# C++编程提高——模板

## 一、模板的概念

模板就是建立通用的模具，打打提高复用性

模板的特点：

- 模板不可以直接使用，它只是一个框架
- 模板的通用并不是万能的

## 二、函数模板

- C++另一种编程思想称为==泛型编程==，主要利用的技术就是模板
- C++提供两种模板机制：**函数模板**和**类模板**

### 2.1函数模板语法

函数模板的作用：

建立一个通用函数，其函数返回值类型和形参类型可以不具体指定，用一个**虚拟的类型**来代表



**语法：**

```c++
template<typename T>
函数声明或定义
```



**解释：**

`template`：声明创建模板

`typename`：表面其后面的符号是一种数据类型，可以用class代替

`T`：通用的数据类型，名称可以替换，通常为大写字母



**示例：**

```c++
template<typename T>
void mySwap(T& a, T& b) {
	T temp = a;
	a = b;
	b = temp;
}

void test11() {
	int a = 10;
	int b = 20;
	//自动类型推导
	//mySwap(a, b);
	//设置类型
	mySwap<int>(a, b);
	cout << "a = " << a << endl;
	cout << "b = " << b << endl;
}
```

### 2.2函数模板注意事项

注意事项：

- 自动类型推导，必须推导出一致的数据类型T，才可以使用
- 模板必须要确定出T的数据类型，才可以使用

### 2.3普通函数与函数模板的区别

- 普通函数调用时可以发生自动类型转换（隐式类型转换）
- 函数模板调用时，如果利用自动类型推导，不会发生隐式类型转换
- 如果利用显示指定类型的方式，可以发生隐式类型转换

### 2.4普通函数与函数模板的调用规则

如下：

- 如果函数模板和普通函数都可以实现，优先调用普通函数
- 可以通过空模板参数列表来强制调用函数模板
- 函数模板也可以发生重载
- 如果函数模板可以产生更好的匹配，优先调用函数模板

## 三、类模板

### 3.1类模板语法

作用：建立一个通用类，类中的成员数据类型可以不具体制定，用一个**虚拟的类型**代表。

**语法：**

```c++
template<typename T>
类
```

**解释：**

- `template`：声明创建模板
- `typename`：表面其后面的符号是一种数据类型，可以用class代替
- `T`：通用的数据类型，名称可以替换，通常为大写字母

**示例：**

```c++
#include<iostream>
using namespace std;

template<class nameType, class ageType>
class Person {
public:
	Person(nameType name, ageType age) {
		this->name = name;
		this->age = age;
	}

	void showInfo() {
		cout << "name = " << this->name << endl;
		cout << "age = " << this->age << endl;
	}

	nameType name;
	ageType age;
};

int main() {

	Person<string, int> p1("张三", 20);
	p1.showInfo();

	/*
		name = 张三
		age = 20
	*/

	system("pause");
	return 0;
}
```

### 3.2类模板与函数模板的区别

- 类模板没有自动推导的使用方式
- 类模板在模板参数列表中可以有默认参数

```c++
template<class nameType, class ageType = int>
```

### 3.3类模板中成员函数创建时机

- 普通类中的成员函数在一开始就可以创建
- 类模板中的成员函数在调用时才创建

### 3.4类模板对象做函数参数

一共有三种传入方式：

- 指定传入的类型：直接显示对象的数据类型
- 参数模板化：将对象中的参数变为模板进行传递
- 整个类模板化：将这个对象类型模板化进行传递

**示例：**

```c++
#include<iostream>
using namespace std;

template<class T1, class T2>
class Person {
public:
	Person(T1 name, T2 age) {
		this->name = name;
		this->age = age;
	}

	void showInfo() {
		cout << "name = " << this->name << endl;
		cout << "age = " << this->age << endl;
	}

	T1 name;
	T2 age;
};

//使用直接指定类型
void testT31(Person<string, int> p) {
	p.showInfo();
}

void test31() {
	Person<string, int> p("Tom", 20);
	testT31(p);
}

//将参数模板化
template<class T1, class T2>
void testT32(Person<T1, T2> p) {
	p.showInfo();
}

void test32() {
	Person<string, int> p("Jack", 18);
	testT32(p);
}

//将整个类模板化
template<class T>
void testT33(T p) {
	p.showInfo();
}

void test33() {
	Person<string, int> p("Rose", 30);
	testT33(p);
}

int main() {

	test31();
	test32();
	test33();

	/*
		name = Tom
		age = 20
		name = Jack
		age = 18
		name = Rose
		age = 30
	*/

	system("pause");
	return 0;
}
```

### 3.5类模板与继承

注意：

- 当子类继承的父类是一个模板类时，子类在声明时要指定出父类中T的类型
- 如果不指定，编译器无法给子类分配内存
- 如果想灵活的指定出父类中T的类型，子类也需要变为类模板

### 3.6成员函数类外实现

**示例：**

```c++
template<class T1, class T2>
class Person {
public:
	Person(T1 name, T2 age);

	void showInfo();

	T1 name;
	T2 age;
};

template<class T1, class T2>
Person<T1, T2>::Person(T1 name, T2 age) {
	this->name = name;
	this->age = age;
}

template<class T1, class T2>
void Person<T1, T2>::showInfo() {
	cout << "name = " << this->name << endl;
	cout << "age = " << this->age << endl;
}
```

### 3.7类模板分文件编写

问题：

- 类模板中成员函数创建时机是在调用阶段，导致分文件编写时链接不到

解决：

- 直接包含`.cpp`文件
- 将声明和实现写到同一个文件中，并后缀名改为`.hpp`，此名称为约定的名称，并不是强制

### 3.8类模板与友元

全局函数类内实现：直接在类内声明友元即可

全局函数类外实现：需要提前让编译器知道全局函数的存在

**示例：**

```c++
#include<iostream>
using namespace std;

//需要让编译器知道Person的存在
template<class T1, class T2>
class Person;

//类外实现友元
template<class T1, class T2>
void getPersonMsg2(Person<T1, T2> p) {
	cout << "name = " << p.name << " age = " << p.age << endl;
}

template<class T1, class T2>
class Person {

	//类内实现友元
	friend void getPersonMsg(Person<T1, T2> p) {
		cout << "name = " << p.name << " age = " << p.age << endl;
	}

	//类外实现需要添加空模板参数列表
	friend void getPersonMsg2<>(Person<T1, T2> p);

public:
	Person(T1 name, T2 age) {
		this->name = name;
		this->age = age;
	}

private:
	T1 name;
	T2 age;
};

int main() {
	Person<string, int> p("tom", 20);
	getPersonMsg(p);
	getPersonMsg2(p);

	system("pause");
	return 0;
}
```

