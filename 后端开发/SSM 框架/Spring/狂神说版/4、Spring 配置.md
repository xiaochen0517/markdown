# Spring 配置

## 1、别名 `alias`

别名标签有两个属性

- `name`：引用一个`bean`
- `alias`：别名

示例

```xml
<alias name="user" alias="FuckYou"/>
```

## 2、`Bean ` 配置

属性

- `id`：`bean`唯一标识符，相当于对象名
- `class`：`bean`所对应的类的全限定类名
- `name`：别名，可以同时取多个别名，使用逗号、分号或空格分隔

## 3、import

此配置可以将多个配置文件合并为一个

- `resource`：值为要合并的`xml`配置文件

