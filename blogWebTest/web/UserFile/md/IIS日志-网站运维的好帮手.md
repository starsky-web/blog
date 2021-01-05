对于一个需要长期维护的网站来说，如何让网站长久稳定运行是件很有意义的事情。
有些在开发阶段没有暴露的问题很有可能就在运维阶段出现了，这也是很正常的。
还有些时候，我们希望不断地优化网站，让网站更快速的响应用户请求，
这些事情都发生在开发之后的运维阶段。



与开发阶段不同的，运维阶段不可能让你去调试程序，发现各类问题，
我们只能通过各种系统日志来分析网站的运行状况，
对于部署在IIS上的网站来说，IIS日志提供了最有价值的信息，我们可以通过它来分析网站的响应情况，来判断网站是否有性能问题，
或者存在哪些需要改进的地方。




# IIS日志包含了哪些信息

我前面说到【IIS日志提供了最有价值的信息】，这些信息有哪些呢？看看这个截图吧：

<img src="https://images0.cnblogs.com/blog/281816/201306/16130849-84f48a7ca1b246cdb834e9d7ed8f95fd.png" alt="">

这里面记录了：<br>
1. 请求发生在什么时刻，<br>
2. 哪个客户端IP访问了服务端IP的哪个端口，<br>
3. 客户端工具是什么类型，什么版本，<br>
4. 请求的URL以及查询字符串参数是什么，<br>
5. 请求的方式是GET还是POST，<br>
6. 请求的处理结果是什么样的：HTTP状态码，以及操作系统底层的状态码，<br>
7. 请求过程中，客户端上传了多少数据，服务端发送了多少数据，<br>
8. 请求总共占用服务器多长时间、等等。



这些信息在分析时有什么用途，我后面再说。先对它有个印象就可以了。










# IIS日志的配置


默认情况下，IIS会产生日志文件，不过，还是有些参数值得我们关注。
IIS的设置界面如下（本文以 IIS 8 的界面为例）。

在IIS管理器中，选择某个网站，双击【日志】图标，请参考下图：

<img src="https://images0.cnblogs.com/blog/281816/201306/16130925-33ff6033ff904539ade7dc0c27aa11da.png" alt="">

此时（主要部分）界面如下：

<img src="https://images0.cnblogs.com/blog/281816/201306/16130945-d176d56f060d4822937c7eaa823ea141.png" alt="">

在截图中，日志的创建方式是每天产生一个新文件，按日期来生成文件名（这是默认值）。<br>
说明：IIS使用UTC时间，所以我勾选了最下面的复选框，告诉IIS用本地时间来生成文件名。


点击【选择字段】按钮，将出现以下对话框：


<img src="https://images0.cnblogs.com/blog/281816/201306/16131005-b9dcf2010a6a46a9912e66ec87f30b80.png" alt="">

<b class="redText">注意：</b>【发送的字段数】和【接收的字节数】默认是没有选择的。<b class="redText">建议勾选它们。</b><br>
至于其它字段，你可以根据需要来决定是否要勾选它们。










# 如何分析IIS日志

如果你按照我前面介绍的方法设置了IIS日志参数，那么IIS在处理请求后（的一段时间之后），会生成IIS日志。<br>
我们可以在【日志界面】的右边区域【操作】中点击【查看日志文件】快速定位到IIS日志的根目录，
然后到目录中寻找相应的日志文件（默认会根据应用程序池序号来区分目录）。


比如：我找到了我需要的日志：

<img src="https://images0.cnblogs.com/blog/281816/201306/16130849-84f48a7ca1b246cdb834e9d7ed8f95fd.png" alt="">

这个文件一大堆密密麻麻的字符，现在我该如何分析它呢？


有个叫 <a href="http://www.microsoft.com/en-us/download/details.aspx?id=24659" target="_blank"><b>Log Parser</b></a> 的工具就可以专门解析IIS日志，我们可以用它来查看日志中的信息。<br>
比如我可以运行下面的命令行（说明：为了不影响页面宽度我将命令文本换行了）：


```console">"C:\Program Files\Log Parser 2.2\LogParser.exe" -i:IISW3C -o:DATAGRID 
"SELECT c-ip,cs-method,s-port,cs-uri-stem,sc-status,sc-win32-status,
sc-bytes,cs-bytes,time-taken FROM u_ex130615.log"


现在就可以以表格形式来阅读IIS日志了：





<br>

说明：<b class="redText">我不推荐用这种方法来分析IIS日志</b>，原因有二点：<br>
1. 慢：当日志文件稍大一点的时候，用它来分析就比较浪费时间了（尤其是需要多次统计时）。<br>
2. 不方便：它支持的查询语法不够丰富，没有像SQL Server针对数据表查询那样全面。











# 推荐的IIS日志分析方法

虽然Log Parser支持将解析的IIS日志以表格形式供人阅读，但是有时候我们需要再做一些细致分析时，可能会按不同的方式进行【多次】查询，
对于这种需求，如果每次查询都直接运行Log Parser，你会浪费很多时间。
幸运的是，Log Parser支持将解析结果以多种格式导出（以下为帮助文档截图）：




在此，我建议选择输出格式为 SQL 。<br>
注意：这里的SQL并不是指SQLSERVER，而是指所有提供ODBC访问接口的数据库。<br>
我可以使用下面的命令将IIS日志导入到SQLSERVER中（说明：为了不影响页面宽度我将命令文本换行了）：



​```console">"C:\Program Files\Log Parser 2.2\logparser.exe"  
"SELECT  *  FROM  'D:\Temp\u_ex130615.log'  to MyMVC_WebLog" -i:IISW3C -o:SQL 
-oConnString:"Driver={SQL Server};server=localhost\sqlexpress;database=MyTestDb;Integrated Security=SSPI" 
-createtable:ON



导入完成后，我们就可以用熟悉的SQLSERVER来做各种查询和统计分析了，例如下面的查询：

​```code">SELECT cip,csmethod,sport,csuristem,scstatus,scwin32status,scbytes,csbytes,timetaken 
FROM dbo.MyMVC_WebLog



如果如下：<br>



注意：<br>
1. IIS日志在将结果导出到SQLSERVER时，字段名中不符合标识符规范的字符将会删除。<br>
&nbsp;&nbsp;&nbsp;例如：c-ip 会变成 cip， s-port 会变成 sport 。<br>
2. IIS日志中记录的时间是UTC时间，而且把日期和时间分开了，导出到SQLSERVER时，会生成二个字段：<br>
&nbsp;&nbsp;&nbsp;<img src="https://images0.cnblogs.com/blog/281816/201306/16131147-cfc210490f39436a8fc6dc61175bccb9.png" alt="">


date, time这二个字段看起来很不舒服，对吧？<br>
我也很反感这个结果，下面来说说的二种解决方法：


1. 在SQLSERVER中增加一列，然后把UTC时间换成本地时区的时间，T-SQL脚本如下：

​```code">alter table MyMVC_WebLog add RequestTime datetime
go
update MyMVC_WebLog set RequestTime=dateadd(hh,8,convert(varchar(10),date,120) 
            + ' ' + convert(varchar(13),time,114))


2. 直接在导出IIS日志时，把时间转换过来，此时要修改命令：


​```console">"C:\Program Files\Log Parser 2.2\logparser.exe"  
"SELECT TO_LOCALTIME(TO_TIMESTAMP(ADD(TO_STRING(date, 'yyyy-MM-dd '), TO_STRING(time, 'hh:mm:ss')), 
'yyyy-MM-dd hh:mm:ss')) AS RequestTime, *  FROM  'D:\Temp\u_ex130615.log'  to  MyMVC_WebLog2" 
-i:IISW3C -o:SQL 
-oConnString:"Driver={SQL Server};server=localhost\sqlexpress;database=MyTestDb;Integrated Security=SSPI"
-createtable:ON


再看这三列：

​```code">select RequestTime, date, time from MyMVC_WebLog2


<img src="https://images0.cnblogs.com/blog/281816/201306/16131212-2e8991071e8c425b9c6ee41319f06de7.png" alt="">

这样处理后，你就可以直接把date, time这二列删除了（你也可以在导出IIS日志时忽略它们，但要明确指出每个字段名）。


IIS日志中的UTC时间问题就说到这里，但愿每个人都懂了~~~~~~~~~~~






# IIS日志中的异常记录

IIS日志中记录了每个请求的信息，包括正常的响应请求和有异常的请求。


这里所说的【异常】与 .net framework 中的异常没有关系。<br>
对于一个ASP.NET程序来说，如果抛出一个未捕获异常，会记录到IIS日志中（500），但我所说的异常不仅限于此。


本文所说的异常可分为四个部分：<br>
1. （ASP.NET）程序抛出的未捕获异常，导致服务器产生500的响应输出。<br>
2. 404之类的请求资源不存在错误。<br>
3. 大于500的服务器错误，例如：502，503<br>
4. 系统错误或网络传输错误。



前三类异常可以用下面的查询获得：


​```code">select scStatus, count(*) AS count, sum(timetaken * 1.0) /1000.0 AS sum_timetaken_second
from MyMVC_WebLog with(nolock)
group by scStatus
order by 3 desc







<br>IIS日志中有一列：sc-win32-status ，它记录了在处理请求过程中，发生的系统级别错误，例如网络传输错误。<br>
正常情况下，0 表示正常，出现非零值意味着出现了错误。我们可以这样统计这类错误：


​```code">declare @recCount bigint;
select @recCount = count(*) from MyMVC_WebLog with(nolock)
select scWin32Status, count(*) AS count, (count(*) * 100.0 / @recCount) AS [percent] 
from MyMVC_WebLog with(nolock)
where scWin32Status > 0
group by scWin32Status
order by 2 desc



<img src="https://images0.cnblogs.com/blog/281816/201306/16131243-362d2f4ac86d494c8e0ee76be39ee98d.png" alt="">

<br>下表列出了比较常见的与网络相关的错误及解释：


<table class="MyTable"><thead>
<tr><td style="width: 160px">scWin32Status</td><td style="width: 240px">含义</td></tr></thead><tbody>
<tr><td>64</td><td>客户端连接已关闭（或者断开）</td></tr>
<tr><td>121</td><td>传输超时</td></tr>
<tr><td>1236</td><td>本地网络中断</td></tr></tbody>
</table>
<br>所有状态码都可以通过下面的命令来获取对应的解释：


​```console">D:\Temp>net helpmsg 64

指定的网络名不再可用。




<br>关于scwin32status与scStatus，我还想补充说明一下：它们没有关联。<br>
比如请求这个地址：http://www.abc.com/test.aspx<br>
有可能scStatus=200，但scwin32status=64，此时表示ASP.NET已成功处理请求，但是IIS在发送响应结果时，客户端的连接断开了。<br>
另一种情况是：scStatus=500，但scwin32status=0，此时表示，在处理请求过程中发生了未捕获异常，但异常结果成功发送给客户端。









# 再谈 scwin32status=64

记得以前看到 scStatus=200，scwin32status=64 这种情况时很不理解，于是搜索了互联网，各种答案都有，有的甚至说与网络爬虫有关。
为了验证各种答案，我做了一个试验。我写一个ashx文件，用它来模拟长时间的网络传输，代码如下：



​```code">public class Test_IIS_time_taken : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        System.Threading.Thread.Sleep(1000 * 2);
        
        context.Response.Write(string.Format("{0}, {1}\r\n", "Start", DateTime.Now));
        context.Response.Flush();
        
        System.Threading.Thread.Sleep(1000 * 2);

        for( int i = 0; i < 20; i++ ) {
            context.Response.Write(string.Format("{0}, {1}\r\n", i, DateTime.Now));
            context.Response.Flush();
            System.Threading.Thread.Sleep(1000 * 1);
        }

        context.Response.Write("End");
    }


这段代码很简单，我不想做过多的解释，只想说一句：我用Thread.Sleep与Response.Flush这二个方法来模拟一个长时间的持续发送过程。


我们可以在浏览器中看到这样的输出（显示还没有完全结束时我截图了）<br>



我把这个测试做了8次，只有2次是全部显示完成了，其余6次我提前关闭了浏览器窗口。<br>
然后，我们再来看IIS日志的内容：<br>



根据IIS日志并结合我自己的操作可以发现：<br>
1. 当我提前关闭浏览器窗口时，就会看到scStatus=200，scwin32status=64<br>
2. 如果请求内容全部显示完成，我就会看到scStatus=200，scwin32status=0<br>
从这个试验我们还可以发现：timeTaken 包含了网络传输时间。





<br>根据这个试验的结果，你是否想过一个问题：<br>如果你的网站的IIS日志中出现了大量的scStatus=200，scwin32status=64，
而且请求是由用户的浏览器发起的。<br>
这是什么原因造成的呢？<br>
我的【猜想】是：用户在访问这个网站时已经不愿意再等待了，他们把浏览器窗口关掉了。<br>
换句话说：可以从scwin32status=64的统计结果看出网站的响应速度是否能让用户满意。








# 寻找性能问题


IIS日志中有一列叫：timeTaken，在IIS的界面中显示了它的含义：所有时间。<br>
这个所用时间的定义是：<b class="redText">从服务端收到请求的第一个字节开始起，直到把所有响应内容发送出去为止的时间。</b><br>
微软的网站有对这个字段做过说明：http://support.microsoft.com/kb/944884



知道了timeTaken的定义后，我们就可以利用它来分析一些请求的处理时间，即性能分析。


例如，我想查看最慢的20个页面的加载情况，可以这样查询：



​```code">select top 20 csuristem,scstatus,scwin32status,scbytes,csbytes,timetaken
from dbo.MyMVC_WebLog with(nolock)
where csUriStem like '/Pages/%'
order by timeTaken desc



再或者我想再看看最慢的20个AJAX情况的响应情况，可以这样查询：


​```code">select top 20 csuristem,scstatus,scwin32status,scbytes,csbytes,timetaken
from dbo.MyMVC_WebLog with(nolock)
where csUriStem like '/ajax/%'
order by timeTaken desc




总之，寻找性能问题的方法就是：在查询选择timeTaken字段，并且用它做降序排序。

注意：<b class="redText">scbytes,csbytes 这二个字段也是值得我们关注的：</b><br>
1. csbytes如果过大，我们就要分析一下到底是不是因为表单包含了过多的无用数据，可否将表单拆分。<br>
&nbsp;&nbsp;&nbsp;csbytes变大还有一种可能：Cookie太大，但它会表现为很多请求的csbytes都偏大，因此容易区分。<br>
2. scbytes如果过大，我们就要检查页面是否没有分页，或者可以考虑用按需加载的方式来实现。<br>
典型的情况是：当大量使用ViewState时，这二个值都会变大。因此我们能通过IIS日志发现ViewState的滥用问题。<br>
还有一种特殊情况是：上传下载文件也会导致这二个数值变大，原因我就不解释了。


scbytes,csbytes，不管是哪个数值很大，都会占用网络传输时间，对于用户来说，就需要更长的等待时间。




一下子说了三个字段，在寻找性能问题时，到底该参考哪个呢？<br>
我认为：应该优先关注timeTaken，因为它的数值直接反映了用户的等待时间（不包括前端渲染时间）。<br>
如果timeTaken过大时，有必要检查scbytes,csbytes是否也过大，<br>
如果后二者也过大，那么优化的方向就是减少数据传输量，否则表示是程序处理占用了大量的时间，应该考虑优化程序代码。















# 寻找可改进的目标


除了可以从IIS日志中发现性能问题，还可以用它来寻找可改进的目标。<br>
例如：<br>
1. 有没有404错误？<br>
2. 是否存在大量的304请求？<br>
3. 是否存在大量重复请求？


<br>当发现有404响应时，我们应该分析产生404的原因：<br>
1. 是用户输入错误的URL地址吗？<br>
2. 还是开发人员引用不存在的资源文件？<br>
如果是后者，就应该尽快移除无效的引用，因为404响应也是一个页面响应，而且它们也会占用网络传输时间，
尤其是这类请求不能缓存，它会一直出现，浪费网络资源。


如果你希望在开发阶段就能轻易的发现404错误，可以参考我的博客：<a href="http://www.cnblogs.com/fish-li/archive/2012/11/05/2754516.html" target="_blank">程序在发布前就应该发现的一些错误</a>



<br>如果发现有大量的304请求也应该仔细分析：<br>
1. 是由于ASP.NET缓存响应而产生的304请求吗？<br>
2. 还是请求静态资源文件时产生的304请求？<br>
如果是后者，则有可能与浏览器的设置有关，也有可能与IIS设置有关。



IIS有个【启用内容过期】功能，可用来在输出响应时设置缓存头，减少请求数量。<br>
此功能对静态文件有用，ASP.NET处理的结果则不受影响。<br>
具体设置方法可参考：<a href="http://www.cnblogs.com/fish-li/archive/2012/12/23/2830301.html" target="_blank">不修改代码就能优化ASP.NET网站性能的一些方法</a>



<br>我们可以用这样的查询来分析页面的加载频率：

​```code">select top 20 csUriStem, count(*) AS [count],
    avg(timeTaken) AS avg_timeTaken, max(timeTaken) AS max_timeTaken
from MyMVC_WebLog with(nolock)
where csUriStem like '/Pages/%'
group by csUriStem
order by 2 desc



如果发现有大量的重复请求，也需要再仔细分析：<br>
1. 请求的响应内容是否随着不同的参数而各不相同？<br>
2. 请求的URL是固定的，响应内容也是极少变化的。<br>
如果是后者，则可以考虑使用页面缓存功能。例如：ASP.NET的OutputCache


我的博客<a href="http://www.cnblogs.com/fish-li/archive/2012/12/23/2830301.html" target="_blank">不修改代码就能优化ASP.NET网站性能的一些方法</a>
介绍了一种不用修改代码就能缓存请求的功能，如果需要，可以试试。







# 程序架构对IIS日志分析过程的影响

前面我介绍了一些分析IIS日志的方法，这些方法的使用都离不开查询。
绝大多数时候，我们需要在查询中输出URL信息（cs-uri-stem）并依据它们分组来统计，
因此，<b class="redText">合理的设计URL会给后期的统计带来方便，
也能得到更准确的统计结果。</b>
一个极端的反例是：采用WebForms默认的开发方式，页面加载以及每个按钮的提交都是同一个URL，你会发现很难统计用户的每个操作花了多少时间。


怎样的URL设计才能满足统计需要呢？<br>
我认为：每个用户操作（页面显示或者提交）都应该有一个URL与之对应，且不同的URL能反映不同的操作。<br>
另外还建议：不同的用户操作能在URL中清楚的区分开，这样能方便做更多的统计（例如：页面加载，AJAX请求，报表显示）。




<br>虽然我们可以用timeTaken来做性能统计，然而，当你在程序中大量使用frameset或者iframe时，
你将难以统计某个页面（包含iframe的页面）加载到底花了多长时间。
因为整个页面被分成了多个请求，它们在IIS日志中并不是连续的，你无法准确地按用户请求来统计。
例如：a1.aspx用iframe的方式嵌入了b1.aspx, b2.aspx, b3.aspx，当你统计a1.aspx的加载时间时，
你得到的结果永远和用户感受的情况不一样，因为a1.aspx的timeTaken并不包含b1.aspx, b2.aspx, b3.aspx这三个请求的timeTaken！



因此，如果你希望利用IIS日志来分析程序性能，那么iframe就不要再使用了。












如果，您认为阅读这篇博客让您有些收获，不妨点击一下右下角的<a id="btnRecommendMyBlog">【<b>推荐</b>】</a>按钮。<br>
如果，您希望更容易地发现我的新博客，不妨点击一下右下角的<a id="btnFollowFishLi">【<b>关注 Fish Li</b>】</a>。<br>
因为，我的写作热情也离不开您的肯定支持。

感谢您的阅读，如果您对我的博客所讲述的内容有兴趣，请继续关注我的后续博客，我是Fish Li 。
```