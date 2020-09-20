# CSS3字体

## 1、基本属性

- 字体颜色：`color`

```
color：字体颜色（前景色）
```

- 字体大小：`font-size`

```
font-size：字体大小
	- em：相当于当前元素的一个font-size
	- rem：相当于根元素的一个font-size
```

- 字体样式：`font-family`

```
font-family：字体样式
	- serif：衬线字体
	- sans-serif：非衬线字体
	- monospace：等宽字体
	- 可以设置多个字体，之间使用“,”隔开优先使用第一个，若无法使用则使用第二个，以此类推
	- 导入服务器的字体
        @font-face {
            font-family: 'myFont';
            src: url('./font/SourceHanSansCN-Normal.otf');
        }
```

> 若网速较慢，在未加载完成时是默认字体，加载完成后会突然变成指定的字体

- 字体行高：`line-height`

```
- 行高就是指文字占用的实际高度
- 行高可以指定单位，也可以直接设置一个整数
	- 若为一个生疏，行高将会是字体的指定的倍数
- 行高经常用来设置文字的行间距
	- 行间距=行高-字体大小
- 行高会在字体框的上下平均分配

字体框
- 字体框就是字体存在的格子，设置font-size实际就是在设置字体框的高度
```

- 简写属性：`font`

```
font: 字重 字体风格 字体大小/行高 字体样式
- 行高可以省略不写
```

- 字重：`font-weight`

```
值：
- normal：默认值，不加粗
- blod：加粗
100-900：九个等级
```

- 字体风格：`font-style`

```
- normal：正常
- italic：斜体
```

## 2、图标字体

图标字体（iconfont）：在网页中经常使用一些图标，可以通过图片的方式引入，但通常在使用时会将图标制作为字体文件来使用图标。

### 2.1、`fontawesome`

- [下载地址](https://fontawesome.com/how-to-use/on-the-web/setup/hosting-font-awesome-yourself)
- 将css和webfonts目录复制到项目中
- 将all.css引入到网页中
- 使用指定类名使用图标

```
<i class="fas fa-car"></i>
```

![image-20200514170856644](photo\1、字体（1）.png).

> 图标字体可以和字体一样随意修改大小和颜色，并且是矢量图，放大不会失真。

- 通过伪元素设置图标字体

```
- 通过before或者after选中
- 在content中设置字体的编码
- 设置字体的样式
- 设置字体权重
```

在标签内部使用编码

```html
<span class="fas">&#xf0f3;</span>
```

### 2.2、`iconfont`

- [官网](https://www.iconfont.cn/)
- 选择图标
- 添加到项目
- 下载到本地
- 引入`iconfont.css`

> 使用方式与`fontawesome`同理

- 示例

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="./font/iconfont.css">
  <style>
    i.iconfont{
      font-size: 50px;
    }

    i.my::before{
      content: '\e8ad';
      font-family: iconfont;
      font-size: 50px;
    }
  </style>
</head>
<body>
  <i class="iconfont sq-like icon-icons-"></i>
  <i class="iconfont">&#xe66a;</i>
  <i class="my"></i>
</body>
</html>
```

- 效果

![image-20200514183345027](photo\2、字体（2）.png).

## 3、文本属性

- 对齐方式：`text-align`

```
- left：左侧对齐
- right：右侧对齐
- center：居中对齐
- justify：两边对齐
```

- 垂直对齐方式：`vertical-align`

```
- baseline：默认值，基线对齐
- top：顶部对齐
- bottom：底部对齐
- middle：居中对齐
```

> `img`元素与父元素底部默认会有一段空白距离，使用`vertical-align`使图片不以基线对齐即可

- 文本修饰：text-decoration

```
- none：无效果
- underline：下划线
- line-through：删除线
- overline：上划线
```

- 网页空白处理：white-space

```
- normal：正常显示
- nowrap：不换行
- pre：保留空白
```

- 文字溢出：text-overflow

```
- 设置溢出文字...省略
white-space: nowrap;
overflow: hidden;
text-overflow: ellipsis;
```

