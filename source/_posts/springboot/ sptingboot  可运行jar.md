---
title: sptingboot  可运行jar
date: 2018-03-14
categories:
    - springboot
tags: 
    -jar
---


java -jar  XXX.jar  param1 param2 ...

<!--more-->


@SpringBootApplication
实现CommandLineRunner 接口

```

@SpringBootApplication
public class SpringBootConsoleApplication implements CommandLineRunner {

  public static void main(String[] args) throws Exception {

    SpringApplication.run(SpringBootConsoleApplication.class, args);

  }

  @Override
  public void run(String... args) throws Exception {
    Scanner sc = new Scanner (new BufferedInputStream(System.in));
...
}

```

