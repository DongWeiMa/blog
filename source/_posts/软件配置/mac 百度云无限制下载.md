
---
title: 利用aria2实现百度云无限制下载
date: 2018-03-31
categories:
    - 软件配置
tags: 
    - 百度云
    - aria2
    - 无限制下载
---


[toc]

<!--more-->


## 介绍

>aria2 is a lightweight multi-protocol & multi-source command-line download utility. It supports HTTP/HTTPS, FTP, SFTP,BitTorrent and Metalink. aria2 can be manipulated via built-inJSON-RPC and XML-RPC interfaces.
Aria2是一个命令行下轻量级、多协议、多来源的下载工具（支持 HTTP/HTTPS、FTP、BitTorrent、Metalink），内建 XML-RPC 和 JSON-RPC 用户界面。

优点:不占用太多资源,多协议支持
可以用来下载百度网盘,迅雷,旋风等基于这些协议下载的东西,找到对应的插件即可(就是获取url到aria2中,并开始下载)

## 安装aria2


### aria2本身的安装
用brew安装比较方便,也可以通过其他的方式(去官网自己看吧)

```
brew install arai2
```

### 安装chrom插件
https://github.com/DongWeiMa/BaiduExporter
这里下载这个文件 然后安装到chrom就可以了

## 配置aria2
创建aria2.conf文件,将以下内容写到文件中

```
#rpc-passwd=passwd
#设置加密的密钥
#rpc-secret=secret
#允许rpc
enable-rpc=true
#允许所有来源, web界面跨域权限需要
rpc-allow-origin-all=true
#是否启用https加密，启用之后要设置公钥,私钥的文件路径
#rpc-secure=true
#启用加密设置公钥
#rpc-certificate=/home/name/.config/aria2/example.crt
#启用加密设置私钥
#rpc-private-key=/home/name/.config/aria2/example.key
#允许外部访问，false的话只监听本地端口
rpc-listen-all=true
#RPC端口, 仅当默认端口被占用时修改
#rpc-listen-port=6800
#最大同时下载数(任务数), 路由建议值: 3
max-concurrent-downloads=5
#断点续传
continue=true
#同服务器连接数
max-connection-per-server=5
#最小文件分片大小, 下载线程数上限取决于能分出多少片, 对于小文件重要
min-split-size=10M
#单文件最大线程数, 路由建议值: 5
split=10
#下载速度限制
max-overall-download-limit=0
#单文件速度限制
max-download-limit=0
#上传速度限制
max-overall-upload-limit=0
#单文件速度限制
max-upload-limit=0
#断开速度过慢的连接
#lowest-speed-limit=0
#验证用，需要1.16.1之后的release版本
#referer=*
#文件保存路径, 默认为当前启动位置
dir=D:\Downloads
#文件缓存, 使用内置的文件缓存, 如果你不相信Linux内核文件缓存和磁盘内置缓存时使用, 需要1.16及以上版本
#disk-cache=0
#另一种Linux文件缓存方式, 使用前确保您使用的内核支持此选项, 需要1.15及以上版本(?)
#enable-mmap=true
#文件预分配, 能有效降低文件碎片, 提高磁盘性能. 缺点是预分配时间较长
#所需时间 none < falloc ? trunc << prealloc, falloc和trunc需要文件系统和内核支持
file-allocation=prealloc
#不进行证书校验
check-certificate=false
```
### 启动
```
aria2c --conf-path=/Users/madongwei/aria2.conf
```
/Users/madongwei/aria2.conf 替换成自己的路径就可以了
## 在线查看任务
http://binux.github.io/yaaw/demo/

配置url为http://localhost:6800/jsonrpc 即可


其他参照:
https://medium.com/@Justin___Smith/aria2%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B-mac%E5%92%8Cwindows-b31d0f64bd4e

