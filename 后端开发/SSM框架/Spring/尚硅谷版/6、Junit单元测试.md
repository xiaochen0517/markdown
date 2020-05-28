## Junit单元测试

#### Spring整合junit的配置

- 导入spring整合junit的jar（坐标）
- 使用Junit提供的一个注解把原有的main方法替换：@RunWith
- 告知spring的运行器，spring和ioc创建是基于xml还是注解的：@ContextConfiguration
  - locations：指定xml文件的位置
  - classes指定注解类所在的位置
- 当使用spring 5.x版本的时候，要求junit的jar包必须是4.12及以上

#### 示例

```java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath*:bean.xml" })
public class Test1 {

    @Autowired
    MyService myService = null;

    @Test
    public void test(){
        myService.findAll();
    }

}
```



