---
title: idea 倒入google-style之后,注释换行的问题
date: 2018-03-13
categories:
    - 软件配置
tags: 
    - idea
    - codeStyle
---


本来想这样

```
/**
 * 1.
 * 2.
 */
```

<!--more-->


结果保存之后成了这样

```
/**
 * 1.  2.
 */
```

解决,就是修改倒入之后的style
editor->code style->java->java doc->other->warp at right margin 去掉勾就行

