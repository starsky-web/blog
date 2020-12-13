&nbsp;
对于linux运维工作者而言，使用ssh远程远程服务器是再熟悉不过的了！对于ssh的一些严格设置也关系到服务器的安全维护，今天在此，就本人工作中使用ssh的经验而言，做一些总结记录来下。
-bash: ssh: command not found<br>解决办法："yum install －y openssh-server openssh-clinets"
**1.&nbsp; ssh登录时提示：Read from socket failed: Connection reset by peer.**<br>尝试了很多解决方案均无效，无奈！卸载sshd，然后重新安装<br># yum remove openssh*<br># rm -rf /etc/ssh*<br># yum install -y openssh*<br># systemctl start sshd.service
**2.&nbsp; ssh远程登陆后的提示信息**<br>我们经常会使用中控机ssh信任跳转到其他机器上，但是不知道有没有运维朋友注意到ssh跳转成功后的终端显示的提示信息？<br>这些提示信息，是为了方便我们在第一时间知道ssh跳转到哪台目标机上，也是为了避免长期频繁跳转后由于大意造成的误入机器操作的风险，我们通常会在ssh跳转到目标机器后显示一些提示信息，在一些国家, 登入给定系统前, 给出未经授权或者用户监视警告信息, 将会受到法律的保护.如下：<br>[root@bastion-IDC ~]# ssh -p22 192.168.1.15<br>Last login: Fri Jul 15 13:26:53 2016 from 124.65.197.154<br>===================================<br>|||||||||||||||||||||||||||||||||||<br>===================================<br>HOSTNAME: monit-server<br>IPADDRES: 192.168.1.15<br>===================================<br>IDC监控机<br>===================================
那么上面的提醒信息是在哪设置的呢？<br>做法一：其实很简单，这些信息是在目标机器的/etc/motd文件里自定义的<br>[root@monit-server ~]# cat /etc/motd <br>===================================<br>|||||||||||||||||||||||||||||||||||<br>===================================<br>HOSTNAME: monit-server<br>IPADDRES: 192.168.1.15<br>===================================<br>IDC监控机<br>===================================
做法二：在目标机器的/etc/ssh/sshd_config文件里定义，然后重启sshd服务即可。这两种做法是一致的效果！<br>Banner /etc/sshfile
[root@host-192-168-1-117 ~]# cat /etc/sshfile<br>this is 192.168.1.117
远程登陆：<br>[root@linux-node2 ~]# ssh 192.168.1.117<br>this is 192.168.1.117<br>[root@host-192-168-1-117 ~]#
**3.&nbsp; 实现SSH无密码登录:使用ssh-keygen和ssh-copy-id**<br>ssh-keygen 产生公钥与私钥对.<br>ssh-copy-id 将本机的公钥复制到远程机器的authorized_keys文件中，ssh-copy-id也能让你有到远程机器的/home/username/.ssh和~/.ssh/authorized_keys的权利.<br>操作记录：<br>1）第一步:在本地机器上使用ssh-keygen产生公钥私钥对<br>#ssh-keygen -t rsa              //一路默认回车<br>这样就会在当前用户家目录下的.ssh目录里产生公钥和私钥文件：id_rsa.pub、id_rsa。可以将id_rsa.pub公钥文件复制成authorized_keys<br>2）第二步：可以手动将本机的id_rsa.pub公钥文件内容复制到远程目标机的.ssh/authorized_keys文件中，可以就可以实现ssh无密码登陆。<br>当然，也可以在本机直接使用ssh-copy-id将公钥复制到远程机器中<br>#ssh-copy-id -i /root/.ssh/id_rsa.pub user@ip ［把本机的公钥拷贝到远程机器上，比如B机器］<br>也可以不加公钥路径，会默认加上<br>#ssh-copy-id  user@ip <br>注意: <br>ssh-copy-id 将key写到远程机器的 ~/ .ssh/authorized_key.文件（文件会自动创建）中

```brush:bash;gutter:true;">对于非22端口(比如22222)情况下的ssh-copy-id的使用，需要这样用：
# ssh-copy-id -i  /root/.ssh/id_rsa.pub  '-p 22222 root@192.168.18.18'
```
3）这样，本机登录到上面远程机器（B机器）就不用输入密码<br>#ssh user@ip
**4.&nbsp; ssh登录失败,报错：Pseudo-terminal will not be allocated because stdin**<br>现象：<br>需要登录线上的一台目标机器A,但是不能直接登录（没有登录权限），需要先登录B机器，然后从B机器跳转到A机器。<br>脚本如下：<br>localhost:~ root# cat IDC-7.sh<br>#!/bin/bash<br>ssh root@101.201.114.106 "ssh -p25791 root@103.10.86.7"
但是在执行脚本的时候报错如下：<br>Pseudo-terminal will not be allocated because stdin
原因：<br>伪终端将无法分配，因为标准输入不是终端。<br>解决办法：<br>需要增加-t -t参数来强制伪终端分配，即使标准输入不是终端。<br>在脚本里添加－t －t参数即可，如下：<br>localhost:~ root# cat IDC-7.sh<br>#!/bin/bash<br>ssh root@101.201.114.106 "ssh －t －t -p25791 root@103.10.86.7"
或者<br>localhost:~ root# cat IDC-7.sh<br>#!/bin/bash<br>ssh －t root@101.201.114.106 "ssh －t －t -p25791 root@103.10.86.7"
**5.&nbsp; ssh远程登陆缓慢问题**<br>解决办法：<br>编译/etc/ssh/sshd_config配置文件：<br>UseDNS no<br>GSSAPIAuthentication no<br>然后重启sshd服务即可！
**6.&nbsp; ssh登录出现：permission denied（publickey.gssapi-with-mic）**<br>解决方法：<br>修改/etc/ssh/sshd-config文件，将其中的：<br>PermitRootLogin no修改为yes<br>PubkeyAuthentication yes        <br>AuthorizedKeysFile     .ssh/authorized_keys前面加上#屏蔽掉<br>PasswordAuthentication no修改为yes<br>最后重启sshd服务即可！
**7.&nbsp; ssh连接错误问题**<br>1)&nbsp; 在使用ssh或scp或rsync远程连接的时候，出现如下报错：<br>Address **** maps to localhost, but this does not map back to the address - POSSIBLE BREAK-IN ATTEMPT!<br>解决方法：<br>修改本机ssh_config文件 <br>[root@kvmserver ~]# vim /etc/ssh/ssh_config <br>GSSAPIAuthentication no<br>[root@kvmserver ~]#/etc/init.d/sshd restart
问题迎刃而解～～
2)&nbsp; 本机scp、rsync命令都已具备，但是在使用scp或rsync远程同步的时候报错：<br>bash: scp: command not found<br>bash: rsync: command not found<br>原因：是由于远程机器上没有安装scp或rsync造成的！安装这两个命令即可～<br>yum install openssh-clients<br>yum install rsync
3）远程ssh连接时错误“ The X11 forwarding request was rejected!”<br>解决方法：<br>将sshd_config中 设置 X11Forwarding yes<br>重启sshd服务。
**8.&nbsp; ssh连接超时被踢出问题**<br>当使用xshell，SecureCRT等客户端访问linux服务器，有时候会出现终端定期超时被踢出的情况。<br>下面介绍三种方法来防止超时被踢出的方法，后两种情况的设置方法以及通过设置shell变量来达到此目的的方法：
1、 配置服务器<br># vim /etc/ssh/sshd_config<br>1）找到 ClientAliveInterval参数，如果没有就自己加一行<br>数值是秒，比如你设置为120 ，则是2分钟<br>ClientAliveInterval 120<br>2）ClientAliveCountMax<br>指如果发现客户端没有响应，则判断一次超时，这个参数设置允许超时的次数。如3 、5等自定义
修改两项参数后如下：<br>----------------------------<br>ClientAliveInterval 120<br>ClientAliveCountMax 3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp//0 不允许超时次数<br>修改/etc/ssh/sshd_config文件，将 ClientAliveInterval 0和ClientAliveCountMax 3的注释符号去掉,将ClientAliveInterval对应的0改成60，没有就自己输入。<br>ClientAliveInterval指定了服务器端向客户端请求消息的时间间隔, 默认是0，不发送.而ClientAliveInterval 60表示每分钟发送一次, 然后客户端响应, 这样就保持长连接了.ClientAliveCountMax, 使用默认值3即可.ClientAliveCountMax表示服务器发出请求后客户端没有响应的次数达到一定值, 就自动断开. 正常情况下, 客户端不会不响应.<br>重新加载sshd服务。退出客户端，再次登陆即可验证。<br>3）重启sshd service<br># /etc/init.d/ssh restart
2、 配置客户端<br>#vim /etc/ssh/ssh_config<br>然后找到里面的<br>ServerAliveInterval<br>参数，如果没有你同样自己加一个就好了<br>参数意义相同，都是秒数，比如5分钟等<br>ServerAliveInterval 300
3、# echo export TMOUT=1000000 >> /root/.bash_profile; source .bash_profile<br>在Linux 终端的shell环境中通过设置环境变量TMOUT来阻止超时。如果显示空白,表示没有设置, 等于使用默认值0, 一般情况下应该是不超时. 如果大于0, 可以在如/etc/profile之类文件中设置它为0.
**9.&nbsp; ssh远程登陆，公钥授权不通过：Permission denied (publickey,gssapi-keyex,gssapi-with-mic)**<br>公司IDC机房服务器，之前做了跳板机环境，其他机器只允许从跳板机ssh无密码信任过去，并且在信任关系做好后，禁用了其他机器的密码登陆功能（sshd_config文件里设置“PermitEmptyPasswords no”）
后来跳板机出现了问题，打算重装这台机器，重装前取消了其他机器里只允许跳板机ssh信任关系，并且恢复了密码登陆功能：<br>[root@bastion-IDC ssh]# vim /etc/ssh/sshd_config<br>PermitEmptyPasswords yes<br>[root@bastion-IDC ssh]# service sshd restart
修改后，当时在其他机器间是可以ssh相互登陆，当时没在意，以为一切ok了。<br>可是，到了第二天，再次ssh登陆时，尼玛，居然报错了~~<br>Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
最后发现是selinux惹的祸！关闭它即可。<br>1）临时关闭selinux<br>[root@bastion-IDC ssh]# setenforce 0<br>[root@bastion-IDC ssh]# getenforce <br>Permissive<br>2）永久关闭<br>[root@bastion-IDC ssh]# vim /etc/sysconfig/selinux <br>SELINUX=disabled<br>[root@bastion-IDC ssh]# reboot #重启系统才能生效
说明：<br>1）ssh可同时支持publickey和password两种授权方式，publickey默认不开启，需要配置为yes。 <br>如果客户端不存在.ssh/id_rsa，则使用password授权；存在则使用publickey授权；如果publickey授权失败，依然会继续使用password授权。
2）GSSAPI身份验证.<br>GSSAPIAuthentication 是否允许使用基于 GSSAPI 的用户认证.默认值为"no".仅用于SSH-2.<br>GSSAPICleanupCredentials 是否在用户退出登录后自动销毁用户凭证缓存。默认值是"yes".仅用于SSH-2.<br>需要特别注意的是：<br>GSSAPI是公共安全事务应用程序接口(GSS-API)<br>公共安全事务应用程序接口以一种统一的模式为使用者提供安全事务,由于它支持最基本的机制和技术,所以保证不同的应用环境下的可移植性.<br>该规范定义了GSS-API事务和基本元素,并独立于基本的机制和程序设计语言环境,并借助于其它相关的文档规范实现.
如果我们在服务端打开GSSAPIAuthentication配置项,如下:<br>[root@server ~]#vim /etc/ssh/sshd_config<br>........<br>GSSAPIAuthentication yes<br>GSSAPICleanupCredentials yes
那么在客户端登录服务端会用gssapi-keyex,gssapi-with-mic进行身份校验,同样客户端也要支持这种身份验证,如下:
[root@client ~]#vim /etc/ssh/ssh_config<br>GSSAPIAuthentication yes<br>GSSAPIDelegateCredentials yes
我们在客户端连接SSH服务端,如下:<br>ssh -v 192.168.1.11<br>.................<br>debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password<br>debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password<br>debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password<br>debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
我们看到如下的信息:<br>debug1: Unspecified GSS failure. Minor code may provide more information<br>No credentials cache found<br>debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password<br>debug1: Next authentication method: gssapi-keyex<br>debug1: No valid Key exchange context<br>说明SSH登录时采用GSSAPI的方式进行身份验证,但我们的系统不支持.
最后如果我们不用这种方式进行身份验证的话,建议关闭这个选项,这样可以提高验证时的速度.
**10.&nbsp; ssh自定义安全设置**<br>1)&nbsp; 为了ssh登陆的时候加一层保护，可以修改默认端口。修改ssh服务配置文件/etc/ssh/sshd_config<br>port  2222
这样远程连接时加短裤<br>#ssh 192.168.1.83 -p 2222 
2)&nbsp; ssh使用时加-l后面跟用户名，表示登陆到对方的这个用户下面。<br>#ssh -l wangshibo 192.168.1.83 -p 2222<br>等同于<br>#ssh wangshibo@192.168.1.83 -p 2222
3)&nbsp; 限制ssh登陆的来源ip，白名单设置（hosts.allow优先级最高，具体参考：<a href="http://www.cnblogs.com/kevingrace/p/6245859.html" target="_blank">Linux服务器安全登录设置记录</a>）<br>一是通过iptables设置ssh端口的白名单,如下设置只允许192.168.1.0/24网段的客户机可以远程连接本机<br>#vim /etc/sysconfig/iptables<br>-A INPUT -s 192.168.1.0/24 -p tcp -m state --state NEW -m tcp --dport 2222 -j ACCEPT<br>二是通过/etc/hosts.allow里面进行限制(如下)，/etc/hosts.deny文件不要任何内容编辑，保持默认！<br>#vim /etc/hosts.allow<br>sshd:192.168.1.*,192.168.9.*,124.65.197.154,61.148.60.42,103.10.86.7:allow<br>sshd:all:deny
4）仅允许特定的用户通过SSH登陆<br>如不允许root用户登录；<br>只允许几个指定的用户登录(比如wangshibo、guohuihui、liuxing用户)<br>禁止某些指定的用户登录（比如zhangda，liqin用户）<br>但是要注意：设置的这几个用户必须同时存在于本机和对方机器上<br>修改ssh服务配置文件/etc/ssh/sshd_config<br>PermitRootLogin no       //将yes修改为no<br>AllowUsers&nbsp; &nbsp; &nbsp; wangshibo guohuihui liuxing    //这个参数AllowUsers如果不存在，需要手动创建，用户之间空格隔开<br>DenyUsers&nbsp; &nbsp; &nbsp; zhagnda liqin   //这个参数DenyUsers如果不存在，需要手动创建，用户之间空格隔开
也可以设置仅允许某个组的成员通过ssh访问主机。<br>AllowGroups wheel ops
实例说明：

```brush:bash;gutter:true;">1）只允许指定用户进行登录（白名单）：
在 /etc/ssh/sshd_config 配置文件中设置 AllowUsers 选项。格式如下：

AllowUsers    root grace kevin app          
表示只允许grace用户、kevin用户通过ssh登录本机。

AllowUsers    root@192.168.10.10 app@192.168.10.11 kevin@192.168.10.13          
表示只允许从192.168.10.10登录的root用户、从192.168.10.11登录的app用户、从192.168.10.13登录的kevin用户可以通过ssh登录本机。


2）只拒绝指定用户进行登录（黑名单）：)
在/etc/ssh/sshd_config配置文件中设置DenyUsers选项。格式如下：   

DenyUsers    wangbo linan zhangyang     
表示拒绝wangbo、linan和zhangyang用户通过ssh登录本机。

需要注意的是：
- AllowUsers、DenyUsers跟后面的配置之间使用TAB键进行隔开
- 多个百名单或黑名单之间使用空格隔开


例子：
[root@Centos6 ~]# cat /etc/ssh/sshd_config
.......
AllowUsers    root@192.168.10.202 app@192.168.10.200 kevin@192.168.10.202
[root@Centos6 ~]# /etc/init.d/sshd restart


[root@Centos6 ~]# cat /etc/ssh/sshd_config
.......
AllowUsers    root app kevin
[root@Centos6 ~]# /etc/init.d/sshd restart


[root@Centos6 ~]# cat /etc/ssh/sshd_config
.......
DenyUsers    wangbo linan zhangyang 
[root@Centos6 ~]# /etc/init.d/sshd restart

如下，由于已经允许了app和root登录，则后面针对root@192.168.10.202和app@192.168.10.200的限制就无效了（两者别放在一起配置）
[root@Centos6 ~]# cat /etc/ssh/sshd_config
.......
AllowUsers    app root root@192.168.10.202 app@192.168.10.200
[root@Centos6 ~]# /etc/init.d/sshd restart
```
########&nbsp; 还可以使用pam规则限制ssh登录&nbsp; ########

```brush:bash;gutter:true;">1）允许指定的用户（比如kevin、grace账号）进行登录
在/etc/pam.d/sshd文件第一行加入，一定要在第一行，因为规则是自上而下进行匹配的。
auth required pam_listfile.so item=user sense=allow file=/etc/sshusers onerr=fail

然后在/etc下建立sshusers文件,编辑这个文件,加入你允许使用ssh服务的用户名,不用重新启动sshd服务。
最后重启sshd服务即可！

操作如下：
[root@docker-test1 ~]# vim /etc/pam.d/sshd
#%PAM-1.0
auth required pam_listfile.so item=user sense=allow file=/etc/sshusers onerr=fail
........

[root@docker-test1 ~]# touch /etc/sshusers
[root@docker-test1 ~]# vim /etc/sshusers
kevin
grace

[root@docker-test1 ~]# /etc/init.d/sshd restart


2）pam规则也可以写成deny的。比如拒绝kevin、grace账号进行登录
操作如下：
[root@docker-test1 ~]# vim /etc/pam.d/sshd
#%PAM-1.0
auth required pam_listfile.so item=user sense=deny file=/etc/sshusers onerr=succeed
........

[root@docker-test1 ~]# touch /etc/sshusers
[root@docker-test1 ~]# vim /etc/sshusers
kevin
grace

[root@docker-test1 ~]# /etc/init.d/sshd restart

3)pam规则可以使用group限制。

允许规则：
auth required pam_listfile.so item=group sense=allow file=/etc/security/allow_groups onerr=fail

禁止规则：
auth required pam_listfile.so item=group sense=deny file=/etc/security/deny_groups onerr=succeed


操作如下：
[root@docker-test1 ~]# vim /etc/pam.d/sshd   
#%PAM-1.0
auth required pam_listfile.so item=group sense=allow file=/etc/security/allow_groups onerr=fail

新建一个组，组名为bobo，然后将kevin和grace添加到这个bobo组内
[root@docker-test1 ~]# groupadd bobo
[root@docker-test1 ~]# gpasswd -a kevin bobo
Adding user kevin to group bobo
[root@docker-test1 ~]# usermod -G bobo grace
[root@docker-test1 ~]# id kevin
uid=1000(kevin) gid=1000(kevin) groups=1000(kevin),1002(bobo)
[root@docker-test1 ~]# id grace
uid=1001(grace) gid=1001(grace) groups=1001(grace),1002(bobo)

在/etc/security/allow_groups文件按中加入组名（注意如果不加root，则root就不能被允许登录了）
[root@docker-test1 ~]# vim /etc/security/allow_groups
bobo

[root@docker-test1 ~]# /etc/init.d/sshd restart

如上设置后，则只有kevin用户能被允许登录！
如果是禁止规则，则第一行改为下面内容：
auth required pam_listfile.so item=group sense=deny file=/etc/security/deny_groups onerr=succeed
```
除此之外，禁止某些用户ssh登录，可以&nbsp;<a href="https://www.cnblogs.com/kevingrace/p/6109818.html" target="_blank">使用passwd或usermod命令进行账号锁定</a>
5）取消密码验证，只用密钥对验证<br>修改ssh服务配置文件/etc/ssh/sshd_config<br>PasswordAuthentication no<br>PubkeyAuthentication yes 
6）给账号设置强壮的密码：将密码保存到文本进行复制和粘帖就可以了<br># yum -y install expect<br># mkpasswd -l 128 -d 8 -C 15 -s 10 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>lVj.jg&amp;sKrf0cvtgmydqo7qPotxzxen9mefy?ej!kcaX2gQrcu2ndftkeamllznx>iHikTagiVz0$cMtqOcIypkpd,vvD*kJhs3q@sb:CiCqgtqdqvse5lssfmranbtx<br>参数说明：<br>-l  密码长度<br>-d  多少个数字<br>-C     大写字母个数<br>-s  特殊符号的个数
7）只允许通过指定的网络接口来访问SSH服务，(如果本服务器有多个IP的时候)<br>仍然是修改/etc/ssh/sshd_config，如下：<br>ListenAddress 192.168.1.15 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;                 //默认监听的是0.0.0.0
这样，就只允许远程机器通过ssh连接本机的192.168.1.15内网ip来进行登陆了。
8）禁止空密码登录<br>如果本机系统有些账号没有设置密码，而ssh配置文件里又没做限制，那么远程通过这个空密码账号就可以登陆了，这是及其不安全的！<br>所以一定要禁止空密码登陆。修改/etc/ssh/sshd_config，如下：<br>PermitEmptyPasswords no     //这一项，默认就是禁用空密码登陆
9) ssh_config和sshd_config<br>ssh_config和sshd_config都是ssh服务器的配置文件，二者区别在于，前者是针对客户端的配置文件，后者则是针对服务端的配置文件。两个配置文件都允许你通过设置不同的选项来改变客户端程序的运行方式。sshd_config的配置一般都比较熟悉，下面单独说下ssh_config针对客户端的配置文件：

```brush:bash;gutter:true;">[root@dns01 dns_rsync]# cat /etc/ssh/ssh_config
# Site-wide defaults for various options
   Host *
        ForwardAgent no
        ForwardX11 no
        RhostsAuthentication no
        RhostsRSAAuthentication no
    ‍    RSAAuthentication yes
        PasswordAuthentication yes
        FallBackToRsh no
        UseRsh no
        BatchMode no
        CheckHostIP yes
        StrictHostKeyChecking no
        IdentityFile ~/.ssh/identity
        Port 22
        Cipher blowfish
        EscapeChar ~

下面对上述选项参数逐进行解释：
# Site-wide defaults for various options
带“#”表示该句为注释不起作，该句不属于配置文件原文，意在说明下面选项均为系统初始默认的选项。说明一下，实际配置文件中也有很多选项前面加有“#”注释，虽然表示不起作用，其实是说明此为系统默认的初始化设置。
Host *
"Host"只对匹配后面字串的计算机有效，“*”表示所有的计算机。从该项格式前置一些可以看出，这是一个类似于全局的选项，表示下面缩进的选项都适用于该设置，可以指定某计算机替换*号使下面选项只针对该算机器生效。
ForwardAgent no
"ForwardAgent"设置连接是否经过验证代理（如果存在）转发给远程计算机。
ForwardX11 no
"ForwardX11"设置X11连接是否被自动重定向到安全的通道和显示集（DISPLAY set）。
RhostsAuthentication no
"RhostsAuthentication"设置是否使用基于rhosts的安全验证。
RhostsRSAAuthentication no
"RhostsRSAAuthentication"设置是否使用用RSA算法的基于rhosts的安全验证。
RSAAuthentication yes
"RSAAuthentication"设置是否使用RSA算法进行安全验证。
PasswordAuthentication yes
"PasswordAuthentication"设置是否使用口令验证。
FallBackToRsh no
"FallBackToRsh"设置如果用ssh连接出现错误是否自动使用rsh，由于rsh并不安全，所以此选项应当设置为"no"。
UseRsh no
"UseRsh"设置是否在这台计算机上使用"rlogin/rsh"，原因同上，设为"no"。
BatchMode no
"BatchMode"：批处理模式，一般设为"no"；如果设为"yes"，交互式输入口令的提示将被禁止，这个选项对脚本文件和批处理任务十分有用。
CheckHostIP yes
"CheckHostIP"设置ssh是否查看连接到服务器的主机的IP地址以防止DNS欺骗。建议设置为"yes"。
StrictHostKeyChecking no
"StrictHostKeyChecking"如果设为"yes"，ssh将不会自动把计算机的密匙加入"$HOME/.ssh/known_hosts"文件，且一旦计算机的密匙发生了变化，就拒绝连接。
IdentityFile ~/.ssh/identity
"IdentityFile"设置读取用户的RSA安全验证标识。
Port 22
"Port"设置连接到远程主机的端口，ssh默认端口为22。
Cipher blowfish
“Cipher”设置加密用的密钥，blowfish可以自己随意设置。
EscapeChar ~
“EscapeChar”设置escape字符。<br>
=================================================================================
比如说，A机器的ssh端口是22，B机器的端口是22222，一般来说A机器ssh连接B机器的时候是使用-p22222指定端口。但是可以修改A机器的/etc/ssh/ssh_config文件中的
Port为22222，这样A机器ssh连接的时候就默认使用22222端口了。
```
########&nbsp; 去掉SSH公钥检查的方法（交互式yes/no）########
SSH公钥检查是一个重要的安全机制，可以防范中间人劫持等黑客攻击。但是在特定情况下，严格的 SSH 公钥检查会破坏一些依赖SSH协议的自动化任务，就需要一种手段能够绕过SSH的公钥检查。<br>SSH连接远程主机时，会检查主机的公钥。如果是第一次连接该主机，会显示该主机的公钥摘要，弹出公钥确认的提示，提示用户是否信任该主机（Yes/no）。当选择Yes接受，就会将该主机的公钥追加到文件 ~/.ssh/known_hosts 中。当再次连接该主机时，就不会再提示该问题了。<br>SSH公钥检查有好处，但首次连接时会导致某些自动化任务中断，或者由于  ~/.ssh/known_hosts 文件内容清空，导致自动化任务中断。
去掉SSH公钥检查的方法：<br>1）SSH客户端的StrictHostKeyChecking 配置指令，可以实现当第一次连接服务器时，自动接受新的公钥。只需要修改 /etc/ssh/ssh_config 文件，包含下列语句：<br>StrictHostKeyChecking no
2）或者在ssh连接命令中使用-oStrictHostKeyChecking=no参数<br>[root@puppet ~]# ssh -p22222 172.168.1.33 -oStrictHostKeyChecking=no                               <br>或者<br>[root@puppet ~]# ssh -p22222 172.168.1.33 -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no
########&nbsp; ssh 登陆忽略known_hosts文件&nbsp; ########<br>使用ssh登录远程机器，同时会把ssh信息记录在本地的~/.ssh/known_hsots文件中。如果出现ssh冲突了，需要手动删除或修改known_hsots里面对应远程机器的ssh信息。那么如果忽略掉这个known_hosts的访问? 操作如下：<br>1）修改/etc/ssh/sshd_config 配置文件中的选项 IgnoreUserKnownHosts 改成 yes，重启sshd服务即可。<br>2）如果还是不行，就在/etc/ssh/sshd_config 配置文件中再加入一下几行，然后再重启sshd服务。<br>StrictHostKeyChecking no<br>UserKnownHostsFile /dev/null
########&nbsp; ansible中取消ssh交换式yes/no&nbsp; ########<br>配置文件/etc/ansible/ansible.cfg的 [defaults] 中（打开注释）<br># uncomment this to disable SSH key host checking<br>host_key_checking = False
########&nbsp; ssh只允许使用key登录, 禁止使用密码登录&nbsp; ########<br>1)&nbsp; 生产公私钥文件<br># ssh-keygen -t rsa <br>上面命令一路回车,  此时在/root/.ssh/目录下生成了2个文件，id_rsa为私钥，id_rsa.pub为公钥。<br>私钥自己下载到本地电脑妥善保存（丢了服务器可就没法再登陆了），为安全，建议删除服务器端的私钥。公钥则可以任意公开。
使用以下命令将公钥导入到系统中：<br># cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
2)&nbsp; 修改SSH的配置文件/etc/ssh/sshd_config&nbsp;<br># vim /etc/ssh/sshd_config<br>RSAAuthentication yes<br>PubkeyAuthentication yes<br>AuthorizedKeysFile      .ssh/authorized_keys
#默认PasswordAuthentication 为yes,即允许密码登录，改为no后，禁止密码登录<br>PasswordAuthentication no
3)&nbsp; 重启SSH服务<br># /etc/init.d/sshd restart
4)&nbsp; 使用私钥登录xshell或securecrt客户端了
########&nbsp;&nbsp;SSH服务启动报错案例&nbsp; ########<br>在某台服务器上部署了sftp服务，最后发现sftp远程登录正常，但是ssh远程登录失败（尽管已经输入了正确的用户名和密码）。

```brush:bash;gutter:true;">[root@kevin ssh]# service sshd restart
Stopping sshd: [ OK ]
Starting sshd:/etc/ssh/sshd_config line 81: Unsupported option GSSAPIAuthentication
/etc/ssh/sshd_config line 83: Unsupported option GSSAPICleanupCredentials
Starting sshd: [ OK ]

如上启动后，远程ssh登录这台机器，输入正确的用户名和密码，则会登录失败！！

[root@kevin ssh]# ssh -V
OpenSSH_7.6p1, OpenSSL 1.0.1e-fips 11 Feb 2013

原因是新版本的openssh不支持以上参数，需要修改sshd的配置文件。
修改内容如下，否则还是无法通过ssh登录这台服务器：
[root@kevin ssh]# vim /etc/ssh/sshd_config
.......
##去掉前面的注释，允许root通过ssh登录
PermitRootLogin yes
##注释掉下面三个参数
#GSSAPIAuthentication yes
#GSSAPICleanupCredentials yes
#UsePAM yes

再次重启ssh，上面的报错信息就没有了。此时远程ssh登录就OK了！
[root@kevin ssh]# service sshd restart
Stopping sshd: [ OK ]
Starting sshd: [ OK ]

```
########&nbsp; SSH连接超时时间(timed out)设置&nbsp; ########

```brush:bash;gutter:true;">1）使用下面命令连接，可以减少ssh连接超时等待的时间
# ssh -o ConnectTimeout=5 -p22 root@172.16.60.20
或者修改sshd_config文件里面的UseDNS 选项，改为UseDNS no

2）设置SSH超时时间的方法
# vim /root/.bash_profile    
export TMOUT=1000000     #以秒为单位。或者修改/etc/profile文件也可以。
# source /root/.bash_profile

# vim /etc/ssh/sshd_config
ClientAliveInterval=60
# service sshd restart

意思是每过一分钟，sshd都会和ssh client打个招呼 (即服务器端给客户端发送一个"空包")，检测它是否存在，如果不存时则断开连接！
这里需要注意： 设置完成后，要退出ssh远程连接，再次登录后才可以生效。因为要再读取一次~/bash_profile文件。

总结：
在ClientAliveInterval（/etc/ssh/sshd_config）、环境变量TMOUT（在/etc/profile或.bash_profile中设置）以及putty的"Seconds between keepalives"（默认为0）这些设置方法中，
经检测验证，只有TMOUT可以控制ssh连接在空闲时间超时，自动断开连接的时间，数字单位为"秒"。在设置了TMOUT后（非0），另外两个变量则不起作用的。

另外，特别提醒的是，设置好ssh的登录超时时间以后，记得退出重新登录或重启系统，以使配置生效。

3）SSH禁止超时设置
SSH默认过一段时间会超时，有时候正在执行着脚本，出去一会回来就断开了，输出信息都看不到了，很是无奈！

其实禁止SSH自动超时最简单的办法就是：每隔一段时间在客户端和服务器之间发送一个"空包"！！！！！
至于到底是从客户端发给服务器，还是服务器发给客户端其实都不重要，重要的是需要它们之间要有通信。

下面介绍两种阻止SSH连接超时的方法（推荐方法二）：

方法一：客户端阻止SSH超时
编辑本地的SSH配置文件：~/.ssh/config
# vim ~/.ssh/config
ServerAliveInterval 120

这个设置会让客服端机器在使用SSH连接服务器时，每隔120秒给服务器发送一个"空包"，保持它们之间的连接。

方法二：服务器端阻止SSH超时
如果有服务器端的root权限，可以在服务端进行配置，这样就不需要每个客户端都单独配置。
# vim /etc/ssh/sshd_config
ClientAliveInterval 120 
ClientAliveCountMax 720

第一行，表示每隔120秒向客户端发送一个"空包"，以保持于客户端的连接。
第二行，表示总共发送720次"空包"，之后断开它们之间的连接，也就是：120秒 × 720 = 86400 秒 = 24小时 后。

最后重启sshd服务，再打开新终端进行ssh连接就可以了，在24小时内不会出现连接超时。
# /etc/init.d/ssh restart
```
######## SSH公钥下发无效 ########<br>ssh的.pub公钥已经拷贝到远程主机的.ssh/authorized_keys文件里，但是ssh跳转时，仍然要输入密码！！即公钥下发后，ssh信任关系没有生效！

```brush:bash;gutter:true;">解决办法：
1）远程主机对应用户家目录下的.ssh目录必须是700或755权限，绝不能是775或777权限！即只对该用户有写权限！(一般设置700权限)
2）远程主机对应用户家目录下的.ssh/authorized_keys文件权限必须是600权限！即只对该用户有写权限！(一般设置600权限)
3）远程主机对应用户家目录的权限必须是700或755权限，绝不能是775或777权限！即只对该用户有写权限！（一般设置700权限），大多数情况下都是由于这个原因导致的！！！
 
如果.ssh目录和.ssh/authorized_keys文件权限对别的用户有写权限，则就会导致ssh认证失败！

=====================================================================================================
例如在一次ansible自动化部署中，之前配置好的ssh信任关系失效，报错如下:
{"changed": false, "msg": "SSH Error: data could not be sent to remote host \"172.16.60.240\". Make sure this host can be reached over ssh", "unreachable": true}

查看现象，发现之前配置好的ssh信任关系失效了！！
[root@bz3devjenci1002 lx0319]# ssh -p22 kevin@172.16.60.240           
Authorized only. All activity will be monitored and reported
kevin@172.16.60.240's password: 

分析原因及解决办法：
登录172.16.60.240这台机器的kevin用户下，发现authorized_keys文件里确实已经传入了ansible主节点的id_rsa.pub公钥内容，并且下面两个权限都正确：
[kevin@bz4autestap1002 ~]$ ll -d .ssh
drwx------ 2 kevin kevin 4096 Jul 24 10:48 .ssh         #700权限是正确的

[kevin@bz4autestap1002 ~]$ ll .ssh/authorized_keys 
-rw------- 1 kevin kevin 2412 Jul 24 10:45 .ssh/authorized_keys     #600权限也是正确的

然后查看kevin用户目录权限，发现是777！这才是问题根源！该用户目录权限不能对别的用户有写权限，否则会造成ssh认证失败！
[kevin@bz4autestap1002 ~]$ ll -d /home/kevin
drwxrwxrwx 14 kevin kevin 4096 Jul 24 10:48 /home/kevin

修改为600权限即可
[kevin@bz4autestap1002 ~]$ chmod 600 /home/kevin
[kevin@bz4autestap1002 ~]$ ll -d /home/kevin
drwx------ 14 kevin kevin 4096 Jul 24 10:48 /home/kevin

再次在远程尝试ssh认证跳转
[root@bz3devjenci1002 lx0319]# ssh -p22 kevin@172.16.60.240  
[kevin@bz4autestap1002 ~]$
```
########&nbsp; Centos7修改ssh默认端口的方法&nbsp; ########

```brush:bash;gutter:true;">CentOS 7 对于防火墙这一块的设置有一定的修改，修改ssh端口后，必须关闭防火墙和selinux之后才能正常重启sshd服务，否则启动失败。操作记录如下：
1）修改/etc/ssh/sshd_config                         #这个是修改ssh服务端配置文件。
[root@k8s-master01 ~]# vim /etc/ssh/sshd_config
.........
#Port 22         #这行最好去掉#号，防止配置失效以后不能远程登录，还得去机房修改，等修改以后的端口能使用以后在注释掉
Port 6666       #下面添加这一行

[root@k8s-master01 ~]# vim /etc/ssh/ssh_config    #这个是修改ssh客户端配置文件，一般可以不用修改。
........
#   Port 22
    Port 6666

======================================================================================================
ssh客户端配置文件使用场景：
比如A机器的/etc/ssh/ssh_config客户端配置文件的ssh端口是22，B机器的/etc/ssh/sshd_config服务端配置文件是6666
那么A机器ssh连接B机器时就要带上"-p6666", 如果A机器的ssh客户端配置文件的端口也是6666的话，就可以直接ssh连接B机器了。
======================================================================================================

2）要关闭防火墙和selinux。否则，centos7修改ssh端口后会启动sshd服务失败！一定要注意这个！
[root@k8s-master01 ~]# systemctl disable firewalld
[root@k8s-master01 ~]# systemctl stop firewalld
[root@k8s-master01 ~]# firewall-cmd --state
not running

[root@k8s-master01 ~]# cat /etc/sysconfig/selinux 
.......
SELINUX=disabled
[root@k8s-master01 ~]# setenforce 0
[root@k8s-master01 ~]# getenforce 
Disabled

这样，在修改ssh端口后，就能顺利启动sshd服务了！

======================================================================================================
这里还需要注意下：如果是打开了防火墙或selinux，则需要将修改的sshd端口添加到对应的防火墙规则中（默认只加了ssh的22端口）

a）firewalld配置
添加到防火墙：
# firewall-cmd --zone=public --add-port=6666/tcp --permanent (permanent是保存配置，不然下次重启以后这次修改无效)
重启：
#firewall-cmd --reload

查看添加端口是否成功，如果添加成功则会显示yes，否则no
# firewall-cmd --zone=public --query-port=6666/tcp

b）selinux配置
使用以下命令查看当前SElinux 允许的ssh端口：
# semanage port -l | grep ssh

添加6666端口到 SELinux
# semanage port -a -t ssh_port_t -p tcp 6666

然后确认一下是否添加进去
# semanage port -l | grep ssh

如果成功会输出
ssh_port_t                    tcp    6666, 22

c）然后就可以顺利启动sshd服务了。
```