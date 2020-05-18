# CSS3动画

## 1、过渡

- 过渡（transition）

```
- 通过过渡可以指定一个属性发生变化时的切换方式
- 通过过渡可以创建一些动画，可以提高用户体验
```

### 1.1、基本使用

- transition

```
- 要执行过渡的属性，多个值使用逗号隔开
	- width：变化宽度
	- height：变化高度
	- background-color：背景颜色
	- all：所有属性
- 过渡的时间
- 过渡延迟，此值只可以在时间之后
```

> 属性的过渡必须在有效值之间过渡，auto不为有效值。

### 1.2、拆分属性

#### 1.2.1、transition-property

- 执行执行过渡的属性

#### 1.2.2、transition-duration

- 执行过渡的持续时间
- 可以在有多个过渡属性时分别指定属性的过渡时间

#### 1.2.3、transition-timing-funtion

- 过渡的执行方式

```
- ease：默认值，慢速开始加速后减速
- linear：匀速
- ease-in：加速
- ease-out：减速
- ease-in-out：慢速开始加速后减速，比默认值速度慢
- cubic-bezier()：使用贝赛尔曲线指定过渡方式
	- https://cubic-bezier.com/工具网站
- steps()：分步执行过渡效果
	- 第一个值，步长
	- 第二个值，开始时执行还是结束时执行
```

#### 1.2.4、transition-delay

- 过渡执行前的等待时间

## 2、动画

- 不同于动画的是，过渡需要在某个属性发生交互时才会触发，而动画可以自动触发动态效果。

### 2.1、设置关键帧

- 格式

```css
@keyframes [关键帧名称] {
    /* 开始属性 */
    from{
        ...
    }

    /* 目标属性 */
    to{
        ...
    }
}
```

- 示例

```css
@keyframes test {
    /* 开始属性 */
    from{
        margin-left: 0;
    }

    /* 目标属性 */
    to{
        margin-left: 400px;
    }
}
```

### 2.2、相关属性

#### 2.2.1、同过渡属性

```
animation-duration：动画执行持续时间
animation-timing-funtion：过渡方式
animation-delay：执行延时
```

#### 2.2.2、特有属性

```
animation-iteration-count：动画执行的次数
	- infinite：无限次数
	
animation-direction：执行的方向
	- normal：默认值，每次都是从from到to
	- reverse：每次都是从to到from
	- alternate：从from到to重复时会交替顺序
	- alternate-reverse：从to到from重复时会交替顺序
	
animation-play-state：动画的执行状态
	- running：默认值，执行动画
	- paused：暂停
	
animation-fill-mode：动画填充模式
	- none：默认值，动画执行完毕元素回到原来的位置
	- forwards：动画执行完毕元素停在动画结束的位置
	- backwards：动画在等待状态时元素就会处于开始关键帧状态
	- both：结合了forwards和backwards的特点
```



