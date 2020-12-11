# 45、JDBC

------

# 1、概述

java程序操作数据库的方法

# 2、使用步骤

**1、导入驱动jar包**

1. 复制包到lib目录下
2. 右键，add  as  library加入项目

**2、注册驱动**

```java
Class.forname("com.mysql.jdbc.Driver");
//驱动文件的路径
```

**3、获取连接对象**

```java
Connection conn = DriverManager.getConnection("jdbc:mysql://主机名:端口号/库名", "用户名", "密码");

Connection conn = DriverManager.getConnection("jdbc:mysql:///库名", "用户名", "密码");
//本地且为3306端口可省略部分内容
```

**4、定义sql语句**

```java
String sql = "update 出版社2 set 邮政编码 = 100012 where 出版社ID = 1";
```

使用字符串写一条要执行的sql命令

**5、获取执行sql的对象  Statement**

```java
Statement stmt = conn.createStatement();
```

**6、执行**

```java
int count = stmt.executeUpdate(sql);
```

**7、处理结果**

```java
System.out.println(count);
```

**8、释放资源**

```java
stmt.close();
conn.close();
```

# 3、各类解析

## 3.1、DriverManager

驱动管理对象

**功能**

1、注册驱动

```java
static void registerDriver(Driver driver)；//注册与给定的驱动程序

写代码使用：Class.forName("com.mysql.jdbc.Driver")
```



2、获取数据库连接

```java
static Connection getConnection(String url,String user,String password);
//获取连接对象
```



## 3.2、Connection

数据库连接对象

**功能**

1、获取执行sql的对象

```java
Statement createStatement()

preparedStatement prepareStatement(String sql)
```

2、管理事务

```java
//开启事务
void setAutoCommit(boolean autoCommit)设置参数为false即可开启
//提交事务
commit()
//回滚事务
rollback()
```



## 3.3、Statement

执行sql的对象

```java
boolean execute(String sql);//可执行任意sql，了解即可，不常用
int executeUpdate(String sql);//执行DML语句(增删改)，DDl语句(创建，删除表和库)；返回值是影响的行数
ResultSet executeQuery(String sql);//执行DQL(查询)
```



## 3.4、ResultSet

结果集对象封装查询结果

```java
next();//游标下移一行
getXXX();//获取数据，XXX代表数据类型
	参数：
		int:代表列的编号，从1开始
		String:代表列的名称,

```

**注意**

```
使用步骤
	1、游标向下移一行
	2、判断是否有数据(用next的返回值判断)
	3、获取数据
```



## 3.5、PreparedStatement

执行sql的对象，功能更强大

**sql注入问题**

在拼接sql时，有一些sql的特殊关键字参与字符串的拼接，会造成安全性问题

解决方式是使用PreparedStatement对象

**预编译的SQL**：参数使用?作为占位符

**步骤**

定义SQL时sql的参数使用?作为占位符

获取执行对象时传入sql

然后给?赋值

```java
使用SetXXX(参数1，参数2)给问号赋值
1是?的位置，2是?的值
```



# 4、CRUD



# 5、事务

使用Connection对象来管理事务

# 6、连接池

概念：存放数据库连接的容器

实现：

标准接口：DataSource

1、方法：

```java
获取连接getConnection()
归还连接：如果连接对象是从连接池中获得的，那么Connection.close方法不会关闭连接，只会归还连接
```

2、由数据库厂商实现

C3P0：数据库连接实现技术，较老

Druld：数据库连接池技术，较新，由阿里提供

## 6.1、C3P0

步骤

1. 导入jar包：两个
2. 定义配置文件
3. 创建核心对象 数据池连接对象 
4. 获取连接

## 6.2、Druld

步骤

1. 导入jar包
2. 定义配置文件
3. 获取数据库连接池对象，通过工厂类获取
4. 获取连接





# 7、Template

Spring框架提供的

使用

1. 导入jar包
2. 创建JDBCTemplate对象，依赖于数据源DataSource
3. 调用方法

