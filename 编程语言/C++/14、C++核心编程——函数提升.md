[TOC]

# C++核心编程——函数提升

## 一、函数默认参数

- 在C++中，函数的形参列表中的形参是可以有默认值的
- 语法：`返回值类型 函数名 (参数=默认值){}`

**示例**

```c++
#include<iostream>
using namespace std;

int t4func2(int a, int b = 10, int c = 20) {
	return a + b + c;
}

int main() {
	cout << t4func2(10) << endl; //40
	cout << t4func2(10, 10, 20) << endl; //40

	system("pause");
	return 0;
}
```

> 注意：
>
> - 在函数参数列表中某个位置已经有了默认参数，那么从这个参数开始往后的参数必须有默认值
> - 如果函数声明中有默认参数，函数实现就不能有默认参数

## 二、函数占位参数

- C++中函数的形参列表里可以有占位参数，用来占位，调用函数时必须填补此位置
- 语法：`返回值类型 函数名(数据类型){}`

```c++
#include<iostream>
using namespace std;

void t4func3(int a, int) {
	cout << "a = " << a << endl;
}

int main() {
	t4func3(1, 1);

	system("pause");
	return 0;
}
```

## 三、函数重载

### 3.1函数重载描述

**作用：**函数名可以相同，提高复用性

**函数重载满足条件**

- 同一作用域下
- 函数名称相同
- 函数参数**类型不同** 或者**个数不同** 或者**顺序不同**

**注意：**

- 函数的返回值不可以作为函数重载的条件
- 函数重载需要函数都在同一作用域下

**示例：**

```c++
#include<iostream>
using namespace std;

void t5func1(int a) {
	cout << "a = " << a << endl;
}

void t5func1(int a, int b) {
	cout << "a = " << a << " b = " << b << endl;
}

int main() {

	t5func1(1);
	t5func1(1, 1);

	/*
		a = 1
		a = 1 b = 1
	*/

	system("pause");
	return 0;
}
```

### 3.2函数重载注意事项

- 引用作为重载条件

```c++
#include<iostream>
using namespace std;

void t5func2(int& a) {
	cout << "t5func2(int& a) = " << a << endl;
}

void t5func2(const int& a) {
	cout << "t5func2(const int& a) = " << a << endl;
}

int main() {
	int a = 10;
	t5func2(a); // t5func2(int& a) = 10
	t5func2(1); // t5func2(const int& a) = 1
    
	system("pause");
	return 0;
}
```

- 函数重载碰到函数默认参数
  - 当遇到这种情况时会出现二义性，编译器会报错