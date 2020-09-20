# C++核心编程——文件操作

程序运行时产生的数据都属于临时数据，程序一旦运行结束都会被释放

通过**文件可以将数据持久化**

C++中对文件操作需要包含头文件==\<fstream\>==



文件类型分为两种：

- **文本文件：**文件以文本的ASCII码的形式存储在计算机中
- **二进制文件：**文件以二进制形式存储在计算机中，用户一般不能直接读懂它们



操作键的三大类：

- `ofstream`：写操作
- `ifstream`：读操作
- `fstream`：读写操作

## 一、文本文件

### 1.1写文件

**步骤：**

- 包含头文件：`#include<fstream>`
- 创建流对象：`ofstream ofs;`
- 打开文件：`ofs.open(文件路径, 打开方式);`
- 写数据：`ofs<<写入的数据`
- 关闭文件：`ofs.close();`

**打开文件的方式：**

| 打开方式      | 解释                       |
| ------------- | -------------------------- |
| `iso::in`     | 读文件方式打开             |
| `ios::out`    | 写文件方式打开             |
| `ios::ate`    | 初始位置：文件尾           |
| `ios::app`    | 追加方式写文件             |
| `ios::trunc`  | 如果文件存在先删除，再创建 |
| `ios::binary` | 二进制方式                 |

> 注意：文件打开方式可以配合使用，利用`|`操作符
>
> 例如：使用二进制方式写文件`ios::binary | ios::out`

**示例：**

```c++
	//1.获取输出流
	ofstream ofs;
	//2.打开文件
	ofs.open("test.txt", ios::out);
	//3.写内容
	ofs << "Hello world" << endl;
	ofs << "programming" << endl;
	//4.关闭流
	ofs.close();

	cout << "写入完成" << endl;
```

**结果：**

![](E:\PerFile\notes\markdown\C++\photo\文件操作-输出-1.png)

### 1.2读文件

读文件步骤：

- 包含头文件
- 创建流对象
- 打开文件并判断文件是否打开成功
- 读数据
- 关闭文件

**示例：**

```c++
	//获取输入流
	ifstream ifs;
	//打开文件
	ifs.open("test.txt", ios::in);
	//判断文件是否正常打开
	if (!ifs.is_open()) {
		cout << "文件打开错误" << endl;
		ifs.close();
		return;
	}

	//第一种方式
	char buf1[1024] = { 0 };
	while (ifs >> buf1) {
		cout << buf1 << endl;
	}

	//第二种方式
	char buf2[1024] = { 0 };
	while (ifs.getline(buf2, sizeof(buf2))) {
		cout << buf2 << endl;
	}

	//第三种方式
	string buf3;
	while (getline(ifs, buf3)) {
		cout << buf3 << endl;
	}

	//第四种方式
	char c;
	while ((c = ifs.get()) != EOF) {
		cout << c;
	}

	ifs.close();
```

> 总结：
>
> - 读文件可以利用`ifstream`，或者`fstream`类
> - 利用`is_open`函数可以判断文件是否打开成功
> - `close`关闭文件

## 二、二进制文件

以二进制的方式对文件进行读写操作

打开法师要指定为`ios::binary`

### 2.1写文件

二进制方式写文件主要利用刘对象调用成员函数write

函数原型：`ostream& write(const char * buffer,int len);`

参数解释：字符指针`buffer`指向内存中一段存储空间。`len`是读写的字节数

```c++
ofstream ofs("test1.txt", ios::out | ios::binary);
Person p = { "张三" , 20 };
ofs.write((const char *)&p, sizeof(Person));
ofs.close();
```

### 2.2读文件

二进制方式读文件主要利用流对象调用函数read

函数原型：`istream& read(char *buffer, int len);`

参数解释：字符指针buffer指向内存中一段存储空间。len时读取的字节数

```c++
	ifstream ifs("test1.txt", ios::in | ios::binary);
	if (!ifs.is_open()) {
		cout << "file error" << endl;
		ifs.close();
		return;
	}
	Person p;
	ifs.read((char*)&p, sizeof(Person));
	cout << "name = " << p.name << endl;
	cout << "age = " << p.age << endl;
```

