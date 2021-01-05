
郑昀 最后更新于2014/11/11
关键词：定时任务、调度、监控报警、Job、crontab、Java```
```

<hr>本文档适用人员：研发员工```
```
```
&nbsp;```
**没有JobCenter时我们要面对的：**```
&nbsp; 电商业务链条很长，业务逻辑也较为复杂，需要成百上千种定时任务。窝窝的大多数定时任务其实调用的是本地或远端 Java/PHP/Python Web Service。如果没有一个统一的调度和报警，在集群环境下，我们会：```


- 不知道哪一个定时任务执行失败或超时，不见得能第一时间知道——直到最终用户投诉反馈过来；

- 要求每一个定时任务输出统一格式的日志供监控系统解析？
- 对每一位定时任务维护者提出高要求？这不是我们的解题思路。

- 不知道哪一个定时任务没配好瞎跑；

- 比如忘记配成开机自启动；
- 比如曾经线上环境B与环境A并存导致定时任务互相争抢；

- 不知道现在线上跑了多少个定时任务，都是干什么的，负责人都是谁；
- 有些定时任务非常重要，不能单点，但又不能同时起多个 crontab，只能采取 master/slave 模式跑——比如退款处理。

```
&nbsp;```
**什么是JobCenter？**```
&nbsp;&nbsp;**窝窝的定时任务管理和调度平台，一个实用工具，****它是一个由 任务管理、任务调度、任务监控报警以及宿主任务执行（注意不再是 crontab了） 这四部分组成的，分布式多任务协调系统**。```
&nbsp;```
&nbsp; 2012年时，我看到暴风影音的马晨开源了一个 CronHub（时间调度系统）项目（<a href="https://github.com/sharpstill/CronHub" target="_blank">github 地址</a>），也可以看一下<a href="http://wenku.baidu.com/link?url=_Tc9q2duvOE7ZJkFeltWNo4mTiG3AR2qZx77RQ_iBNOGO9Si9GQdhIUmIbazRtYSrlZZx_kzeL90lLLWv7xT2ApDS2RbZ98WHPf7c9OGj2i">百度文库上的PPT</a>。马晨描述的需求与我们相似，他对 CronHub 的功能设计给我们很大启发：```

<table border="1" cellspacing="0" cellpadding="2">
<tbody>
<tr>
<td valign="top">
1 、大量的crontab管理起来好烦人```
任务老是没按时执行，各种原因失败，真让人抓狂。```
2、多台服务器环境下，管理crontab更是烦上加烦，登录每台机器查看crontab结果不是折磨一贯偷懒的程序员吗？```
3、要是能有个自动化管理，可供的GUI界面管理就好了。```
</td>
</tr>
<tr>
<td valign="top">
所以暴风影音做一个“真正通用”，“真正解决日常需求”的时间调度系统。```
</td>
</tr>
</tbody>
</table>
```
&nbsp; 由于前面说过大多数定时任务其实调用的是 Web 接口，所以我们的做法与 CronHub 有所不同，说是定时任务，其实我只是**登记了要调用的远端接口、通讯协议、Crontab 时间格式表达式、执行机器组、超时时间、报警接收人等而已。已经没有 crontab 了，全都是远端 WebService。由 JobCenter 按时通知对端的接口，并接收任务执行者的进度反馈和最终执行结果，这些响应均为 JSON 格式。还可以为同一个定时任务添加多个执行机器，JobCenter 保证通知成功**。```
&nbsp; JobCenter 是2013年初聂兰彬构建的，那个历史时期同时有多个研发内部项目启动，如 <a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution4.html" target="_blank">NotifyServer</a>、<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution2.html" target="_blank">Tracing</a>、Recsys、<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution3.html" target="_blank">ConfigServer</a>。经过几个月的线上试用和功能完善，我们便开始督促各个研发组织把 Java/PHP 定时任务迁移到这个平台里。```
&nbsp;&nbsp;```
&nbsp; JobCenter 目前也纳入在我们的 <a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution5.html" target="_blank">idcenter </a>体系下，这样可以共用一套帐号体系（LDAP），共用一套权限分配体系：```
<img class="decoded" style="display: block; margin-left: auto; margin-right: auto" src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_idcenter1.png" alt="http://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_idcenter1.png">
图1 jobcenter 在 idcenter 的入口
&nbsp; 它的主界面如下：```
<img src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter%e6%96%b0%e7%95%8c%e9%9d%a2.png" alt="jobcenter主界面(bootstrap样式)">```
图2 jobcenter 主界面```
&nbsp;```
**JobCenter的优点：**```
<ol data-front-font-size="14px">
- **管理直观**

- 可以指定定时任务的&nbsp;Worker&nbsp;集群，并指定执行策略，如随机选取一台机器执行，如第一台执行；
- 可以指定通知策略：保证执行成功，只通知一次；
- 可以设置超时警告时间；

<ol data-front-font-size="14px">

- 并可以进一步设置警告接收人（短信和邮件），如下图所示：

- <img class="decoded" src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e6%8a%a5%e8%ad%a6.png" alt="http://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e6%8a%a5%e8%ad%a6.png">

- 任务失败会发邮件给警告接收人；

</ol>
- **调度方便**

- 集中查看所有定时任务的执行总况，如下图所示：

- <img class="decoded" src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e4%bb%bb%e5%8a%a1%e8%b0%83%e5%ba%a6.png" alt="http://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e4%bb%bb%e5%8a%a1%e8%b0%83%e5%ba%a6.png">
- 可以在“定时任务调度”界面上，暂停定时任务，或者立即执行定时任务；


- **观察方便**

- 按定时任务查看它的上次执行时间、耗时、是否超时、执行结果和通知结果。如下图所示：

- <img class="decoded" src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_job-%e6%89%a7%e8%a1%8c%e6%83%85%e5%86%b5.png" alt="http://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_job-%e6%89%a7%e8%a1%8c%e6%83%85%e5%86%b5.png">

- 按定时任务查看它的执行趋势图，能直观地反映每一次执行是否成功、耗时、是否超时，如下图所示：

- 可以用鼠标在图表上拖动放大时间轴；
- 黄色叹号图标代表超时了，红色叉图代表执行失败，红色横线图标代表任务未执行；
- <img class="decoded" src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_job-%e6%89%a7%e8%a1%8c%e6%80%a7%e8%83%bd%e8%b6%8b%e5%8a%bf.png" alt="http://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_job-%e6%89%a7%e8%a1%8c%e6%80%a7%e8%83%bd%e8%b6%8b%e5%8a%bf.png">


</ol>
&nbsp;
&nbsp;&nbsp;总之，它借鉴了 CronHub 的界面设计和菜单，这是一款大幅提升实施和管理效率、方便易用的中间件。
&nbsp;
**JobCenter 的工作原理**
&nbsp; 下图是聂兰彬当年绘制的架构示意图，后续虽然结构有所调整，但下图还是能说明问题的：
<img class="decoded" src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e5%8e%9f%e7%90%86.png" alt="http://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e5%8e%9f%e7%90%86.png">
图3 jobcenter 示意图
&nbsp; 它如何调度宿主执行定时任务呢？如下图所示：
<img class="decoded" src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e6%b3%b3%e9%81%93%e5%9b%be.png" alt="http://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_jobcenter-%e6%b3%b3%e9%81%93%e5%9b%be.png">
图4 jobcenter 任务执行的泳道图
&nbsp;
**JobCenter 的通知保证机制：**
&nbsp;&nbsp;通知保证机制有以下3种：


- 只通知一次
- 保证成功
- 保证成功（任务不在执行中）

&nbsp; 特别对&nbsp;“保证成功(任务不在执行中)”&nbsp;作以下说明：
&nbsp; 当一个任务到了这一轮的通知时间，jobcenter 会去检查这个任务之前的执行，是否还在执行中（如正在执行，客户端未返回）。如果有，则本次执行直接失败，不通知。
&nbsp;
**窝窝的其他解决方案介绍列表：**
<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution1.html">#研发解决方案介绍#Recsys-Evaluate（推荐评测）</a>&nbsp;<br>
<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution2.html">#研发解决方案介绍#Tracing（鹰眼）</a><br>
<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution3.html">#研发解决方案介绍#基于持久化配置中心的业务降级</a>
<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution4.html">#研发中间件介绍#异步消息可靠推送Notify</a>
<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution5.html">#研发解决方案介绍#IdCenter（内部统一认证系统）</a>
<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution6.html">#研发解决方案介绍#基于ES的搜索+筛选+排序解决方案</a>
<a href="http://www.cnblogs.com/zhengyun_ustc/p/55solution7.html">#数据技术选型#即席查询Shib+Presto，集群任务调度HUE+Oozie</a>
-over-
&nbsp;
欢迎订阅我的微信订阅号『老兵笔记』，请扫描二维码关注：```
&nbsp;
<img src="https://images.cnblogs.com/cnblogs_com/zhengyun_ustc/255879/o_qrcode_for_gh_4ac648907321_344.jpg" alt="老兵笔记订阅号二维码">```
&nbsp;






```






```