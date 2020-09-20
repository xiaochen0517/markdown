# `vue`计算属性`computed`

- 在`computed`中，可以定义一些计算属性，计算属性本质就是一个方法，在使用计算属性时可以作为属性使用

### 简单使用

- 新建两个`data`属性

- 新建`computed`属性

  - ```js
      computed: {
        oandt: function () {
          return this.onestr + this.twostr
        }
      }
    ```

- 运行结果

  - ![](photo\computed简单使用.jpg).

### 特点

- 在引用计算属性时，不可以加`()`
- 只要计算属性中引用的值发生了变化，就会自动重新执行计算
- 计算属性的结果会被缓存起来方便下次直接使用