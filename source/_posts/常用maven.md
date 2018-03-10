---
title: 常用maven
date: 2018-03-11 
categories:
    - 软件配置
tags: 
    - maven
---

一些常用的maven
<!--more-->

## 单元测试
```
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-test</artifactId>
  <scope>test</scope>
</dependency>
<dependency>
  <groupId>junit</groupId>
  <artifactId>junit</artifactId>
  <scope>test</scope>
</dependency>
<dependency>
  <groupId>org.mockito</groupId>
  <artifactId>mockito-all</artifactId>
  <version>1.10.19</version>
  <scope>test</scope>
</dependency>
<dependency>
  <groupId>org.mockito</groupId>
  <artifactId>mockito-core</artifactId>
  <scope>test</scope>
</dependency>
<dependency>
  <groupId>org.testng</groupId>
  <artifactId>testng</artifactId>
  <version>RELEASE</version>
</dependency>

```
## 日志
```
<dependency>
  <groupId>com.nbugs.logging</groupId>
  <artifactId>nbugs-boot-starter-logging</artifactId>
</dependency>
<dependency>
  <groupId>com.nbugs.logging</groupId>
  <artifactId>nbugs-boot-starter-logging</artifactId>
</dependency>
<dependency>
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-api</artifactId>
</dependency>
<dependency>
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-log4j12</artifactId>
</dependency>
<dependency>
  <groupId>log4j</groupId>
  <artifactId>log4j</artifactId>
</dependency>
```
## 数据库
```
<dependency>
  <groupId>mysql</groupId>
  <artifactId>mysql-connector-java</artifactId>
  <scope>runtime</scope>
</dependency>
<dependency>
	<groupId>com.alibaba</groupId>
	<artifactId>druid</artifactId>
</dependency>
<dependency>
	<groupId>org.apache.hbase</groupId>
	<artifactId>hbase-client</artifactId>
	<version>${hbase-client.version}</version>
</dependency>
<dependency>
  <groupId>org.apache.phoenix</groupId>
  <artifactId>phoenix-core</artifactId>
  <version>4.6.0-HBase-1.1</version>
</dependency>
```
## springboot
```
<parent>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-parent</artifactId>
	<version>1.3.8.RELEASE</version>
	<relativePath/> <!-- lookup parent from repository -->
</parent>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-web</artifactId>
  <exclusions>
    <exclusion>
      <groupId>ch.qos.logback</groupId>
      <artifactId>logback-classic</artifactId>
    </exclusion>
    <exclusion>
      <groupId>ch.qos.logback</groupId>
      <artifactId>logback-core</artifactId>
    </exclusion>
  </exclusions>
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-jdbc</artifactId>
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-tomcat</artifactId>
  <!--	<scope>provided</scope>-->
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-test</artifactId>
  <scope>test</scope>
</dependency>
```
## 字节码
```
<dependency>
  <groupId>cglib</groupId>
  <artifactId>cglib</artifactId>
  <version>3.2.4</version>
</dependency>
<dependency>
  <groupId>net.bytebuddy</groupId>
  <artifactId>byte-buddy</artifactId>
  <version>1.7.11</version>
</dependency>
```
## 公司私有包
```

<!--https://code.aliyun.com/nbugs_base/nbugs-boot-starter-disconf-->
<dependency>
  <groupId>com.nbugs.disconf.start</groupId>
  <artifactId>disconf</artifactId>
</dependency>

<!--https://code.aliyun.com/nbugs_base_app/nbugs-boot-starter-mq-->
<dependency>
    <groupId>com.nbugs.xiaoyuanhao</groupId>
    <artifactId>nbugs-boot-starter-mq</artifactId>
    <version>1.2.4.RELEASE</version>
</dependency>

<!--https://code.aliyun.com/nbugs_base/nbugs-boot-starter-hsf-->
<dependency>
  <groupId>com.nbugs.xiaoyuanhao</groupId>
  <artifactId>nbugs-boot-starter-hsf</artifactId>
</dependency>

<!--https://code.aliyun.com/nbugs/nbugs-log-->
<dependency>
  <groupId>com.nbugs</groupId>
  <artifactId>log</artifactId>
  <version>1.0.4</version>
</dependency> 

<!--https://code.aliyun.com/nbugs/nbugs-boot-starter-logging-->
<dependency>
	<groupId>com.nbugs.logging</groupId>
	<artifactId>nbugs-boot-starter-logging</artifactId>
	<version>2.0.4-RELEASE</version>
</dependency>

<!--https://code.aliyun.com/nbugs_base/nbugs-disconf-datasource-starter-->
<dependency>
   <groupId>com.nbugs</groupId>
	<artifactId>datasource-starter</artifactId>
	<version>1.0.0</version>
</dependency>

<!--https://code.aliyun.com/nbugs_base_app/nbugs-boot-starter-exception/-->
<dependency>
	<groupId>com.nbugs.boot.exception</groupId>
	<artifactId>nbugs-boot-starter-exception</artifactId>
	<version>1.0.2</version>
</dependency>
```

