# JQuery 事件绑定

## 1、点击事件

### 1.1、绑定事件

#### 1.1.1、点击

```js
// 建议使用此写法，便捷且便于寻错
$('.but1').click(function() {
    console.log('test');
});
$('.but2').on('click', function() {
    console.log('test 1');
})
```

#### 1.1.2、鼠标相关

```js
// 鼠标进入触发
$('.but1').mouseleave(function() {
    console.log('mouse leave');
});
// 鼠标移出触发
$('.but1').mouseenter(function() {
    console.log('mouse enter');
});
```

### 1.2、移除事件

```js
// 移除指定元素的所有事件
$('.but1').off();
// 移除指定元素的所有指定事件
$('.but1').off('click');
// 移除指定元素的指定方法的事件
$('.but1').off('click', test1);
```

## 2、默认行为

### 2.1、事件冒泡

当在父元素和子元素中都设置点击事件后，当点击子元素时，父元素的点击事件也会被触发。

```js
$('.box1').click(function (){
    console.log('box1');
})

$('.box2').click(function(event){
    console.log('box2');
    // return false;
    event.stopPropagation();
})
```

> 在子元素事件中添加 `return false;` 或者调用 `stopPropagation()` 函数即可。

### 2.2、默认行为

```js
$('a').click(function(event){
    alert('百度');
    // return false;
    event.preventDefault();
})
```

## 3、自动触发

```js
// 此自动触发函数会触发事件冒泡，并触发默认行为
$('a').trigger('click');
// 此函数不会触发事件冒泡和默认行为
$('.box2').triggerHandler('click');
```

## 4、自定义事件

- 事件必须由 `on` 绑定
- 必须由 `trigger` 触发

```js
$('button').one('myclick', function(){
    console.log('myclick');
})
$('button').trigger('myclick');
```

## 5、事件命名空间

 ```js
$('.box2').on('click.one', function(){
    console.log('box2 -- one');
})
$('.box2').on('click.two', function(){
    console.log('box2 -- two');
})

$('.box1').on('click.one', function(){
    console.log('box1 -- one');
})
$('.box1').on('click.two', function(){
    console.log('box1 -- two');
})

// 在使用事件命名空间时，子元素的相应命名空间事件触发，父元素也只会触发同样命名空间的事件
$('.box2').trigger('click.two');
 ```

## 6、事件委托

```js
$('button').click(function(){
    $('ul').append('<li>this is new li</li>');
})

// jquery 会将所有查找的元素遍历并逐一添加点击事件
// 这样新增的 li 是没有绑定点击事件的
// $('ul>li').click(function(){
// 	console.log($(this).html());
// })

// 使用事件委托将 li 的点击事件委托给 ul 实现
// 新增的 li 也是属于 ul 的一部分，则新增的 li 也可以实现点击事件
$('ul').delegate('li', 'click', function(){
    console.log($(this).html());
})
```

