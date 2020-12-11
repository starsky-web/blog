# 21、map集合

------



# 1、概述

双列集合，是一个接口，有两个泛型，将键映射到值

特点：

​	1、双列集合，一个元素包含两个值（键值）

​	2、Map集合中的元素，键和值的数据类型可以相同也可以不同

​	3、K不允许重复，Key与value一一对应

# 2、常用子类

## 2.1、HashMap集合

实现了Map接口

特点：

​	底层是哈希表，查询速度快

​	是无序集合

## 2.2、LinkedHashMap

继承了HashMap集合

特点：

​	底层是哈希表加链表（保证迭代顺序）

​	是有序集合

# 3、Map集合常用方法

```java
public V put(K key,V value);//把指定的键值对添加到Map集合中
public V remove(Object Key);//把指定的键所对应的的键值对元素，在Map中删除，返回被删元素的值
public V get(Object Key);//根据指定的键，在Map集合中获取相应的值
boolean containsKey(Object Key);//判断是否有指定值
```

# 4、遍历Map集合

使用迭代器或增强for

步骤：

​	1、使用map集合中的方法keySet()，把map中所有key取出，存储在一个set集合中

​	2、遍历Set集合，获取map集合中的每一个key

​	3、通过map集合中的方法get(key)，通过key找到值

示例:

```java
//使用迭代器
Set<String> set = map.keySet();
        Iterator<String> it = set.iterator();
        while(it.hasNext()){
            String key = it.next();
            Integer value = map.get(key);
            System.out.println(value);
        }
```

```java
//使用增强for
Set<String> set = map.keySet();
for (String s : set) {//s中是键
            Integer value = map.get(s);
            System.out.println(s+value);
        }
```



使用entry对象遍历

**方法**:Set<Map.Entry<K,V>> entrySet()返回此映射中包含的映射关系的Set视图

**实现步骤**：

​	1、使用Map集合中的方法entrySet()，把map集合中多个entry对象取出，存到一个Set集合中

​	2、遍历Set集合，获取每一个Entry对象

​	3、使用entry对象中的方法getKey()和getvalue()获取键和值

```java
Set<Map.Entry<String, Integer>> set = map.entrySet();
        //使用迭代器
        Iterator<Map.Entry<String, Integer>> it = set.iterator();
        while(it.hasNext()){
            Map.Entry<String, Integer> entry = it.next();
            String key = entry.getKey();
            Integer value = entry.getValue();
            System.out.println(key+value);
        }
```

```java
Set<Map.Entry<String, Integer>> set = map.entrySet();
 for (Map.Entry<String,Integer> entry:set){
            String key = entry.getKey();
            Integer value = entry.getValue();
            System.out.println(key+value);
        }
```

# 5、HashMap存储自定义类型

必须重写HashCode和equals方法

# 6、LinkedHashMap

Map接口的哈希表和链表实现类，有序集合

# 7、HashTable

Map接口的实现类，底层也是哈希表，**已被取代**，不允许为空，单线程，速度慢

其子类Property还在使用