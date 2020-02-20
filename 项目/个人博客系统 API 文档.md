# 个人博客系统 API 文档

## 一、博客文章相关（无需登录）

### 1.1 获取主页文章列表

- 接口：`/blog/homearticle`
- 请求方式：`GET`
- 参数：`page`，参数要求：`大于0`

- 返回：

| key           | 描述             |
| ------------- | ---------------- |
| `status`      | 请求状态         |
| `articlesize` | 总文章数         |
| `pagesize`    | 页数             |
| `articlelist` | 文章详情json数组 |

