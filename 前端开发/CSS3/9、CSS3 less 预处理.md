# CSS3 less 预处理

## 1、概述

Less 是一门 CSS 预处理语言，它扩展了 CSS 语言，增加了变量、Mixin、函数等特性，使 CSS 更易维护和扩展。

Less 可以运行在 Node 或浏览器端。

Less 相当于是一个 CSS 的增强版，可以使用更少的代码实现更加强大的样式

## 2、使用

### 2.1、下载插件

在 `vscode` 中下载 `Easy Less` 插件

![image-20200813154532508](photo\5、EasyLess插件（9）.gif)l

### 2.2、新建 `Less` 文件

```less
body{
  width: 100px;
  height: 100px;
  .box1{
    width: 20px;
    height: 20px;
  }
}
```

此文件在保存后会在目录中自动生成同名的 `css` 文件

```css
body {
  width: 100px;
  height: 100px;
}
body .box1 {
  width: 20px;
  height: 20px;
}
```

在 `html` 中引入此生成的 `css` 文件即可

## 3、相关特性

### 3.1、选择器嵌套

在 `less` 中可以像 `html` 中的标签一样进行嵌套，进行对元素的定位。

```less
body{
  width: 100px;
  height: 100px;
  .box1{
    width: 20px;
    height: 20px;
  }
}
```

### 3.2、注释

在 `less` 中可以使用单行注释 `// 注释内容` 这种类型的注释只适用于 `less` 文件，在生成的 `css` 文件中只会有 `/* 注释内容 */` 。

- `less` 

```less
// less comment

/*
  css comment
*/
body{
  width: 100px;
  height: 100px;
}
```

- `css` 

```css
/*
  css comment
*/
body {
  width: 100px;
  height: 100px;
}
```

### 3.3、变量

语法

```less
@变量名:值
```

变量在作为属性的值时可以直接使用 `@变量名` 进行使用，在作为选择器和路径时则需要 `@{变量名}` 

```less
@a:100px;
@b:box1;

body{
  width: @a;
}

.@{b}{
  color: #bfa;
  background-image: url("@{b}/1.jpg");
}
```

编译后

```css
body {
  width: 100px;
}
.box1 {
  color: #bfa;
  background-image: url("box1/1.jpg");
}
```

> 变量的值可以为任何内容，若变量重复赋值总是使用最后复制的内容，同时，在选择器内部定义的变量在选择器外部是不生效的。

### 3.4、属性值引用

若想在某个选择器中重复使用一个属性的值，可以使用 `$属性名` 来使用。

```less
.box1{
  color: #bfa;
  background-color: $color;
}
```

编译后

```css
.box1 {
  color: #bfa;
  background-color: #bfa;
}
```

### 3.5、`&` 父元素

若要在一个选择器中使用这个选择器则可以使用 `&` 表示父元素

```less
.box1{
  width: 100px;

  &:hover{
    width: 200px;
  }
}
```

编译后

```css
.box1 {
  width: 100px;
}
.box1:hover {
  width: 200px;
}
```

### 3.6、继承属性

需要使用某个选择器的属性时，可以使用继承属性。

- 分组选择器实现

```less
.box1{
  width: 100px;
  height: 100px;
}

.box2:extend(.box1){
  color: red;
}

// css

.box1,
.box2 {
  width: 100px;
  height: 100px;
}
.box2 {
  color: red;
}
```

- 复制属性

```less
.box3{
  width: 100px;
  height: 100px;
}

.box4{
  .box3();
  color: red;
}

// css

.box3 {
  width: 100px;
  height: 100px;
}
.box4 {
  width: 100px;
  height: 100px;
  color: red;
}
```

### 3.7、 `mixin` 函数

使用在类选择器后加括号创建一个函数，这时编译的 `css` 文件中不会出现这个选择器及其属性，使用复制属性的方法使用此函数。

```less
.my_style(){
  width: 100px;
  height: 200px;
  color: red;
}

.box5{
  .my_style();
}

// css

.box5 {
  width: 100px;
  height: 200px;
  color: red;
}
```

在函数中可以添加参数

```less
.my_style(@w,@h,@color){
  width: @w;
  height: @h;
  color: @color;
}

.box5{
  .my_style(100px,200px,#bfa);
}

// css

.box5 {
  width: 100px;
  height: 200px;
  color: #bfa;
}
```

> - 可以使用 `.my_style(@color:#bfa,@w:100px,@h:200px);` 这种方式指定每个参数的值，可以打乱顺序。
>
> - 可以在定义函数时使用 `.my_style(@w:100px,@h:200px,@color:red){...}` 设置默认参数

### 3.8、引入 `less` 

可以使用 `improt 'filepath'` 引入其他 `less` 文件

```less
@import './test1.less';

.box1{
  color: red;
}
```

