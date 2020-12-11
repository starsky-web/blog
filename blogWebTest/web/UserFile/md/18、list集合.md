# 18、list集合

------



# 1、概述

list接口继承了Collection，

# 2、特点

1、有序集合，存储元素和取出元素的顺序是一致的

2、有索引

3、允许存储重复的元素

# 3、特有方法

```java
void add(int index, E element)在列表的指定位置插入指定元素
E set(int index, E element)用指定元素替换列表中指定位置的元素
E get(int index)返回列表中指定位置的元素
E remove(int index)移除列表中指定位置的元素
```

# 4、使用

```java
//创建对象，多态
List<String> list = new ArrayList<>();
//使用add方法
List.add("a");
List.add(3,"b");//新加的元素索引为3
//remove方法
String remove = list.remove(2);//移除索引2的元素，并存储到remove中
//使用set方法
list.set(3,"A");//把索引为3的元素设置成A
```

# 5、LinkedList集合

list集合的另一个链表实现类，linkedlist的链表可以实现多线程

## 5.1、特点

底层是链表，查询慢，增删快，有大量操作首尾元素的方法

使用list集合特有的方法，不使用多态

## 5.2、方法

```java
void addFirst(E e)将指定元素添加到开头
void addLast(E e)将指定元素添加到此列表的结尾，等效于add
E getFirst()返回列表的第一个元素
E getLast()返回最后一个元素
E removeFirst()移除第一个元素
E removeLast()移除最后一个元素
E pop()从此列表的堆栈处弹出一个元素
void push(E e)将元素推入堆栈，等效于addfirst
boolean isEmpty()查看列表是否为空
```

## 5.3、使用

```java
//创建对象
java.util.LinkedList<String> linked = new java.util.LinkedList<>();
//在开头添加
linked.add("a");
linked.add("b");
```

