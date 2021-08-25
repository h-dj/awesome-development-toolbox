### Node 安装配置

#### 下载安装 
- https://nodejs.org/en/

#### 配置npm 下载源

方法一
```
npm config set registry https://registry.npm.taobao.org

```
或者配置 .npmrc 文件  npm help config 命令查看配置帮助
```
sass_binary_site=https://npm.taobao.org/mirrors/node-sass/
registry=https://registry.npm.taobao.org/
chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver
electron_mirror=https://npm.taobao.org/mirrors/electron/
phantomjs_cdnurl=https://npm.taobao.org/mirrors/phantomjs/
```


方法二

使用nrm 管理
```
#下载安装nrm
npm install -g nrm

#查看源
nrm ls

#切换源
nrm use taobao

```

#### 安装配置nvm 
```
安装nvm

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

#配置环境变量 .bashrc
echo 'export NVM_DIR="$HOME/.config/nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bashrc

＃设置国内源
echo 'export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node' >> ~/.bashrc


# 安装完成, 查看版本
nvm -v 

# 查看帮助
nvm -h 

#查看可安装node 版本
nvm ls-remote

#安装版本
nvm install 8.0.0

#使用
nvm use 8.0
```

#### 参考
- npm 切换源  https://www.runoob.com/w3cnote/npm-switch-repo.html
- nvm-window 版 https://github.com/coreybutler/nvm-windows
- nvm https://github.com/nvm-sh/nvm#troubleshooting-on-linux