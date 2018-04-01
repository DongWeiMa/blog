---
title: maven jar 打包
date: 2018-03-20
categories:
    - 软件配置
tags: 
    - maven
    - jar
    - 打包
---


## 覆盖默认MANIFEST.MF文件
maven-jar-plugin 插件

```
   <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-jar-plugin</artifactId>
      <version>3.0.2</version>
      <configuration>
        <archive>
          <index>true</index>
          <manifestFile>
            src/main/resources/META-INF/MANIFEST.MF
          </manifestFile>
          <manifest>
            <addClasspath>true</addClasspath>
            <classpathPrefix>lib/</classpathPrefix>
          </manifest>
          <manifestEntries>
            <mode>development</mode>
            <url>${project.url}</url>
            <key>value</key>
          </manifestEntries>
        </archive>
      </configuration>
    </plugin>-
```
## 把依赖的jar包打进去和覆盖默认MANIFEST.MF文件

maven-assembly-plugin 插件
也支持MANIFEST.MF文件修改

```
    <plugin>
        <artifactId>maven-assembly-plugin</artifactId>
        <version>2.2</version>
        <configuration>
            <descriptorRefs>
                <descriptorRef>jar-with-dependencies</descriptorRef>
            </descriptorRefs>
             <archive>
                <index>true</index>
                <manifest>
                    <addDefaultImplementationEntries>true</addDefaultImplementationEntries>
                    <addDefaultSpecificationEntries>true</addDefaultSpecificationEntries>
                </manifest>
                <manifestEntries>
                    <Premain-Class>test.agent.MyAgent</Premain-Class>
                </manifestEntries>
            </archive>
        </configuration>
        <executions>
            <execution>
                <id>make-assembly</id>
                <!-- this is used for inheritance merges -->
                <phase>package</phase>
                <!-- append to the packaging phase. -->
                <goals>
                    <goal>single</goal>
                    <!-- goals == mojos -->
                </goals>
            </execution>
        </executions>
    </plugin>
```




