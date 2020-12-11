/*
 Navicat Premium Data Transfer

 Source Server         : net
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 11/12/2020 16:18:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `article_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '博文ID',
  `user_id` bigint(0) NOT NULL COMMENT '发表用户ID',
  `article_title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博文标题',
  `article_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博文内容',
  `article_views` bigint(0) NOT NULL COMMENT '浏览量',
  `article_comment_count` bigint(0) NOT NULL COMMENT '评论总数',
  `article_date` datetime(0) NULL DEFAULT NULL COMMENT '发表时间',
  `article_like_count` bigint(0) NOT NULL COMMENT '点赞数',
  `article_preview` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`article_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of articles
-- ----------------------------
INSERT INTO `articles` VALUES (27, 2, 'EL', 'EL.md', 11, 0, '2020-12-04 22:24:37', 0, 'EL表达式 概念Exeio Laguage 作用替换和简化j页面中java代码的编写 语法${表达式} 注意j默认支持EL表达式，要忽略的话在age指令里加上iELIgoed=\"tue\"或者在$前加 \\  使用方式 运算 运算符1、算数运算');
INSERT INTO `articles` VALUES (28, 2, '这里是文章标题', '这里是文章标题.md', 8, 0, '2020-12-04 22:31:25', 0, '这里是edito的内');
INSERT INTO `articles` VALUES (30, 2, 'sdsd', 'sdsd.md', 1, 0, '2020-12-07 13:57:34', 0, NULL);
INSERT INTO `articles` VALUES (31, 2, 'test', 'test.md', 1, 0, '2020-12-07 13:58:29', 0, '这里是edito的内');
INSERT INTO `articles` VALUES (32, 3, '01、安装', '01、安装.md', 55, 0, '2020-12-07 19:31:46', 9, '1、安装------ 1、java安装java的安装不难，跟着提示下一步就好。但是安装完以后要配置环境变量，以下给大家说一下如何配置环境变量右击此电脑---属性---高级系统设置---环境变量在下面的系统变量处新建一个变量，名字是JAVA_');
INSERT INTO `articles` VALUES (33, 3, '02、基础知识', '02、基础知识.md', 0, 0, '2020-12-07 19:32:16', 0, '2、基础知识------ 1、注释 1.1、单行注释使用//来写单行注释，//到行末都是注释。 1.2、多行注释多行注释分为多行注释和文档注释。多行注释:/*   */通常用于对方法的注释文档注释:/**   */通常用于对类的注释或者文档');
INSERT INTO `articles` VALUES (34, 2, '08、继承', '08、继承.md', 0, 0, '2020-12-08 22:29:29', 0, '8、继承------ 1、概述面向对象的三大特性之一，是多态的前提主要解决的问题是**共性抽取**，用于抽取类之间相同的部分子类可以拥有父类的内容，也可以拥有自己的内容 2、继承的格式父类就是普通的类子类：javaulic cla 子类的名');
INSERT INTO `articles` VALUES (53, 26, '09、抽象类', '09、抽象类.md', 0, 0, '2020-12-10 19:24:29', 0, '9、抽象类------ 1、抽象抽象即具体的反义词，表示把物体共性抽取出来 2、格式抽象方法：ulic后面加上atact关键字，去掉大括号，直接分号结束javaulic atact void eat()抽象类：抽象方法所在的类一定是抽象类，');
INSERT INTO `articles` VALUES (54, 26, '10、接口', '10、接口.md', 0, 0, '2020-12-10 19:25:11', 0, '10、接口------ 1、概念接口即一种公共规范标准只要符合标准，就可以通用 2、定义基本格式接口就是多个类的公共规范，是引用数据类型最重要的就是其中的抽象方法javaulic iteface 接口名称{	//接口内容}备注：编译生成的字');
INSERT INTO `articles` VALUES (55, 26, '11、多态', '11、多态.md', 0, 0, '2020-12-10 19:26:08', 0, '11、多态------ 1、多态概述面向对象三大特征之一，即多种形态，例如一个人可以有学生形态，但同时也有人类形态 2、格式与使用代码当中体现多态性，其实就是一句话，父类引用指向子类对象格式：​	父类名称 对象名 = ew 子类名称()​	');
INSERT INTO `articles` VALUES (56, 26, '12、final关键字和权限修饰符', '12、final关键字和权限修饰符.md', 0, 0, '2020-12-10 19:26:58', 0, '12、fial关键字------ 1、概述fial代表最终，使用fial关键字后无法更改 2、使用 2.1、类javaulic fial cla{}使用fial关键字后，这个类不能有任何子类 2.1、方法javaulic fial 返回值 ');
INSERT INTO `articles` VALUES (57, 26, '13、内部类', '13、内部类.md', 0, 0, '2020-12-10 19:27:42', 0, '13、内部类------ 1、概述内部类即在类的内部在创建一个类分为成员内部类（直接在类中创建）局部内部类（在成员方法中创建）匿名内部类（局部内部类的一种，三种中最重要 2、定义**成员内部类**：java修饰符 cla 内部类名称{}成员');
INSERT INTO `articles` VALUES (58, 26, '14、常用API第二部分\r\n\r\n', '14、常用API第二部分\r\n\r\n.md', 0, 0, '2020-12-10 19:31:14', 0, '14、常用API第二部分------ 1、oject类 1.1、totig用于返回对象的字符串表示，比如数组，使用该方法后可以查看对应的字符串表示而无需遍历javaStig  = Aay.toStig(det) 1.2、equal方法用于比');
INSERT INTO `articles` VALUES (59, 26, '15、Collection集合', '15、Collection集合.md', 0, 0, '2020-12-10 19:33:07', 0, '15、Collectio集合------ 1、概述Collectio对象用于存储多个对象（变量）可以对这些对象（变量进行同时操作） 2、常用方法介绍 2.1、add方法oolea add(E e)添加一个元素，返回的布尔值为时候成功添加 2');
INSERT INTO `articles` VALUES (60, 27, '16、泛型', '16、泛型.md', 0, 0, '2020-12-10 19:35:15', 0, '16、泛型------ 1、概述泛型即未知的数据类型，在创建类时不确定传入的数据类型可以使用泛型。在创建对应的对象是需要指定数据类型，不然默认是oject类。 2、优势与劣势避免数据类型转换的麻烦，把运行期出现的异常提升到了编译期弊端：泛型');
INSERT INTO `articles` VALUES (62, 27, '17、数据结构', '17、数据结构.md', 0, 0, '2020-12-10 19:38:13', 0, '17、数据结构------ 1、栈先进后出，后进先出。入口和出口在同一侧 2、队列先进先出，入口出口不同侧，队尾进入，队首出来 3、数组查询块，增删慢增删必须要创建新数组 4、链表查询慢，增删块地址不是连续的，每次都必须从头开始查链表结构增');
INSERT INTO `articles` VALUES (63, 27, '18、list集合', '18、list集合.md', 0, 0, '2020-12-10 19:38:47', 0, '18、lit集合------ 1、概述lit接口继承了Collectio， 2、特点1、有序集合，存储元素和取出元素的顺序是一致的2、有索引3、允许存储重复的元素 3、特有方法javavoid add(it idex, E elemet)在');
INSERT INTO `articles` VALUES (64, 27, '19、set集合', '19、set集合.md', 0, 0, '2020-12-10 19:39:34', 0, '19、et集合------ 1、概述et接口是Collectio下的一个子接口，不允许重复，没有索引，不能使用普通fo循环遍历 2、HahSet集合实现了et接口，是一个无序集合，底层是哈希表，查询速度快 2.1、使用HahSetjava/');
INSERT INTO `articles` VALUES (65, 27, '20、Collections工具类', '20、Collections工具类.md', 0, 0, '2020-12-10 19:40:11', 0, '20、Collectio工具类------ 1、Collectio是一个操作数组的工具类 2、addALL方法同时添加多个元素到集合中，静态方法javaCollectio.addAll(lit,\"a\",\"\",\"c\",\"d\",\"e\")第一个参');
INSERT INTO `articles` VALUES (66, 27, '21、map集合', '21、map集合.md', 0, 0, '2020-12-10 19:43:35', 0, '21、ma集合------ 1、概述双列集合，是一个接口，有两个泛型，将键映射到值特点：​	1、双列集合，一个元素包含两个值（键值）​	2、Ma集合中的元素，键和值的数据类型可以相同也可以不同​	3、K不允许重复，Key与value一一对应');
INSERT INTO `articles` VALUES (67, 27, '22、异常', '22、异常.md', 0, 0, '2020-12-10 19:44:04', 0, '22、异常------ 1、异常概念指程序在执行过程中出现的非正常情况，会导致JVM的非正常停止，异常本来是一个类，产生异常就是创建异常对象并抛出。 2、异常体系最高父类thowale，子类eo和excetio 3、异常分类运行期异常、编译');
INSERT INTO `articles` VALUES (68, 28, '23、线程实现', '23、线程实现.md', 1, 0, '2020-12-10 19:45:52', 0, '23、线程实现------ 1、并发与并行并发：指多个事件在同一个时间段内发生（交替）并行：值多个时间在同一时刻发生（同时） 2、进程概念进入到内存的程序叫进程 3、线程概念线程属于进程，是进程的一个执行单元 4、线程调度1、分时调度2、抢');
INSERT INTO `articles` VALUES (69, 28, '24、java线程安全', '24、java线程安全.md', 3, 0, '2020-12-10 19:46:25', 0, '24、线程安全------ 1、线程安全问题概述多个线程在调用同一共享资源时可能会出现访问到不存在的数据或重复访问某个数据的问题 2、解决方法一、同步代码块格式javaychoized(锁对象){	可能出问题的代码}锁对象可以是任意对象，需');
INSERT INTO `articles` VALUES (70, 28, '25、等待唤醒', '25、等待唤醒.md', 0, 0, '2020-12-10 19:47:00', 0, '24、线程安全------ 25、等待唤醒------ 1、线程状态计时等待状态锁阻塞状态**无限等待状态**(调用wait方法等待，等otify方法唤醒) 2、睡眠和唤醒的代码实现java/** * 等待唤醒机制：线程之间的通信 *   ');
INSERT INTO `articles` VALUES (71, 28, '26、线程池', '26、线程池.md', 0, 0, '2020-12-10 19:49:16', 0, '26、线程池------ 1、概述多线程并发时，频繁的创建线程和销毁线程会降低系统效率线程池可以可以使线程执行完不销毁，继续执行别的任务线程池是一个容器，可以使用集合最好使用LikedLitThead集合(可以用别的) 2、实现思路但程序第');
INSERT INTO `articles` VALUES (72, 28, '27、Lambda表达式', '27、Lambda表达式.md', 0, 0, '2020-12-10 19:49:59', 0, '27、lamda表达式------ 1、函数式编程思想只要能获取到结果，谁去做的、怎么做的都不重要，只重视结果，不重视过程 2、lamda的标准格式由三部分组成参数，箭头，代码**格式**java(参数列表) - {重写方法的代码}**解释');
INSERT INTO `articles` VALUES (73, 28, '28、File类', '28、File类.md', 0, 0, '2020-12-10 19:50:33', 0, '28、File类------ 1、概述File类是一个封装了文件和文件夹的类，可以使用file类对文件夹和文件进行操作file类与系统无关，在任何系统下都可正常运作 2、成员变量file类有四个常用的成员变量**路径分隔符**javatat');
INSERT INTO `articles` VALUES (74, 28, '29、递归', '29、递归.md', 0, 0, '2020-12-10 19:51:35', 0, '29、递归------ 1、概述递归是指当前方法调用自己的现象 2、分类**直接递归**：方法直接调用自己**间接递归**：A方法调用B方法，B方法调用C方法，C方法调用A方法 3、注意递归要有条件限定，保证递归可以停下来，否则会栈内存溢出');
INSERT INTO `articles` VALUES (75, 29, '30、过滤器', '30、过滤器.md', 0, 0, '2020-12-10 19:59:31', 0, '30、过滤器------ 1、概述过滤器是用来定义文件查找中过滤方法的接口在File中有两个和LitFile重载的方法，传递的是过滤器 2、方法File[] litFile(FileFilte filte)方法接受一个过滤器，并按过滤器的定');
INSERT INTO `articles` VALUES (76, 29, '31、IO字符流', '31、IO字符流.md', 0, 0, '2020-12-10 20:00:14', 0, '30、过滤器------ 32、IO字符流------ 1、概述以字符形式传输数据，其他与字节流相似 2、输入流ReadeReade是字符输入流的最顶层父类，抽象类方法：javait ead()//读取单个字符并返回it ead(cah[]');
INSERT INTO `articles` VALUES (77, 29, '32、IO字节流', '32、IO字节流.md', 0, 0, '2020-12-10 20:01:11', 0, '30、过滤器------ 32、IO字符流------ 1、概述 31、IO字节流------ 1、概述硬盘的输入输出流**顶层四个父类**|        | 输入流                | 输出流               ');
INSERT INTO `articles` VALUES (78, 29, '33、Properties集合', '33、Properties集合.md', 0, 0, '2020-12-10 20:01:52', 0, '33、Poetie集合------ 1、概述继承了Hahtalek,v imlemet  Mak,vPoetie类表示了一个持久的属性集，Poetie可保存在流中或从流中加载，属性列表中每个键及其对应的值默认都是字符串格式是唯一和IO流相结');
INSERT INTO `articles` VALUES (79, 29, '34、缓冲流', '34、缓冲流.md', 0, 0, '2020-12-10 20:02:28', 0, '34、缓冲流------ 1、字节缓冲输出流BuffeedOututSteam字节缓冲输出流继承了OututSteam 1.1、构造javaBuffeedOututSteam(OututSteam out)// 创建一个新的缓冲输出流，以将');
INSERT INTO `articles` VALUES (80, 29, '35、转换流', '35、转换流.md', 0, 0, '2020-12-10 20:02:59', 0, '35、转换流------ 1、概述是字符与字节的桥梁，将要写入/读取的字符编码成字节主要功能是可以指定字符集 2、OututSteamWite字符通向字节的桥梁，将要写入流中的字符编码成字节 2.1、构造javaOututSteamWite');
INSERT INTO `articles` VALUES (81, 29, '36、序列化流', '36、序列化流.md', 0, 0, '2020-12-10 20:03:36', 0, '36、序列化流------ 1、概述OjectSteam用于将对象以流的形式（字节流）保存到文件中（或从文件中读取对象）将对象存到文件中叫做对象的序列化，读取叫做反序列化 2、OjectOututSteamOjectOututSteam继承');
INSERT INTO `articles` VALUES (82, 29, '37、打印流', '37、打印流.md', 0, 0, '2020-12-10 20:04:09', 0, '37、打印流------ 1、概述PitSteam位于IO包，继承了OututSteam，为其他输出流添加了功能，使他们能够更方便的打印各种数据值表示形式 2、特点只负责数据输出，不负责读取不会抛出IO异常特有方法有it和itl 3、构造j');
INSERT INTO `articles` VALUES (83, 30, '38、网络编程', '38、网络编程.md', 0, 0, '2020-12-10 20:08:50', 0, '38、网络编程------使用Socket类下的方法进行服务端与用户端的设置 1、客户端TCP通信的客户端，向服务器发送链接请求，给服务器发送数据**关键名词**Socket类：实现了客户端的套接字（两台机器的端点）套接字：包含一个流套接字');
INSERT INTO `articles` VALUES (84, 30, '39、常用函数式接口', '39、常用函数式接口.md', 0, 0, '2020-12-10 20:09:25', 0, '39、常用函数式接口------ 1、概述有且只有一个抽象方法的接口可以避免性能浪费一般作为方法的参数和返回值使用lamda表达式有延迟加载的特性例如使用lamda表达式作为参数传递，只有满足条件才会调用方法，如果条件不满足，接口中的方法不');
INSERT INTO `articles` VALUES (85, 30, '40、Stream流式编程', '40、Stream流式编程.md', 0, 0, '2020-12-10 20:10:03', 0, '40、Steam流------ 1、概述类似于流水线，流的数据源可以是集合数组等**有两个特征:**1. Pieliig：中间的操作都返回流对象本身2. 内部迭代：流可以直接调迭代方法(foeach) 2、获取Steam流的两种方式1. 所');
INSERT INTO `articles` VALUES (86, 30, '41、方法引用', '41、方法引用.md', 0, 0, '2020-12-10 20:10:32', 0, '41、方法引用------ 1、概述对lamda表达式的简化双冒号::为引用运算符，而它所在的表达式称为**方法引用**，如果lamda表达式要表达的函数式接口已经存在，要使用的方法也已经存在，这可以用过方法引用来优化lamda的书写 2、');
INSERT INTO `articles` VALUES (87, 30, '42、Junit单元测试', '42、Junit单元测试.md', 1, 0, '2020-12-10 20:11:15', 0, '42、Juit单元测试------ 1、测试分类 1.1、黑盒测试输入一个值，看输出的值是否符合预期，不需要写代码 1.2、白盒测试关注程序运行过程，需要写一些代码 2、Juit使用Juit属于白盒测试**步骤**1. 定义一个测试类（测试');
INSERT INTO `articles` VALUES (88, 30, '43、反射', '43、反射.md', 0, 0, '2020-12-10 20:12:42', 0, '43、反射------ 1、概述框架设计的灵魂将类的各个组成部分封装为其他对象，这就是反射机制可以在程序运行过程中操作这些对象可以解耦，提高程序可拓展性 2、获取Cla对象的三种方式 1、源代码阶段Cla.foame(\'全类名\')，将字节码');
INSERT INTO `articles` VALUES (89, 30, '44、注解', '44、注解.md', 0, 0, '2020-12-10 20:13:28', 0, '44、注解------ 1、概念 1.1、概念说明程序的，给计算机看的 1.2、定义注解也叫元数据，一种代码级别的说明，与类、接口、枚举是同一个层次，可以声明在包、类、字段、方法、局部变量、方法参数等的前面，用来对这些元素进行说明、注释 1');
INSERT INTO `articles` VALUES (90, 30, '45、JDBC', '45、JDBC.md', 0, 0, '2020-12-10 20:14:21', 0, '45、JDBC------ 1、概述java程序操作数据库的方法 2、使用步骤**1、导入驱动ja包**1. 复制包到li目录下2. 右键，add  a  liay加入项目**2、注册驱动**javaCla.foame(\"com.myql.');
INSERT INTO `articles` VALUES (91, 31, '01、MySQL基础知识与查询', '01、MySQL基础知识与查询.md', 0, 0, '2020-12-10 20:19:57', 0, '1、MySQL基础知识与查询------[TOC] 1、基本概念**特点**：1、持久化存储数据的，其实数据库是一个文件系统2、方便存储和管理数据3、使用了统一的方法操作数据库——SQL 2、数据库软件数据库概念的实现 3、MySQL的安装');
INSERT INTO `articles` VALUES (92, 31, '02、MySQL中的约束', '02、MySQL中的约束.md', 0, 0, '2020-12-10 20:20:51', 0, '2、MySQL中的约束------ 1、约束概念对表中数据进行限定，保证数据正确性、有效性和完整性。 2、分类主键约束 imay key非空约束 ot ull 唯一约束 uique外键约束 foeig key 3、非空约束即该列的值不能为空');
INSERT INTO `articles` VALUES (93, 31, '03、MySQL数据表设计，三大范式', '03、MySQL数据表设计，三大范式.md', 0, 0, '2020-12-10 20:21:22', 0, '3、数据库的三大范式------ 数据库的三大设计范式三大范式即三个创建数据表的准则，根据自己的实际需求决定是否遵守即可 1、第一范式，（1NF）数据表中的所有字段都是不可分割的原子值例如一个地址信息，如果全部存在一个字段中就不符合第一范式');
INSERT INTO `articles` VALUES (94, 31, '04、MySQL中的多表操作', '04、MySQL中的多表操作.md', 0, 0, '2020-12-10 20:22:32', 0, '3、MySQL中的多表操作------ 1、多表之间的关系 1.1、一对一如：人和身份证是意义对应的 1.2、一对多(多对一)如：部门和员工 1.3、多对多如：学生和课程 2、关系的实现 2.1、一对多(多对一)使用外键实现在多的一方建立外');
INSERT INTO `articles` VALUES (95, 31, '05、数据库的备份与还原', '05、数据库的备份与还原.md', 0, 0, '2020-12-10 20:23:05', 0, '4、数据库的备份与还原------ 1、备份qlmyqldum -u用户名 -密码 数据库名  保存的路径 2、还原1. 登录数据库2. 创建数据库3. 使用数据库4. 执行文件。ouce 路');
INSERT INTO `articles` VALUES (96, 31, '06、MySQL多表查询', '06、MySQL多表查询.md', 0, 0, '2020-12-10 20:23:48', 0, '5、MySQL多表查询------ 1、概述取出的是笛卡尔积，两张表中所有数据组合情况 2、分类 2.1、内连接需要明确以下内容：1. 从哪些表中查2. 条件是什么3. 查询哪些字段 2.1.1、隐式内连接使用whee条件消除无用数据qle');
INSERT INTO `articles` VALUES (97, 31, '07、视图与索引', '07、视图与索引.md', 0, 0, '2020-12-10 20:24:16', 0, '6、视图与索引------ 1、索引作用：提升查询效率使用：qlceate idex 索引名 o 表名(字段名)do idex 索引名 -- 删除elect * fom 表名 whee 字段=8特点：索引要依赖于某个字段显示的创建，隐式的执');
INSERT INTO `articles` VALUES (98, 31, '08、事务', '08、事务.md', 0, 0, '2020-12-10 20:25:23', 0, '8、事务------ 1、基本介绍 1.1、概念如果一个包含多个步骤的业务操作被事务管理，那这些操作要么同时成功，要么同时失败 1.2、操作1. 开启事务：tat  taactio2. 回滚：ollack3. 提交：commitMySQL数');
INSERT INTO `articles` VALUES (99, 32, '09、DCL', '09、DCL.md', 0, 0, '2020-12-10 20:27:37', 0, '9、DCL------ 1、管理用户 **1、查询用户**1、切换到myql数据库2、查询ue表 2、创建用户qlceate ue \'用户名\'@\'主机名\' idetified y \'密码\'-- %表示任意主机 3、删除用户qldo ue \'');
INSERT INTO `articles` VALUES (100, 32, '10、MySQL变量', '10、MySQL变量.md', 0, 0, '2020-12-10 20:28:22', 0, '10、MySQL变量------ 1、系统变量变量由系统提供，不是用户定义，属于服务器层面**使用语法**1、查看所有的系统变量qlhow gloal vaiale-- 参看所有全局变量how eio vaiale-- 查看所有会话变量，可');
INSERT INTO `articles` VALUES (101, 32, '11、MySQL存储过程', '11、MySQL存储过程.md', 0, 0, '2020-12-10 20:29:07', 0, '11、MySQL存储过程------ 1、存储过程含义：一组预先编译好的SQL语句集合，理解成批处理语句，类似于java中的方法 1.1、语法**创建**qlceate ocedue 存储过程名(参数列表) egi 存储过程体  ed注意：');
INSERT INTO `articles` VALUES (102, 32, '12、函数', '12、函数.md', 0, 0, '2020-12-10 20:29:39', 0, '12、函数------ 1、概述与过程相似，区别在返回值过程可以无返也可以有多个返回函数必须有一个返回，且只有一个过程适合批量插入、更新函数适合处理数据后返回值 2、创建语法qlceate Fuctio 函数名(参数列表) etu 返回类型');
INSERT INTO `articles` VALUES (103, 32, '13、流程控制', '13、流程控制.md', 0, 0, '2020-12-10 20:30:14', 0, '13、流程控制------ 1、if函数相当于三元运算符语法qlelect if(表达式1,表达式2，表达式3)表达式1为tue则返回表达式2的值，反之返回表达式3的值 2、cae结构 2.1、类似java中的witch语法qlcae 变量');
INSERT INTO `articles` VALUES (104, 32, '14、触发器', '14、触发器.md', 0, 0, '2020-12-10 20:30:46', 0, '14、触发器------ 1、概述触发器是一种与表操作有关的数据库对象，当触发器所在表上出现指定事件时，将调用该对象，即表的操作事件触发表上触发器的执行 2、创建ceate tigge 触发器名触发时机 取值为efoe或afte触发事件 取');
INSERT INTO `articles` VALUES (105, 24, 'Bootstrap', 'Bootstrap.md', 0, 0, '2020-12-10 20:36:52', 0, '1、概述一个前端开发的框架​	**框架**：一个半成品软件，开发人员可以在框架基础上二次开发，可以简化编码​	**好处**：1. 定义了很多c样式和j插件，开发人员可以直接使用这些样式和插件得到丰富的页面效果2. 响应式布局，同一套页面可以');
INSERT INTO `articles` VALUES (106, 24, '01、JavaScript简介', '01、JavaScript简介.md', 0, 0, '2020-12-10 20:37:38', 0, '1、JavaScit简介------ 1、JavaScit简介**概念**：一门客户端脚本语言​	运行在客户端浏览器中​	脚本语言不需要编译，直接可以被浏览器解析执行**功能**：​	可以增强用户和HTML页面的交互，可以控制HTML元素，');
INSERT INTO `articles` VALUES (107, 24, '02、常用内置对象', '02、常用内置对象.md', 0, 0, '2020-12-10 20:38:11', 0, '2、常用内置对象------ 1、fuctio对象描述方法1、创建：1. ​	va fu = ew Fuctio(形参表，方法体)2. fuctio 方法名称(形参表){方法体}3. va 方法名 = fuctio(){}2、方法3、属性​');
INSERT INTO `articles` VALUES (108, 24, '03、BOM对象', '03、BOM对象.md', 0, 0, '2020-12-10 20:38:41', 0, '3、BOM对象------ BOM简介功能：控制HTML文档的内容代码：获取页面的标签（元素）对象Elemetjavacitdocumet.getElemetById(\"Id值\")操作Elemet对象：1. 设置属性值：明确获取的对象是哪一');
INSERT INTO `articles` VALUES (109, 24, '04、DOM对象', '04、DOM对象.md', 0, 0, '2020-12-10 20:39:08', 0, '4、DOM对象------ 1、概念Documet oject  model 文档对象模型将标记语言文档的各个组成部分，封装为对象，可以使用这些对象，对标记语言文档进行CRUD操作 2、核心DOM1. Documet：文档对象2. Elem');
INSERT INTO `articles` VALUES (110, 24, '05、事件', '05、事件.md', 0, 0, '2020-12-10 20:39:44', 0, '5、事件------ 1、概述某些组件被执行了某些操作后，触发某些代码的执行 事件源组件，按钮，输入框 监听器代码 注册监听将事件，事件源，监听器结合在一起，当事件源上发生了某个事件，就触发某个监听器代码 2、常见事件 2.1、点击事件oc');
INSERT INTO `articles` VALUES (111, 24, 'python学习笔记（六）抽象', 'python学习笔记（六）抽象.md', 0, 0, '2020-12-10 20:40:47', 0, '六、抽象（函数）在大型项目中，经常有一些功能要重复使用，为了编程的效率，不可能每使用一次就要写一次相关代码。而应该把这些代码写成函数，使用时调用即可。 1、自定义函数使用def来定义函数def hello(ame):	etu \'Hello,');
INSERT INTO `articles` VALUES (112, 33, '二、列表和元组', '二、列表和元组.md', 0, 0, '2020-12-10 20:43:36', 0, '二、列表和元组 1、序列概述ytho内置了多种序列，本章重点讨论其中最常用的两种：**列表**和**元组**。另一种重要的序列是字符串。列表和元组主要的不同在于，列表是可以修改的，而元组不行。所以列表适用于需要中途添加元素的情况，而元组适用');
INSERT INTO `articles` VALUES (113, 33, '三、使用字符串', '三、使用字符串.md', 0, 0, '2020-12-10 20:44:12', 0, '三、使用字符串 1、字符串基本操作所有的标准序列操作都适用于字符串，但是字符串不可变，所以不可以给字符串赋值。 2、设置字符串的格式 替换字段名在最简单的情况下，只需向fomat提供要设置其格式的未命名参数，并在格式字符串中使用未命名字段。');
INSERT INTO `articles` VALUES (114, 33, '四、字典', '四、字典.md', 0, 0, '2020-12-10 20:44:50', 0, '四、字典 1、字典的用途字典通过键值对来存储数据，经常用来储存有关联的几组数据。在需要处理较多数据时用的很频繁 2、创建和使用字典字典通过以下方式创建ythohoeook = {\'Alice\':\'2341\',\'Beth\':\'9102\',\'C');
INSERT INTO `articles` VALUES (115, 33, '五、条件、循环及其他语句', '五、条件、循环及其他语句.md', 0, 0, '2020-12-10 20:45:21', 0, '五、条件、循环及其他语句 1、再谈it和imot 1.1、打印多个参数it不仅可以打印一个表达式，还可以同时打印多个表达式，条件是用逗号分隔。ytho it(\'Age:\',42)Age: 42如你所见，打印后的两个参数之间有一个空格。在你要');
INSERT INTO `articles` VALUES (116, 33, '一、基础知识', '一、基础知识.md', 0, 0, '2020-12-10 20:45:56', 0, '一、基础知识本文主要介绍ytho开始学习应该掌握的一些基础知识。 1、算法算法即解决一个问题的方法，由一系列必须按照顺序执行的操作说明组成，其中有些可以直接完成，有些需要特别注意，还有一些粗腰重复多次。 2、数和表达式交互式ytho解释器可');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `user_id` bigint(0) NOT NULL COMMENT '发表用户ID',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `article_id` bigint(0) NOT NULL COMMENT '评论博文ID',
  `article_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被评论的博文名字',
  `comment_date` datetime(0) NULL DEFAULT NULL COMMENT '评论日期',
  `comment_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `article_id`(`article_id`) USING BTREE,
  INDEX `comment_date`(`comment_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (7, 2, 'loginTest', 27, NULL, '2020-12-09 22:28:35', '评论');
INSERT INTO `comments` VALUES (11, 3, 'login', 32, NULL, '2020-12-10 19:10:07', '评论');
INSERT INTO `comments` VALUES (12, 2, 'loginTest', 27, NULL, '2020-12-10 19:11:37', '456');
INSERT INTO `comments` VALUES (13, 3, 'login', 32, NULL, '2020-12-10 19:26:57', '678');
INSERT INTO `comments` VALUES (14, 2, 'loginTest', 32, NULL, '2020-12-10 19:29:17', '789');
INSERT INTO `comments` VALUES (15, 2, 'loginTest', 27, 'EL', '2020-12-10 20:34:16', 'test');
INSERT INTO `comments` VALUES (16, 2, 'loginTest', 27, 'EL', '2020-12-10 20:38:07', '123456');

-- ----------------------------
-- Table structure for labels
-- ----------------------------
DROP TABLE IF EXISTS `labels`;
CREATE TABLE `labels`  (
  `label_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `label_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名称',
  `label_alias` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签别名',
  `label_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签描述',
  PRIMARY KEY (`label_id`) USING BTREE,
  INDEX `label_name`(`label_name`) USING BTREE,
  INDEX `label_alias`(`label_alias`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for set_artitle_label
-- ----------------------------
DROP TABLE IF EXISTS `set_artitle_label`;
CREATE TABLE `set_artitle_label`  (
  `article_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `label_id` bigint(0) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`article_id`) USING BTREE,
  INDEX `label_id`(`label_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for set_artitle_sort
-- ----------------------------
DROP TABLE IF EXISTS `set_artitle_sort`;
CREATE TABLE `set_artitle_sort`  (
  `article_id` bigint(0) NOT NULL COMMENT '文章ID',
  `sort_id` bigint(0) NOT NULL COMMENT '分类ID',
  PRIMARY KEY (`article_id`, `sort_id`) USING BTREE,
  INDEX `sort_id`(`sort_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sorts
-- ----------------------------
DROP TABLE IF EXISTS `sorts`;
CREATE TABLE `sorts`  (
  `sort_id` bigint(0) NOT NULL COMMENT '分类ID',
  `sort_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `sort_alias` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类别名',
  `sort_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类描述',
  `parent_sort_id` bigint(0) NOT NULL COMMENT '父分类ID',
  PRIMARY KEY (`sort_id`) USING BTREE,
  INDEX `sort_name`(`sort_name`) USING BTREE,
  INDEX `sort_alias`(`sort_alias`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_friends
-- ----------------------------
DROP TABLE IF EXISTS `user_friends`;
CREATE TABLE `user_friends`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `user_friends_id` bigint(0) NOT NULL COMMENT '好友ID',
  `user_note` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '好友备注',
  `user_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '好友状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `user_password` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `user_profile_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `user_registration_time` datetime(0) NULL DEFAULT NULL COMMENT '注册时间',
  `user_birthday` date NULL DEFAULT NULL COMMENT '用户生日',
  `user_age` tinyint(0) NULL DEFAULT NULL COMMENT '用户年龄',
  `user_telephone_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户手机号',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE,
  INDEX `user_telephone_number`(`user_telephone_number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (2, 'loginTest', '456', 'loginTest.jpg', NULL, NULL, 18, '123456');
INSERT INTO `users` VALUES (3, 'login', '456', NULL, NULL, '3895-02-17', 5, '15270696715');
INSERT INTO `users` VALUES (23, '王', '123456', NULL, '2020-12-08 22:00:13', '1995-01-17', 0, '123456');
INSERT INTO `users` VALUES (24, 'XikX', '123456', NULL, '2020-12-10 10:47:40', '2000-02-25', 0, '15970984655');
INSERT INTO `users` VALUES (25, '张三丰', '123456', NULL, '2020-12-10 10:50:22', '1998-04-13', 0, '15270696715');
INSERT INTO `users` VALUES (26, '夏书童', '123456', NULL, '2020-12-10 19:00:59', '2001-02-12', 0, '18270648268');
INSERT INTO `users` VALUES (27, '熊麟', '123456', NULL, '2020-12-10 19:08:42', '2001-02-12', 0, '12345678910');
INSERT INTO `users` VALUES (28, '王健帆', '123456', NULL, '2020-12-10 19:14:06', '2001-02-12', 0, '12345678910');
INSERT INTO `users` VALUES (29, '汤运', '123456', NULL, '2020-12-10 19:58:22', '1995-01-17', 0, '15970514455');
INSERT INTO `users` VALUES (30, '童金燕', '123456', NULL, '2020-12-10 20:06:04', '2001-01-01', 0, '12345678910');
INSERT INTO `users` VALUES (31, '丁毅凡', '123456', NULL, '2020-12-10 20:15:35', '2001-01-01', 0, '12345678910');
INSERT INTO `users` VALUES (32, '蔡秋淼', '123456', NULL, '2020-12-10 20:26:11', '2001-01-01', 0, '12345678910');
INSERT INTO `users` VALUES (33, '栀子', '123456', NULL, '2020-12-10 20:42:31', '1995-01-17', 0, '15978523545');

SET FOREIGN_KEY_CHECKS = 1;
