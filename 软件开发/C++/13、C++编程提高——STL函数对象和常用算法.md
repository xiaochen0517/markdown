[TOC]

# C++编程提高——STL函数对象和常用算法

## 一、函数对象

### 1.1函数对象概念

**概念：**

- 重载函数调用操作符的类，其对象常称为函数对象
- 函数对象使用重载的()时，行为类似函数调用，也叫仿函数

**本质：**

- 函数对象（仿函数）是一个类，不是一个函数

### 1.2函数对象的使用

**特点：**

- 函数对象在使用时，可以向普通函数那样调用，可以有参数，可以有返回值
- 函数对象超出普通函数的概念，函数对象可以有自己的状态
- 函数对象可以作为参数传递

**示例：**

```c++
#include<iostream>
using namespace std;

//函数对象创建
class MyAdd {
public:
	int operator()(int a, int b) {
		return a + b;
	}
};

void test81() {
	MyAdd ma;
	cout << "1----" << ma(13, 24) << endl;
}

//函数对象有自己的状态
class MyPrint {
public:
	MyPrint() {
		this->count = 0;
	}
	void operator()(string msg) {
		cout << msg << endl;
		this->count++;
	}
	int count;
};

void test82() {
	MyPrint mp;
	mp("hello world");
	mp("hello world");
	mp("hello world");
	mp("hello world");
	mp("hello world");
	cout << "count = " << mp.count << endl;
}

//函数对象作为参数传递
void doPrint(MyPrint& p, string msg) {
	p(msg);
}

void test83() {
	MyPrint mp;
	doPrint(mp, "Hello World");
}

int main() {

	test83();

	system("pause");
	return 0;
}
```

### 1.3谓词

#### 1.3.1谓词概念

**概念：**

- 返回`bool`类型的仿函数称为谓词
- 如果一个仿函数接受一个参数，那么就叫做一元谓词
- 如果一个仿函数接收两个参数，那么就叫做二元谓词

#### 1.3.2一元谓词

```c++
//一元谓词
class Getnum {
public:
	bool operator()(int a) {
		return a > 5;
	}
};

void test91() {
	vector<int> v;
	v.push_back(10);
	v.push_back(3);
	v.push_back(4);
	v.push_back(6);

	vector<int>::iterator it = find_if(v.begin(), v.end(), Getnum());
	cout << *it << endl;
	it++;
	cout << *it << endl;
}
```

#### 1.3.3二元谓词

```c++
//二元谓词
class MyCom {
public:
	bool operator()(int v1, int v2) {
		return v1 > v2;
	}
};

void test92() {
	vector<int> v;
	v.push_back(10);
	v.push_back(3);
	v.push_back(4);
	v.push_back(6);

	sort(v.begin(), v.end());

	for (vector<int>::iterator it = v.begin(); it != v.end(); it ++) {
		cout << *it << endl;
	}

	sort(v.begin(), v.end(), MyCom());

	cout << "排序后" << endl;

	for (vector<int>::iterator it = v.begin(); it != v.end(); it++) {
		cout << *it << endl;
	}
}
```

### 1.4内建函数对象

#### 1.4.1内建函数对象意义

**概念：**

- STL内建了一些函数对象

**分类：**

- 算数仿函数
- 关系仿函数
- 逻辑仿函数

**用法：**

- 这些仿函数所产生的对象，用法和一般函数完全相同
- 使用内建函数对象，需要引入头文件`#include<functional>`

#### 1.4.2算数仿函数

**功能描述：**

- 实现四则运算
- 其中negate是一元运算，其他都是二元运算

**仿函数原型：**

| 函数                                | 描述 |
| ----------------------------------- | ---- |
| `template<class T> T plus<T>`       | 加法 |
| `template<class T> T minus<T>`      | 减法 |
| `template<class T> T multiplies<T>` | 乘法 |
| `template<class T> T divides<T>`    | 除法 |
| `template<class T> T modulus<T>`    | 取模 |
| `template<class T> T negate<T>`     | 取余 |

#### 1.4.3关系仿函数

**仿函数原型：**

| 函数                                      | 描述     |
| ----------------------------------------- | -------- |
| `template<class T> bool equal_to<T>`      | 等于     |
| `template<class T> bool not_equal<T>`     | 不等于   |
| `template<class T> bool greater<T>`       | 大于     |
| `template<class T> bool greater_equal<T>` | 大于等于 |
| `template<class T> bool less<T>`          | 小于     |
| `template<class T> bool less_equal<T>`    | 小于等于 |

#### 1.4.4逻辑仿函数

**仿函数原型：**

| 函数                                    | 描述 |
| --------------------------------------- | ---- |
| `template<class T> bool logical_and<T>` | 与   |
| `template<class T> bool logical_or<T>`  | 或   |
| `template<class T> bool logical_not<T>` | 非   |

## 二、常用算法

**概述：**

- 算法主要是有头文件`<algorithm>` `<functional>` `<numeric>`组成
- `<algorithm>`是所有STL头文件中最大的一个，范围涉及到比较、交换、查找、遍历操作、复制、修改等等
- `<numeric>`体积很小，只包括几个在序列上面进行简单数学运算的模板函数
- `<functional>`定义了一些模板类，用于声明函数对象

### 2.1常用遍历算法

**简介：**

- `for_each`：遍历容器
- `transform`：搬运容器到另一个容器中

#### 2.1.1`for_each`

**函数原型：**

- `for_each(iterator beg, iterator end, _func);`
  - `beg`：开始迭代器
  - `end`：结束迭代器
  - `_func`：函数或者函数对象

#### 2.1.2`transform`

**函数原型：**

- `transform(iterator beg1, iterator end1, iterator beg2, _func);`
  - `beg1`：源容器开始迭代器
  - `end1`：原容器结束迭代器
  - `beg2`：目标容器开始迭代器
  - `_func`：函数或者函数对象

### 2.2常用查找算法

**算法简介：**

- `find`：查找元素
- `find_if`：按条件查找元素
- `adjacent_find`：查找相邻重复元素
- `binary_search`：二分查找法
- `count`：统计元素个数
- `count_if`：按条件统计元素个数

#### 2.2.1`find`

**函数原型：**

- `find(iterator beg, iterator end, value);`：按值查找元素，找不到返回结束迭代器位置
  - `beg`：开始迭代器
  - `end`：结束迭代器
  - `value`：查找的元素



#### 2.2.2`find_if`

**函数原型：**

- `find_if(iterator beg, iterator end, _Pred);`按指定条件查找元素
  - `beg`：开始迭代器
  - `end`：结束迭代器
  - `_Pred`：函数或者谓词（返回`bool`类型的仿函数）

#### 2.2.3`adjacent_find`

**函数原型：**

- `adjacent_find(iterator beg, iterator end);`：查找相邻重复元素
  - `beg`：开始迭代器
  - `end`：结束迭代器

#### 2.2.4`binary_search`

**函数原型：**

- `bool binary_search(iterator beg, iterator end, value);`：查找指定元素，返回`bool`值
  - `beg`：开始迭代器
  - `end`：结束迭代器
  - `value`：查找的元素
- **注意：**在无序序列中不可用

#### 2.2.5`count`

函数原型：

- `count(iterator beg, iterator end, value);`：统计元素出现次数
  - `beg`：开始迭代器
  - `end`：结束迭代器
  - `value`：要统计的元素

#### 2.2.6`count_if`

函数原型：

- `count_if(iterator beg, iterator end, _Pred);`：按照条件统计元素出现次数
  - `beg`：开始迭代器
  - `end`：结束迭代器
  - `_Pred`：谓词

### 2.3常用排序算法

算法简介：

- `sort`：对容器内元素进行排序
- `random_shuffle`：洗牌，指定范围内的元素随机调整次序
- `merge`：容器元素合并，并储存到另一个容器中
- `reverse`：反转指定范围的元素

#### 2.3.1`sort`

函数原型：

- `sort(iterator beg, iterator end, _Pred);`：按值查找元素，找到返回指定位置迭代器，找不到返回结束迭代器
  - `beg`：开始迭代器
  - `end`：结束迭代器
  - `_Pred`：谓词

#### 2.3.2`random_shuffle`

函数原型：

- `random_shuffle(iterator beg, iterator end);`：指定范围内的元素随机调整次序
  - `beg`：开始迭代器
  - `end`：结束迭代器

#### 2.3.3`merge`

函数原型：

- `merge(iterator beg1, iterator end1, iterator beg2, iterator end2, iterator dest);`：两个容器合并，并储存到另一个容器中
  - `beg1`：容器1开始迭代器
  - `end1`：容器1结束迭代器
  - `beg2`：容器2开始迭代器
  - `end2`：容器2结束迭代器
  - `dest`：目标容器开始迭代器
- 注意：两个容器必须是有序的

#### 2.3.4`reverse`

函数原型：

- `reverse(iterator beg, iterator end);`：反转指定范围的元素
  - `beg`：开始迭代器
  - `end`：结束迭代器

### 2.4常用拷贝和替换算法

算法简介：

- `copy`：容器内指定范围的元素拷贝到另一个容器中
- `replace`：将容器内指定范围的旧元素修改为新元素
- `replace_if`：容器内指定范围满足条件的元素替换为新元素
- `swap`：互换两个容器的元素

#### 2.4.1`copy`

函数原型：

- `copy(iterator beg, iterator end, iterator dest);`：按值查找元素，找到返回指定位置迭代器找不到返回结束迭代器位置
  - `beg`：容器开始迭代器
  - `end`：容器结束迭代器
  - `dest`：目标容器开始迭代器

#### 2.4.2`replace`

函数原型：

- `replace(iterator beg, iterator end, oldValue, newValue);`：将区间内的旧元素替换为新元素
  - `beg`：容器开始迭代器
  - `end`：容器结束迭代器
  - `oldValue`：旧元素
  - `newValue`：新元素

#### 2.4.3`replace_if`

函数原型：

- `replace_if(iterator beg, iterator end, _Pred, newValue);`：按条件替换元素，满足条件替换为指定元素
  - `beg`：容器开始迭代器
  - `end`：容器结束迭代器
  - `_Pred`：谓词
  - `newValue`：新元素

#### 2.4.4`swap`

函数原型：

- `swap(container c1, container c2);`：互换两个容器的元素
  - `c1`：容器1
  - `c2`：容器2

### 2.5常用算术生成算法

注意：

- 算术生成算法属于小型算法，使用时包含头文件`numeric`

算法简介：

- `accumulate`：计算容器元素累加和
- `fill`：向容器中添加元素

#### 2.5.1`accumulate`

函数原型：

- `accumulate(iterator beg, iterator end, value);`：计算容器元素累计总和
  - `beg`：容器开始迭代器
  - `end`：容器结束迭代器
  - `value`：开始累加的起始值

#### 2.5.2`fill`

函数原型：

- `fill(iterator beg, iterator end, value);`：向容器中填充元素
  - `beg`：容器开始迭代器
  - `end`：容器结束迭代器
  - `value`：要填充的值

### 2.6常用集合算法

算法简介：

- `set_intersection`：求两个容器的交集
- `set_union`：求两个容器的并集
- `set_difference`：求两个容器的差集

#### 2.6.1`set_intersection`

函数原型：

- `set_intersection(iterator beg1, iterator end1, iterator beg2, iterator end2, iterator dest);`：求两个容器的交集
  - `beg1`：容器1开始迭代器
  - `end1`：容器1结束迭代器
  - `beg2`：容器2开始迭代器
  - `end2`：容器2结束迭代器
  - `dest`：目标容器开始迭代器

#### 2.6.2`set_union`

函数原型：

- `set_union(iterator beg1, iterator end1, iterator beg2, iterator end2, iterator dest);`：求两个容器的并集
  - `beg1`：容器1开始迭代器
  - `end1`：容器1结束迭代器
  - `beg2`：容器2开始迭代器
  - `end2`：容器2结束迭代器
  - `dest`：目标容器开始迭代器

- 注意：两个集合必须是有序序列

#### 2.6.3`set_difference`

函数原型：

- `set_difference(iterator beg1, iterator end1, iterator beg2, iterator end2, iterator dest);`：求两个容器的差集
  - `beg1`：容器1开始迭代器
  - `end1`：容器1结束迭代器
  - `beg2`：容器2开始迭代器
  - `end2`：容器2结束迭代器
  - `dest`：目标容器开始迭代器

- 注意：两个集合必须是有序序列