# 28、File类

------



# 1、概述

File类是一个封装了文件和文件夹的类，可以使用file类对文件夹和文件进行操作

file类与系统无关，在任何系统下都可正常运作

# 2、成员变量

file类有四个常用的成员变量

**路径分隔符**

```java
static String pathSeparator
static char pathSeparator
```

与系统相关的路径分隔符，Windows下为分号

第一种为字符串格式，第二种为字符格式

**名称分隔符**

```java
static String separator
static char separator
```

与系统相关的默认名称分隔符，Windows下为反斜杠

# 3、绝对路径与相对路径

**绝对路径**：完整路径，以盘符开始

**相对路径**：是一个简化版的路径，相对于当前项目的根目录

**注意**：

1. 路径不区分大小写
2. 路径中的文件名称用分隔符，Windows使用反斜杠，由于反斜杠是转义符，可以使用两个反斜杠表示一个普通斜杠

# 4、构造方法

**File(String pathname)**

该构造要传递一个路径（文件夹的或文件的都可以），不论路径是否存在，都会被封装成一个file对象

**File(String parent,String child)**

该构造把路径分成了两部分，可以单独使用，十分灵活

**File(File parent,String child)**

此构造有一段路径是File对象，可以使用File中的方法进行操作，更为灵活

# 5、File类获取相关的方法

```java
String getAbsolutePath();//返回此File对象的绝对路径(相对路径调用此方法返回的也是绝对路径)

String getPath();//返回此File对象的路径

String getName();//返回此File对象表示的文件或目录的名称(实质是路径最后一段)

Long length();//返回此抽象路径表示的文件的大小(文件夹不能获取，文件不存在返回0)
```



# 6、File类判断相关方法

```java
boolean exists();//测试此FIle类表示的文件或目录是否存在

boolean isDirectory();//测试此FIle类表示的文件是否是一个目录

boolean isFile();//测试此FIle对象表示的文件是否是一个标准文件
```

# 7、创建和删除相关的功能

```java
boolean createNewFile();//当且经当此File类指向的对象不存在时不可分地创建一个空文件

boolean delete();//删除此File类指向的文件或目录

boolean mkdir();//创建此抽象类指向的目录(只能创建一个)

Boolean mkdirs();//创建此抽象路径指定的目录，可以创建多级
```

**注意**：

1. 四种方法都是成功执行时返回true，未执行(目录存在或其他情况)是返回false
2. delete直接在硬盘删除，不进回收站，谨慎操作
3. createNewFile的路径如果不存在会抛出异常

# 8、遍历目录相关方法

```java
String[] list(FilenameFilter filter);//返回指定目录中满足过滤器条件的文件和目录

File[] listFiles();//把目录中所有文件和目录封装成File对象，存在数组中
```

**注意**：

1. 两个方法遍历的都是构造中传递的目录
2. 如果目录不存在，会空指针
3. 如果路径不是目录，也会空指针