---
title: mac 开机自启
date: 2018-03-15
categories:
    - 软件配置
tags: 
    - launchd
    - plist
---


了解launchd和plist

<!--more-->
# 

## launchd---Mac OS 的开机启动方式
launchd 是 Mac OS 下用于初始化系统环境的关键进程，它是内核装载成功之后在OS环境下启动的第一个进程。采用这种方式来配置自启动项很简单，只需要一个plist文件，该plist文件存在的目录有

## Launchd 配置
目录配置
Mac 下 Launchd 指定目录有：
~/Library/LaunchAgents
/Library/LaunchAgents
/Library/LaunchDaemons
/System/Library/LaunchAgents
/System/Library/LaunchDaemons

其中的区别：
/System/Library 目录下存放的是系统文件
/Library 、~/Library/ 目录是用户存放的第三方软件
LaunchDaemons 是用户未登陆前就启动的服务
LaunchAgents 是用户登陆后启动的服务


## Plist 配置
这里列举几个比较有用的配置关键字：
Label - 标识符，用来表示该任务的唯一性
Program - 程序名称，用来说明运行哪个程序、脚本
ProgramArguments - 数组程序名，同上，只是可以运行多个程序
WatchPaths - 监控路径，当路径文件有变化是运行程序，也是数组
RunAtLoad - 是否在加载的同时启动

## plist 文件demo
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <dict>
      <key>SuccessfulExit</key>
      <false/>
    </dict>
    <key>Label</key>
    <string>homebrew.mxcl.redis</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/opt/redis/bin/redis-server</string>
      <string>/usr/local/etc/redis.conf</string>
      <string>--daemonize no</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>/usr/local/var</string>
    <key>StandardErrorPath</key>
    <string>/usr/local/var/log/redis.log</string>
    <key>StandardOutPath</key>
    <string>/usr/local/var/log/redis.log</string>
  </dict>
</plist>
```
注意，XXXXX 应该替换为 Mac 的用户名。「com.chanjh.wificheck」 可以更换为任意其他内容，保证不会重复就行。将这个 Plist 文件保存，文件名和 Label 一致，保存在 ~/Library/LaunchAgents

## 设置
```
设置开机启动
launchctl load ~/Library/LaunchAgents/com.chanjh.wifikeeper.plist
launchctl start com.chanjh.wifikeeper
卸载可以使用命令：
launchctl unload ~/Library/LaunchAgents/com.chanjh.wifikeeper.plist
launchctl stop com.chanjh.wifikeeper
```


