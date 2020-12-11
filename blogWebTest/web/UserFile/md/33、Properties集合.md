# 33、Properties集合

------

# 1、概述

继承了Hashtable<k,v> implement  Map<k,v>

Properties类表示了一个持久的属性集，Properties可保存在流中或从流中加载，属性列表中每个键及其对应的值默认都是字符串格式

是唯一和IO流相结合的的集合

可以使用store方法把集合中的数据写入硬盘

使用load方法把硬盘中的数据读取到集合中



属性列表中每个键及其对应值都是一个字符串，Properties集合是一个双列集合，key和value默认都是字符串

# 2、添加数据

```java
Object setProperty(String key, String value)
 //调用 Hashtable 的方法 put。存储数据到集合
 String getProperty(String key)
 //用指定的键在此属性列表中搜索属性（根据键值获取属性）
Set<String> stringPropertyNames()
//返回属性列表中的键集，其中该键及其对应值是字符串
```



# 3、存储相关方法

```java
void store(OutputStream out, String comments)
//以适合使用 load(InputStream) 方法加载到 Properties 表中的格式，将此 Properties 表中的属性列表（键和元素对）写入输出流。
 void store(Writer writer, String comments)
//以适合使用 load(Reader) 方法的格式，将此 Properties 表中的属性列表（键和元素对）写入输出字符。
```

**参数含义**：

1. outputStream  out:字节输出流，不能写中文
2. Writer  writer:字符输出流，可以写中文
3. String  comments：注释，解释说明保存文件中的作用，不能用中文

**使用步骤**：

1. 创建Properties集合对象，添加数据
2. 创建输出流对象，构造方法中绑定输出目的地
3. 使用集合中的store方法，把数据写入文件
4. 释放资源

# 4、读取相关方法

```java
void load(InputStream inStream)
//从输入流中读取属性列表（键和元素对）。
void load(Reader reader)
//按简单的面向行的格式从输入字符流中读取属性列表（键和元素对）。
```

**参数解释**：

1. InputStream  instream：字节输入流，不能读取中文
2. Reader  reader：字符输入流，能读取中文

**使用步骤**：

1. 创建Properties集合对象
2. 创建流对象
3. 使用load方法读取保存读取键值对的文件
4. 遍历集合

**注意：**

1. 存储键值对的文件中，键与值默认的连接符号可以使用=、空格（其他符号）
2. 存储键值对的文件可以使用#进行注释，注释的内容不会被读取
3. 存储键值对的文件中，键与值默认都是字符串，不用加等号



