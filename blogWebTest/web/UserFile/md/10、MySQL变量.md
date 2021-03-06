# 10、MySQL变量

------



# 1、系统变量

变量由系统提供，不是用户定义，属于服务器层面

**使用语法**

1、查看所有的系统变量

```sql
show global variables;-- 参看所有全局变量
show session variables;-- 查看所有会话变量，可以不写session
```

2、查看满足条件的部分系统变量

```sql
show global variables like '%char%';
```

3、查看指定的某个系统变量的值

```sql
select @@系统变量名;
select @@global.变量名;
```

4、为某个系统变量赋值

```sql
set 系统变量名 = 值;--其他的在变量名前面加前缀
set @@global[session].系统变量=值;
-- 跨连接有效
```

**注意**

如果是全局变量，者加global，会话级别就加session，不写默认session

## 1.1、全局变量

作用域：服务器每次启动将为所有全局变量赋初始值，针对于所有的连接的有效，重启会恢复

## 1.2、会话变量

作用域：针对于当前连接有效

# 2、自定义变量

变量是用户自定义的，不是由系统生成的

使用步骤

声明-->赋值-->使用



## 2.1、用户变量

作用域：针对于当前会话（连接）有效

**声明并初始化**

```sql
set @用户变量名=值;
set @用户变量名：值;
select @用户变量名：=值;
```

**赋值（更新）**

```sql
使用set 或 select，语句同上
```

```sql
select 字段 into 变量名 from 表; -- 把查询出来的值赋给变量
```

**使用**

```sql
select @变量名;-- 参看变量的值
```

可以应用在任何地方，放在begin end里面或外面

## 2.2、局部变量

作用域：局部有效，定义它的begin end中有效

必须指定类型，可以不赋初始值，只能在begin end的第一句话

**声明**

```
declare 变量名 类型;
declare 变量名 类型 default 值;
```

**赋值**

```sql
同用户变量，使用set时不用@，使用select时要
```

**使用**

```sql
select 局部变量名;
```

|          | 作用域       | 定义和使用位置                  | 语法          |
| -------- | ------------ | ------------------------------- | ------------- |
| 用户变量 | 当前会话     | 会话中的任何地方                | 必须加@       |
| 局部变量 | begin  end中 | 只能在begin end中，且为第一句话 | 一般不用@符号 |

