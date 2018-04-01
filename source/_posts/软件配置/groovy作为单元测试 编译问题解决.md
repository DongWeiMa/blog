---
title: groovy作为单元测试 编译问题解决
date: 2018-03-18
categories:
    - 软件配置
tags: 
    - idea
    - maven
    - groovy
    - 编译
---



java与groovy混合编程
<!--more-->

## 普通
project设置中
modules,右击add
添加groovy-all,即可
仅仅配这个只能是调试的时候运行groovy-test,但是maven打包的时候就不会进行编译

## maven 配置
主要是maven打包时也支持编译和运行单元测试

```

<plugins>
  <plugin>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.3</version>
    <configuration>
      <compilerId>groovy-eclipse-compiler</compilerId>
      <source>${java.version}</source>
      <target>${java.version}</target>
      <encoding>UTF-8</encoding>
    </configuration>
    <dependencies>
      <dependency>
        <groupId>org.codehaus.groovy</groupId>
        <artifactId>groovy-eclipse-compiler</artifactId>
        <version>2.9.2-01</version>
      </dependency>
      &lt;!&ndash; for 2.8.0-01 and later you must have an explicit dependency on groovy-eclipse-batch &ndash;&gt;
      <dependency>
        <groupId>org.codehaus.groovy</groupId>
        <artifactId>groovy-eclipse-batch</artifactId>
        <version>2.4.3-01</version>
      </dependency>
    </dependencies>
  </plugin>
</plugins>
```

