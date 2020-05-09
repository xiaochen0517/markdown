# CSS3单位及颜色

## 1、像素和百分比

- px：像素，在不同缩放大小时，显示的像素个数不同
- 百分比：相对于父元素大小的百分比

## 2、em和rem

- em：相对于元素的字体大小计算的
  - 1em=1font-size
  - 通常1font-size为16个像素

- rem：相对于根元素（html）的字体大小计算的

## 3、RGB值

> 通过三种不同颜色的浓度来调配出的颜色

- R red, G green, B blue

- 颜色范围在0~255之间

```css
RGB(red, green, blue);
```

> RGBA：在RGB的基础上增加了不透明度，值为0~1的小数

> 十进制的RGB值

- 语法：`#红色绿色蓝色`
- 每一个颜色的值为00~FF

## 4、HSL值

- H (hue) 色相（0-360）
- S (saturation) 饱和度 （0%~100%）
- L (lightness) 亮度 （0%~100%）