#### maven 相关配置片段

- maven 仓库地址
```xml

<mirror>  
  <id>alimaven</id>  
  <name>aliyun maven</name>  
  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>;  
  <mirrorOf>central</mirrorOf>          
</mirror>
```


- maven 配置打包，生成执行命令
```xml
       <plugins>
            <!-- 设置编译版本 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>appassembler-maven-plugin</artifactId>
                <version>1.10</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>assemble</goal>
                        </goals>
                    </execution>
                </executions>
                <configuration>
                    <!-- 生成linux, windows两种平台的执行脚本 -->
                    <platforms>
                        <platform>windows</platform>
                        <platform>unix</platform>
                    </platforms>
                    <!-- 根目录 -->
                    <assembleDirectory>${project.build.directory}/WebHelper</assembleDirectory>
                    <!-- 打包的jar，以及maven依赖的jar放到这个目录里面 -->
                    <repositoryName>lib</repositoryName>
                    <!-- 可执行脚本的目录 -->
                    <binFolder>bin</binFolder>
                    <!-- 配置文件的目标目录 -->
                    <configurationDirectory>conf</configurationDirectory>
                    <!-- 拷贝配置文件到上面的目录中 -->
                    <copyConfigurationDirectory>true</copyConfigurationDirectory>
                    <!-- 从哪里拷贝配置文件 (默认src/main/config) -->
                    <configurationSourceDirectory>src/main/resources</configurationSourceDirectory>
                    <!-- lib目录中jar的存放规则，默认是${groupId}/${artifactId}的目录格式，flat表示直接把jar放到lib目录 -->
                    <repositoryLayout>flat</repositoryLayout>
                    <encoding>UTF-8</encoding>
                    <logsDirectory>logs</logsDirectory>
                    <tempDirectory>tmp</tempDirectory>
                    <programs>
                        <program>
                            <id>WebHelper</id>
                            <!-- 启动类 -->
                            <mainClass>cn.hdj.helper.App</mainClass>
                            <jvmSettings>
                                <extraArguments>
                                    <extraArgument>-server</extraArgument>
                                    <extraArgument>-Xmx256m</extraArgument>
                                    <extraArgument>-Xms256m</extraArgument>
                                </extraArguments>
                            </jvmSettings>
                        </program>
                    </programs>
                </configuration>
            </plugin>
        </plugins>
```