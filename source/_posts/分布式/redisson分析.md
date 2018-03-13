---
title: redisson 分布式锁,分布式实时对象简单分析
date: 2018-03-11 
categories:
    - 分布式
tags: 
    - redisson
    - 分布式
---

分布式锁和分布式实时对象简单分析
FLUSHALL 
<!--more-->
## 分布式锁
以下内容是边debug边redis-cli上查看

```
127.0.0.1:6379> keys *
1) "redisson_live_object:{223135323034373636363932363322}:com.nbugs.xiaoyuanhao.springboot.demo.service.pojo.MyLiveObject:Id:java.lang.String"


127.0.0.1:6379> type anyLock
hash


127.0.0.1:6379> hkeys anyLock
1) "0e746833-cad4-4f94-b80e-abfb3e7abf4f:20"


127.0.0.1:6379> hvals anyLock
1) "1"
1
```

## 分布式对象
以下内容是边debug边redis-cli上查看

```
获取新增的所有key,发现是hash的
127.0.0.1:6379> keys *
1) "redisson_live_object:{223135323034373636363932363322}:com.nbugs.xiaoyuanhao.springboot.demo.service.pojo.MyLiveObject:Id:java.lang.String"


hash中,找到其内容
key
127.0.0.1:6379> hkeys redisson_live_object:{223135323034373636363932363322}:com.nbugs.xiaoyuanhao.springboot.demo.service.pojo.MyLiveObject:Id:java.lang.String
1) "\"redisson_live_object\""
2) "\"name\""

value
127.0.0.1:6379> hvals redisson_live_object:{223135323034373636363932363322}:com.nbugs.xiaoyuanhao.springboot.demo.service.pojo.MyLiveObject:Id:java.lang.String
1) "\"1\""
2) "\"myName\""
```


### 分布式实时对象代理类
字节码框架 bytebuddy
http://bytebuddy.net/#/tutorial

```
缓存器只有一个,但是被几个地方获取了引用
ConcurrentMap<Class<?>, Class<?>>   Redisson.liveObjectClassCache   分布式对象缓存器
RedissonLiveObjectService classCache,redissonClient,objectBuilder  分布式对象缓存和配置信息

 Class<? extends T> proxied = builder.method(ElementMatchers.isDeclaredBy(
                Introspectior.getTypeDescription(RLiveObject.class))
                .and(ElementMatchers.isGetter().or(ElementMatchers.isSetter())
                        .or(ElementMatchers.named("isPhantom"))
                        .or(ElementMatchers.named("delete"))))
                .intercept(MethodDelegation.withDefaultConfiguration()
                        .withBinders(FieldProxy.Binder
                                .install(LiveObjectInterceptor.Getter.class,
                                        LiveObjectInterceptor.Setter.class))
                        .to(new LiveObjectInterceptor(redisson, entityClass,
                                getRIdFieldName(entityClass))))
//                .intercept(MethodDelegation.to(
//                                new LiveObjectInterceptor(redisson, codecProvider, entityClass,
//                                        getRIdFieldName(entityClass)))
//                        .appendParameterBinder(FieldProxy.Binder
//                                .install(LiveObjectInterceptor.Getter.class,
//                                        LiveObjectInterceptor.Setter.class)))
                .implement(RLiveObject.class)
                .method(ElementMatchers.isAnnotatedWith(RFieldAccessor.class)
                        .and(ElementMatchers.named("get")
                        .or(ElementMatchers.named("set"))))
                .intercept(MethodDelegation.to(FieldAccessorInterceptor.class))
                
                .method(ElementMatchers.isDeclaredBy(RObject.class)
                        .or(ElementMatchers.isDeclaredBy(RObjectAsync.class)))
                .intercept(MethodDelegation.to(RObjectInterceptor.class))
                .implement(RObject.class)
                
                .method(ElementMatchers.isDeclaredBy(RExpirable.class)
                        .or(ElementMatchers.isDeclaredBy(RExpirableAsync.class)))
                .intercept(MethodDelegation.to(RExpirableInterceptor.class)). #方法拦截器 当运行set/get方法,被代理
                .implement(RExpirable.class)
                
                .method(ElementMatchers.isDeclaredBy(Map.class)
                        .or(ElementMatchers.isDeclaredBy(ConcurrentMap.class))
                        .or(ElementMatchers.isDeclaredBy(RMapAsync.class))
                        .or(ElementMatchers.isDeclaredBy(RMap.class)))
                .intercept(MethodDelegation.to(RMapInterceptor.class))
                .implement(RMap.class)
                
                .method(ElementMatchers.not(ElementMatchers.isDeclaredBy(Object.class))
                        .and(ElementMatchers.not(ElementMatchers.isDeclaredBy(RLiveObject.class)))
                        .and(ElementMatchers.not(ElementMatchers.isDeclaredBy(RExpirable.class)))
                        .and(ElementMatchers.not(ElementMatchers.isDeclaredBy(RExpirableAsync.class)))
                        .and(ElementMatchers.not(ElementMatchers.isDeclaredBy(RObject.class)))
                        .and(ElementMatchers.not(ElementMatchers.isDeclaredBy(RObjectAsync.class)))
                        .and(ElementMatchers.not(ElementMatchers.isDeclaredBy(ConcurrentMap.class)))
                        .and(ElementMatchers.not(ElementMatchers.isDeclaredBy(Map.class)))
                        .and(ElementMatchers.isGetter()
                                .or(ElementMatchers.isSetter()))
                        .and(ElementMatchers.isPublic()
                                .or(ElementMatchers.isProtected()))
                        )
                .intercept(MethodDelegation.to(
                                new AccessorInterceptor(redisson, objectBuilder)))
                
                .make().load(getClass().getClassLoader(),
                        ClassLoadingStrategy.Default.WRAPPER)
                .getLoaded();# 运行时生成class,加载class
                
                
                实现接口
                RObject.class, RMap.class, RExpirable.class, RLiveObject.class
classCache.putIfAbsent(entityClass, proxied);

```
T attachedObject = attach(detachedObject); 每次持久化,都会生成一个代理类,代理类是上面动态生成的class


boolean fastResult = liveMap.fastPut("redisson_live_object", "1");
        if (type == RCascadeType.PERSIST && !fastResult) {
            throw new IllegalArgumentException("This REntity already exists.");
        }
        
   判断是否已经存在该分布式共享对象的方法就是快速试错
   
### 分布式实时对象使用分析
第一次创建分布式对象,这个对象不是代理的,是原生的,因此需要手动持久化.

```
RLiveObjectService service = redisson.getLiveObjectService();
service.registerClass(MyLiveObject.class);
MyLiveObject obj1 = new MyLiveObject();
obj1.setName("myName");
obj1.setId(id);
service.<MyLiveObject>merge(obj1);


手动持久化,但是真正的持久化还是在代理类中完成的.copy的时候调用代理类的方法,触发持久化
copy(detachedObject, attachedObject, excludedFields);
```

获取对象实际得到的是代理对象

```
service.<MyLiveObject, String>get(MyLiveObject.class, id);
obj3.setName("change2");
service.<MyLiveObject, String>get(MyLiveObject.class, id);
System.out.println(obj4.getName());  #得到change2,是立刻刷新的


RedissonLiveObjectService
@Override
public <T, K> T get(Class<T> entityClass, K id) {
    try {
        T proxied = instantiateLiveObject(getProxyClass(entityClass), id);
        return asLiveObject(proxied).isExists() ? proxied : null;
    } catch (Exception ex) {
        unregisterClass(entityClass);
        throw ex instanceof RuntimeException ? (RuntimeException) ex : new RuntimeException(ex);
    }
}
```

