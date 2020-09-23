# JQuery 入门

## 1、`JQuery` 是什么？

`JQuery` 是一款优秀的 `JavaScript` 库，从命名可以看出 `JQuery` 最主要的用途是用来做查询。使用 `JQuery` 可以让我们对 `HTML ` 文档遍历和操作、事件处理、动画以及 `Ajax` 变得更加简单。

**特点： ** 

**快速获取文档元素** 

jQuery的选择机制构建于Css的选择器，它提供了快速查询DOM文档中元素的能力，而且大大强化了JavaScript中获取页面元素的方式。

**提供漂亮的页面动态效果** 

jQuery中内置了一系列的动画效果，可以开发出非常漂亮的网页，许多网站都使用jQuery的内置的效果，比如淡入淡出、元素移除等动态特效。

**创建AJAX无刷新网页** 

AJAX是异步的JavaScript和XML的简称，可以开发出非常灵敏无刷新的网页，特别是开发服务器端网页时，比如PHP网站，需要往返地与服务器通信，如果不使用AJAX，每次数据更新不得不重新刷新网页，而使用AJAX特效后，可以对页面进行局部刷新，提供动态的效果。

**提供对JavaScript语言的增强** 

jQuery提供了对基本JavaScript结构的增强，比如元素迭代和数组处理等操作。

**增强的事件处理** 

jQuery提供了各种页面事件，它可以避免程序员在HTML中添加太多事件处理代码，最重要的是，它的事件处理器消除了各种浏览器兼容性问题。

**更改网页内容** 

jQuery可以修改网页中的内容，比如更改网页的文本、插入或者翻转网页图像，jQuery简化了原本使用JavaScript代码需要处理的方式。

## 2、使用 `JQuery` 

### 2.1、引入 `JQuery` 

- 下载

[官网](https://jquery.com/) 

- 引入

```html
<script src="./jquery-3.4.1.min.js"></script>
```

### 2.2、入口函数

```js
window.onload = function (ev) {}

$(document).ready(function () {})
// 简写格式
$(function () {})
```

原生 `js` 和 `jquery` 入口函数的加载模式不同，原生 `js` 会等待 `DOM` 元素和图片加载完毕才会执行，而 `jquery` 会等到 `DOM` 元素加载完毕就会执行，不会等待图片加载。

原生 `js` 如果编写了多个入口函数，最后编写的入口函数会覆盖前面的入口函数，而 `jquery` 中编写多个入口函数，会按前后顺序执行并不会被覆盖。

### 2.3、冲突解决

当在 `jquery.js` 之后引入的 `js` 与 `jquery.js` 中的 `$` 冲突时，`jquery.js` 放弃 `$` 符号使用 `jQuery` 

```js
jQuery.noConflict();
jQuery(function () {
    alert('冲突解决');
})
```

使用自定义符号

```js
let $jq = jQuery.noConflict();
$jq(function () {
    alert('冲突解决');
})
```

### 2.4、核心函数

#### 2.4.1、接收一个函数

当接收一个函数时，即为 `js` 的入口函数。

```js
$(function () {})
```

#### 2.4.2、接收字符串

当接收一个字符串选择器时，会依据 `css` 选择器的方式返回指定 `DOM` 节点。

```js
let input = $('.username');
let button = $('#okbut');
let box = $('div');
```

当接收的字符串为一段 `html` 代码时， `jquery` 会将字符串转化为 `DOM` 节点并包装为一个 `jquery` 对象返回。

```js
let p = $('<p>我是一段文字</p>');
```

#### 2.4.3、接收 `DOM` 节点

当接收的内容为一个 `DOM` 节点时， `jquery` 会将节点打包为一个 `jquery` 对象返回。

```js
let sp = $(document.getElementsByTagName('span'));
```

### 2.5、 `JQuery` 对象

`JQuery` 是一个伪数组，它具有 `length` 属性和 `0~length-1` 的属性。

![image-20200917174359564](Photo\1、JQuery 对象（1）.png).

### 2.6、`jquery` 静态方法

#### 2.6.1、 `each` 遍历

此方法不仅可以用来遍历数组，也可以遍历伪数组。

```js
let arr = {
    0: 3,
    1: 2,
    2: 6,
    3: 9,
    length: 4
};

$.each(arr, function (index, value) {
    console.log(index + "|" + value);
})
```

#### 2.6.2、`map` 遍历

```js
$.map(arr, function (value, index) {
    console.log(index + "|" + value);
});
```

同样，原生 `js` 的 `map` 方法并不可以用来遍历伪数组，而 `jquery` 则可以遍历伪数组，与 `each` 不同的是函数中的 `index` 和 `value` 的顺序相反。

> `each` 静态方法会返回当前遍历的对象，添加 `return` 语句并不会影响返回值
>
> `map` 静态方法默认会返回一个空数组，添加 `return` 返回值时会将返回的值组成一个数组，即可以在 `map` 静态方法中对数组或者伪数组执行一些操作。

#### 2.6.3、`strim` 去除两端空格

```js
let str1 = '    doomfist    ';
let res1 = $.trim(str1); // doomfist
```

#### 2.6.4、判断对象是否为 `window` 

```js
let win = window;
let res2 = $.isWindow(win); // true
```

#### 2.6.5、 `isArray` 判断是否为数组

```js
let arr1 = [1, 3, 4, 2, 5, 4, 3, 6];
let res3 = $.isArray(arr1);
```

#### 2.6.6、 `isFunction` 判断是否为函数

```js
let fun1 = function () {};
let res4 = $.isFunction(fun1);
```

#### 2.6.7、 `holdReady` 暂停入口函数

```js
$.holdReady(true); // 暂停入口函数
$.holdReady(false); // 继续执行入口函数
```

