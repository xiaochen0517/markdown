# `vue`路由

### 后端路由

- 对于普通网站，所有超链接都是URL地址，所有URL地址都对应服务器上对应的资源。

### 前端路由

- 对于单页面应用程序来说，主要通过URL中的`hash`（`#`号）来实现不同页面之间的切换，同时`hash`有一个特点：`HTTP`请求不会包含`hash`相关的内容，所以，单页面程序中的页面跳转主要用`hash`实现
- 在单页面应用程序中，这种通过`hash`改变来切换页面的方式，称作前端路由。

### 简单使用

- 创建`vue`文件

- 在`index.js`中导入创建的组件`import 【组件名】 from '路径'`

- 在`routes`中定义

  - ```js
    routes: [
    	{
    		path: '/',
    		name: 'HelloWorld',
    		component: HelloWorld
    	}
    ]
    ```

- 使用`<router-link to="/a">a</router-link>`实现路由跳转

### 实现激活路由高亮

- 定义`css`样式

- ```css
  .router-link-active {
    color: black;
    text-decoration: none;
  }
  ```

- 通过路由构造选项`linkActiveClass`全局自定义激活路由类名

### 路由切换动画

- 修改`html`

  - ```html
    <transition name="slide" mode="out-in">
    	<router-view></router-view>
    </transition>
    ```

- 添加css

  - ```css
    .slide-enter, .slide-leave-to {
      opacity: 0;
      transform: translateX(150px);
    }
    
    .slide-enter-active, .slide-leave-active {
      transition: all 0.5s ease;
    }
    ```

- 效果

  - ![](photo\路由切换动画.gif)

### 路由使用`query`方式传参

- 在跳转链接处添加参数`<router-link to="/four?id=10">four</router-link>`
- 在组件中获取`route`信息`console.log(this.$route)`
  - ![](photo\路由query传参.jpg).

### 路由使用`params`方式传参

- 在定义路由时使用占位符

  - ```js
    {
    	path: '/four/:id',
    	name: 'four',
    	component: four,
    	props: true
    }
    ```

- 在组件中定义`props`：`props: ['id'],`

- 运行结果

  - ![](photo\路由params传参.jpg).

### 使用`children`实现路由嵌套

- 在路由组件中定义子组件

  - ```js
    {
    	path: '/five',
    	name: 'five',
    	component: five,
    	children: [{
    		path: 'pone',
    		component: pone
    	},
    	{
    		path: 'ptwo',
    		component: ptwo
    	}]
    }
    ```

- 在组件中调用

  - ```html
    <router-link to="/five/pone">pone</router-link>
    <router-link to="/five/ptwo">ptwo</router-link>
    <router-view></router-view>
    ```

- 运行结果

  - ![](photo\children子路由切换动画.gif).

- 注：
  
  - 使用`children`属性，实现子路由，在子路由的`path`前不要带`/`，否则会以根路径请求

### 命名视图

- 定义`routes`

  - ```js
    {
    	path: '/six',
    	component: six,
    	children: [
    		{
    			path: 'pthree',
    			components: {
    				default: pthree,
    				pone: pone,
    				ptwo: ptwo
    			}
    		}
    	]
    }
    ```

- 定义组件

  - ```html
    <p>six</p>
    <router-link to="/six/pthree">pthree</router-link>
    <router-view></router-view>
    <router-view name="pone"></router-view>
    <router-view name="ptwo"></router-view>
    ```

- 运行结果

  - ![](photo\命名视图.jpg).