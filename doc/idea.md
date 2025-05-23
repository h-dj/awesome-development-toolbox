### IDEA 配置

#### 好用的插件

- MyBatisX : 方便 Mapper 接口与 Xml 文件之间的导航。
- Maven Helper: Maven 依赖查看，方便解决依赖冲突
- Alibaba Java Coding Guidelines 阿里巴巴Java开发规范
- Lombok 代码简化工具
- Key Promoter X快捷键学习工具
- ReadHub 每天高效浏览行业资讯
- CodeGlance 代码地图插件
- RestfulTool 一套 Restful 服务开发辅助工具集，能快速通过请求url 找到Controller
- Vuesion Theme IDEA 主题
- Atom Material ICons  IDEA 文件图标显示插件
- Search In Repository  搜索 maven/gradle 依赖
- String Manipulation 字符串处理插件： 大小写转换、变量名有下划线转驼峰命名等

#### 1. 字体修改

![image-20201206215749542](../images/idea/image-20201206215749542.png)

#### 2. 设置每次启动idea不自动打开项目

![image-20201206215920777](../images/idea/image-20201206215920777.png)

#### 3. 配置文件头注释模板

![image-20201206220255892](../images/idea/image-20201206220255892.png)

自定义一个注释模板

```
/** 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @Author ${USER}
 * @Date ${DATE} ${TIME} 
 */
```

修改Class中的默认名

```
这里改为你定义的名称
#parse("My File Header.java")
```

![image-20201206220523027](../images/idea/image-20201206220523027.png)

记得保存

#### 4. 重用运行配置

- 添加tomcat 配置，并保存

  ![image-20210112113453936](../images/idea/image-20210112113453936.png)
- 再项目路径 .idea/runConfigurations中找到运行的配置，保存起来
- 再新的项目中，重新包这些运行配置放到  .idea/runConfigurations中，重启IDEA，就可以重用配置

#### 5. 配置Live Template

> 1. https://www.jetbrains.com/help/idea/2016.3/creating-and-editing-template-variables.html
> 2. https://github.com/mraible/idea-live-templates

- 调用变量

```shell
$<variable_name>$
```

- 创建和编辑变量
  ![image-20210826093219756](../images/idea/image-20210826093219756.png)
- 内置预设变量

> https://www.jetbrains.com/help/idea/2016.3/live-template-variables.html#predefined_functions

- 进入设置Live Template
  ![img.png](../images/idea/img-202108251827.png)
- 模板

```java
/** 
 * 
 * @Author huangjiajian
 * @Date $DATE$ $TIME$
 * @Description: TODO(这里用一句话描述这个类的作用)
 */
```

- 使用

```java
// 输入 cdesc 按 Tab 键
```
