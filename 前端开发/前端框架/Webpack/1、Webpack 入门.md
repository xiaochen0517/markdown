# Webpack 入门

## 1、概述

### 1.1、`Webpack` 是什么

`Webpack` 是一种前端资源构建工具，一个静态模块打包器 `module bundler` 。

所有的资源文件都会被 `Webpack` 当做模块处理，它将根据模块的依赖关系进行静态分析，打包生成对应的静态资源 `bundle` 。

![image-20200923111924650](Photo\1、webpack 介绍图（1）.png)

### 1.2、核心概念

#### 1.2.1、 `Entry` 

入口表示以哪个文件为入口起点开始打包，分析构建内部依赖图。

#### 1.2.2、 `Output` 

输出表示打包后的资源 `bundler` 输出到哪里，以及如何命名

#### 1.2.3、 `Loader` 

`loader` 使 `webpack` 可以处理非 `js` 文件

#### 1.2.4、 `Plugins` 

插件可以执行范围更广的任务。插件的范围包括，从打包到压缩，直到重新定义环境中的变量等。

#### 1.2.5、 `Mode` 

- `development` 开发模式，代码本地调试运行
- `production` 部署模式，代码优化上线运行

## 2、打包使用

### 2.1、打包样式文件

- 新建配置文件 `webpack.config.js` 

```js
const path = require('path');

module.exports = {
	// 入口
	entry: './src/index.js',
	// 输出
	output: {
		// 文件名
		filename: 'built.js',
		// 文件路径
		path: path.resolve(__dirname, 'build')
	},
	// loader 配置
	module: {
		rules: [
			// 处理 css 文件
			{
				test: /\.css$/,
				// 配置 loader 的执行顺序是从下往上，首先文件经过 css-loader 处理
				// 再经过 style-loader 处理，less 文件也是同理
				use: [
					'style-loader',
					'css-loader'
				]
			},
			// 处理 less 文件
			{
				test: /\.less$/,
				// 处理 less 文件需要添加 less-loader 
				// 注意：需要下载两个模块 npm i less less-loader -D
				use: [
					'style-loader',
					'css-loader',
					'less-loader'
				]
			}
		]
	},
	// plugins 配置
	plugins: [],
	// 打包模式
	mode: 'development',
	// mode: 'production'
}
```

### 2.2、打包 `html` 

```js
// 引入插件
const HtmlWebpackPlugin = require('html-webpack-plugin');

// 配置插件

// plugins 配置
plugins: [
    // 默认会创建一个空的 html 文件 自动打包输出所有的资源文件
    new HtmlWebpackPlugin({
        // 复制指定文件，并打包输出所有的资源文件
        template: './src/index.html'
    })
],
```

### 2.3、打包图片

```js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
	entry: './src/index.js',
	output: {
		filename: 'built.js',
		path: path.resolve(__dirname, 'build')
	},
	module: {
		rules: [
			// 处理 less 文件
			{
				test: /\.less$/,
				// 处理 less 文件需要添加 less-loader 
				// 注意：需要下载两个模块 npm i less less-loader -D
				use: [
					'style-loader',
					'css-loader',
					'less-loader'
				]
			},
			{
				// 处理图片资源，但是此方式无法处理 html 中直接引入的图片文件
				test: /\.(jpg|png|gif)$/,
				loader: 'url-loader',
				options: {
					// 图片文件小于此大小则使用 base64 处理
					// 优点：减少请求数量（减轻服务器压力）
					// 缺点：图片体积增大（请求速度变慢）
					limit: 8 * 1024,
					// 文件重命名
					// [hash:10]取图片的 hash 的前 10 位
					// [ext] 获取文件扩展名
					name: '[hash:10].[ext]'
				}
			},
			{
				// 处理 html 中 img 引入的图片，后交给 url-loader 处理
				test: /\.html$/,
				loader: 'html-loader'
			}
		]
	},
	plugins: [
		new HtmlWebpackPlugin({
			template: './src/index.html'
		})
	],
	mode: 'development',
	// mode: 'production'
}
```

## 3、使用 `webpack-dev-server` 

下载 `webpack-dev-server` 

在 `package.json` 中添加

```json
"scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node ../node_modules/webpack-dev-server/bin/webpack-dev-server.js"
},
```

在 `webpack.config.js` 中配置

```js
devServer: {
    contentBase: path.resolve(__dirname, 'build'),
    // 启动 gzip 压缩
    compress: true,
    // 端口号
    port: 8888,
    inline: true
}
```

使用命令 `npm run start` 启动服务器

> 编译后的文件会存在内存中，不会有任何输出。

