---
title: 在mac OSX 中zookeeper安装使用
date: 2018-03-13
categories:
    - 软件配置
tags: 
    - mac
    - zookeeper
---


安装和使用zk shell客户端

<!--more-->

[toc]
## 查看信息
```brew info zookeeper```

## 安装
```
$brew install zookeeper
==> Downloading https://homebrew.bintray.com/bottles/zookeeper-3.4.6_1.mavericks.bottle.2.tar.gz
######################################################################## 100.0%
==> Pouring zookeeper-3.4.6_1.mavericks.bottle.2.tar.gz
==> Caveats
To have launchd start zookeeper at login:
  ln -sfv /usr/local/opt/zookeeper/*.plist ~/Library/LaunchAgents
Then to load zookeeper now:
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.zookeeper.plist
Or, if you don't want/need launchctl, you can just run:
  zkServer start
==> Summary
��  /usr/local/Cellar/zookeeper/3.4.6_1: 207 files, 13M
```

## 配置
```ls /usr/local/etc/zookeeper```


## 基本命令zkServer 
zkServer XXX 报个错
显示
```
ZooKeeper JMX enabled by default
Using config: /usr/local/etc/zookeeper/zoo.cfg
Usage: ./zkServer.sh {start|start-foreground|stop|restart|status|upgrade|print-cmd}
```
基本命名都有了

## zkCli基本命令
输入h

```
ZooKeeper -server host:port cmd args
	stat path [watch]
	set path data [version]
	ls path [watch]
	delquota [-n|-b] path
	ls2 path [watch]
	setAcl path acl
	setquota -n|-b val path
	history 
	redo cmdno
	printwatches on|off
	delete path [version]
	sync path
	listquota path
	rmr path
	get path [watch]
	create [-s] [-e] path data acl
	addauth scheme auth
	quit 
	getAcl path
	close 
	connect host:port

```

### 建立会话连接

```
zkCli.sh  -timeout 0  -r  -server  ip:port
```
```
zkCli.sh -timeout 5000 -server 192.168.0.23:2181
```
### 增

```create [-s] [-e] path data acl```
默认情况下,不添加-s或-e参数的,创建的是持久节点
-s表示创建顺序节点 
-e表示创建临时节点 
acl表示创建的节点路径 
data表示创建的节点的数据内容

```
create /node1 1222
ls2 /node1


create -e /node 122
ls2 / 

 
create -s /node1 123
ls /  
```
### 删
删除无子节点的节点
```delete path [version]```
删除有子节点的节点
```rmr path```

```
stat /node1
delete /node1 1
delete /node1 2

#version和修改时的version意义是一样的，也是用于校验。 
#注意这个命令中的node必须是没有子节点的，否则抛出异常：
```
### 改
```set path data [version] ```

```
create -s /node1 123
get /node1
set /node1 12344
get /node1

#加入dataversion校验
set /node1 12331 2
set /node1 12331 1
#可知，增加了version校验之后，那么version就必须和修改之前的dataversion相同，否则抛出异常
```

### 查
#### 获取节点的子节点列表
```ls path```

#### 获取节点的数据，其结果是当前节点的值和stat该路径的值放在一起
```get path```
#### 获取节点的子节点列表以及stat该路径
```ls2 path```






