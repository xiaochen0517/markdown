[TOC]

# C++结构体

## 一、结构体的基本概念

- 结构体属于用户自定义的数据类型，允许用户储存不同的数据类型

## 二、结构体定义和使用

### 2.1定义

- 语法：`struct 结构体名 { 结构体成员列表 }`
- 通过结构体创建变量的方式有三种：
  - `struct 结构体名 变量名`
  - `struct 结构体名 变量名 = { 成员1值, 成员2值, ...}`
  - 定义结构体时顺便创建变量

- 示例

```c++
#include <iostream>
using namespace std;

struct Student
{
	string name;
	int age;
	string gender;
};

int main() {
	// 创建对象
	struct Student s1;

	// 赋值
	s1.name = "tom";
	s1.age = 20;
	s1.gender = "man";

	// name = tom age = 20 gender = man
	cout << "name = " << s1.name << " age = " << s1.age << " gender = " << s1.gender << endl;

	system("pause");
	return 0;
}
```

### 2.2使用

- 语法：`结构体变量.结构体属性名`
- 示例：

```c++
s1.name
```

## 二、结构体数组

- 作用：将自定义的结构体放入数组中方便维护
- 语法：`struct 结构体名 数组名[元素个数] = {{}, {}, ... {}}`
- 示例：

```c++
	struct Student stuArray[3] =
	{
		{"Tom", 20, "man"},
		{"Rose", 21, "women"},
		{"Jack", 23, "man"}
	};

	stuArray[2].name = "bill";

	for (int i = 0; i < 3; i++)
	{
		cout << "name = " << stuArray[i].name << " age = " << stuArray[i].age << " gender = " << stuArray[i].gender << endl;
	}

	/*
	name = Tom age = 20 gender = man
	name = Rose age = 21 gender = women
	name = bill age = 23 gender = man
	*/
```

## 三、结构体指针

- 作用：通过指针访问结构体中的成员
- 利用操作符`->`可以通过结构体指针访问结构体属性

- 示例：

```c++
	Student s2 = { "Tom", 21, "man" };
	Student* p = &s2;

	// 通过结构体指针访问数据
	cout << "name = " << p->name << " age = " << p->age << " gender = " << p->gender << endl;
	// name = Tom age = 21 gender = man
```

## 四、结构体嵌套

```c++
#include <iostream>
using namespace std;

struct Student
{
	string name;
	int age;
	string gender;
};

struct Teacher
{
	string name;
	int age;
	Student stu;
};

int main() {

	Teacher t1 = { "rose", 30, {"tom", 20, "man"} };
	cout << "name = " << t1.name << " age = " << t1.age <<
		" stu.name = " << t1.stu.name <<
		" stu.age = " << t1.stu.age <<
		" stu.gender = " << t1.stu.gender << endl;

	/*
	name = rose age = 30 stu.name = tom stu.age = 20 stu.gender = man
	*/

	system("pause");
	return 0;
}
```

## 五、结构体做函数参数

**作用**：将结构体作为参数向函数中传递

传递方式有两种

- 值传递
- 地址传递

> 用法同普通参数传递