# `vue`中`watch`侦听器

### 创建侦听器

- 创建数据：`msg`

- 添加监听器

  - ```js
      watch: {
        'msg': function (newValue, oldValue) {
          console.log(oldValue + '----' + newValue)
        }
      }
    ```

  - 参数一为变化后的新值

  - 参数二为变化前的旧值

- `<input type="text" v-model="msg">`

- 运行结果

  - ![](photo\watch监听数据变化.jpg).

### `watch`监听路由变化

- 创建监听器

  - ```js
    '$route.path': function (newValue, oldValue) {
    	console.log(oldValue + '----' + newValue)
    }
    ```

- 运行结果

  - ![](photo\watch监听路由变化.jpg).