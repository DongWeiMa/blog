---
title: git ssh 多账号
date: 2018-03-11 
categories:
    - 软件配置
tags: 
    - git
    - ssh
---

git ssh 多账号配置遇到问题解决
<!--more-->
## 生成ssh密钥
```
ssh-keygen -t rsa
Enter file in which to save the key 输入文件名
```
## 新密钥添加到SSH agent中
 ```
 ssh-agent bash
 ssh-add ~/.ssh/id_rsa
 ```
 
## 公钥添加到远程
比如添加到github,ssh管理冲,将pub文件中的值放进去
## config文件
 必须先进入ssh目录下创建

 vi config

```
 Host github.com
	 HostName github.com
	 User git
	 IdentityFile ~/.ssh/github
 
 Host aliyun
	 HostName code.aliyun.com
	 User git
	 IdentityFile ~/.ssh/aliyun

 Host code.aliyun.com
	 HostName code.aliyun.com
	 User git
	 IdentityFile ~/.ssh/nbugs_aliyun
	 
```

## 添加SSH Key 后进行测试是否连接成功
```
ssh -T aliyun # 此处为上面config文件中的Host  如果报域名无法解析,可能是你的config文件命名成了ssh_config,改回来即可
```
如果报 
```
Permission denied (publickey).
```
则可能是你新密钥忘记添加到SSH agent中

## 如何使用
比如使用 Host aliyun 这个配置<br/>
原来的url为<br/>
```git remote add origin git@code.aliyun.com:Company/testing.git```
改为<br/>
```git remote add origin git@aliyun:Company/testing.git```
<br/>
这样就能clone下来了


## 同域名多账号注意点
需要几点注意

1.remote pull push的时候有问题，因为要设置邮箱问题了 pull的时候识别的是邮箱，2个github账号，2个邮箱，我们自然不能使用global的user.email了

1.取消global

```
git config --global --unset user.name
git config --global --unset user.email
```

2.设置每个项目repo的自己的user.email

```
git config  user.email "xxxx@xx.com"
git config  user.name "suzie"
```
之后push pull就木有问题了

