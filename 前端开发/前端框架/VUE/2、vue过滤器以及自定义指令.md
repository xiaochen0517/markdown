# `vue` 过滤器以及自定义指令

### 过滤器

- 私有过滤器

  - ```js
    filters: {
        capitalize: function (msg) {
          return msg.replace('傻子', '**')
        }
      },
    ```

- 全局过滤器

  - ```js
    Vue.filter('globalFilter', function (msg) {
      return msg.replace('傻逼', '**')
    })
    ```

- 使用：`{{data name|filter name}}`

### 自定义指令

- 私有

  - ```js
    directives: {
      focus: {
        inserted: function (el) {
          el.focus()
        }
      }
    }
    ```

- 全局

  - ```js
    Vue.directive('focus', {
      bind: function (el) {
    
      },
      inserted: function (el) {
        // 聚焦元素
        el.focus()
      }
    })
    ```

- 在定义指令时不需要加`v-`，在使用时需要加`v-`

- 钩子函数
  - `bind`：只调用一次，指令第一次绑定到元素时调用
  - `inserted`：被绑定元素插入父节点时调用 ，仅保证父节点存在，但不一定已被插入文档中
  - `update`：所在组件的` VNode` 更新时调用，**但是可能发生在其子 `VNode` 更新之前**

- 钩子函数参数

  - `el`：指令所绑定的元素，可以用来直接操作 DOM 

  - `binding`：包含以下属性：
    - `name`：指令名，不包括 `v-` 前缀。
    - `value`：指令的绑定值，例如：`v-my-directive="1 + 1"` 中，绑定值为 `2`。
    - `oldValue`：指令绑定的前一个值，仅在 `update` 和 `componentUpdated` 钩子中可用。
    - `expression`：字符串形式的指令表达式。例如 `v-my-directive="1 + 1"` 中，表达式为 `"1 + 1"`
    - `arg`：传给指令的参数，可选。例如 `v-my-directive:foo` 中，参数为 `"foo"`
    - `modifiers`：一个包含修饰符的对象。例如：`v-my-directive.foo.bar` 中，修饰符对象为 `{ foo: true, bar: true }`