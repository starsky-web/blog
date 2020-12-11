# 15、Collection集合

------



# 1、概述

Collection对象用于存储多个对象（变量）可以对这些对象（变量进行同时操作）

# 2、常用方法介绍

## 2.1、add方法

boolean add(E e)添加一个元素，返回的布尔值为时候成功添加

## 2.2、remove方法

boolean remove(Object o)删除指定元素

## 2.3、contains方法

boolean contains(Object o)检查是否存在指定元素

## 2.4、isEmpty方法

boolean isEmpty()

检查Collection是否为空

## 2.5、size方法

int size()返回Collection中的元素数

## 2.6、toArray方法

Object[] toArray()返回包含所有元素的数组

## 2.7、clear方法

void clear()清空所有元素，但对象还在

# 3、使用方法

先使用多态写法获得一个对象

```java
Collection<String> coll = new ArrayList<>();
//使用多态写法获得了一个String类型的对象数组
```

add方法

```java
boolean b1 = coll.add("张三");
//可以不接收返回值
```

# 4、迭代器

Itreator，是Collection框架下的一个接口，需要实现类对象

## 4.1、常用方法

boolean hasNext()判断有没有元素剩余

E next()返回迭代的下一个元素，并让指针推进一

## 4.2、使用步骤

1. 使用集合中的方法Itreator()获取迭代器，使用Itreator接受
2. 使用Itreator中的hasNext判断有没有下一个
3. 使用next方法输出
4. 主要使用while循环执行

## 4.3、示范

```java
//构造一个数组，并存两个值
Collection<String> coll = new ArrayList<>();
coll.add("一");
coll.add("二");

//创建迭代器
Iterator<String> it = coll.iterator();

//使用while循环遍历
while(it.hasNext()){
            System.out.println(it.next());
        }
```

# 5、增强for循环

用来遍历数组和对象，底层是迭代器

格式：

```java
for(集合/数组的数据类型 变量名：集合名/数组名){
	sout（变量名）
}
```

举例：

```java
int[] arr = {1,2,3,4,5};
for(int i:arr){
	System.out.println(i);
}
```

