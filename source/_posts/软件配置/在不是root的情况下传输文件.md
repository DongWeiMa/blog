---
title: 在不是root的情况下传输文件
date: 2018-03-15
categories:
    - 软件配置
tags: 
    - ftp
    - sudo
    - shell
---



遇到一个问题,虽然sudo 可以进行操作,但是ftp的时候因为权限不足导致无法上传文件.

<!--more-->



## 三个解决方法
1. scp
2. 先上传自己的home目录下,再ssh上去移动文件夹
3. 修改文件夹权限2333

sudo chown -R user:user folder

