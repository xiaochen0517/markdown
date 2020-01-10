## Cookie记忆上一次访问时间

#### 需求

- 访问Servlet，如果是第一次访问，提示：你好，欢迎您首次访问
- 若不是第一次访问，则提示：欢迎回来，您上次访问时间为：xxx

#### 实现

- 解决中文乱码

  - ```java
    //解决中文乱码
            req.setCharacterEncoding("utf-8");
            resp.setContentType("text/html;charset=utf-8");
    ```

- 新建bool变量，设置是否第一次访问

  - ```java
    //是否第一次访问
            boolean firstAccess = true;
    ```

- 获取当前时间

  - ```java
    //获取当前时间
            Date d = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
            String nowTime = sdf.format(d);
            System.out.println("当前时间：" + nowTime);
    ```

- 获取cookie并判断是否第一次访问

  - ```java
    //获取cookie
            Cookie[] cookies = req.getCookies();
            if (cookies !=null){
                for (Cookie cookie:cookies){
                    if (cookie.getName().equals("lastTime")){
                        //不是第一次访问
                        firstAccess = false;
                        //显示时间
                        PrintWriter writer = resp.getWriter();
                        writer.write("<h1>欢迎您，上次访问时间："+ URLDecoder.decode(cookie.getValue(), "utf-8")+"</h1>");
                        //刷新cookie
                        Cookie newCookie = new Cookie("lastTime", URLEncoder.encode(nowTime,"utf-8"));
                        cookie.setMaxAge(60*60*24*30);
                        resp.addCookie(newCookie);
                        break;
                    }
                }
            }
    ```

- 是第一次访问

  - ```java
    //第一次访问
            if (firstAccess){
                Cookie cookie = new Cookie("lastTime", URLEncoder.encode(nowTime,"utf-8"));
                cookie.setMaxAge(60*60*24*30);
                resp.addCookie(cookie);
                PrintWriter writer = resp.getWriter();
                writer.write("<h1>当前是您第一次访问本网站！</h1>");
            }
    ```

- 在cookie中不可以存储空格等特殊字符

  - 使用URLEncoder、URLDecoder解决