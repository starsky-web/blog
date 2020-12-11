# 20、Collections工具类

------



# 1、Collections是一个操作数组的工具类

# 2、addALL方法

同时添加多个元素到集合中，静态方法

```java
Collections.addAll(list,"a","b","c","d","e");
```

第一个参数为列表，后面的参数是要添加的元素

# 3、shuffle方法

打乱集合的顺序

```java
Collections.shuffle(list);
```

参数方式集合的名字

# 4、sort方法

把元素按默认规则（升序）排序

如果要排列自定义类型，需实现Comparable接口，重写接口中的compareTo方法

```java
Collections.sort(list3);
```



或者直接传递构造器进行比较，

```java
Collections.sort(list4, new Comparator<Integer>() {
            @Override
            public int compare(Integer o1, Integer o2) {
                return o1-o2;
            }
        });
```

（较复杂）