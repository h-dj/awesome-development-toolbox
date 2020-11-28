### Python 环境安装

### 安装

官网地址 https://www.python.org/downloads/

#### window 
下载对应的安装包，按照步骤执行即可，注意把python添加到PATH中

#### Linux 
在Linux 中，一般会默认安装python2, 现在我们安装Python 3.9.0


```
#解压安装包
tar -xJf Python-3.9.0.tar.xz

#进入解压的文件夹，执行 ./configure 脚本
./configure

#编译安装
make && make install

#查看版本
python3.9 --version
```

执行以上操作后，Python 会安装在 /usr/local/bin 目录中
Python 库安装在 /usr/local/lib/python3.8.0，3.8.0为你使用的 Python 的版本号。

### 多版本管理工具: pyenv
```
#多版本管理

#下载
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

#配置
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc

#设置别名
echo -e 'function pyInstall(){\n\tv="$1";wget https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -P ~/.pyenv/cache/;pyenv install $v\n}' >> ~/.bashrc

#刷新配置
source ~/.bashrc

#使用
pyenv -v

#安装
#pyenv install 3.9.0 

#使用别名安装
pyInstall 3.9.0
```

### pip 源配置
```
# 在linux 配置
vim ~/.pip/pip.conf

[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com

```

### 参考
- Python 环境搭建 https://www.runoob.com/python/python-install.html