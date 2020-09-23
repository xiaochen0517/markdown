# JQuery 值操作

## 1、属性节点

在编写 `HTML` 代码时，在 `HTML` 标签中添加的属性就是属性节点， `DOM` 元素中的 `attributes` 属性的值就是属性节点。

任何对象都有属性，只有 `DOM` 对象才有属性节点。

### 1.1、 `attr` 设置属性节点

- 一个参数：获取属性节点的值，无论发现多少元素，只会返回一个元素属性节点的值
- 两个参数：设置属性节点的值，会修改所有已发现元素的属性节点的值。

```js
let div1 = $('div').attr('class'); // 获取属性节点
console.log(div1);
$('div').attr('name', 'boxs');
```

> 若当前标签添加的属性节点名不存在，则会自动新增。

### 1.2、`removeAttr` 移除属性节点

移除所有找到的元素指定属性节点，属性节点名以空格隔开同时删除多个属性节点。

```js
$('div').removeAttr('class');
```

### 1.3、 `prop` 设置属性节点

```js
let res = $('div').eq(0).prop('class');
console.log(res);

$('div').eq(0).prop('class', 'haha');

$('div').prop('class', 'hello');
```

效果与 `attr` 相同，可以使用 `eq()` 指定设置第几个元素的属性节点。

`removeProp` 用法与 `removeAttr` 相同

> 在操作属性节点时，具有 `true` 和 `false` 两个属性的属性节点，如 `checked` `selected` `disabled` 使用 `prop` ，其他则使用 `attr` 。

## 2、类操作

### 2.1、添加类

添加类时旧的类名不会被删除，只会在已有基础上添加，当添加与已有类相同时不会重复添加。

```js
$('div').addClass('box1');
$('div').addClass('box2'); // box1 box2
```

### 2.2、移除类

```js
$('div').removeClass('box1');
```

### 2.3、切换类

当指定类已存在时，将会删除指定类，若不存在则会添加。

```js
$('div').addClass('box1');
$('div').toggleClass('box1 box2'); // box2
```

## 3、文本值相关操作

### 3.1、 `html` 相关

#### 3.1.1、设置

```js
$('div').html('<p>我是一个p标签</p>');
```

### 3.1.2、获取

```js
let res = $('div').html();
console.log(res);
```

### 3.2、`text` 相关

#### 3.2.1、设置

```js
$('.box2').text('<p>我是一个p标签</p>');
```

#### 3.2.2、获取

```js
let res1 = $('.box2').text();
console.log(res1);
```

### 3.3、`value` 相关

#### 3.3.1、设置

```js
$('.box3').val('我是一个输入框');
```

#### 3.3.2、获取

```js
let res2 = $('.box3').val();
console.log(res2);
```

## 4、样式操作

### 4.1、普通样式操作

```js
// 设置单个
$('.box1').css('background', 'red');

// 链式 设置多个
$('.box1').css('width', '100px').css('height', '100px');

// 批量设置多个
$('.box1').css({
    border: '1px solid black',
    'margin-top': '100px'
})
```

获取指定样式

```js
let res1 = $('.box1').css('background');
console.log(res1);
```

## 5、距离尺寸操作

### 5.1、尺寸操作

```js
let res1 = $('.box2').width();
console.log(res1);

$('.box2').width('200px');
```

### 5.2、距离操作

#### 5.2.1、距离窗口偏移量

```js
// 距离窗口左侧的偏移量
let res2 = $('.box2').offset().left;
console.log(res2);

// 设置偏移量
$('.box2').offset({
    left: '10'
});
```

#### 5.2.2、距离定位元素偏移量

```js
// 获取相对于定位元素的偏移量
let res3 = $('.box2').position().left;
console.log(res3);
```

### 5.3、滚动偏移

```js
$('.but1').click(function () {
    let res = $('.box1').scrollTop();
    console.log(res);
});

// 设置滚动偏移量
$('.box1').scrollTop(100);

// 在ie浏览器中html获取不到值，而在其他浏览器中body获取不到值，故使用此方法兼容不同浏览器
$('.but2').click(function () {
    let res = $('html').scrollTop() + $('body').scrollTop();
    console.log(res);
});

$('html,body').scrollTop(200);
```

