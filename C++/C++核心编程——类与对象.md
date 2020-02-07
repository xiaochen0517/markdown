[TOC]

# C++核心编程——类与对象

C++面向对象的三大特征为：==封装、继承、多态==

C++认为==万事万物都皆为对象==，对象上有其属性和行为 

## 一、封装

### 1.1封装的意义

封装是C++面向对象三大特性之一

封装的意义：

- 将属性和行为作为一个整体，表现生活中的事物
- 将属性和行为加以权限控制

**语法：**`class 类名{ 访问权限：属性/行为 }`

**示例**

```c++
#include<iostream>
using namespace std;

class person {
private:
	string name;
	int age;
	string gender;
public:
	string getName() {
		return name;
	}
	void setName(string name) {
		this->name = name;
	}
};

int main() {

	person p;
	p.setName("tom");

	cout << p.getName() << endl; // tom


	system("pause");
	return 0;
}
```

### 1.2访问修饰符

类设计时，可以把属性和行为放在不同的权限下，加以控制

访问权限有三种

- `public`：公共权限
- `protected`：保护权限
- `private`：私有权限

### 1.3`struct`和`class`区别

在`C++`中`struct`和`class`唯一的区别就在于**默认的访问权限不同**

区别：

- `struct`默认权限为公共
- `class`默认权限为私有

## 二、对象

C++中的面向对象来源于生活，每个对象也都会有初始设置以及对象销毁前的清理数据的设置

### 2.1构造函数和析构函数

对象的**初始化和清理**也是两个非常重要的安全问题

- 一个对象或者变量没有初始装填，对其使用后果是未知的
- 同样的，使用完一个对象或者变量，没有及时清理，也会造成一定的安全问题

C++利用了**构造函数**和**析构函数**解决上述问题，这两个函数将会被编译器自动调用，完成对对象初始化和清理工作。对象的初始化和清理工作是编译器强制要我们做的事情，因此如果我们**不提供构造和析构**，编译器会提供默认的**空实现构造函数和析构函数**

- 构造函数：主要用于创建对象时为对象的成员属性赋值，构造函数由编译器自动调用，无需手动调用。
- 析构函数：主要用于对象**销毁前**系统自动调用，执行一些清理工作

**构造函数语法：**`类名(){}`

- 构造函数，没有返回值也不写`void`
- 函数名称与类名相同
- 构造函数可以有参数，因此可以发生重载
- 程序在调用对象时会自动调用构造，无需手动调用，而且只会调用一次

**析构函数语法：**`~类名(){}`

- 析构函数，没有返回值也不写`void`
- 函数名称与类名相同，在名称前加符号`~`
- 析构函数不可以参数，因此不可以发生重载
- 程序在对象销毁前会自动调用析构，无需手动调用，而且只会调用一次

**示例：**

```c++
#include<iostream>
using namespace std;

class person {
public:
	person() {
		cout << "构造函数执行" << endl;
	}

	~person() {
		cout << "析构函数执行" << endl;
	}
};

void t6func1() {
	person p;
}

int main() {

	t6func1();

	/*
		构造函数执行
		析构函数执行
	*/

	system("pause");
	return 0;
}
```

### 2.2构造函数的分类及调用

两种分类方式：

- 按参数分为：有参构造和无参构造
- 按类型分为：普通构造和拷贝构造

三种调用方式：

- 括号法
- 显式法
- 隐式转换法

**示例：**

```c++
#include<iostream>
using namespace std;

class person {
private:
	string name;
	int age;
	string gender;
public:
	person() {
		cout << "无参构造函数执行" << endl;
	}

	person(int age) {
		cout << "有参构造函数执行" << endl;
		this->age = age;
	}

	person(const person& p) {
		cout << "拷贝构造函数执行" << endl;
		this->age = p.age;
	}

	~person() {
		cout << "析构函数执行" << endl;
	}
};

int main() {

	// 括号法
	person p1;
	person p2(10);
	person p3(p2);

	//显式调用
	person p21 = person();
	person p22 = person(10);
	person p23 = person(p22);

	//隐式调用
	person p31 = 10; // person p22 = person(10);
	person p32 = p31; // person p23 = person(p22);

	/*
		无参构造函数执行
		有参构造函数执行
		拷贝构造函数执行
	*/

	system("pause");
	return 0;
}
```

### 2.3拷贝构造函数调用时机

C++中拷贝构造函数调用时机通常有三种情况

- 使用一个已经创建完毕的对象来初始化一个新对象
- 值传递的方式给函数参数传值
- 以值方式返回局部对象

### 2.4构造函数调用规则

默认情况下，C++编译器至少给一个类添加3个函数

- 默认构造函数（无参，函数体为空）
- 默认析构函数（无参，函数体为空）
- 默认拷贝构造函数，对属性进行值拷贝

构造函数调用规则如下：

- 如果用户定义有参构造函数，C++不再提供默认无参构造，但是会提供默认拷贝构造
- 如果用户定义拷贝构造函数，C++不会再提供其他构造函数

### 2.5深拷贝与浅拷贝

**浅拷贝：**简单的赋值拷贝操作

**深拷贝：**在堆区中重新申请空间进行拷贝操作

![](E:\PerFile\notes\markdown\C++\photo\浅拷贝导致指针重复释放.png)

**源码：**

```c++
#include<iostream>
using namespace std;

class Person {
public:
	Person() {
		cout << "无参构造函数" << endl;
		age = 18;
		height = new int(10);
	}

	Person(const Person& p) {
		age = p.age;
        //深拷贝
		height = new int(*p.height);
	}

	~Person() {
		cout << "析构函数" << endl;
		if (height != NULL)
		{
			delete height;
			height = NULL;
		}
	}

	int age;
	int* height;
};

void t7func1() {
	Person p1;
	Person p2(p1);
}

int main() {

	t7func1();

	system("pause");
	return 0;
}
```

### 2.6初始化列表

**作用：**C++提供了初始化列表语法，用来初始化属性

**语法：**`构造函数():属性1(值1),属性2(值2)...{}`

**示例：**

```c++
#include<iostream>
using namespace std;

class Person {
public:
	Person(int a, int b, int c) : m_A(a), m_B(b), m_C(c)
	{
	}

	int m_A;
	int m_B;
	int m_C;
};

int main() {

	Person p(10, 20, 30);

	cout << "a = " << p.m_A << endl;
	cout << "b = " << p.m_B << endl;
	cout << "c = " << p.m_C << endl;

	/*
		a = 10
		b = 20
		c = 30
	*/

	system("pause");
	return 0;
}
```

### 2.7类对象作为类成员

C++类中的成员可以是另一个类的对象，我们称该成员为对象成员

**例如：**

```c++
class A {}
class B {
    A a;
}
```

> 构造的顺序为：先调用对象成员的构造，再调用本类构造
>
> 析构顺序与构造相反

### 2.8静态成员

静态成员就是在成员变量和成员函数前加上关键字`static`称为静态成员

静态成员分为：

- 静态成员变量
  - 所有对象共享同一份数据
  - 在编译阶段分配内存
  - 类内声明，类外初始化
- 静态成员函数
  - 所有对象共享同一个函数
  - 静态成员函数只能访问静态成员变量

**示例：**

```c++
#include<iostream>
using namespace std;

class Person {
public:
	static void func() {
		a = 100;
		cout << "静态成员函数调用" << endl;
	}

	static int a;
};

int Person::a = 0;

int main() {

	//通过对象
	Person p;
	p.func();

	//通过类名
	Person::func();

	/*
		静态成员函数调用
		静态成员函数调用
	*/

	system("pause");
	return 0;
}
```

## 三、C++对象模型和this指针

### 3.1成员变量和成员函数分开存储

在C++中，类内的成员变量和成员函数分开存储

- 只有非静态成员变量才属于类的对象上

- 空对象：
  - 空对象占用内存空间为：1
  - C++编译器会给每个空对象页分配一个字节控件，是为了区分空对象占内存的位置
  - 每个空对象也应该有一个独一无二的内存地址

### 3.2`this`指针

每个非静态成员函数只会生成一份函数示例，也就是说多个同类型的对象会共用一块代码

C++通过提供特殊的对象指针，`this`指针，解决上述问题。**`this`指针指向被调用的成员函数所属的对象**

**`this`指针的特点**

- `this`指针是隐含每一个非静态成员函数内的一种指针
- `this`指针不需要定义，直接使用即可

**`this`指针的用途**

- 当形参和成员变量同名时，可用`this`指针来区分
- 在类的非静态成员函数中返回对象本身，可使用`return *this`

### 3.3空指针访问成员函数

C++中空指针也是可以调用成员函数的，但是也要注意有没有用到`this`指针

```c++
#include<iostream>
using namespace std;

class Man {
public:
	void showClassName() {
		cout << "Man" << endl;
	}

	void showAge() {
		//如果传入的this指针为空，则让程序跳出，否则会报错
		if (this == NULL)
		{
			return;
		}
		//在引用成员变量前默认添加着一个this指针
		cout << age << endl;
	}

	int age = 10;
};

int main() {
	
	Man* man = NULL;
	man->showClassName();
	man->showAge();//此行会触发this==NULL判断

	system("pause");
	return 0;
}
```

### 3.4`const`修饰成员函数

**常函数：**

- 成员函数后加const后我们称这个函数为**常函数**
- 常函数内不可以修改成员属性
- 成员属性声明时加关键字mutable后，在常函数中依然可以修改

**常对象：**

- 声明对象前加const称该对象为常对象
- 常对象只能调用常函数

**示例：**

```c++
#include<iostream>
using namespace std;

class Person {
public:

	//this指针相当于一个指针常量：Person * const this;
	//常函数相当于将this指针改为：const Person * const this;
	void func1() const
	{
		//a = 100;//不可以修改
		b = 100;
	}

	void func2() {

	}

	int a; // 此成员变量在常函数中不可以修改
	mutable int b; //使用mutable修饰的成员变量在常函数中可以修改
};

int main() {

	//常对象
	const Person p;
	//p.a = 100;//此变量在常对象中不可以修改
	p.b = 100;//使用mutable修饰的变量可以修改

	p.func1();//常对象只可以调用常函数

	system("pause");
	return 0;
}
```

## 四、友元

友元的目的就是让一个函数或者类访问另一个类中私有成员

友元的关键字为`friend`

友元的三种实现

- 全局函数做友元
- 类做友元
- 成员函数做友元

**示例：**

```c++
#include<iostream>
using namespace std;

class MyRoom;
class OtherBestFriend {
public:
	OtherBestFriend();

	void start1();

	MyRoom* myRoom;
};

/*
我的房间类
*/
class MyRoom {
	//全局函数作为友元
	friend void bestFriend(MyRoom* myRoom);
	//类作为友元
	friend class BestFriendClass;
	//成员函数作为友元
	friend void OtherBestFriend::start1();
public:
	MyRoom() {
		kt = "客厅";
		ws = "卧室";
	}

public:
	string kt;
private:
	string ws;
};

/*
实现OtherBestFriend构造函数
*/
OtherBestFriend::OtherBestFriend() {
	myRoom = new MyRoom();
}

/*
实现OtherBestFriend成员函数
*/
void OtherBestFriend::start1() {
	cout << "OtherBestFriend访问" << myRoom->kt << endl;
	//当成员函数作为友元时，在这个函数中就可以访问到类中的私有的属性
	cout << "OtherBestFriend访问" << myRoom->ws << endl;
}

class BestFriendClass {
public:
	BestFriendClass() {
		myRoom = new MyRoom();
	}
	void start() {
		cout << "BestFriendClass访问" << myRoom->kt << endl;
		//当类作为友元时，在这个函数中就可以访问到类中的私有的属性
		cout << "BestFriendClass访问" << myRoom->ws << endl;
	}

	MyRoom* myRoom;
};

void bestFriend(MyRoom * myRoom) {
	cout << "bestFriend访问" << myRoom->kt << endl;
	//当全局函数作为友元时，在这个函数中就可以访问到类中的私有的属性
	cout << "bestFriend访问" << myRoom->ws << endl;
}

int main() {
	MyRoom myRoom;
	bestFriend(&myRoom);

	BestFriendClass bfc;
	bfc.start();

	OtherBestFriend obf;
	obf.start1();

	system("pause");
	return 0;
}
```

## 五、运算符重载

运算符重载概念：对已有的运算符重新进行定义，赋予其另一种功能，以适应不同的数据类型

### 5.1加号运算符

作用：实现两个自定义数据类型相加的运算

```c++
#include<iostream>
using namespace std;

class Person {
public:
	int a;
	int b;

	Person() {
		a = 10;
		b = 10;
	}

	//使用成员函数重载+运算符
	//Person operator+(Person& p) {
	//	Person temp;
	//	temp.a = this->a + p.a;
	//	temp.b = this->b + p.b;
	//	return temp;
	//}
};

//使用全局函数重载+运算符
Person operator+(Person& p1, Person& p2) {
	Person p;
	p.a = p1.a + p2.a;
	p.b = p1.b + p2.b;
	return p;
}

int main() {

	Person p1;
	Person p2;
	Person p3 = p1 + p2;

	cout << "a -- " << p3.a << endl;
	cout << "b -- " << p3.b << endl;

	/*
		a -- 20
		b -- 20
	*/

	system("pause");
	return 0;
}
```

### 5.2左移运算符

```c++
operator<<(count, obj)
```

### 5.3递增运算符

```c++
operator++() //前置递增
operator++(int) //后置递增
```

### 5.4赋值运算符

C++编译器至少给一个类添加4个函数

- 默认构造函数（无参，函数体为空）
- 默认析构函数（无参，函数体为空）
- 默认拷贝构造函数，对属性进行值拷贝
- 赋值运算符`operator=`，对属性进行值拷贝

如果类中有属性指向堆区，做赋值操作时也会出现深浅拷贝问题

### 5.5关系运算符

```
operator==()
operator!=
```

### 5.6函数调用运算符

- 函数调用运算符()可以重载
- 由于重载后使用的方式非常像函数的调用，因此称为仿函数
- 仿函数没有固定写法，非常灵活

```
operator()()
```

## 六、继承

**继承时面向对象三大特性之一**

### 6.1继承的基本语法

```
class 子类: 继承方式 父类
```

**示例：**

```c++
#include<iostream>
using namespace std;

class Father {
public:
	void fatherFunc() {
		cout << "父类的方法" << endl;
	}
};

class Son :public Father {
public:
	void sonFunc() {
		cout << "子类的方法" << endl;
	}
};

int main() {
	Son s;
	s.fatherFunc(); //父类的方法
	s.sonFunc(); //子类的方法

	system("pause");
	return 0;
}
```

**总结：**

继承的好处：==可以减少重复的代码==

**子类中的成员，包含两大部分：**

- 父类中继承的成员
- 自己增加的成员

### 6.2继承的方式

继承的语法：`class 子类:继承方式 父类`

**继承方式一共有三种：**

- 公共继承
- 保护继承
- 私有继承

**图示**

![](E:\PerFile\notes\markdown\C++\photo\继承的三种方式.png)

### 6.3继承同名成员处理方式

- 访问子类同名成员 直接访问即可
- 访问父类同名成员 需要加作用域

```c++
子类名 son;
son.成员名; //访问的成员为子类中的成员
son.父类名::成员名; //访问的成员为父类中的成员
//同名函数同理
```

**总结：**

- 子类对象可以直接访问到子类中同名成员
- 子类对象加作用域可以访问到父类同名成员
- 单子类与父类拥有同名的成员函数，子类会隐藏父类中同名成员函数，加作用域可以访问到父类中同名函数

> 静态同名成员解决方法与此相同
>
> 通过类名：
>
> ```c++
> 子类::静态成员//访问子类中的静态成员
> 子类::父类::静态成员//访问父类中的静态成员
> ```

### 6.4多继承语法

语法：`class 子类:继承方式 父类1, 继承方式 父类2 ...`

多继承可能会引发父类中有同名成员出现，需要加作用域区分

**C++实际开发中不建议使用多继承**

### 6.5菱形继承

**概念：**

- 两个子类继承同一个父类，又有某个类同时继承着两个子类，这种继承被称为菱形继承

## 七、多态

### 7.1基本概念

**多态时C++面向对象三大特性之一**

多态分为两类：

- 静态多态：函数重载和运算符重载属于静态多态，复用函数名
- 动态多态：子类和虚函数实现运行时多态

静态多态和动态多态区别：

- 静态多态的函数地址早绑定 - 编译阶段确定函数地址
- 动态多态的函数地址晚绑定 - 运行阶段确定函数地址

动态多态的满足条件：

- 有继承关系
- 子类重写父类的虚函数

动态多态的使用：

- 使用父类的指针或者引用指向子类的对象

**示例：**

```c++
#include<iostream>
using namespace std;

class Human {
public:
	//virtual关键字：虚函数
	//添加virtual关键字，使函数地址晚加载，实现子类中的函数调用
	virtual void speak() {
		cout << "人类说话" << endl;
	}
};

class Jack : public Human {
public:
	void speak() {
		cout << "Jack说话" << endl;
	}
};

void doSpeak(Human& h) {
	h.speak();
}

int main() {
	
	Jack jack;
	doSpeak(jack);

	system("pause");
	return 0;
}
```

### 7.2多态的原理

- 当父类中的`speak()`函数返回类型前添加`virtual`关键时，父类内部会新增一个`vfptr`（virtual function pointer 虚函数表指针）。这个指针指向父类中的一个`vftable`（virtual function table 虚函数表），在此表中保存着一个父类`speak()`函数地址的指针——`&Human::speak`。
- 当子类继承父类并且重写父类的`speak()`函数时，子类中也会有一个`vfptr`和`vftable`，其`vftable`中储存的就是子类的`speak()`函数地址——`&Jack::speak`。
- 当使用父类的指针或者引用去指向之类的对象后，执行`speak()`函数时`vfptr`就会到子类的`vftable`中查找函数地址，此时执行的函数就是子类中的`speak()`函数。

**父类虚函数指针**

![](E:\PerFile\notes\markdown\C++\photo\多态Human类虚函数指针.png)

**子类虚函数指针**

![](E:\PerFile\notes\markdown\C++\photo\多态Jack类虚函数指针.png)

### 7.3纯虚函数和抽象类

在多态中，通常父类中虚函数的实现是毫无意义的，主要都是调用子类重写的内容

因此可以将虚函数改为**纯虚函数**

语法：`virtual 返回值类型 函数名 (参数列表) = 0;`

当类中有了纯虚函数，这个类也称为==抽象类==

**抽象类的特点**

- 无法实例化对象
- 子类必须重写抽象类中的纯虚函数，否则也属于抽象类

**示例：**

```c++
#include<iostream>
using namespace std;

class Father {
public:
	virtual void func() = 0;
};

class Son : public Father {
public:
	void func() {
		cout << "子类重写的父类纯虚函数" << endl;
	}
};

int main() {

	Father* father = new Son;
	father->func(); // 子类重写的父类纯虚函数

	system("pause");
	return 0;
}
```

### 7.4虚析构和纯虚析构

多态使用时，如果子类中有属性开辟到堆区，那么父类指针在释放时无法调用到子类的析构代码

解决方式：将父类中的析构函数改为**虚析构函数**或者**纯虚析构函数**

虚析构和纯虚析构共性：

- 可以解决父类指针释放子类对象
- 都需要有具体的函数实现

虚析构和纯虚析构区别

- 如果是纯虚析构，该类属于抽象类，无法实例化对象

虚析构语法：`virtual ~类名(){}`

纯虚析构语法：`virtual ~类名() = 0;`

**示例：**

```c++
#include<iostream>
using namespace std;

class Father {
public:
	
	virtual void func() = 0;

	//虚析构函数
	/*virtual ~Father() {
		cout << "~Father" << endl;
	};*/

	//纯虚析构函数
	virtual ~Father() = 0;

};

//纯虚析构函数实现
Father::~Father() {
	cout << "~Father" << endl;
}

class  Son: public Father
{
public:
	Son(string name) {
		this->name = new string(name);
	}

	void func() {
		cout << "子类重写父类纯虚函数" << endl;
	}

	~Son() {
		cout << "~Son" << endl;
		if (name != NULL)
		{
			delete name;
			name = NULL;
		}
	}

	string* name;
};

void test181() {
	Father* father = new Son("tom");
	father->func();

	delete father;
}

int main() {

	test181();

	system("pause");
	return 0;
}
```

