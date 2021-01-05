目录[-]


- <a href="http://my.oschina.net/u/1020238/blog/519767#OSC_h3_1">1、三层架构</a>
- <a href="http://my.oschina.net/u/1020238/blog/519767#OSC_h3_2">2、MVC</a>
- <a href="http://my.oschina.net/u/1020238/blog/519767#OSC_h4_3">2.1 标准的MVC（Model-View-Controller）</a>
- <a href="http://my.oschina.net/u/1020238/blog/519767#OSC_h4_4">2.2 Web MVC</a>
- <a href="http://my.oschina.net/u/1020238/blog/519767#OSC_h3_5">3、三层架构和MVC的区别与联系</a>

```

### 1、三层架构
三层架构(3-tier application) 通常意义上的三层架构就是将整个业务应用划分为：表现层（UI）、业务逻辑层（BLL）、数据访问层（DAL）。区分层次的目的即为了“高内聚，低耦合”的思想。
1、表现层（UI）：通俗讲就是展现给用户的界面，即用户在使用一个系统的时候他的所见所得。&nbsp;
2、业务逻辑层（BLL）：针对具体问题的操作，也可以说是对数据层的操作，对数据业务逻辑处理。&nbsp;
3、数据访问层（DAL）：该层所做事务直接操作数据库，针对数据的增添、删除、修改、更新、查找等。&nbsp;
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;表现层实现的代表作品是Struts框架，业务层实现的代表作品是Spring，持久层实现的代表作品是Hibernate。&nbsp;
举个例子：
持久层从持久库中取出-10。
业务层按照一定的逻辑（这里我们举例取温度的逻辑）翻译成-10摄氏度。
表示层显现给用户“哎呀，今天好冷！”。
层就相当于一个黑盒子，我们不用知道它内部怎么实现，只需要知道如何去调用它就行了。每层只与上下相邻的两层打交道。当一层内部由于技术变迁发生变化时，只要接口不变，其他层不用做任何改变。分层之后灵活性提高，也便于团队分工开发。
&nbsp;
### 2、MVC
#### 2.1 标准的MVC（Model-View-Controller）
<a href="http://static.oschina.net/uploads/img/201601/26185156_T7CF.jpg" target="_blank"><img src="http://static.oschina.net/uploads/img/201601/26185156_T7CF.jpg" alt="这里写图片描述"></a>

- 
Model（模型）：数据模型，提供要展示的数据，因此包含数据和行为，可以认为是领域模型(domain)或JavaBean组件（包含数据和行为），不过现在一般都分离开来：Value Object（数据） 和 服务层（行为）。也就是模型提供了模型数据查询和模型数据的状态更新等功能，包括数据和业务。

- 
View（视图）：负责进行模型的展示，一般就是我们见到的用户界面，客户想看到的东西。

- 
Controller（控制器）：接收用户请求，委托给模型进行处理（状态改变），处理完毕后把返回的模型数据返回给视图，由视图负责展示。 也就是说控制器做了个调度员的工作。


　　从图中我们还看到，在标准的MVC中模型能主动推数据给视图进行更新（观察者设计模式，在模型上注册视图，当模型更新时自动更新视图），但在Web开发中模型是无法主动推给视图（无法主动更新用户界面），因为在Web开发是请求-响应模型。
#### 2.2 Web MVC
Web MVC中的M(模型)-V(视图)-C(控制器)概念和标准MVC概念一样，我们再看一下Web MVC标准架构，如下图所示：
<a href="http://static.oschina.net/uploads/img/201601/26185156_co9w.jpg" target="_blank"><img src="http://static.oschina.net/uploads/img/201601/26185156_co9w.jpg" alt="这里写图片描述"></a>
在Web MVC模式下，模型无法主动推数据给视图，如果用户想要视图更新，需要再发送一次请求（即请求-响应模型）。
&nbsp;
M：(Model) &nbsp;模型 &nbsp;: &nbsp;应用程序的核心功能，管理这个模块中用的数据和值；
V(View )视图: &nbsp; 视图提供模型的展示，管理模型如何显示给用户，它是应用程序的外观；
C(Controller)控制器: 对用户的输入做出反应，管理用户和视图的交互，是连接模型和视图的枢纽。
MVC用于将web（UI）层进行职责解耦
&nbsp;
### 3、三层架构和MVC的区别与联系
&nbsp;&nbsp;&nbsp;&nbsp;MVC是 Model-View-Controller，严格说这三个加起来以后才是三层架构中的UI层，也就是说，MVC把三层架构中的UI层再度进行了分化，分成了控制器、视图、实体三个部分，控制器完成页面逻辑，通过实体来与界面层完成通话；而C层直接与三层中的BLL进行对话。
&nbsp;
MVC可以是三层中的一个表现层框架，属于表现层。三层和mvc可以共存。
三层是基于业务逻辑来分的，而MVC是基于页面来分的。
MVC主要用于表现层，3层主要用于体系架构，3层一般是表现层、中间层、数据层，其中表现层又可以分成M、V、C，(Model View Controller)模型－视图－控制器&nbsp;
&nbsp;
MVC是表现模式（Presentation Pattern）
三层架构是典型的架构模式（Architecture Pattern）
三层架构的分层模式是典型的上下关系，上层依赖于下层。但MVC作为表现模式是不存在上下关系的，而是相互协作关系。即使将MVC当作架构模式，也不是分层模式。MVC和三层架构基本没有可比性，是应用于不同领域的技术。
```