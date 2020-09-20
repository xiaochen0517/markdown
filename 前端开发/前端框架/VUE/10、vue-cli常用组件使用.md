# vue-cli 常用组件使用

### 创建`vue-cli`

- 安装：`npm install vue-cli -g`
- 创建项目：`vue init webpack 【项目名】`
- ![](photo\vue脚手架项目配置.jpg).

- 配置`element-ui`

  - 安装：`npm i element-ui -D`

  - 配置`main.js`

    - ```js
      ...
      import element from 'element-ui'
      import 'element-ui/lib/theme-chalk/index.css'
      ...
      Vue.use(element)
      ```

- 配置`axios`

  - 安装：`npm i axios -D`

  - 配置`main.js`

    - ```js
      ...
      import axios from 'axios'
      ...
      Vue.prototype.axios = axios
      ```

### 使用示例

- `login.vue`
	
	- ```vue
	  <!-- login -->
	  <template>
	  <div class="login">
	    <el-row>
	      <el-col :span="8" :push="8">
	        <div class="grid-content bg-purple">
	          <el-row class="usernameBox">
	            <el-col :span="20" :push="2"><el-input v-model="username" placeholder="用户名"></el-input></el-col>
	          </el-row>
	          <el-row class="passwordBox">
	            <el-col :span="20" :push="2"><el-input v-model="password" placeholder="密码"></el-input></el-col>
	          </el-row>
	          <el-row>
	            <el-col :span="22" :push="2">
	              <el-checkbox v-model="checked">保存密码</el-checkbox>
	            </el-col>
	          </el-row>
	          <el-row>
	            <el-col :span="20" :push="2">
	              <el-button class="submitButton" type="primary" @click="submit">登录</el-button>
	            </el-col>
	          </el-row>
	        </div>
	      </el-col>
	    </el-row>
	  </div>
	  </template>
	  
	  <script>
	  import axios from 'axios'
	  
	  export default {
	    name: 'login',
	    data () {
	      return {
	        username: '張三',
	        password: '123456',
	        checked: false
	      }
	    },
	    methods: {
	      submit: function () {
	        console.log('submit!!!')
	        //使用params解决springmvc接收不到参数问题
	        var params = new URLSearchParams()
	        params.append('username', this.username)
	        params.append('password', this.password)
	        axios.post('http://127.0.0.1:8080/moblog/test/login', params)
	          .then(function (response) {
	            console.log(response)
	          })
	          .catch(function (error) {
	            console.log(error)
	          })
	      }
	    }
	  }
	  </script>
	  <style scoped>
	  .el-row{
	    margin-top: 10px;
	    margin-bottom: 10px;
	  }
	  .submitButton{
	    width: 100%;
	  }
	  </style>
	  
	  ```
	
- 运行结果

  - <img src="photo\vue-cli+element-ui+axios运行效果.jpg" style="zoom:80%;" />
  - ![](photo\vue-cli+element-ui+axios返回数据.jpg).