本文将会讲到5G和HTTP。曾经在<a href="https://www.cnblogs.com/confach/p/10050437.html" target="_blank">深入浅出经典面试题：从浏览器中输入URL到页面加载发生了什么 - Part 3</a> 提到为什么有些RPC框架不选用HTTP，而5G会采用HTTP。
您可以从本文里获取到一些概念：5G用HTTP作为reference point interface的实现，HTTP/2，RESTful API/HATEOAS/OpenAPI等最佳实践和标准，这些都是一些常见但是又容易忽略的知识点。
本文参考了一些文章，见文章末尾的链接列表。
## **HTTP的优点和缺点**
我们大家知道HTTP协议包含的信息太多，太繁重，导致消息体会很大，但是其中有一些消息根本用不上，这也是为什么HTTP/1.1消息效率不高的原因，所以一些RPC框架舍弃它，例如dubbo定义自己的协议等，如果大家定义过协议，例如类似TCP协议，就能明白协议定义的重要性。如果要效率高，消息短，那就会太底层，如TCP，如果要想易于理解，例如HTTP，那就得长一些。
## **5G和HTTP**
5G明年试商用，在5G里采用HTTP协议，确实有意思。可以参看TS 29.501协议&nbsp;5G System;Principles and Guidelines for Services Definition，Stage 3。先看看下图：
<img src="https://img2018.cnblogs.com/blog/1249/201812/1249-20181212150011785-1319115377.png" alt="" width="956" height="453">
在通信领域，由原来的Diameter，AAA等转变为HTTP，的确是一个大变化，但是开发的效率将会大大提高。
那么5G将会应用到什么HTTP相关技术呢？
<ol>
- HTTP/2/0 （协议下载https://http2.github.io/http2-spec/）
- JSON
- HATEOAS
- RESTful
- OpenAPI
</ol>
## **HTTP/2.0**
还是先看看HTTP/2吧。谈到HTTP/2，最先想到Google的SPDY，它是HTTP/2的前身。为什么Google要做SPDY呢？原因很简单，HTTP的效率不高。自从有了SPDY后，加载时间减少64%（http://dev.chromium.org/spdy/spdy-whitepaper），原话这么说的， In lab tests, we have compared the performance of these applications over HTTP and SPDY, and have observed up to 64% reductions in page load times in SPDY.
SPDY并不用于取代HTTP，它只是修改了HTTP的请求与应答在网络上传输的方式；这意味着只需增加一个SPDY传输层，现有的所有服务端应用均不用做任何修改。 当使用SPDY的方式传输，HTTP请求会被处理、标记简化和压缩。比如，每一个SPDY端点会持续跟踪每一个在之前的请求中已经发送的HTTP报文头部，从而避免重复发送还未改变的头部。而还未发送的报文的数据部分将在被压缩后被发送。
HTTP/2主要特性包括：
&nbsp;
**二进制协议**
HTTP/1.1 版的头信息肯定是文本（ASCII编码），数据体可以是文本，也可以是二进制。HTTP/2 则是一个彻底的二进制协议，头信息和数据体都是二进制，并且统称为"帧"（frame）：头信息帧和数据帧。
二进制协议的一个好处是，可以定义额外的帧。HTTP/2 定义了近十种帧，为将来的高级应用打好了基础。如果使用文本实现这种功能，解析数据将会变得非常麻烦，二进制解析则方便得多。
&nbsp;
**多工**
HTTP/2 复用TCP连接，在一个连接里，客户端和浏览器都可以同时发送多个请求或回应，而且不用按照顺序一一对应，这样就避免了"队头堵塞"。
举例来说，在一个TCP连接里面，服务器同时收到了A请求和B请求，于是先回应A请求，结果发现处理过程非常耗时，于是就发送A请求已经处理好的部分， 接着回应B请求，完成后，再发送A请求剩下的部分。
这样双向的、实时的通信，就叫做多工（Multiplexing）。
&nbsp;
**数据流**
因为 HTTP/2 的数据包是不按顺序发送的，同一个连接里面连续的数据包，可能属于不同的回应。因此，必须要对数据包做标记，指出它属于哪个回应。
HTTP/2 将每个请求或回应的所有数据包，称为一个数据流（stream）。每个数据流都有一个独一无二的编号。数据包发送的时候，都必须标记数据流ID，用来区分它属于哪个数据流。另外还规定，客户端发出的数据流，ID一律为奇数，服务器发出的，ID为偶数。
数据流发送到一半的时候，客户端和服务器都可以发送信号（`RST_STREAM`帧），取消这个数据流。1.1版取消数据流的唯一方法，就是关闭TCP连接。这就是说，HTTP/2 可以取消某一次请求，同时保证TCP连接还打开着，可以被其他请求使用。
客户端还可以指定数据流的优先级。优先级越高，服务器就会越早回应。
&nbsp;
**头信息压缩**
HTTP 协议不带有状态，每次请求都必须附上所有信息。所以，请求的很多字段都是重复的，比如`Cookie`和`User Agent`，一模一样的内容，每次请求都必须附带，这会浪费很多带宽，也影响速度。
HTTP/2 对这一点做了优化，引入了头信息压缩机制（header compression）。一方面，头信息使用`gzip`或`compress`压缩后再发送；另一方面，客户端和服务器同时维护一张头信息表，所有字段都会存入这个表，生成一个索引号，以后就不发送同样字段了，只发送索引号，这样就提高速度了。
&nbsp;
**服务器推送**
HTTP/2 允许服务器未经请求，主动向客户端发送资源，这叫做服务器推送（server push）。
常见场景是客户端请求一个网页，这个网页里面包含很多静态资源。正常情况下，客户端必须收到网页后，解析HTML源码，发现有静态资源，再发出静态资源请求。其实，服务器可以预期到客户端请求网页后，很可能会再请求静态资源，所以就主动把这些静态资源随着网页一起发给客户端了。&nbsp;
**我给自己挖个坑，后面专门出一篇文章写HTTP/2.**
## HATEOAS 约束
HATEOAS（Hypermedia as the engine of application state）是 REST 架构风格中最复杂的约束，也是构建成熟 REST 服务的核心。它的重要性在于打破了客户端和服务器之间严格的契约，使得客户端可以更加智能和自适应，而 REST 服务本身的演化和更新也变得更加容易。
在介绍 HATEOAS 之前，先介绍一下 Richardson 提出的 REST 成熟度模型。该模型把 REST 服务按照成熟度划分成 4 个层次：（这个可以参考Richardson的成熟度模型，见后文链接）

- 第一个层次（Level 0）的 Web 服务只是使用 HTTP 作为传输方式，实际上只是远程方法调用（RPC）的一种具体形式。SOAP 和 XML-RPC 都属于此类。
- 第二个层次（Level 1）的 Web 服务引入了资源的概念。每个资源有对应的标识符和表达。
- 第三个层次（Level 2）的 Web 服务使用不同的 HTTP 方法来进行不同的操作，并且使用 HTTP 状态码来表示不同的结果。如 HTTP GET 方法来获取资源，HTTP DELETE 方法来删除资源。
- 第四个层次（Level 3）的 Web 服务使用 HATEOAS。在资源的表达中包含了链接信息。客户端可以根据链接来发现可以执行的动作。

从上述 REST 成熟度模型中可以看到，使用 HATEOAS 的 REST 服务是成熟度最高的，也是推荐的做法。对于不使用 HATEOAS 的 REST 服务，客户端和服务器的实现之间是紧密耦合的。客户端需要根据服务器提供的相关文档来了解所暴露的资源和对应的操作。当服务器发生了变化时，如修改了资源的 URI，客户端也需要进行相应的修改。而使用 HATEOAS 的 REST 服务中，客户端可以通过服务器提供的资源的表达来智能地发现可以执行的操作。当服务器发生了变化时，客户端并不需要做出修改，因为资源的 URI 和其他信息都是动态发现的。
所以我们可以看到HATEOAS可以降低客户端和服务器之间的耦合。
我们看看在Spring官网上的例子。
下面是一个类&nbsp;`Customer`.

class Customer {
    String name;
}
```
一个传统的例子是:

{ 
    "name" : "Alice"
}
```
如果变成HATEOAS风格的，可以是下面这样：

{
    "name": "Alice",
    "links": [ {
        "rel": "self",
        "href": "http://localhost:8080/customer/1"
    } ]
}
```
我们可以看到，不仅有了name，还多了一个links. links下的rel的值是self，意思就是说指向当前资源的链接。
关于ref的值，可以参考下表：
<table id="DataTables_Table_0" style="margin-left: 30px">
<thead style="margin-left: 30px">
<tr style="margin-left: 30px"><th class="ibm-background-neutral-white-30 sorting_disabled" style="margin-left: 30px" rowspan="1" colspan="1">rel 属性值</th><th class="ibm-background-neutral-white-30 sorting_disabled" style="margin-left: 30px" rowspan="1" colspan="1">描述</th></tr>
</thead>
<tbody style="margin-left: 30px">
<tr class="odd" style="margin-left: 30px">
<td style="margin-left: 30px">self</td>
<td style="margin-left: 30px">指向当前资源本身的链接的 rel 属性。每个资源的表达中都应该包含此关系的链接。</td>
</tr>
<tr class="even" style="margin-left: 30px">
<td style="margin-left: 30px">edit</td>
<td style="margin-left: 30px">指向一个可以编辑当前资源的链接。</td>
</tr>
<tr class="odd" style="margin-left: 30px">
<td style="margin-left: 30px">item</td>
<td style="margin-left: 30px">如果当前资源表示的是一个集合，则用来指向该集合中的单个资源。</td>
</tr>
<tr class="even" style="margin-left: 30px">
<td style="margin-left: 30px">collection</td>
<td style="margin-left: 30px">如果当前资源包含在某个集合中，则用来指向包含该资源的集合。</td>
</tr>
<tr class="odd" style="margin-left: 30px">
<td style="margin-left: 30px">related</td>
<td style="margin-left: 30px">指向一个与当前资源相关的资源。</td>
</tr>
<tr class="even" style="margin-left: 30px">
<td style="margin-left: 30px">search</td>
<td style="margin-left: 30px">指向一个可以搜索当前资源及其相关资源的链接。</td>
</tr>
<tr class="odd" style="margin-left: 30px">
<td style="margin-left: 30px">first、last、previous、next</td>
<td style="margin-left: 30px">这几个 rel 属性值都有集合中的遍历相关，分别用来指向集合中的第一个、最后一个、上一个和下一个资源。</td>
</tr>
</tbody>
</table>
&nbsp;根据以上，我们可以清楚的看出根据rel不同的类型有不同的用处，这样客户端可以智能的进行不同的操作，达到解耦的目的。
## OpenAPI
其实RESTful API都是和OpenAPI相关的，为什么会把OpenAPI单独拿出来说？原理很简单，那是因为现在很多API的定义，包括一些大厂的，都做的不是很好。RESTful API设计的最佳实践文档就在这里，但是大部分人还是没有去遵守。关于RESTful API文档，建议去参考微软的文章（&nbsp;&nbsp;https://docs.microsoft.com/en-us/azure/architecture/best-practices/api-design）。那么OpenAPI是干什么的？说白了就是为了RESTful API，定义了一个标准，让我们和机器不用再去查看源代码、文档，甚至不用像我前面文件里抓包那样，去了解API的定义。&nbsp;
最典型的例子还是Swagger。Swagger的Editor等产品是支持OpenAPI的，总的来说，Open API的那些标准不是太难，因为现成的例子供参考。关键是如果利用这些将自己的产品变得更加标准，这是很重要的策略和思路。我原来在这个上面花了很多时间引入到项目里，我觉得是值的，一个是让产品规范了，有质的保证，二是让自己和同事的思维提高了。
&nbsp;
总的来说，这篇文章简单介绍了5G和HTTP的关系，以及HTTP里用到RESTful API，HTTP/2等技术，这和以前通信领域是不一样的。
参考文章：

- <a href="https://www.ibm.com/developerworks/cn/java/j-lo-SpringHATEOAS/%20" target="_blank">https://www.ibm.com/developerworks/cn/java/j-lo-SpringHATEOAS/&nbsp;</a>
- <a href="https://spring.io/understanding/HATEOAS" target="_blank">https://spring.io/understanding/HATEOAS</a>
- <a href="https://http2.github.io/http2-spec/" target="_blank">https://http2.github.io/http2-spec/</a>
- <a href="https://martinfowler.com/articles/richardsonMaturityModel.html" target="_blank">https://martinfowler.com/articles/richardsonMaturityModel.html</a>
- <a href="http://www.ruanyifeng.com/blog/2016/08/http.html" target="_blank">http://www.ruanyifeng.com/blog/2016/08/http.html</a>
- <a href="https://docs.microsoft.com/en-us/azure/architecture/best-practices/api-design" target="_blank">https://docs.microsoft.com/en-us/azure/architecture/best-practices/api-design</a>
- <a href="https://www.openapis.org/" target="_blank">https://www.openapis.org/</a>
- <a href="http://dev.chromium.org/spdy/spdy-whitepaper" target="_blank">http://dev.chromium.org/spdy/spdy-whitepaper</a>
- <a href="https://www.etsi.org/deliver/etsi_ts/129500_129599/129501/15.00.01_60/ts_129501v150001p.pdf" target="_blank">https://www.etsi.org/deliver/etsi_ts/129500_129599/129501/15.00.01_60/ts_129501v150001p.pdf</a>

<style>p.p1 { margin: 0; font: 11px Times }</style>
<style>p.p1 { margin: 0; font: 17px Helvetica }</style>