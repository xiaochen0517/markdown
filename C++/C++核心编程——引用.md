# C++核心编程——引用

## 一、引用的基本使用

**作用：**给变量起别名

**语法：**`数据类型 &别名 = 原名`

- 两个变量指向的是同一块内存地址

```c++
#include<iostream>
using namespace std;

int main() {
	//使用引用
	int a = 10;
	int& b = a;

	cout << "a = " << a << endl; //10
	cout << "b = " << b << endl; //10

	cout << "a = " << &a << endl; //00AFFAF0
	cout << "b = " << &b << endl; //00AFFAF0

	b = 100;

	cout << "a = " << a << endl; //100
	cout << "b = " << b << endl; //100

	system("pause");
	return 0;
}
```

## 二、引用注意事项

- 引用必须初始化
- 引用在初始化后，不可以改变

**示例**

```c++
#include<iostream>
using namespace std;

int main() {
	//使用引用
	int a = 10;
	int& b = a;

	cout << "a = " << a << endl; //10
	cout << "b = " << b << endl; //10

	cout << "a的内存地址" << &a << endl; //00AFFAF0
	cout << "b的内存地址" << &b << endl; //00AFFAF0

	//初始化后不可以更改
	int c = 100;

	b = c;//此行是赋值操作

	cout << "a = " << a << endl; //100
	cout << "b = " << b << endl; //100
	cout << "c = " << c << endl; //100

	cout << "a的内存地址" << &a << endl; //00AFFAF0
	cout << "b的内存地址" << &b << endl; //00AFFAF0
	cout << "c的内存地址" << &c << endl; //004FFE34
    
	system("pause");
	return 0;
}
```

> 总结：由此可见，引用在初始化之后，指向的内存地址不能更改

## 三、引用做函数参数

**作用：**函数传参时，可以利用引用的技术让形参修饰实参

**优点：**可以简化指针修改实参

**示例：**

```c++
#include<iostream>
using namespace std;

void t3func1(int &a, int &b) {
	int c = a;
	a = b;
	b = c;
}

int main() {
	int one = 10;
	int two = 20;

	t3func1(one, two);

	cout << "one = " << one << endl; //20
	cout << "two = " << two << endl; //10

	system("pause");
	return 0;
}
```

> 引用传递和地址传递效果都是相同的，只是引用的方法更加简洁

## 四、引用的本质

- 引用的本质在c++内部实现是一个指针常量

- ```c++
  int a = 10;
  int& b = a;
  //相等于
  int * const b = &a;
  ```

## 五、常量引用

**作用：**常量引用主要用来修饰形参，防止误操作

在函数形参列表中，可以加==const修饰形参==，防止形参改变实参

```c++
#include<iostream>
using namespace std;

void t4func1(const int& a) {
	//a = 1000; // 使用const修饰形参之后参数不可以修改
	cout << "a = " << a << endl;
}

int main() {
	int a = 10;
	t4func1(a);

	system("pause");
	return 0;
}
```

