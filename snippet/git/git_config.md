
1. 设置代理
```shell
git config --global http.proxy http://proxyUsername:proxyPassword@proxy.server.com:port
```
2. 指定域名代理
```shell
git config --global http.https://domain.com.proxy http://proxyUsername:proxyPassword@proxy.server.com:port


#使用socks5代理（推荐）
git config --global http.https://github.com.proxy socks5://127.0.0.1:51837
#使用http代理（不推荐）
git config --global http.https://github.com.proxy http://127.0.0.1:58591
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
