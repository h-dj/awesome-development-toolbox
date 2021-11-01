### nginx 安装配置说明

#### 一、Nginx 安装

##### 1.1、window 下安装

##### 1.2、docker 安装


##### 1.3、安装扩展模块
```shell
# 在nginx 安装目录下
./configure --with-http_ssl_module --add-module=安装模块的绝对路径
make
make install
```


#### 二、Nginx 配置文件了解

##### 2.1、nginx.conf 整体指令了解

```nginx
user nobody; # a directive in the 'main' context

worker_processes  1; #工作线程

error_log  /var/log/nginx/error.log warn; #错误日志
pid        /var/run/nginx.pid; #线程ID

events {
    # 连接处理配置
}

http {
    # 对http 配置，影响该代码区域内的虚拟服务server  
    
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    # 日志格式
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main; #访问日志

    #加载其他模块配置
    include /etc/nginx/conf.d/*.conf;
        
    server {
        # HTTP virtual server 配置
        location /one {
            # 处理以 请求开始为 '/one' 的配置 
        }
        location /two {
            # 处理以 请求开始为 '/two' 的配置 
        }
    } 
    
    server {
        # configuration of HTTP virtual server 2
    }
}
stream {
    # TCP/UDP 配置
    server {
        # configuration of TCP virtual server 1 
    }
}
```



#### 三、Nginx 相关配置（使用场景）

##### 3.1、Nginx 负载均衡配置

- Nginx 内置方案

```nginx
http {
    #轮询（默认）
    upstream dev_cmallmanage{
        server 127.0.0.1:9102 ;
        server 127.0.0.1:9112;
    }
    #weight（根据权值分配）
    upstream dev_cmallmanage2{
        server 127.0.0.1:9102 weight=10;
        server 127.0.0.1:9112 weight=10;
    }
    # ip_hash（根据ip地址分配）
    upstream dev_cmallmanage3{
        ip_hash; 
        server 127.0.0.1:9102;
        server 127.0.0.1:9112;
    }

    # fair算法可以根据页面大小和加载时间长短智能地进行负载均衡
    # 需要安装模块 upstream_fair
    # https://github.com/gnosek/nginx-upstream-fair
    upstream dev_cmallmanage3{
        server 127.0.0.1:9102;
        server 127.0.0.1:9112;
        fair;
    }

    #url_hash（根据url分配）
    upstream backend {  
        server 127.0.0.1:9102;
        server 127.0.0.1:9112;
        hash $request_uri;  
        hash_method crc32;  #指定使用的hash算法
    }

    server {
        # 监听端口
		listen       80;
		# 监听访问的域名
        server_name dev.jiajianhuang.com;
		
	
		location  /cmallmanage/ {
			proxy_pass	http://dev_cmallmanage;	#反向代理到 dev_cmallmanage	 
			proxy_set_header Host $host;
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header REMOTE-HOST $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;				
		}
    
}
```

##### 3.2、Nginx 限流配置
- 限制请求数
```nginx
http {
    # $binary_remote_addr : 表示通过用户请求的ip地址这个标识来做限制
    # zone=one:10m : 表示生成一个大小为10M，名字为one的内存区域，用来存储访问的频次信息
    # rate=1r/s ： 表示允许相同标识的客户端的访问频次
    limit_req_zone $binary_remote_addr zone=one:10m rate=1r/s;
    server {
        location /search/ {
            # one ： 指定命名为 one 的内存区域
            # burst=5 ： 设置缓冲区大小，当超出访问频次时，先把请求放到缓冲区处理，当缓冲区满了后再排队等待
            # nodelay ：设置该参数， 超过访问频次而且缓冲区也满了的时候就会直接返回503
            # 如果想修改 不同的状态码，可用指令 limit_req_status
            limit_req_zone=one burst=5 nodelay;
        }
    }
}     
```
- 限制并发连接数
```nginx
http{
      limit_conn_zone $binary_remote_addr zone=addr:10m;

      server {
          location /download/ {
                  limit_conn addr 1;
          }
      }
}
```