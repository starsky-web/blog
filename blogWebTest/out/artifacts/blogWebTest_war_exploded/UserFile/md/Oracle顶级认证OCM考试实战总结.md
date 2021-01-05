OCM是Oracle认证体系中最顶级的证书和技能考试，通过后将成为企业内的资深专家，IT认证考试资源网应广大考生的要求制作了一个OCM考试实战总结，就是为了广大Oracle考生了解神秘的OCM考试流程和大致考点内容，以期更好地有针对性的学习相关知识准备考试，OCM考试一共有9个section，具体的安排如下：
<table border="1" cellspacing="0" cellpadding="4">
<tbody>
<tr><th>OCM考试第一天</th><th>OCM考试第二天</th></tr>
<tr valign="top">
<td bgcolor="#ffffff">section 0:创建一个数据库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45分钟<br>section 1:数据库和网络配置&nbsp;&nbsp;&nbsp; 120分钟<br>section 2:Gridcontrol安装配置 120分钟<br>section 3:数据库备份恢复&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60分钟<br>section 4:数据仓库管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90分钟</td>
<td bgcolor="#ffffff">section 5:数据库管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 120分钟<br>section 6:数据库性能管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 120分钟<br>section 7:部署Oracle RAC数据库&nbsp;&nbsp; 105分钟<br>sectoin 8:部署dataguard数据库 60分钟</td>

</tr>

</tbody>

</table>
# <a name="t0"></a>OCM考试内容
#15分钟熟悉考前环境，根据ITExamPrep.com的统计各个考场考试机器配置不同，据了解上海的考场的机器配置很差，1G内存 1CPU的机器，心态放好！
## <a name="t1"></a>一、手动建库
如果自己打命令创建数据库的话时间会很紧张,我采用的方法是：
1. 设置环境变量ORACLE_SID<br>参照考题中需要创建的数据库SID，设置操作系统环境变量，假设要求创建的数据库的SID是TEST。
2. 手工创建如下目录：<br>$ORACLE_BASE/admin/test/cdump<br>$ORACLE_BASE/admin/test/bdump<br>$ORACLE_BASE/admin/test/udump<br>$ORACLE_BASE/admin/test/adump<br>$ORACLE_BASE/oradata/test
3. 创建最简单的initTEST.ora文件<br>在$ORALCE_HOME/dbs下可以找到一份已经存在的init.ora文件，这是一份样本（在正式考试的机器上你也可以找到）。ITExamPrep.com的易证宝老师提醒考生可能最开先打开这份文件可以看到很多被注释的行，让人烦躁，一行一行地修改这个文件比较耗时，使用下面的命令，把所有以#开头和所有的空行全部过滤掉，同时生成最简单的 initTEST.ora初始化参数文件。
$> cat init.ora | grep -v ^# | grep -v ^$ > initSID.ora
然后修改该文件的db_name参数和control_files参数（控制文件放在哪里，需要多少份控制文件，在考题中会清楚地提出要求），其它的参数保持原状不需要修改。<br>db_name=TEST<br>control_files=("/oracle/oradata/TEST/controlfile01.dbf")<br>sga_max_size=280M<br>sga_target=280M
note:删除其他内存参数
4. 启动数据库到nomount状态<br>此时已经有可供启动的初始化参数文件了，将数据库启动到nomount状态。
SQL> startup nomount;
5. 创建spfile<br>实例启动以后立刻创建spfile，然后重启一次数据库，让数据库能够使用到spfile。
6. 修改其它必须的初始化参数<br>ITExamPrep.com的易证宝老师提醒考生为什么需要先快速地将实例启动到nomount状态？因为我们需要使用show parameter命令，在记不清楚那些初始化参数具体怎么敲的时候，show parameter命令能够来帮助我们快速定位其它必须要修改的初始化参数名字的写法。因为用到了spfile，所以此处我们已经可以使用alter system命令来修改初始化参数了。
db_block_size=8192<br>background_dump_dest=/oracle/product/RAC10G/admin/test01/bdump<br>core_dump_dest=/oracle/product/RAC10G/admin/test01/cdump<br>user_dump_dest=/oracle/product/RAC10G/admin/test01/udump<br>audit_file_dest=/oracle/product/RAC10G/admin/test01/udump<br>db_create_file_dest = 考题中要求你创建数据文件时存放的目录<br>db_create_online_log_dest_1 = 考题中要求你创建联机重做日志文件时存放的目录<br>undo_management=auto<br>undo_tablespace=undotbs1<br>#创建em时需要job_queue_processes>1<br>job_queue_processes=5
IT认证考试资源网的老师提醒考生不要一条命令一条命令在SQL*Plus里面敲，用vi或者Text Editor将所有的alter system命令都编辑好，然后一次执行。<br>执行完毕以后，关闭实例，再重新启动到nomount状态，让刚才修改的初始化参数生效。
7. 创建密码文件<br>用orapwd程序创建orapwTEST密码文件，如果记不清楚orapwd程序怎么用，直接敲orapwd然后回车，会告诉你语法是怎样的。
orapwd&nbsp;&nbsp; file=$ORACLE_HOME/dbs/orapwSID password=oracle entries=5
8. 创建数据库<br>要快速找到例句，如果你去查SQL Reference文档中的create database的语法，时间肯定是比较紧张的，<br>我们要查的是Administrator’s Guide这本文档中第二章 Creating an Oracle Database -> Creating the database ->&nbsp;<br>Step 7: Issue the CREATE DATABASE Statement，这里有完整的一条SQL语句，copy出来，然后按照考试要求去编辑相应的地方，<br>然后执行，这样出来的命令基本上不会出现问题。
注意数据文件分布到disk1~disk5
CREATE DATABASE TEST<br>USER SYS IDENTIFIED BY oracle<br>USER SYSTEM IDENTIFIED BY oracle<br>LOGFILE GROUP 1 ('/oracle/oradata/test/redo01.log') SIZE 10M,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GROUP 2 ('/oracle/oradata/test/redo02.log') SIZE 10M,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GROUP 3 ('/oracle/oradata/test/redo03.log') SIZE 10M<br>MAXLOGFILES 30<br>MAXLOGMEMBERS 5<br>MAXLOGHISTORY 1<br>MAXDATAFILES 200<br>MAXINSTANCES 2<br>CHARACTER SET ZHS16GBK<br>NATIONAL CHARACTER SET AL16UTF16<br>DATAFILE '/oracle/oradata/test/system01.dbf' SIZE 325M REUSE EXTENT MANAGEMENT LOCAL<br>SYSAUX DATAFILE '/oracle/oradata/test/sysaux01.dbf' SIZE 325M REUSE<br>DEFAULT TEMPORARY TABLESPACE tempts1 TEMPFILE '/oracle/oradata/test/temp01.dbf' SIZE 20M REUSE<br>UNDO TABLESPACE undotbs1&nbsp;&nbsp; DATAFILE '/oracle/oradata/test/undotbs01.dbf'&nbsp;<br>SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
#创建缺省表空间<br>CREATE SMALLFILE TABLESPACE "USERS" LOGGING DATAFILE '/oracle/oradata/test1/users01.dbf'&nbsp;<br>SIZE 5M REUSE AUTOEXTEND ON NEXT&nbsp;&nbsp; 1280K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT&nbsp;&nbsp; AUTO<br><br>ALTER DATABASE DEFAULT TABLESPACE "USERS";
NOTE:修改MAXLOGFILES,undo,default
9. 运行catalog.sql 和 catproc.sql<br>只需要运行这两个SQL，都在$ORACLE_HOME/rdbms/admin中，创建必须的数据字典和内置的package等
optional:<br>connect /as sysdba<br>@?/rdbms/admin/catblock.sql<br>@?/rdbms/admin/catoctk.sql<br>@?/rdbms/admin/owminst.plb
connect system/oracle<br>@?/sqlplus/admin/pupbld.sql<br>@?/sqlplus/admin/help/hlpbld.sql helpus.sql
Note :section0中没有要求你运行catalog ，catproc脚本，但是如果时间有多我建议在section 0中就运行这2个脚本为下一个section节省时间.
## <a name="t2"></a>二、配置数据库和网络
1. 修改数据库几个参数
2. 按照要求创建几个表空间
3. 网络配置
创建监听
ITExamPrep.com的易证宝老师提醒考生考试可能会要求你创建非默认端口（1521）的监听，并且要求实例自动注册到这个监听上，<br>那么这时候需要配置listener.ora和 tnsnames.ora,并且修改local_listener参数
MTS配置
## <a name="t3"></a>三、gridcontrol
#安装
每个人面前会有两台机器，一台称为奇数机（ODD），一台称为偶数机（EVEN），注意，考题上也会这样表述的，要你在ODD机器上做什么或者在 EVEN 机器上做什么，偶数还是奇数是依靠机器的hostname最后一位或者两位数字来定的，通常会要求你在奇数机上创建数据库，在偶数机上安装Grid Control的OMS。
偶数机上是没有Oracle软件的，因此OMS需要的Repository这个数据库也需要创建在奇数机上，再加上之后第二天会要求创建的Standby实例，总共会有三个实例运行在奇数机上，上海机器的内存是1G，所以一定要预先考虑好分配给每个实例的内存。
为什么上午就要求配置监听？因为下午的考试中OMS需要通过监听来访问创建的数据库，总之，ITExamPrep.com的易证宝老师提醒考生OCM考试中基本上都是这样环环相扣的，其中某一步做慢了或者没完成就很可能影响接下来的考试。
Grid Control的安装软件会预先放置在偶数机的某个目录下，考题里面会告诉你的。但是，不要着急安装，为了一次就安装成功我们需要预先做一些工作。再次强调一下，安装OMS我们基本上只有一次的机会，因为大部分的错误都会是在等待了一个漫长的Configuration过程之后再报出来，而这时候通常已经没有剩余的时间让你去找到问题发生的原因，然后清理已经安装了残迹再重新安装OMS了。
1. Use DBCA<br>按照要求，通常会创建一个新数据库在奇数机上（不同于上午的Section中要求创建的SID），用于存储OMS需要的Repository信息，下午的时候应该是已经可以使用图形界面了，所以我们可以用dbca来创建这个数据库。
2. Check Pacakage<br>数据库创建完毕以后，也许仍然你习惯用手动的方法创建，所以请检查数据库里面有没有dbms_shared_pool这个package，如果没有，运行$ORACLE_HOME/rdbms/admin/dbmspool.sql来创建这个package，因为安装OMS时候某些自动的检查需要调用这个包，没有的话将会报错。
3. Implement SSH<br>快速地建立两台机器之间的ssh信任关系，如果还不会的，请务必去网上查资料并且牢记每一步操作。这里有个小陷阱，默认情况下，两台机器上的oracle 用户的home目录权限是0777，也就是完全的可读些权限，但是在这种情况下，建立oracle用户的ssh信任关系，即使你完全配正确了，也同样无法正常地不输入密码就登陆到另外一台机器上。据说很多人折在这里，怎么也配不通两机的信任关系，那时候焦躁的心情应该可想而之了。需要做的是将oracle用户的home目录权限改为0755。
这步是可选的有些兄弟没配置也能安装成功的
4. Transfer X Window<br>尽量在一台机器上操作，不要在两台机器面前一会儿敲敲这个的键盘，一会儿动动那个的鼠标。字符界面的话，用terminal ssh过去就可以了，图形界面呢？不需要费劲地去检查vnc server有没有启动，启动在哪个端口了什么的，直接用ssh -X hostname这样的方式，就可以将远程的X界面显示在本机上。
5. Follow the Error Messege<br>安装OMS，对于Repository库是有一些初始化参数的要求的，比如java池该多大，shared pool该多大，job queue该多大，但是不要去阅读安装文档，那个浪费时间。我们需要做的就是设置SGA_TARGET = 300M，这样内存参数就自动管理了，安装OMS不会报任何错误，另外对于job queue等其它的参数，在点击开始安装之后的某个界面，会弹出一个警告框，告诉你哪些参数不符合要求，需要改为多少多少，OK，安装这个界面里的要求，依次修改数据库的参数，然后重新启动数据库，不需要退出安装界面，在重启完数据库之后，点确定，直接继续安装就可以了。
6. Be Patient<br>要有耐心，OMS安装的时候，在Configuration那一步时会非常慢，千万不要等不及了就准备关掉重来，时刻监控安装的log文件（log文件的位置在安装界面上应该可以找到），只要不停地有输出，你就可以安心地等待。
7. Install Agent<br>OMS安装完毕，也启动成功了。还需要在奇数机上安装Grid Control的Agent，有好多种方法可以安装，但是我们需要选择最简单最快速的方法，那就是使用agentDownload.linux程序，将这个程序从偶数机的OMS安装目录中copy到奇数机的某个目录下，随便哪个目录都行。然后运行下面的命令：<br>./agentDownload.linux -b /u01/app/oracle/product<br>最后一个参数是我们希望将agent安装到的BASE目录。<br>用这种方法安装Agent的速度很快，而且无需任何人工参与。
8. Learning GUI<br>OMS也启动了，Agent也启动了，通过浏览器去检查一下Grid Control的管理界面是不是好用吧，到这里，基本上就没什么问题了，下面会是一些要求你通过Grid Control来创建一些表空间或者一些用户或者一些什么别的操作，按照要求来就好。不过，对于命令行死忠派来说，还是预先去熟悉一下图形界面的操作吧，否则到时候找个按钮都要找半天。
9. Lucky<br>这次考试中有个兄弟特别背，考着考着鼠标就动不了了。。考着考着数据库就自己down了。。所以运气也是很重要的
#配置
新建一个管理员用户<br>配置email通知<br>创建schedule,program,windows,job
## <a name="t4"></a>三、数据库备份恢复
丢失一个controlfile的恢复
1. 创建catalog 数据库
2. rman 备份
1.set rman env
rman target sys/oracle catalog&nbsp;<a href="mailto:rman/rman@test1" rel="nofollow" target="_blank">rman/rman@test1</a>
RMAN>CONFIGURE DEFAULT DEVICE TYPE TO DISK;<br>RMAN>CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/oracle/oradata/orcl/backup/DB_%U';<br>RMAN>CONFIGURE CONTROLFILE AUTOBACKUP ON;<br>RMAN>CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/oracle/oradata/orcl/backup/cf_%F';&nbsp;<br>RMAN>CONFIGURE BACKUP OPTIMIZATION ON<br>Optimization does not back up a file to a device type if the identical file is already backed up on the device type.<br>For two files to be identical, their content must be exactly the same.
要求设置compress备份,具体命令有点忘记了。。可以查一下联机帮助
2.RMAN Online Full Database Backup
#scripts:bck_db_level0.rcv
run {<br>BACKUP INCREMENTAL LEVEL 0 DATABASE;<br>BACKUP&nbsp;&nbsp; ARCHIVELOG ALL DELETE ALL INPUT;<br>}
#run rman backup<br>rman target&nbsp;<a href="mailto:sys/oracle@orcl" rel="nofollow" target="_blank">sys/oracle@orcl</a>&nbsp;catalog&nbsp;<a href="mailto:rman/rman@test1" rel="nofollow" target="_blank">rman/rman@test1</a>&nbsp;@bck_db_level0.rcv log bck_db_level0.log
recovery<br>datafile 1丢失的恢复
3. 配置flashback 数据库
## <a name="t5"></a>四、数据仓库
select distinct a,b from t1;
要求创建一个能够快速刷新的物化视图
创建一个可刷新的物化视图
外部表会考datapump方式的导出和导入，Oracle_loader的外部表也会考
## <a name="t6"></a>五、数据库管理
exp,imp
transport tablespace
创建分区表
创建分区索引 global hash 和local
truncate partition
创建带clob字段的表
使用FGA对一张表做审计（可以参考联机帮助）
flashback table to before drop&nbsp;&nbsp; rename to xxx; (注意要flashback到包含某个字段的，show recyclebin)<br>考试内容和考纲比较吻合
## <a name="t7"></a>六、性能管理
创建IOT表<br>创建bitmap Index ，function index<br>统计信息收集<br>表空间使用ASSM 以减少buffer busy wait
statspack安装<br>使用level 7产生snap<br>创建一个Job 每5分钟运行一次<br>按照指定路径生成report文件
outline也考了。。
## <a name="t8"></a>七、RAC
安装crs、asm和db软件<br>创建 rac db<br>添加service<br>启用archive&nbsp;<br>时间应该足够，剩下的时间，我是用来将下一节中手工创建dataguard需要用到的sql和参数修改都事先编辑好
## <a name="t9"></a>八、datagurad
1.在奇数机器上创建physical standby<br>2.添加standby logfile ，使用lgwr async方式<br>3.切换到standby ，运行一个脚本，然后在切换回，运行一个脚本<br>4.read only打开standby