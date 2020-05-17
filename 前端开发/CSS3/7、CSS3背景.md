# CSS3背景

## 1、背景图片

### 1.1、`background-image`

- 格式

```
background-image: url([路径]);
```

- 解析

```
- 可以同时设置背景图片和背景色，此时背景色会变成图片的背景
- 图片小于元素，图片会自动在元素中重复平铺
- 图片大于元素，图片将会有一部分无法完全显示
- 图片和元素一样大，则会正常显示
```

### 1.2、重复显示设置

- 格式

```
background-repeat: [值];
```

- 解析

```
- repeat：默认值，x轴和y轴重复显示
- repeat-x：x轴方向重复
- repeat-y：y轴方向重复
- no-repeat：不重复
```

### 1.3、背景图片位置

- 格式

```
background-position: [值];
```

- 解析

```
- 使用top、left、right、bottom、center设置位置
	- 标准为两个值，只写一个值时第二个值默认为center
- 使用偏移量来指定位置
	- 两个值，水平方向偏移量 垂直方向偏移量
```

### 1.4、背景的范围

- 格式

```
background-clip: [值];
```

- 解析

```
- border-box：默认值，背景会溢出到边框下
- padding-box：背景不会出现在边框，只会出现在内容区和内边距中
- content-box：背景只会出现在内容区
```

### 1.5、背景图片的偏移原点

- 格式

```
background-origin: [值];
```

- 解析

```
- padding-box：默认值，内边距左上角开始计算
- content-box：内容区左上角开始计算
- border-box：边框的左上角计算
```

### 1.6、背景图片的大小

- 格式

```
background-size: [值];
```

- 解析

```
- 第一个值：宽度
- 第二个值：高度
- 若只有一个值，则另一个值为等比例缩放
- cover：保持比例，铺满元素
- contain：保持比例，将图片完整显示
```

### 1.7、背景图片随元素滚动

- 格式

```
background-attachment: [值];
```

- 解析

```
- scroll：默认值，会跟随元素移动
- fixed：固定在页面中，不会随元素移动
```

## 2、雪碧图

CSS雪碧 即CSS Sprite，也有人叫它CSS精灵，是一种CSS图像合并技术，该方法是将小图标和背景图像合并到一张图片上，然后利用css的背景定位来显示需要显示的图片部分。

- 雪碧图

![](photo\3、背景（1）.png).

- 代码

```css
css------------------
.box:link {
    display: block;
    width: 200px;
    height: 64px;
    background-image: url("./images/btn.png");
    background-repeat: no-repeat;
}

.box:hover {
    background-position: 0 -66px;
}

.box:active {
    background-position: 0 -132px;
}
```

```html
html--------------
<a href="javascript:;" class="box"></a>
```

- 效果

![](photo\4、背景（2）.gif).

## 3、背景渐变

渐变通过属性`background-image`设置

### 3.1、线性渐变

- linear-gradient()

```
- 每个值之间用逗号隔开
- 多个颜色值，表示从一种颜色渐变到另一种颜色
	- 可在颜色值后添加px大小和百分比来设置颜色的分布距离
- 在颜色值前添加一个参数改变方向
	- to left：从右到左渐变
	- to right：从左到右渐变
	- to bottom：从上到下
	- to top：从下到上
	- xxdeg：指定旋转的度数，默认为180
		- 同时方向值也可以组合到一起，eg. to top left
	- xxturn：旋转的圈数可用小数  
```

- repeating-linear-gradient()：重复线性渐变

```
- 用法同上，但在颜色值后制定大小的相差为区间重复变化
```

### 3.2、径向渐变

- radial-gradient()

```css
- 多个颜色值，渐变方向从中心向四周渐变
- 可以在颜色前指定颜色渐变的范围。
	- eg. radial-gradient(100px 100px, red, yellow)
- 在渐变颜色后添加渐变中心的位置，从元素左上角开始计算。
	- eg. radial-gradient(100px 100px at 10px 10px, red, yellow)
```





























