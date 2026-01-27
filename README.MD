### 开发记录

我的开发工具箱: 记录项目搭建配置，代码片段，开发工具，常用脚本，资讯阅读，小知识点等方面

持续更新中...

### 一、开发环境配置

- [Java](./doc/java_dev_env_conf.md)
    - JDK安装
    - 多版本 JDK 管理工具: jenv、jabba、sdkman,vfox
    - Maven
- [Node](./doc/node_conf.md)
    - 安装
    - 多版本管理工具: nvm
    - npm 源配置
- [Python](./doc/python_conf.md)
    - 安装
    - 多版本管理工具: pyenv, vfox
    - pip 源配置
- [docker](./doc/docker.md)
    - [docker-compose 一键安装需要的服务](./docker/docker-compose-env.yml)
        - redis
        - mysql
        - oracle
        - rabbitmq
        - es
        - nginx

### 二、开发相关工具

- IDE 工具

    - [IntelliJ IDEA](https://www.jetbrains.com/idea/): 一款优秀的 Java 开发 IDE
        - [IDE 设置](./doc/idea.md)
    - [Visual Studio Code](https://code.visualstudio.com/): 开源的 IDE
- 科学上网工具
    - [clash-verge](https://github.com/clash-verge-rev/clash-verge-rev)
- 书签同步工具
    - [floccus](https://floccus.org/) + webdev 多平台同步，不支持 Safari 浏览器
- 接口调试

    - [Postman](https://www.postman.com/) API 调试工具
    - vscode rest-client 插件

- Chrome浏览器插件
    - Quick QR 二维码生成器
    - JSON Viewer 响应的json格式化显示
    - Proxy SwitchyOmega 代理切换
    - floccus bookmarks 书签同步
    - 沉浸式翻译

- 内嵌数据库
    - duckdb, OLAP 数据库
    - sqlite ， OLTP 数据库

- shell 工具

    - [FinalShell](http://www.hostbuf.com/) :一款由 Java 开发的 shell 工具
    - [MobaXterm](https://mobaxterm.mobatek.net/) 在 Window 下可以使用一些 Linux 命令，免费版限制了 sessions 数量
    - [XTerminal](https://www.terminal.icu/)
- 版本控制

    - [Git](https://git-scm.com/) : 版本管理工具
        - [Git 菜鸟教程](https://www.runoob.com/git/git-tutorial.html): Git 简单学习教程
        - [learnGitBranching](https://github.com/pcottle/learnGitBranching): 一个 Git 命令可视化学习项目
- 数据库管理工具

    - Navicat Premium 收费
    - IntelliJ DataGrip 收费
    - DBeaver 有免费的社区版
    - [Another Redis Desktop Manager](https://github.com/qishibo/AnotherRedisDesktopManager) : Redids GUI 客户端
    - [PDMan](https://gitee.com/robergroup/pdman) PDMan-国产免费通用数据库建模工具
    - [PrettyZoo](https://github.com/vran-dev/PrettyZoo) 使用 JavaFX 实现的 Zookeeper GUI 管理工具
- 开发调试

    - [whistle](https://github.com/avwo/whistle):基于 Node 实现的跨平台抓包调试代理工具
- 在线排版工具

    - [markdown-nice](https://github.com/mdnice/markdown-nice) :支持主题设计的 Markdown 编辑器，让排版变 Nice
- 自动化工具
- 在线练习工具

    - [SQL 在线练习](https://sqlzoo.net/wiki/SELECT_basics)
    - [SQL语句练习](./snippet/db/SQL语句练习.md)
- 算法可视化工具

    - https://algorithm-visualizer.org/
    - https://visualgo.net/en
- 内网穿透工具

    - [cpolar](https://www.cpolar.com/): 简单免费的内网穿透工具
- 数据库字典

    - [DBCHM](https://gitee.com/lztkdr/DBCHM): 只支持 Window，支持导出 html，chm,pdf
- 作图工具

    - [draw.io](https://app.diagrams.net/): 在线画图工具，有离线版
    - [代码片段图片生成](https://github.com/carbon-app/carbon)
    - [StarUML](https://staruml.io/download)  StarUML是一个开源的UML工具列表软件
- Linux 下好用的工具
    - [jq](https://github.com/stedolan/jq) 命令行下 json 操作
    - [clipboard](https://github.com/sindresorhus/clipboard-cli) 剪切板
    - [fail2ban](https://github.com/fail2ban/fail2ban) fail2ban是一款实用软件，可以监视你的系统日志，然后匹配日志的错误信息（正则式匹配）执行相应的屏蔽动作。
    - [一键更换国内软件源脚本](https://gitee.com/SuperManito/LinuxMirrors)
- [Motrix 下载工具](https://github.com/agalwood/Motrix): Motrix 是一款全能的下载工具，支持下载 HTTP、FTP、BT、磁力链等资源。
- [ToDesk 远程桌面](https://www.todesk.com/): 个人免费稳定的远程桌面工具，可作为 TeamViewer 的代替方案
- [在线 LaTeX 公式编辑器](https://www.codecogs.com/latex/eqneditor.php)
- [ASCII 注释工具](http://asciiflow.com/)
- [Shields](https://shields.io/)  开源项目徽章生成

- JVM 相关库或工具
    - [JOL](https://openjdk.java.net/projects/code-tools/jol/) 用于查看 Java 对象头类库
    - [jmh 图表](https://github.com/Sayi/jmh-visual-chart) 用于可视化 jmh 基准测试数据
    - [GCViewer](https://github.com/chewiebug/GCViewer) GC log 可视化工具

- 文件加密工具
  - Cryptomator

### 三、资讯 & 博客

- https://readhub.cn/tech
- [阮一峰科技周刊](http://www.ruanyifeng.com/blog/weekly/)


### 四、AI 相关
#### 4.1、编程工具
- Claude Code
- opencode

#### 4.2、国内大模型
  - https://www.volcengine.com/activity/codingplan
  - https://platform.minimax.io/subscribe/coding-plan
  - https://docs.bigmodel.cn/cn/coding-plan
  - 智谱免费模型glm-4.7-flash https://docs.bigmodel.cn/cn/guide/models/free/glm-4.7-flash

### 其它 awesome toolbox

- [awesome-java](https://github.com/akullpp/awesome-java)

### 版权声明 (Copyright and License)

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
<img alt="知识共享许可协议" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
</a><br />本作品采用
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议</a>进行许可。
