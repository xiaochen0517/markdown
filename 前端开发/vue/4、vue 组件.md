# `vue` 组件

### 什么是组件：

- 为了拆分`vue`示例的代码量，能够使我们以不同的组件，来划分不同的功能模块，将来我们需要什么样的功能，就可以去调用对应的组件。

### 组件和模块化的不同：

- 模块化：从代码逻辑的角度进行划分的
- 组件化：从UI界面的角度进行划分的

### 创建组件

- 创建`vue`组件

```vue
<!-- pone -->
<template>
<div class='pone'>
  <p>component one</p>
</div>
</template>

<script>
export default {
  components: {},
  data () {
    return {
    }
  },
  methods: {
  }
}
</script>
<style scoped>
.pone{
  border: 1px solid red;
}
</style>

```

- 引入组件

```vue
<template>
<div class='three'>
  <p>three</p>
  <div class="box">
    <p>组件</p>
    <pone/>
    <ptwo/>
  </div>
</div>
</template>

<script>
//组件导入
import pone from './components/one'
import ptwo from './components/two'

export default {
  name: 'three',
  components: {
    pone,
    ptwo
  },
  data () {
    return {
    }
  }
}
</script>
<style scoped>
.box{
  padding: 10px;
  border: 3px solid #000000;
}
</style>
```

### 运行效果

![](photo\组件运行效果.jpg)

