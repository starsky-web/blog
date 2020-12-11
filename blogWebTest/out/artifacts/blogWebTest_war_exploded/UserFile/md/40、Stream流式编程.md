# 40、Stream流

------

# 1、概述

类似于流水线，流的数据源可以是集合数组等

**有两个特征:**

1. Pipelining：中间的操作都返回流对象本身
2. 内部迭代：流可以直接调迭代方法(foreach)

# 2、获取Stream流的两种方式

1. 所有的Collection集合都可以通过stream默认方法获取流
2. Stream接口的静态方法of可以获取数组对应的流

# 3、stream流中的常用方法

## 3.1、forEach方法

使用forEach方法可以遍历流中的数据

```java
//获取Stream流
        Stream<String> stream = Stream.of("张三", "李四", "王五", "赵六", "田七");
        //使用forEach
        stream.forEach((String name)->{
            System.out.println(name);
        });
```

## 3.2、filter方法

filter方法可以对数据进行过滤

参数predicate是一个函数式接口

Stream流只能使用一次

```java
//创建一个Stream流
        Stream<String> stream = Stream.of("张三丰", "张翠山", "赵敏", "周芷若", "张无忌");
        Stream<String> stream2 = stream.filter((String name)->{return name.startsWith("张");});
        stream2.forEach((name)->{
            System.out.println(name);
        });
```

## 3.3、map方法

将流中的元素映射到另一流

```java
Stream<String> stream = Stream.of("1", "2", "3", "4");
        //使用map方法,映射为Integer类型
        Stream<Integer> stream2 = stream.map((String str) -> {
            return Integer.parseInt(str);
        });
```

## 3.4、count方法

终结方法，统计元素个数，返回long值



## 3.5、其他方法

去掉前几个元素

limit方法，参数是long值，如果集合长度大于参数则进行截取

返回一个新的流



跳过前几个

skip方法

返回新流，参数是long值



组合方法，静态方法concat

组合两个流