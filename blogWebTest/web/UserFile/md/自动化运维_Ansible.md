# **1.&nbsp;****前言**
Ansible是自动化运维的工具，基于Python开发，实现了批量系统配置、批量程序部署、批量运行命令等功能。
Ansible是基于模块工作的，ansible提供一个框架，通过模块实现批量部署。
<img src="https://images2015.cnblogs.com/blog/868522/201601/868522-20160121163736406-1244231376.png" alt="">
# **2.&nbsp;****安装，使用**
### 2.1 安装Ansible
使用epel的源安装，添加epel源此处不详述。

```brush:bash;gutter:true;"># yum install ansible --enablerepo=epel
```
### 2.2 设置密钥登录
生成SSH公钥密钥对

```brush:bash;gutter:true;"># ssh-keygen -t rsa -P ''
```
拷贝公钥到被管理端的服务器

```brush:bash;gutter:true;"># cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
# chmod 600 /root/.ssh/authorized_keys
```
确认可以用密钥连接到管理端的服务器<br>
### 2.3 配置Ansible
定义主机组，可以使用主机名或IP

```brush:bash;gutter:true;"># vi /etc/ansible/hosts
[tests]
test167
test154
```
另外，Ansible的配置文件在&nbsp/etc/ansible/ansible.cfg，默认不需要修改。
### 2.4 使用Ansible
#### 2.4.1 Ping模块

```brush:bash;gutter:true;"># ansible tests -m ping

```
<img src="https://images2015.cnblogs.com/blog/868522/201601/868522-20160121164808828-366241031.png" alt="">
#### 2.4.2 执行命令，command、shell模块


```brush:bash;gutter:true;"># ansible tests -m command -a 'uptime'
# ansible tests -m shell -a 'date'

# ansible tests -m command -a 'cat  /etc/resolv.conf'
```
#### 2.4.3 查看配置，setup模块

```brush:bash;gutter:true;"># ansible tests -m setup

```
#### 2.4.4 拷贝文件，copy模块

```brush:bash;gutter:true;"># ansible tests -m copy -a 'src=/home/ec2-user/test.txt dest=/tmp/test222.txt mode=0644'
```
#### 2.4.5 添加用户，user模块

```brush:bash;gutter:true;"># ansible tests -m user -a 'name=test comment="test user" uid=1000 password="crypted-password"'
```
密码生成方法：

```brush:bash;gutter:true;"># yum install python-pip
# pip install passlib

# python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"

```
#### 2.4.6 安装软件，yum模块

```brush:bash;gutter:true;"># ansible tests -m yum -a 'name=vsftpd state=present'
```
#### 2.4.7 启动服务，设置开机自启动，service模块

```brush:bash;gutter:true;"># ansible tests -m service -a 'name=vsftpd state=started enabled=yes'
```
查看

```brush:bash;gutter:true;"># ansible tests -m shell -a 'ps -ef| grep ftp'
# ansible tests -m shell -a 'ss -tln| grep 21'
```
#### 2.4.8 支持管道，raw，shell模块

```brush:bash;gutter:true;"># ansible tests -m raw -a 'ss -tln| grep 21'
```
### 2.5 其他命令
#### 2.5.1 查看帮助
列出所有已安装模块

```brush:bash;gutter:true;"># ansible-doc -l
```
查看某模块的简介

```brush:bash;gutter:true;"># ansible-doc -s ping

```
#### 2.5.2 ansible-pull
使用pull模式，（默认是push模式）
# Playbook文件


Playbook是由一个或多个“play”组成的列表，可以让它们联同起来按事先编排的机制执行

```brush:bash;gutter:true;"># ansible-playbook test.yml
```
Playbook文件的格式，YAML是一个可读性高的标记语言。
Role可以把playbook分成一个一个模块，使结构更清晰。
### 3.1 Role的构造
包括&nbsp;tasks, defaults, vars, files, templates, mata, handlers 各目录，其中&nbsp;tasks 是必需的。
<img src="https://images2015.cnblogs.com/blog/868522/201601/868522-20160121170419578-1799249375.png" alt="">
### 3.2&nbsp;Role的例子
本例子是最基本的构成，只包括tasks

#### 3.2.1 创建目录 roles/apache2/tasks

```brush:bash;gutter:true;"># mkdir -p roles/apache2/tasks
```
#### 3.2.2 创建 tasks/main.yml

```brush:bash;gutter:true;">---
- name: Install apache2 (RedHat).
  yum: name=httpd
  when: "ansible_os_family == 'RedHat'"

- name: Install apache2 (Debian).
  apt: name=apache2
  when: "ansible_os_family == 'Debian'"

```
#### 3.2.3 创建 Playbook (site.yml)

```brush:bash;gutter:true;">---
- name: Install Apache2
  hosts: tests
  remote_user: root

  roles:
    - apache2
```
#### 3.2.4 执行

```brush:bash;gutter:true;"># ansible-playbook site.yml

```
<img src="https://images2015.cnblogs.com/blog/868522/201601/868522-20160121171044000-288471170.png" alt="">
```
### 3.3 官方的playbook例子

https://github.com/ansible/ansible-examples
```
### 3.4 playbook文件加密
ansible-vault&nbsp;对配置文件（比如playbooks），进行基于密码的加密，防止敏感信息泄露
#### 3.4.1 加密已存在文件

```brush:bash;gutter:true;"># ansible-vault encrypt ./site.yml
```
#### 3.4.2 加密并创建文件

```brush:bash;gutter:true;"># ansible-vault create filename

```
#### 加密后的playbook
<img src="https://images2015.cnblogs.com/blog/868522/201601/868522-20160121171456000-586015545.png" alt="">
#### 3.4.3 执行加密后的playbook

```brush:bash;gutter:true;"># ansible-playbook ./site.yml --ask-vault-pass
```
#### 3.4.4 解密

```brush:bash;gutter:true;"># ansible-vault decrypt ./site.yml

```
# 后记


Ansible使用简单，不需要客户端，模块化程度高，定制灵活，当管理服务器的数量多的时候，能起到很大的帮助。是一个很好的自动化运维工具。
```