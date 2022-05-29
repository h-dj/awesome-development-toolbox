
1. 设置代理
```shell
git config --global http.proxy http://proxyUsername:proxyPassword@proxy.server.com:port
```
2. 指定域名代理
```shell
git config --global http.https://domain.com.proxy http://proxyUsername:proxyPassword@proxy.server.com:port
```
3. 禁用 ssl 验证
```shell
git config http.sslVerify false

# 指定域名
git config --global http.https://domain.com.sslVerify false
```
4. 去除代理
```shell

git config --global --unset http.proxy
git config --global --unset http.https://domain.com.proxy

```
5. 启用ssl 验证
```shell
git config --global --unset http.sslVerify
git config --global --unset http.https://domain.com.sslVerify
```
