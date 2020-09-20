# `webpack`使用

### 什么是`webpack`

- `wewbpack`是前端的一个项目构建工具，它是基于`Node.js`开发的前端工具

### 安装`webpack`

- 安装`Node.js`
- 安装`nrm`：`npm install nrm -g`
- 切换源：`nrm use taobao`
  - 查看源：`nrm ls`
- 安装`webpack`：`npm install webpack -g`
- 安装`webpack-cli`：`npm install webpack-cli -g`
- 检查`webpack -v`

### 使用示例

- 新建文件夹
  
- ![](photo\webpack示例文件目录结构.jpg).
  
- 进入项目目录，使用命令`npm init -y`初始化`npm`

- 下载`jquery`：`npm install jquery -S`

- 修改`index.html`文件

  - ```html
    <ul>
        <li>this is a li</li>
        <li>this is a li</li>
        <li>this is a li</li>
        <li>this is a li</li>
        <li>this is a li</li>
        <li>this is a li</li>
    </ul>
    ```

- 修改`main.js`文件

  - ```js
    import $ from 'jquery'//导入jquery
    
    $(function () {//实现隔行变色
      $('li:odd').css('backgroundColor', 'blue')
      $('li:even').css('backgroundColor', 'red')
    })
    ```

- 打包编译

  - 在项目根目录新建文件`webpack.config.js`

  - ```js
    const path = require('path')
    
    module.exports={
      entry:path.join(__dirname, './src/main.js'),//需要编译的文件
      output:{
        path: path.join(__dirname, './dist'),//编译后的输出目录
        filename:'bundle.js'//输出的文件名
      },
      mode: 'development'//编译模式
    }
    ```

  - 执行命令`webpack`

  - 在`index.html`中引入打包好的`js`文件
  
- 运行

  - ![](photo\webpack示例运行结果.jpg).

### 使用`webpack-dev-server`自动打包

- 安装：`npm i webpack-dev-server -D`

- 本地安装`webpack`和`webpack-cli`

  - `npm i webpack -D`
  - `npm i webpack-cli -D`

- 编辑`package.json`

  - 添加`scripts`脚本

  - ```js
    "devs": "webpack-dev-server"
    ```

- 运行：`npm run devs`

- 注：

  - `webpack-dev-server`打包生成的`bundle.js`文件在项目的根目录下，并且没有存在物理磁盘中，直接托管到电脑的内存中

### `webpack-dev-server`常用参数

- 语法：`webpack-dev-server 【参数】`
- 常用参数
  - `--open`：自动打开浏览器
  - `--port 【端口号】`：配置端口号
  - `--contentBase 【路径名】`：配置托管的根路径
  - `--hot`：热加载，浏览器免刷新加载

- 在`webpack.config.js`中配置

  - ```js
    const path = require('path')
    const webpack = require('webpack')//webpack>=4.x时可以省略
    
    module.exports={
      entry:path.join(__dirname, './src/main.js'),
      output:{
        ....
      },
      mode: 'development',
      devServer:{
        open: true,//自动打开浏览器
        port: 8081,//配置端口
        contentBase: 'src',//配置托管根路径
        hot: true//热加载
      },
      plugins: [//热加载需要导入此对象，webpack>=4.x时可以省略
        new webpack.HotModuleReplacementPlugin()
      ]
    }
    ```

### 使用`html-webpack-plugin`将`html`文件托管到内存中

- 安装：`npm i html-webpack-plugin -D`

- 修改`webpack.config.js`

  - ```js
    const path = require('path')
    const htmlWebpackPlugin = require('html-webpack-plugin')//引入html-webpack-plugin
    
    module.exports={
      entry:path.join(__dirname, './src/main.js'),
      output:{
        path: path.join(__dirname, './dist'),
        filename:'bundle.js'
      },
      mode: 'development',
      devServer:{
        open: true,
        port: 8081,
        contentBase: 'src',
        hot: true
      },
      plugins: [//配置需要托管的文件和托管后的文件名
        new htmlWebpackPlugin({
          template: path.join(__dirname, './src/index.html'),
          filename:'index.html'
        })
      ]
    }
    ```

- 注：

  - 使用`html-webpack-plugin`后会自动将打包好的`js`文件引入到`html`中，无需在`html`中手动引入

### 引入`css`文件

- 安装样式加载器：`npm i style-loader css-loader -D`

- 修改`webpack.config.js`

  - ```js
    const path = require('path')
    const htmlWebpackPlugin = require('html-webpack-plugin')
    
    module.exports={
      entry:path.join(__dirname, './src/main.js'),
      output:{
        path: path.join(__dirname, './dist'),
        filename:'bundle.js'
      },
      mode: 'development',
      devServer:{
        open: true,
        port: 8081,
        contentBase: 'src',
        hot: true
      },
      plugins: [
        new htmlWebpackPlugin({
          template: path.join(__dirname, './src/index.html'),
          filename:'index.html'
        })
      ],
      module: {//用于配置所有第三方模块，加载器
        rules: [//配置规则
          {test: /\.css$/, use: ['style-loader', 'css-loader']}//配置css文件规则
        ]
      }
    }
    ```

- 在`main.js`中引入：`import './css/index.css'`

- `less`文件加载器：`less-loader`
- `scss`文件加载器：`sass-loader`
  - 需要安装`node-sass`
    - `npm i node-sass -D`
    - 如果`npm`无法安装
      - `npm i cnpm -g`
      - `cnpm i node-sass -D`

### 使用`url-loader`加载文件

- 安装：`npm i url-loader file-loader -D`

- 修改`webpack.config.js`文件

  - `{test: /\.(jpg|jpeg|png|gif)$/, use: 'url-loader'}`

- 给`url-loader`添加参数

  - `use: 'url-loader?【参数名】=【参数】'`

- 常用参数（参数之间使用`&`符号连接）

  - `limit`：值为图片大小，单位为byte，当图片文件小于或等于设定的大小时，图片会进行`Base64`编码
  - `name`：
    - `[hash:【位数，最大32】]`
    - `[name]`：表示原文件名
    - `[ext]`：表示原文件后缀
    - 示例：`name=[hash:8]-[name].[ext]`

- 使用字体图标文件

  - 安装`bootstrap`：`npm i bootstrap -D`

    - 若`bootstrap`为`4.x`版本，需要下载`open-iconic`
    - `npm i open-iconic -D`

  - 添加`html`标签：`<span class="oi oi-account-login" aria-hidden="true"></span>`

  - 在`main.js`中导入`css`文件

    - ```js
      import 'bootstrap/dist/css/bootstrap.min.css'
      import 'open-iconic/font/css/open-iconic-bootstrap.min.css'
      ```

    - 在引入`node_modules`中的文件时可以直接添加包路径

  - 在`webpack.config.js`中添加`loader`

    - `{test: /\.(ttf|eot|svg|woff|woff2|otf)$/, use: 'url-loader'}`

