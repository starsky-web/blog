## 背景
常见的一种数据库设计是使用连续的整数为做主键，当新的数据插入到数据库时，由数据库自动生成。但这种设计不一定适合所有场景。
随着越来越多的使用Nhibernate、EntityFramework等ORM（对象关系映射）框架，应用程序被设计成为工作单元（Unit Of Work）模式，需要在数据持久化之前生成主键，为了保证在多线程并发以及站点集群环境中主键的唯一性，最简单最常见的方式是将主键设计成为GUID类型。
<blockquote>
**工作单元**是数据库应用程序经常使用的一种设计模式，简单一点来说，就是对多个数据库操作进行打包，记录对象上的所有变化，并在最后提交时一次性将所有变化通过系统事务写入数据库。目的是为了**减少数据库调用次数**以及**避免数据库长事务**。关于工作单元的知识可以在园子里面搜索到很多，在这里就不做详细的介绍了。
</blockquote>
GUID（全球唯一标识符）也称为UUID，是一种由算法生成的二进制长度为128位的数字标识符。在理想情况下，任何计算机和计算机集群都不会生成两个相同的GUID。GUID 的总数达到了2<sup>128（3.4×10</sup>38）个，所以随机生成两个相同GUID的可能性非常小，但并不为0。GUID一词有时也专指微软对UUID标准的实现。
<blockquote>
<a href="http://www.ietf.org/rfc/rfc4122.txt" target="_blank">RFC 41222</a>描述了创建标准GUID，如今大多数GUID生成算法通常是一个很长的随机数，再结合一些像网络MAC地址这种随机的本地组件信息。
</blockquote>
GUID的优点允许开发人员随时创建新值，而无需从数据库服务器检查值的唯一性，这似乎是一个完美的解决方案。
很多数据库在创建主键时，为了充分发挥数据库的性能，会自动在该列上创建聚集索引。我们先来说一说什么是聚集索引，。集索引确定表中数据的物理顺序。聚集索引类似于电话簿，按姓氏排列数据。由于聚集索引规定数据在表中的物理存储顺序，因此一个表也只能包含一个聚集索引。它能够快速查找到数据，但是如果插入数据库的主键不在列表的末尾，向表中添加新行时就非常缓慢。例如，看下面这个例子，在表中已经存在三行数据(例子来自Jeremy Todd的博客<a href="https://www.codeproject.com/articles/388157/guids-as-fast-primary-keys-under-multiple-database" target="_blank">GUIDs as fast primary keys under multiple databases</a>：
<table>
<thead>
<tr>
<th>ID</th>
<th>Name</th>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td>Holmes, S.</td>
</tr>
<tr>
<td>4</td>
<td>Watson, J.</td>
</tr>
<tr>
<td>7</td>
<td>Moriarty, J.</td>
</tr>
</tbody>
</table>
此时非常简单：数据行按对应ID列的顺序储存。如果我们新添加一行ID为8的数据，不会产生任何问题，新行会追加的末尾。
<table>
<thead>
<tr>
<th>ID</th>
<th>Name</th>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td>Holmes, S.</td>
</tr>
<tr>
<td>4</td>
<td>Watson, J.</td>
</tr>
<tr>
<td>7</td>
<td>Moriarty, J.</td>
</tr>
<tr>
<td><font color="Gold">8</font></td>
<td><font color="Gold">Lestrade, I.</font></td>
</tr>
</tbody>
</table>
但如果我们想插入一行的ID为5的数据:
<table>
<thead>
<tr>
<th>ID</th>
<th>Name</th>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td>Holmes, S.</td>
</tr>
<tr>
<td>4</td>
<td>Watson, J.</td>
</tr>
<tr>
<td><font color="Gold">5</font></td>
<td><font color="Gold">Hudson, Mrs.</font></td>
</tr>
<tr>
<td><font color="red">7</font></td>
<td><font color="red">Moriarty, J.</font></td>
</tr>
<tr>
<td><font color="red">8</font></td>
<td><font color="red">Lestrade, I.</font></td>
</tr>
</tbody>
</table>
ID为7,8的数据行必须向下移动。虽然在这算什么事儿，但当您的数据量达到数百万行的级别之后，这就是个问题了。如果你还想要每秒处理上百次这种请求，那可真是难上加难了。
这就是GUID主键引发的问题：它是随机产生的，所以在数据插入时，随时都会涉及到数据的移动，导致插入会很缓慢，还会涉及大量不必要的磁盘活动。总结果有两点：

- **空间的浪费以及由此带来的读写效率的下降；**
- **更主要的，存储的碎片化以及由此带来的读写效率严重下降。**
- 

备注：摘自Crazy.Liu博客<a href="http://www.cnblogs.com/springwind268/p/3984175.html" target="_blank">SQL SERVER下有序GUID和无序GUID作为主键&amp;聚集索引的性能表现</a>
GUID最关键的问题就是它是随机的。我们需要设计一种有规则的GUID生成方式，在之后生成的GUID类型总是比之前的要大，保证插入数据库的主键是在列表末尾追加的，这种我们称之为**有序GUID**。
## GUID排序规则
在讲解有序GUID之前，我们必须先了解一下GUID在.Net中以及各个数据库中的排序规则，排序规则不一样，生成有序GUID的规则也会随之变化。
128位的GUID主要有4部分组成：Data1, Data2, Data3, and Data4，你可以看成下面这样：
<blockquote>
11111111-2222-3333-4444-444444444444
</blockquote>
Data1 占4个字节, Data2 2个字节, Data3 2个字节加 Data4 8个字节。我们分别的对个字节编上序号：
<table>
<thead>
<tr>
<th>序号</th>
<th>1</th>
<th>2</th>
<th>3</th>
<th>4</th>
<th></th>
<th>5</th>
<th>6</th>
<th></th>
<th>7</th>
<th>8</th>
<th></th>
<th>9</th>
<th>10</th>
<th></th>
<th>11</th>
<th>12</th>
<th>13</th>
<th>14</th>
<th>15</th>
<th>16</th>
</tr>
</thead>
<tbody>
<tr>
<td>Value</td>
<td>11</td>
<td>11</td>
<td>11</td>
<td>11</td>
<td>-</td>
<td>22</td>
<td>22</td>
<td>-</td>
<td>33</td>
<td>33</td>
<td>-</td>
<td>44</td>
<td>44</td>
<td>-</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
</tr>
</tbody>
</table>
### GUID在.Net中的排序规则
在.Net中，GUID默认的排序过段规则是按左到右的，看下面这个示例。
```
    var list = new List<Guid> {
        new Guid("00000000-0000-0000-0000-010000000000"),
        new Guid("00000000-0000-0000-0000-000100000000"),
        new Guid("00000000-0000-0000-0000-000001000000"),
        new Guid("00000000-0000-0000-0000-000000010000"),
        new Guid("00000000-0000-0000-0000-000000000100"),
        new Guid("00000000-0000-0000-0000-000000000001"),
        new Guid("00000000-0000-0000-0100-000000000000"),
        new Guid("00000000-0000-0000-0010-000000000000"),
        new Guid("00000000-0000-0001-0000-000000000000"),
        new Guid("00000000-0000-0100-0000-000000000000"),
        new Guid("00000000-0001-0000-0000-000000000000"),
        new Guid("00000000-0100-0000-0000-000000000000"),
        new Guid("00000001-0000-0000-0000-000000000000"),
        new Guid("00000100-0000-0000-0000-000000000000"),
        new Guid("00010000-0000-0000-0000-000000000000"),
        new Guid("01000000-0000-0000-0000-000000000000")
    };
    list.Sort();

    foreach (Guid guid in list) {
        Console.WriteLine(guid.ToString());
    }

```
输出结果：
<blockquote>
00000000-0000-0000-0000-00000000000**1**<br>
00000000-0000-0000-0000-000000000**1**00<br>
00000000-0000-0000-0000-0000000**1**0000<br>
00000000-0000-0000-0000-00000**1**000000<br>
00000000-0000-0000-0000-000**1**00000000<br>
00000000-0000-0000-0000-0**1**0000000000<br>
00000000-0000-0000-00**1**0-000000000000<br>
00000000-0000-0000-0**1**00-000000000000<br>
00000000-0000-000**1**-0000-000000000000<br>
00000000-0000-0**1**00-0000-000000000000<br>
00000000-000**1**-0000-0000-000000000000<br>
00000000-0**1**00-0000-0000-000000000000<br>
0000000**1**-0000-0000-0000-000000000000<br>
00000**1**00-0000-0000-0000-000000000000<br>
000**1**0000-0000-0000-0000-000000000000<br>
0**1**000000-0000-0000-0000-000000000000
</blockquote>
通过上面的输出结果，我们可以得到排序的权重如下：
<table>
<thead>
<tr>
<th>序号</th>
<th>1</th>
<th>2</th>
<th>3</th>
<th>4</th>
<th></th>
<th>5</th>
<th>6</th>
<th></th>
<th>7</th>
<th>8</th>
<th></th>
<th>9</th>
<th>10</th>
<th></th>
<th>11</th>
<th>12</th>
<th>13</th>
<th>14</th>
<th>15</th>
<th>16</th>
</tr>
</thead>
<tbody>
<tr>
<td>权重</td>
<td>1</td>
<td>2</td>
<td>3</td>
<td>4</td>
<td></td>
<td>5</td>
<td>6</td>
<td></td>
<td>7</td>
<td>8</td>
<td></td>
<td>9</td>
<td>10</td>
<td></td>
<td>11</td>
<td>12</td>
<td>13</td>
<td>14</td>
<td>15</td>
<td>16</td>
</tr>
<tr>
<td>Value</td>
<td>11</td>
<td>11</td>
<td>11</td>
<td>11</td>
<td>-</td>
<td>22</td>
<td>22</td>
<td>-</td>
<td>33</td>
<td>33</td>
<td>-</td>
<td>44</td>
<td>44</td>
<td>-</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
</tr>
</tbody>
</table>
这与数字排序规则一致，从右到左进行依次进行排序（数字越小，权重越高，排序的优先级越高）。
### GUID在各个数据库中的排序规则
在SQL Server数据库中，我们有一种非常简单的方式来比较两个GUID类型的大小值（其实在SQL Server数据库中称为`UniqueIdentifier`类型）：
```
With UIDs As (--                         0 1 2 3  4 5  6 7  8 9  A B C D E F
            Select ID =  1, UID = cast ('00000000-0000-0000-0000-010000000000' as uniqueidentifier)
    Union   Select ID =  2, UID = cast ('00000000-0000-0000-0000-000100000000' as uniqueidentifier)
    Union   Select ID =  3, UID = cast ('00000000-0000-0000-0000-000001000000' as uniqueidentifier)
    Union   Select ID =  4, UID = cast ('00000000-0000-0000-0000-000000010000' as uniqueidentifier)
    Union   Select ID =  5, UID = cast ('00000000-0000-0000-0000-000000000100' as uniqueidentifier)
    Union   Select ID =  6, UID = cast ('00000000-0000-0000-0000-000000000001' as uniqueidentifier)
    Union   Select ID =  7, UID = cast ('00000000-0000-0000-0100-000000000000' as uniqueidentifier)
    Union   Select ID =  8, UID = cast ('00000000-0000-0000-0010-000000000000' as uniqueidentifier)
    Union   Select ID =  9, UID = cast ('00000000-0000-0001-0000-000000000000' as uniqueidentifier)
    Union   Select ID = 10, UID = cast ('00000000-0000-0100-0000-000000000000' as uniqueidentifier)
    Union   Select ID = 11, UID = cast ('00000000-0001-0000-0000-000000000000' as uniqueidentifier)
    Union   Select ID = 12, UID = cast ('00000000-0100-0000-0000-000000000000' as uniqueidentifier)
    Union   Select ID = 13, UID = cast ('00000001-0000-0000-0000-000000000000' as uniqueidentifier)
    Union   Select ID = 14, UID = cast ('00000100-0000-0000-0000-000000000000' as uniqueidentifier)
    Union   Select ID = 15, UID = cast ('00010000-0000-0000-0000-000000000000' as uniqueidentifier)
    Union   Select ID = 16, UID = cast ('01000000-0000-0000-0000-000000000000' as uniqueidentifier)
)
Select * From UIDs Order By UID, ID

```
例子来自Ferrari的博客<a href="http://sqlblog.com/blogs/alberto_ferrari/archive/2007/08/31/how-are-guids-sorted-by-sql-server.aspx" target="_blank">How are GUIDs sorted by SQL Server?</a>
查询结果：
<table>
<thead>
<tr>
<th>ID</th>
<th>UID</th>
</tr>
</thead>
<tbody>
<tr>
<td>16</td>
<td>0**1**000000-0000-0000-0000-000000000000</td>
</tr>
<tr>
<td>15</td>
<td>000**1**0000-0000-0000-0000-000000000000</td>
</tr>
<tr>
<td>14</td>
<td>00000**1**00-0000-0000-0000-000000000000</td>
</tr>
<tr>
<td>13</td>
<td>0000000**1**-0000-0000-0000-000000000000</td>
</tr>
<tr>
<td>12</td>
<td>00000000-0**1**00-0000-0000-000000000000</td>
</tr>
<tr>
<td>11</td>
<td>00000000-000**1**-0000-0000-000000000000</td>
</tr>
<tr>
<td>10</td>
<td>00000000-0000-0**1**00-0000-000000000000</td>
</tr>
<tr>
<td>9</td>
<td>00000000-0000-000**1**-0000-000000000000</td>
</tr>
<tr>
<td>8</td>
<td>00000000-0000-0000-00**1**0-000000000000</td>
</tr>
<tr>
<td>7</td>
<td>00000000-0000-0000-0**1**00-000000000000</td>
</tr>
<tr>
<td>6</td>
<td>00000000-0000-0000-0000-00000000000**1**</td>
</tr>
<tr>
<td>5</td>
<td>00000000-0000-0000-0000-000000000**1**00</td>
</tr>
<tr>
<td>4</td>
<td>00000000-0000-0000-0000-0000000**1**0000</td>
</tr>
<tr>
<td>3</td>
<td>00000000-0000-0000-0000-00000**1**000000</td>
</tr>
<tr>
<td>2</td>
<td>00000000-0000-0000-0000-000**1**00000000</td>
</tr>
<tr>
<td>1</td>
<td>00000000-0000-0000-0000-0**1**0000000000</td>
</tr>
</tbody>
</table>
通过上面可以得于是如下结果：
<ol>
- 先按每1-8从左到右进行排序；
- 接着按第9-10位从右到左进行排序；
- 最后按后11-16位从右到左进行排序;
</ol>
通过分析，我们可得到如下权重列表：
<table>
<thead>
<tr>
<th>序号</th>
<th>1</th>
<th>2</th>
<th>3</th>
<th>4</th>
<th></th>
<th>5</th>
<th>6</th>
<th></th>
<th>7</th>
<th>8</th>
<th></th>
<th>9</th>
<th>10</th>
<th></th>
<th>11</th>
<th>12</th>
<th>13</th>
<th>14</th>
<th>15</th>
<th>16</th>
</tr>
</thead>
<tbody>
<tr>
<td>权重</td>
<td>16</td>
<td>15</td>
<td>14</td>
<td>13</td>
<td></td>
<td>12</td>
<td>11</td>
<td></td>
<td>10</td>
<td>9</td>
<td></td>
<td>7</td>
<td>8</td>
<td></td>
<td>1</td>
<td>2</td>
<td>3</td>
<td>4</td>
<td>5</td>
<td>6</td>
</tr>
<tr>
<td>Value</td>
<td>11</td>
<td>11</td>
<td>11</td>
<td>11</td>
<td>-</td>
<td>22</td>
<td>22</td>
<td>-</td>
<td>33</td>
<td>33</td>
<td>-</td>
<td>44</td>
<td>44</td>
<td>-</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
<td>44</td>
</tr>
</tbody>
</table>
在Microsoft官方文档中，有一篇文档关于GUID与`uniqueidentifier`的值比较：<br>
<a href="https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/comparing-guid-and-uniqueidentifier-values" target="_blank">Comparing GUID and uniqueidentifier Values</a>。
不同的数据库处理GUID的方式也是不同的。在SQL Server存在内置GUID类型，没有原生GUID支持的数据库通过模拟来方式来实现的。在Oracle保存为raw bytes类型，具体类型为**raw(16)**；在MySql中通常将GUID储存为**char(36)**的字符串形式。
关于Oracle、MySql数据库的排序规则与.Net中排序规则，不过篇章的限制，这里不再做具体的演示，不过我在github上提供了示例SQL语句：<a href="https://gist.github.com/tangdf/f0aed064ba10bfa0050e4344b9236889" target="_blank">https://gist.github.com/tangdf/f0aed064ba10bfa0050e4344b9236889</a>，您可以自己进行测试。我们在这里只给出最终的结论：
<blockquote>
**小结：**
<ol>
- .Net中GUID的排序规则是从左到右依次进行排序，与数字排序规则一致；
- Sql Server数据库提供对GUID类型的支持，在数据库中称为`UniqueIdentifier`类型，但是排序规则比较复杂：

- 先按每1-8从左到右进行排序；
- 接着按第9-10位从右到左进行排序；
- 最后按后11-16位从右到左进行排序；


- Oracle数据库未提供对GUID类型的支持，使用的是raw bytes类型保存数据**raw(16)**，具体类型为，排序规则与GUID在.Net中规则一致；
- MySql数据未提供对GUID类型的支持，使用的是字符串的类型保存数据，使用是的**char(36)**类型，由于使用的是字符串类型，排序规则与GUID在.Net中的规则一致。
</ol>
</blockquote>
## 有序GUID
有序GUID是有规则的生成GUID，保存在之后生成的GUID类型总是比之前的要大。不过在上一节中，已经提到过各个数据库对GUID支持不一样，而且排序的规则也不一样，所以我们需要为每一个数据库提供不一致的有序GUID生成规则。
### UuidCreateSequential函数
我们都知道SQL Server数据库有一个`NewSequentialId()`函数，用于创建有序GUID。在创建表时，可以将它设置成为GUID类型字段的默认值，在插入新增数据时自动创建主键的值（该函数只能做为字段的默认值，不能直接在SQL中调用）。
示例：
```
Create Table TestTable
	   (
		 ID UniqueIdentifier Not Null Default ( NewSequentialId() ) ,
		 Number Int
	   );

```
`NewSequentialId()`函数只能在数据库使用，不过在 Microsoft 的 MSDN 文档中有说明，**NEWSEQUENTIALID 是对 Windows UuidCreateSequential 函数的包装**，<a href="https://msdn.microsoft.com/zh-cn/library/ms189786(v=sql.120).aspx" target="_blank">https://msdn.microsoft.com/zh-cn/library/ms189786(v=sql.120).aspx</a>。这样我们可以在C#通过非托管方法调用：
```
   [System.Runtime.InteropServices.DllImport("rpcrt4.dll", SetLastError = true)]
   private static extern int UuidCreateSequential(out Guid guid);

   public static Guid NewSequentialGuid()
   {
       const int RPC_S_OK = 0;

       int result = UuidCreateSequential(out var guid);
       if (result != RPC_S_OK) {
           throw new System.ComponentModel.Win32Exception(System.Runtime.InteropServices.Marshal.GetLastWin32Error());
       }

       return guid;
   }

```
不这个方法也存在三个问题：
<ol>
- 
这个方法涉及到安全问题，`UuidCreateSequential`函数依赖的计算硬件，该方法的后12位其实是网卡的MAC地址。这是我电脑生成的一组有序GUID。
<blockquote>
{A2A9339**3**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**4**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**5**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**6**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**7**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**8**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**9**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**A**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**B**-C8DC-11E7-B133-**2C56DC497A97**}<br>
{A2A9339**C**-C8DC-11E7-B133-**2C56DC497A97**}
</blockquote>
这是我电脑的网卡的MAC地址：<br>
<img src="https://images2017.cnblogs.com/blog/162090/201711/162090-20171117164633499-10139893.png" alt="" loading="lazy">

- 
由于`UuidCreateSequential`函数生成的有序GUID中包括MAC地址，所以如果在服务器集群环境中，肯定存在一台服务器A上生成的有序GUID总比另一台服务器B生成要更小，服务器A产生的数据插入到数据库时，由于聚集索引的问题，总是会移动服务器B已经持久化到数据库中的数据。集群的服务器越多，产生的IO问题更严重。在服务器群集环境中，需要自行实现有序GUID。

- 
`UuidCreateSequential`函数生成的**GUID规则与SQL Server中排序的规则存在不一致**，这样仍然会导致严重的IO问题，所以需要将GUID重新排序后再持久化到数据库。例如上面列出生成的GUID列表，依次生成的数据可以看出，是第4位字节在自增长，在这与任何一个数据库的排序规则都不一致；关于该函数生成的规则，可以见此链接：<a href="https://stackoverflow.com/questions/5585307/sequential-guids" target="_blank">https://stackoverflow.com/questions/5585307/sequential-guids</a>。

</ol>
下面的方法是将生成的GUID调整成为适合Sql Server使用的有序GUID（针对其它数据库支持，您可以按排序规则自行修改）：
```

[System.Runtime.InteropServices.DllImport("rpcrt4.dll", SetLastError = true)]
static extern int UuidCreateSequential(byte[] buffer);

static Guid NewSequentialGuid() {

    byte[] raw = new byte[16];
    if (UuidCreateSequential(raw) != 0)
        throw new System.ComponentModel.Win32Exception(System.Runtime.InteropServices.Marshal.GetLastWin32Error());

    byte[] fix = new byte[16];

    // reverse 0..3
    fix[0x0] = raw[0x3];
    fix[0x1] = raw[0x2];
    fix[0x2] = raw[0x1];
    fix[0x3] = raw[0x0];

    // reverse 4 &amp; 5
    fix[0x4] = raw[0x5];
    fix[0x5] = raw[0x4];

    // reverse 6 &amp; 7
    fix[0x6] = raw[0x7];
    fix[0x7] = raw[0x6];

    // all other are unchanged
    fix[0x8] = raw[0x8];
    fix[0x9] = raw[0x9];
    fix[0xA] = raw[0xA];
    fix[0xB] = raw[0xB];
    fix[0xC] = raw[0xC];
    fix[0xD] = raw[0xD];
    fix[0xE] = raw[0xE];
    fix[0xF] = raw[0xF];

    return new Guid(fix);
}

```
<blockquote>
**小结：**<br>
`UuidCreateSequential`函数存在隐私的问题，不适合集群环境，并且需要重新排序后再提交到数据库；
</blockquote>
### COMB解决方案
COMB 类型的GUID 是由`Jimmy Nilsson`在他的“<a href="http://www.informit.com/articles/article.aspx?p=25862" target="_blank">The Cost of GUIDs as Primary Keys</a>”一文中设计出来的。<br>
基本设计思路是这样的：既然GUID数据生成是随机的造成索引效率低下，影响了系统的性能，那么能不能通过组合的方式，保留GUID的前10个字节，用后6个字节表示GUID生成的时间（DateTime），这样我们将时间信息与GUID组合起来，在保留GUID的唯一性的同时增加了有序性，以此来提高索引效率（这是针对Sql Server数据库来设计的）。
在NHibernate框架中已经实现该功能，可以在github上看到实现方式：<a href="https://github.com/nhibernate/nhibernate-core/blob/master/src/NHibernate/Id/GuidCombGenerator.cs#L25-L72" target="_blank">https://github.com/nhibernate/nhibernate-core/blob/master/src/NHibernate/Id/GuidCombGenerator.cs#L25-L72</a>。
在EF以及EF Core也同样实现了类似的解决方案，EF Core的实现方式：<a href="https://github.com/aspnet/EntityFrameworkCore/blob/f7f6d6e23c8e47e44a61983827d9e41f2afe5cc7/src/EFCore/ValueGeneration/SequentialGuidValueGenerator.cs#L25-L44" target="_blank">https://github.com/aspnet/EntityFrameworkCore/blob/f7f6d6e23c8e47e44a61983827d9e41f2afe5cc7/src/EFCore/ValueGeneration/SequentialGuidValueGenerator.cs#L25-L44</a>
在这里介绍一下使用的方式，由EF Core框架自动生成有序GUID的方式：
```
    public class SampleDbContext : DbContext
    {
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<GuidEntity>(b =>
            {
                b.Property(e => e.Id).HasValueGenerator<SequentialGuidValueGenerator>();
            });
        }
    }

```
**但是请注意，这两个ORM的解决方案只针对Sql Server数据库，因为只保证了最后几位字节是按顺序来生成的。**
### SequentialGuid框架
<a href="https://github.com/jhtodd/SequentialGuid/" target="_blank">SequentialGuid</a>框架也是我要推荐给您，因为它提供了常见数据库生成有序Guid的解决方案。
关于该框架的设计思路以及针对各个数据库的性能测试，见链接：<a href="https://www.codeproject.com/Articles/388157/GUIDs-as-fast-primary-keys-under-multiple-database" target="_blank">https://www.codeproject.com/Articles/388157/GUIDs-as-fast-primary-keys-under-multiple-database</a>。
使用方式，建议您参考ABP框架，在ABP中使用SequentialGuid框架来生成有序GUID，关键代码链接：<a href="https://github.com/aspnetboilerplate/aspnetboilerplate/blob/b36855f0c238c3592203f058c641862844a0614e/src/Abp/SequentialGuidGenerator.cs#L36-L51" target="_blank">https://github.com/aspnetboilerplate/aspnetboilerplate/blob/b36855f0c238c3592203f058c641862844a0614e/src/Abp/SequentialGuidGenerator.cs#L36-L51</a>。
## 总结
我们来解决一下：
<ol>
- 在数据库中最好不要使用随机的GUID，它会影响性能；
- 在SQL Server中提供了`NewSequentialId`函数来生成有序GUID；
- 各个数据库对GUID支持的不一样，而且排序的规则也不一样；
- `UuidCreateSequential`函数存在隐私的问题，不适合集群环境，并且需要重新排序后再提交到数据库；
- 各ORM框架提供了有序GUID的支持，但是其实只是针对Sql Server数据库设计的；
- 推荐您使用SequentialGuid框架，它解决了多数据库以及集群环境的问题。
</ol>
<style>strong { font-size: 16px }</style>