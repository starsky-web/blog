www.cnblogs.com/lingyunhu/p/3621057.html
&nbsp;


前面介绍了WebRTCDemo的基本结构，本节主要介绍WebRTC音视频服务端的处理，，转载请说明出处（博客园RTC.Blacker）。
&nbsp;
通过前面的例子我们知道运行WebRTCDemo即可看到P2P的效果，实际应用中我们不可能让用户自己去里面设置对方的IP和音视频端口，
而且即使设置了对方的IP和端口也不一定能运行起来，因为P2P如果双方不在同一个网段则还需穿透NAT，那服务端具体该如何部署呢？
&nbsp;
1、信令服务：
想知道信令服务的作用前您先想想通讯双方彼此都不知道对方在哪里，怎么与对方建立连接，怎么给对方发起视频请求？
想到这里我们是不是会想到双方都应该先跟一个服务器建立连接，所以这就是信令服务的作用，具体如下图：
<img src="https://images0.cnblogs.com/blog/77236/201501/250858193139007.png" alt="">
2、打洞服务：打洞的原理理解了其实很简单，主要思路就是通过STUN服务器获取自己的ip,port及NAT信息，
然后通过信令服务器交换这些信息,最后两客户端根据各自得到的ip,port,NAT信息进行相应的穿透，
现在开源STUN代码很多，网上也有很多介绍这方面的问题，有兴趣的可以找相关资料看看.
补充:不过对NAT进步一研究你会发现内网下多重NAT穿透是个比较麻烦的事情，网上有一些专门研究多层NAT穿透的论文,
正因为STUN方式不能完全解决P2P问题,所以后面出现了ICE,而libjingle就是ICE思想的具体实现。
<img src="https://images0.cnblogs.com/blog/77236/201501/250911048442049.png" alt="">
&nbsp;
&nbsp;
3、媒体转发服务：P2P失败时，客户端先将RTP包发给媒体服务，然后再通过服务器转发给对方，
实际上很多视频会议都是这么实现的,在多人视频通讯的情况下如果都通过P2P来实现则会给客户端带来很大的压力,
特别是手机端负载有限的情况下,这宗点点的转发方式的弊端尤为明显,但如果通过RelayServer,客户端压力可大大减轻。&nbsp;
补充：如果要考虑多人视频，直播，如三方会议同时广播给几千人观看，这就设置到服务端的编解码，混音，屏幕叠加等等功能，
这是一个比较负责的课题，也是语音通信厂商的核心技术，后面会整理一篇文章专门介绍这方面的内容。
<img src="https://images0.cnblogs.com/blog/77236/201501/250928421722836.png" alt="">
本篇文章主要介绍webrtc里面的stun,turn服务的安装与配置(转载请说明出处: http://www.cnblogs.com/lingyunhu, RTC.Blacker)
说到STUN,TURN服务的作用,相信很多人都知道,主要处理打洞与转发,配合完成ICE协议.但很多人不知道该怎么搭建.
其实不会搭建关键是不熟悉linux或没接触过linux,如果熟悉linux再仔细阅读相关文档,应该不难完成这个过程.
&nbsp;
linux有很多版本,本文主要介绍在ubuntu14上的搭建过程:
1.$ wget http://turnserver.open-sys.org/downloads/v<......>/turnserver-<......>.tar.gz&nbsp;
2.$&nbsp;tar xvfz turnserver-<...>.tar.gz
3.$ cd turnserver-<...>
4.$ sudo apt-get update
5.$ sudo apt-get install gdebi-core
6.$ sudo gdebi coturn*.deb
7.$ turnadmin -a -b -u username -r example.org -p password
8.$ turnserver.conf external-ip=*.*.*.*
9.$ turnserver -c -b -u username -r example.org -p password -a -f -v &nbsp;&nbsp;
10. http://*.*.*.*:3478 返回TURN Server
&nbsp;
以上10个步骤就完成了stun,turn服务的安装与配置,接下来就是客户端脚本中的配置(*.*.*.*代表自己的IP):
```python
1 iceServers: [
2                   {"url": "stun:*.*.*.*},<br>3       　　　　　　  {"url":"turn:*.*.*.*","credential":"username","username":"password"}
4             ]
5         
```
&nbsp;
最后:
1,stun和turn服务不仅仅可以用在webrtc里面还可以用在其他地方,当然了webrtc要实现打洞与转发你也可以自己去实现.
2,有人会问在客户端JS里面就可以直接看到username和password,会不会不安全?答案是肯定的,怎么解决呢?如有兴趣请继续关注.
&nbsp;
以上,如果错误和遗漏,请纠正与补充,不胜感激! RTC.Blacker.
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
下面这篇介绍webrtc的文章不错,我花了大半天翻译了一下.
翻译的时候不是逐字逐句的，而是按照自己的理解翻译的,同时为了便于理解,也加入一些自己组织的语言.
&nbsp;
本文主要介绍webrtc的信令,stun,turn，转载请说明出处（博客园RTC.Blacker）.
英文来自:http://www.html5rocks.com/en/tutorials/webrtc/infrastructure/&nbsp;
&nbsp;
WEBRTC支持点对点通讯,但是WEBRTC仍然需要服务端,因为:
1,为了协调通讯过程客户端之间需要交换元数据,如一个客户端找到另一个客户端以及通知另一个客户端开始通讯.
2,需要处理NAT或防火墙,这是公网上通讯首要处理的问题.
在这篇文章里我们将告诉您怎么创建一个信令服 务,怎么处理现实世界中两个客户端的连接,以及怎么处理多方通话和怎么与VOIP,PSTN的交互.如果您不了解webrtc,建议您读这篇文章前先 看:http://www.html5rocks.com/en/tutorials/webrtc/basics/
&nbsp;
**什么是信令?**
信令就是协调通讯的过程,为了建立一个webrtc的通讯过程,客户端需要交换如下信息:
1,会话控制消息:用来开始和结束通话(即开始视频,结束视频这些操作指令)
2,处理错误的消息.
3,元数据:如各自的音视频编解码方式,带宽.
4,网络数据:对方的公网IP,端口,内网IP,端口.
5,......
信令处理过程需要客户端能够来回传递消息,这个过程在webrtc里面是没有实现的,需要您自己创建,下面我们会告诉您怎么创建这样一个过程.
&nbsp;
为什么WEBRTC没有定义信令处理?
为了避免重复定义和最大程度兼容现有技术,JSEP(<a href="http://tools.ietf.org/html/draft-ietf-rtcweb-jsep-03#section-1.1">JavaScript Session Establishment Protocol</a>)上已有概述.
现有的SIP协议就可以较好地处理整个信令过程,另外不同的应用程序可能对信令处理有特别的要求,如我们做的很多项目信令处理都是自己写的,很灵活.
其实只要你能满足你自己的业务需求,信令处理你完全可以自己定义,实现起来也不难,就是客户端和服务端怎么通讯而已,用得最广的就是websocket了,后面会介绍.
如下是JSEP定义的客户端通讯架构:
<img src="http://www.html5rocks.com/en/tutorials/webrtc/infrastructure/jsep.png" alt="JSEP 架构" width="834" height="520">
JSEP要求客户端之间交换offer和answer:其实就是上面提到的元数据,他们是以SDP格式进行交换,格式如下:
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 v=0
 2 o=- 7614219274584779017 2 IN IP4 127.0.0.1
 3 s=-
 4 t=0 0
 5 a=group:BUNDLE audio video
 6 a=msid-semantic: WMS
 7 m=audio 1 RTP/SAVPF 111 103 104 0 8 107 106 105 13 126
 8 c=IN IP4 0.0.0.0
 9 a=rtcp:1 IN IP4 0.0.0.0
10 a=ice-ufrag:W2TGCZw2NZHuwlnf
11 a=ice-pwd:xdQEccP40E+P0L5qTyzDgfmW
12 a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
13 a=mid:audio
14 a=rtcp-mux
15 a=crypto:1 AES_CM_128_HMAC_SHA1_80 inline:9c1AHz27dZ9xPI91YNfSlI67/EMkjHHIHORiClQe
16 a=rtpmap:111 opus/48000/2
17 …
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
如果您对SDP格式有兴趣,可以参考:<a href="http://datatracker.ietf.org/doc/draft-nandakumar-rtcweb-sdp/?include_text=1">IETF examples</a>
在webrtc架构里面调用setLocalDiscription,setRemoteDiscription前可通过编辑SDP里面的值来更改offer和anser.如<a href="https://apprtc.appspot.com/js/main.js">apprtc.appspot.com</a>&nbsp;中得 preferAudioCodec()能用来设置默认的音频编码和码率,sdp用javascript修改起来可能有点痛苦,W3C组织有在讨论通过jason方式来编辑,不过目前这种方式也有些优点(<a href="http://tools.ietf.org/html/draft-ietf-rtcweb-jsep-03#section-3.3">some advantages</a>). 
&nbsp;
### RTCPeerConnection + signaling: offer, answer and candidate
RTCPeerConnection就是webrtc应用程序用来创建客户端连接和视频通讯的API.为了初始化这个过程&nbsp;RTCPeerConnection有两个任务:
　　1,确定本地媒体条件,如分辨率,编解码能力,这些需要在offer和answer中用到.
　　2,取到应用程序所在机器的网络地址,即称作 candidates. 
 一旦上面这些东西确定了,他们将通过信令机制和远端进行交换. 
 想象一下Alice呼叫Eve的过程(&nbsp;<a href="http://xkcd.com/177/">Alice is trying to call Eve</a>.),下面就是完整offer/answer机制的细节: 
 1,Alice创建一个&nbsp;RTCPeerConnection对象. 
 2,Alice创建一个offer(即SDP会话描述)通过RTCPeerConnection&nbsp; createOffer()方法.  
  3,Alice调用 setLocalDescription()方法用他的offer.   
  4,Alice通过信令机制将他的offer发给Eve.  
  5,Eve调用 setRemoteDescription()方式设置Alice的offer,因此他的RTCPeerConnection知道了Alice的设置.   
  6,Eve调用方法 createAnswer(),然后会触发一个callback,这个callback里面可以去到自己的answer.   
   7,Eve设置他自己的anser通过调用方法 setLocalDescription().    
    8,Eve通过信令机制将他的anser发给Alice.    
    9,Alice设置Eve的anser通过方法 setRemoteDescription().     
&nbsp;
另外Alice和Eve也需要交换网络信息(即candidates),发现candidates参考了<a href="http://en.wikipedia.org/wiki/Interactive_Connectivity_Establishment">ICE framework</a>.
1,Alice创建RTCPeerConnection对象时设置了 onicecandidate&nbsp; handler.
2,hander被调用当candidates找到了的时候.
3,当Eve收到来自Alice的candidate消息的时候,他调用方法 addIceCandidate(),添加candidate到远端描述里面. 
 JSEP支持<a href="http://tools.ietf.org/html/draft-ietf-rtcweb-jsep-03#section-3.4.1">ICE Candidate Trickling</a>,他允许呼叫方在offer初始化结束后提供candidates给被叫方.而被叫方开始建立呼叫和连接而不需要等到所有candidate到达.<br> 
&nbsp;
### Coding WebRTC for signaling
 下面是一个W3C的例子(<a href="http://www.w3.org/TR/webrtc/#simple-peer-to-peer-example">W3C code example</a>)概括了一个完整的信令过程,他里面假设已经存在信令机制: SignalingChannel ,信令在下面被详细讨论 
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 var signalingChannel = new SignalingChannel();
 2 var configuration = {
 3   'iceServers': [{
 4     'url': 'stun:stun.example.org'
 5   }]
 6 };
 7 var pc;
 8 
 9 // call start() to initiate
10 
11 function start() {
12   pc = new RTCPeerConnection(configuration);
13 
14   // send any ice candidates to the other peer
15   pc.onicecandidate = function (evt) {
16     if (evt.candidate)
17       signalingChannel.send(JSON.stringify({
18         'candidate': evt.candidate
19       }));
20   };
21 
22   // let the 'negotiationneeded' event trigger offer generation
23   pc.onnegotiationneeded = function () {
24     pc.createOffer(localDescCreated, logError);
25   }
26 
27   // once remote stream arrives, show it in the remote video element
28   pc.onaddstream = function (evt) {
29     remoteView.src = URL.createObjectURL(evt.stream);
30   };
31 
32   // get a local stream, show it in a self-view and add it to be sent
33   navigator.getUserMedia({
34     'audio': true,
35     'video': true
36   }, function (stream) {
37     selfView.src = URL.createObjectURL(stream);
38     pc.addStream(stream);
39   }, logError);
40 }
41 
42 function localDescCreated(desc) {
43   pc.setLocalDescription(desc, function () {
44     signalingChannel.send(JSON.stringify({
45       'sdp': pc.localDescription
46     }));
47   }, logError);
48 }
49 
50 signalingChannel.onmessage = function (evt) {
51   if (!pc)
52     start();
53 
54   var message = JSON.parse(evt.data);
55   if (message.sdp)
56     pc.setRemoteDescription(new RTCSessionDescription(message.sdp), function () {
57       // if we received an offer, we need to answer
58       if (pc.remoteDescription.type == 'offer')
59         pc.createAnswer(localDescCreated, logError);
60     }, logError);
61   else
62     pc.addIceCandidate(new RTCIceCandidate(message.candidate));
63 };
64 
65 function logError(error) {
66   log(error.name + ': ' + error.message);
67 }
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
 了解offer,anser,candidate交换过程,可通过<a href="http://simpl.info/rtcpeerconnection/">simpl.info/pc</a>上 视频聊天的控制台日志,如果您想了解更多,可以下载完整的WebRTC signaling and stats from the chrome://webrtc-internals page in Chrome or the opera://webrtc-internals page in Opera. 
&nbsp;
### 怎么发现客户端
这里有一种很简单的表述方式---我怎么找到别人视频?
 打电话的时候我们有电话号码和电话本,知道打给谁,QQ聊天的时候,我们可以通过通讯录找到要聊天的人,webrtc也一样,他的客户端需要通过一种方式找到要聊天的人或要加入的会议. 
 webrtc没有定义这样一个发现过程,这个其实很简单,可以参考&nbsp;<a href="http://talky.io/">talky.io</a>,&nbsp;<a href="http://tawk.com/">tawk.com</a>&nbsp;and&nbsp;<a href="http://browsermeeting.com/">browsermeeting.com</a>,另外Chris Ball创建了<a href="http://blog.printf.net/articles/2013/05/17/webrtc-without-a-signaling-server/">serverless-webrtc</a>,他可以通过Emai,IM来参与视频.<br> 
&nbsp;
## 怎么创建信令服务?
再次重申:webrtc没有定义信令机制,因此无论你选择什么机制你都的需要一台中间服务端,用来在客户端之间交换数据,你总不可能直接说:"跟我朋友视频?",
由于信令消息很小,大多数交互都是在开始通话之前,可以参考&nbsp;<a href="http://apprtc.appspot.com/">apprtc.appspot.com</a>&nbsp;and&nbsp;<a href="http://samdutton-nodertc.jit.su/">samdutton-nodertc.jit.su</a>, 测试发现:一个视频通话过程大概有35~40消息,数据量在10K左右,
所以相对来说信令服务器不怎么占带宽,也不需要消耗多大的CPU和内存.
### 从服务端推送消息给客户端
信令服务器推送消息需要时双向的,即客户端能发消息给服务器,服务器也能发消息给服务端,这种双向机制就将Http给排除了(当然可以使用长连接,而且很多人都是这么做的,只不过比较占资源).
 说到这里很多人会想到WebSocket,没错,这是一种很好的解决方案,而且后台实现框架也很多,如PHP,Python,Ruby. 
 大约3/4的浏览器支持webSocekt,更重要的是支持WEBRTC的浏览器都支持WebSocket,包括PC和手机,&nbsp;<a href="https://en.wikipedia.org/wiki/Transport_Layer_Security">TLS</a>应该被使用为了所有连接,他能确保为被加密的消息不被截获,同时也能减少使用代理带来的问题(<a href="http://www.infoq.com/articles/Web-Sockets-Proxy-Servers">reduce problems with proxy traversal</a>),更多这方面的知识请参考&nbsp;<a href="http://hpbn.co/webrtc">WebRTC chapter</a>和<a href="http://refcardz.dzone.com/refcardz/html5-websocket">WebSocket Cheat Sheet</a>&nbsp;. 
 <a href="http://apprtc.appspot.com/">apprtc.appspot.com</a>中的视频通讯使用的信令是&nbsp;<a href="https://developers.google.com/appengine/docs/java/channel/">Google App Engine Channel API</a>,他采用的是&nbsp;<a href="http://en.wikipedia.org/wiki/Comet_%28programming%29">Comet</a>技术,&nbsp;<a href="http://www.html5rocks.com/en/tutorials/webrtc/basics/">HTML5 Rocks WebRTC article</a>有详细的介绍(<a href="http://www.html5rocks.com/en/tutorials/webrtc/basics/#toc-simple">detailed code walkthrough</a>)<br> 
 当然你也可以通过Ajax来实现这样一个长连接,不过这样会产生很多重复的网络请求,而且应用在移动端会有很多问题. 
### 扩展信令的实现
尽管信令服务占用的CPU和带宽资源都比较少,但实际应用中如果要考虑到高并发,信令服务还是有很大负载的.这些我们不深入讨论了,下面有一些不错的选择供参考:
1,<a title="XMPP Wikipedia article" href="http://en.wikipedia.org/wiki/Xmpp">eXtensible Messaging and Presence Protocol</a>(XMPP):主要是用来给即时通讯用的,开源服务端包括<a title="ejabberd article on Wikipedia" href="http://en.wikipedia.org/wiki/Ejabberd">ejabberd</a>&nbsp;and&nbsp;<a title="Openfire Wikipedia article" href="http://en.wikipedia.org/wiki/Openfire">Openfire</a>. 客户端包括&nbsp;<a title="Strophe XMPP library for JavaScript" href="http://strophe.im/strophejs/">Strophe.js</a>&nbsp;use&nbsp;<a title="BOSH article on Wikipedia" href="http://en.wikipedia.org/wiki/BOSH">BOSH</a>(但因为&nbsp;<a title="Stack Overflow question about XMPP BOSH v Comet: see also http://stackoverflow.com/questions/6434088/why-isnt-bosh-more-popular-especially-as-an-alternative-to-websockets-and-long" href="http://stackoverflow.com/questions/7327153/xmpp-bosh-vs-comet">various reasons</a>,BOSH没有WebSocket高效),补充说明:<a title="Jingle Wikipedia article" href="http://en.wikipedia.org/wiki/Jingle_%28protocol%29">Jingle</a>是XMPP的扩展,支持音视频,webrtc项目里面的network和transort组件就是来自&nbsp;<a title="Google Talk for Developers: About libjingle" href="https://developers.google.com/talk/libjingle/">libjingle</a>库.
2,开源库如&nbsp;<a href="http://zeromq.org/">ZeroMQ</a>,&nbsp;<a title="OpenMQ Wikipedia article" href="http://en.wikipedia.org/wiki/Open_Message_Queue">OpenMQ</a>
Developer Phil Leggetter's&nbsp;<a title="Comprehensive list of realtime services and libraries" href="http://www.leggetter.co.uk/real-time-web-technologies-guide">Real-Time Web Technologies Guide</a>&nbsp;提供了一个消息服务和库的综合清单.
### 使用Nodejs上的Socket.io实现一个信令服务
下面这个代码是一个简单的web应用,使用了&nbsp;<a href="http://socket.io/">Socket.io</a>&nbsp;on&nbsp;<a href="http://nodejs.org/">Node</a>, &nbsp;socket.io的设计目标就是为了简化消息通讯服务的创建,特别适合作为webrtc的信令,因为他内嵌了房间的概念,下面这个样例设计主要是为了少量用户的使用,并没有考虑太多的扩展性.
下面代码主要用来介绍怎么创建信令服务,可以通过查看日志来了解客户端加入房间时交换的消息过程,&nbsp;<a href="https://bitbucket.org/webrtc/codelab">WebRTC codelab</a>提供了怎么集成这个例子到webrtc视频通讯中的一步步的完整说明.你能从&nbsp;<a href="https://bitbucket.org/webrtc/codelab/src/master/complete/step5">step 5 of the codelab repo</a>&nbsp;下载代码或直接进入&nbsp;<a href="http://samdutton-nodertc.jit.su/">samdutton-nodertc.jit.su</a>查看(用浏览器打开两个URL即可).
下面是客户端的&nbsp; index.html :
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 <!DOCTYPE html>
 2 <html>
 3   <head>
 4     <title>WebRTC client</title>
 5   </head>
 6   <body>
 7     <script src='/socket.io/socket.io.js'></script>
 8     <script src='js/main.js'></script>
 9   </body>
10 </html>
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
客户端的JS
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 var isInitiator;
 2 
 3 room = prompt('Enter room name:');
 4 
 5 var socket = io.connect();
 6 
 7 if (room !== '') {
 8   console.log('Joining room ' + room);
 9   socket.emit('create or join', room);
10 }
11 
12 socket.on('full', function (room){
13   console.log('Room ' + room + ' is full');
14 });
15 
16 socket.on('empty', function (room){
17   isInitiator = true;
18   console.log('Room ' + room + ' is empty');
19 });
20 
21 socket.on('join', function (room){
22   console.log('Making request to join room ' + room);
23   console.log('You are the initiator!');
24 });
25 
26 socket.on('log', function (array){
27   console.log.apply(console, array);
28 });
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
完整服务端代码:
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 var static = require('node-static');
 2 var http = require('http');
 3 var file = new(static.Server)();
 4 var app = http.createServer(function (req, res) {
 5   file.serve(req, res);
 6 }).listen(2013);
 7 
 8 var io = require('socket.io').listen(app);
 9 
10 io.sockets.on('connection', function (socket){
11 
12   // convenience function to log server messages to the client
13   function log(){
14     var array = ['>>> Message from server: '];
15     for (var i = 0; i < arguments.length; i++) {
16       array.push(arguments[i]);
17     }
18       socket.emit('log', array);
19   }
20 
21   socket.on('message', function (message) {
22     log('Got message:', message);
23     // for a real app, would be room only (not broadcast)
24     socket.broadcast.emit('message', message);
25   });
26 
27   socket.on('create or join', function (room) {
28     var numClients = io.sockets.clients(room).length;
29 
30     log('Room ' + room + ' has ' + numClients + ' client(s)');
31     log('Request to create or join room ' + room);
32 
33     if (numClients === 0){
34       socket.join(room);
35       socket.emit('created', room);
36     } else if (numClients === 1) {
37       io.sockets.in(room).emit('join', room);
38       socket.join(room);
39       socket.emit('joined', room);
40     } else { // max two clients
41       socket.emit('full', room);
42     }
43     socket.emit('emit(): client ' + socket.id + ' joined room ' + room);
44     socket.broadcast.emit('broadcast(): client ' + socket.id + ' joined room ' + room);
45 
46   });
47 
48 });
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
如果需要运行上面这个app,需要用到node,详见&nbsp;<a href="http://nodejs.org/">nodejs.org</a>,很好很强大的一个东东,我后面会翻译一篇介绍nodejs的文章.
其实不管你用什么方式创建信令服务,您的后台和客户端最少需要具有样例代码中的功能.
### 使用RTCDataChannel控制信令
一旦信令服务建立好了,两个客户端之间建立了连接,理论上他们就可以使用RTCDataChannel进行点对点通讯了,这样可以减轻信令服务的压力和消息传递的延迟,这部分没有提供Demo.
### 使用已有信令服务
如果您不想自己动手,这里还有提供几个webrtc信令服务器,与上述代码类似他们使用socket.io. 与webrtc客户端的javascript集成到一起了.
<a href="https://github.com/webRTC/webRTC.io">webRTC.io</a>:webrtc的第一个抽想库.
<a href="https://github.com/priologic/easyrtc">easyRTC</a>:一个完整的webrtc库.
<a href="https://github.com/andyet/signalmaster">Signalmaster</a>:信令服务器,和&nbsp;<a href="https://github.com/HenrikJoreteg/SimpleWebRTC">SimpleWebRTC</a>作为客户端脚本库配套使用.
如果您不想写任何代码的花,可以直接使用现有商业产品:<a href="http://www.vline.com/">vLine</a>,&nbsp;<a href="http://tokbox.com/opentok">OpenTok</a>&nbsp;and&nbsp;<a href="https://wiki.asterisk.org/wiki/display/AST/Asterisk+WebRTC+Support">Asterisk</a>.
如果您想实现录制功能,可参考&nbsp;<a href="https://labs.ericsson.com/blog/a-web-rtc-tutorial">signaling server using PHP on Apache</a>,虽然已经过时了,但代码可供参考.
### 信令安全性问题
因为信令使我们自己定义的,所以安全性问题跟webrtc无关,需要自己处理.一旦黑客掌握了你的信令,那他就是控制会话的开始,结束,重定向等等.
最重要的因素在信令安全中还是要靠使用安全协议,如HTTPS,WSS(如TLS),他们能确保未加密的消息不能被截取.
为确保信令安全,强烈推荐使用<a href="https://en.wikipedia.org/wiki/Transport_Layer_Security">TLS</a>.
## 使用ICE处理NATs和防火墙
元数据是通过信令服务器中转发给另一个客户端,但是对于流媒体数据,一旦会话建立,RTCPeerConnection将首先尝试使用点对点连接.
简单一点说就是:每个客户端都有一个唯一的地址,他能用来和其他客户端进行通讯和数据交换.
&nbsp;
现实生活中客户端都位于一个或多个NAT之后,或者一些杀毒软件还阻止了某些端口和协议,或者在公司还有防火墙或代理,等等,防火墙和NAT或许是同一个设备,如我们家里用的路由器.
&nbsp;
webrtc就是通过&nbsp;<a href="https://en.wikipedia.org/wiki/Interactive_Connectivity_Establishment">ICE</a>这套框架来处理复杂的网络环境的,如果想启用这个功能,你必须让你得应用程序传ice服务器的URL给RTCPeerConnection,描述如下:
ICE试着找最好的路径来让客户端建立连接,他会尝试所有可能的选项,然后选择最合适的方案,ICE首先尝试P2P连接,如果失败就会通过Turn服务器进行转接.
换一个说法就是:
1,STUN服务器是用来取外网地址的.
2,TURN服务器是在P2P失败时进行转发的.
每个TURN服务器都支持STUN,ICE处理复杂的NAT设置,同时NAT打洞要求不止一个公网IP和端口.
javascript中ice配置如下:
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 {
 2   'iceServers': [
 3     {
 4       'url': 'stun:stun.l.google.com:19302'
 5     },
 6     {
 7       'url': 'turn:192.158.29.39:3478?transport=udp',
 8       'credential': 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
 9       'username': '28224511:1379330808'
10     },
11     {
12       'url': 'turn:192.158.29.39:3478?transport=tcp',
13       'credential': 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
14       'username': '28224511:1379330808'
15     }
16   ]
17 }
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
一旦RTCPeerConnection取到了所要的信息,ICE过程就自动发生了,RTCPeerConnection使用ICE框架取到两点之间最好的路径,当然这个过程离不开STUN和TURN的支持.
### STUN
NAT的作用就是提供内外网端口的映射,因为在公网上两个内网客户端要建立直接连接就不许先知道彼此对应的公网地址和端口,这时候知道对方内网IP和地址是没用的.
而STUN的作用就是让客户端发现自己的公网IP和端口,所以负载不大,同时目前免费得STUN服务器也很多.一搜一大把.
通过<a href="http://webrtcstats.com/">webrtcstats.com</a>可知85%的情况下可以P2P,当然复杂NAT和网络环境下这个概率会更低.
&nbsp;
### TURN
RTCPeerConnection首先尝试使用P2P,如果失败,他将求助于TCP,使用turn转发两个端点的音视频数据.
重申:turn转发的是两个端点之间的音视频数据,不是信令数据.
因为TURN服务器是在公网上,所以他能被各个客户端找到,另外TURN服务器转发的是数据流,很占用带宽和资源.
### 部署STUN和TURN服务器
google提供了stun.l.google.com:19302供测试,&nbsp;<a href="http://apprtc.appspot.com/">apprtc.appspot.com</a>用的就是这个stun服务器,实际应用中,我们推荐使用rfc5766-turn-server,同时也提供了一些连接源:&nbsp;<a href="https://groups.google.com/forum/#%21msg/discuss-webrtc/X-OeIUC0efs/XW5Wf7Tt1vMJ">VM image for Amazon Web Services</a>
turn服务器的安装后面我专门写篇文章来介绍,作者写的那种方式我也没有尝试过,不过看起来比较复杂.有兴趣的可以去看原文.
&nbsp;
**下面这几部分我放到下一篇文章介绍,内容太多,大家会看得很晕**
## Beyond one-to-one: multi-party WebRTC
### Multipoint Control Unit
## Beyond browsers: VoIP, telephones and messaging
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
谈到音视频不得不谈谈对视频呈现的理解，为了让大家能有一个更好的理解，先看看android里面SurfaceView的原理，后续陆续分享其绘画原理。
&nbsp;
说明：本文是转载的，转载自哪里我也不知道，貌似经过很多层转载了，在这里先对原创者表示谢意. &nbsp;**cnblogs RTC.Blacker**
&nbsp;
通过自定义View，&nbsp;我们知道使用它可以做一 些简单的动画效果。它通过不断循环的执行View.onDraw方法，每次执行都对内部显示的图形做一些调整，我们假设 onDraw方法每秒执行20次，这样就会形成一个20帧的补间动画效果。但是现实情况是你无法简单的控制View.onDraw的执行帧数，这边说的执 行帧数是指每秒View.onDraw方法被执行多少次，这是为什么呢？首先我们知道，onDraw方法是由系统帮我们调用的，我们是通过调用View的 invalidate方法通知系统需要重新绘制View，然后它就会调用View.onDraw方法。这些都是由系统帮我们实现的，所以我们很难精确去定 义View.onDraw的执行帧数，这个就是为什么我们这边要了解SurfaceView了，它能弥补View的一些不足。
&nbsp;
首先我们先写一个自定义View实现动画效果，AnimateViewActivity.java：
&nbsp;
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 package com.android777.demo.uicontroller.graphics;  
 2    
 3 import android.app.Activity;  
 4 import android.content.Context;  
 5 import android.graphics.Canvas;  
 6 import android.graphics.Color;  
 7 import android.graphics.Paint;  
 8 import android.os.Bundle;  
 9 import android.view.View;  
10    
11 public class AnimateViewActivity extends Activity {  
12    
13     @Override  
14     protected void onCreate(Bundle savedInstanceState) {  
15         super.onCreate(savedInstanceState);  
16    
17         setContentView(new AnimateView(this))//這邊傳入的this代表這個對象，因為Activity是繼承自Content類的，因此該對象也  
18                                                可向上轉型為Content類型作為AnimateView的構造方法的參數  
19     }  
20    
21     class AnimateView extends View{  
22    
23         float radius = 10;  
24         Paint paint;  
25    
26         public AnimateView(Context context) {  
27             super(context);  
28             paint = new Paint();  
29             paint.setColor(Color.YELLOW);  
30             paint.setStyle(Paint.Style.STROKE);  
31         }  
32    
33         @Override  
34         protected void onDraw(Canvas canvas) {  
35    
36             canvas.translate(200, 200);  
37             canvas.drawCircle(0, 0, radius++, paint);            
38    
39             if(radius > 100){  
40                 radius = 10;  
41             }  
42    
43             invalidate()//通过调用这个方法让系统自动刷新视图  
44    
45         }  
46    
47     }  
48    
49 }  
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
运行上面的Activity，你将看到一个圆 圈，它原始半径是10，然后不断的变大，直到达到100后又恢复到10，这样循环显示，视觉效果上说你将看到一个逐渐变大的圆圈。它能做的只是简单的动画 效果，具有一些局限性。首先你无法控制动画的显示速度，目前它是以最快的 速度显示，但是当你要更快，获取帧数更高的动画呢？ 因为View的帧数是由系统控制的，所以你没办法完成上面的操作。如果你需要编写一个游戏，它需要的帧数比较高，那么View就无能为力了，因为它被设计 出来时本来就不是用来处理一些高帧数显示的。你可以把View理解为一个经过系统优化的，可以用来高效的执行一些帧数比较低动画的对象，它具有特定的使用 场景，比如有一些帧数较低的游戏就可以使用它来完成：贪吃蛇、俄罗斯方块、棋牌类等游戏，因为这些游戏执行的帧数都很低。但是如果是一些实时类的游戏，如 射击游戏、塔防游戏、RPG游戏等就没办法使用View来做，因为它的帧数太低了，会导致动画执行不顺畅。所以我们需要一个能自己控制执行帧数的对 象，SurfaceView因此诞生了。
&nbsp;
### <a name="t0"></a>什么是SurfaceView呢？
&nbsp;
为什么是SurfaceView 呢？Surface的意思是表层，表面的意思，那么SurfaceView就是指一个在表层的View对象。为什么 说是在表层呢，这是因为它有点特殊跟其他View不一样，其他View是绘制在表层外，而它就是充当表层对象。假设你要在一个球上画画，那么球的表层就当 做你的画布对象，你画的东西会挡住它的表层，我们默认没使用SurfaceView，那么球的表层就是空白的，如果我们使用了SurfaceView，我 们可以理解为我们拿来的球本身表面就具有纹路，你是画再纹路之上的，如果你画的是半透明的，那么你将可以透过你画的东西看到球面本身的纹路。SDK的文档 说到：SurfaceView就是在Window上挖一个洞，它就是显示在这个洞里，其他的View是显示在Window上，所以View可以显式在 SurfaceView之上，你也可以添加一些层在SurfaceView之上。
&nbsp;
SurfaceView还有其他的特性，上面我们讲了它可以控制帧数，那它是什么控制的呢？这就需要了解它的使用机制。一般在很多游戏设计中，我们都是开辟一个后台线程计算游戏相关的数据，然后根据这些计算完的新数据再刷新视图对象，由于<a title="Android应用程序原理" href="http://www.android777.com/index.php/tutorial/android-to-new/principles-of-android-applications.html" target="_blank">对View执行绘制操作只能在UI线程上</a>， 所以当你在另外一个线程计算完数据后，你需要调用View.invalidate方法通知系统刷新View对象，所以游戏相关的数据也需要让UI线程能访 问到，这样的设计架构比较复杂，要是能让后台计算的线程能直接访问数据，然后更新View对象那改多好。我们知道View的更新只能在UI线程中，所以使 用自定义View没办法这么做，但是SurfaceView就可以了。它一个很好用的地方就是**允许其他线程(不是UI线程)绘制图形(使用Canvas)**，根据它这个特性，你就可以控制它的帧数，你如果让这个线程1秒执行50次绘制，那么最后显示的就是50帧。
&nbsp;
### &nbsp;
&nbsp;
### 如何使用SurfaceView？
&nbsp;
首先SurfaceView也是一个View， 它也有自己的生命周期。因为它需要另外一个线程来执行绘制操作，所以我们可以在它生命周期的初始化阶 段开辟一个新线程，然后开始执行绘制，当生命周期的结束阶段我们插入结束绘制线程的操作。这些是由其内部一个SurfaceHolder对象完成的。 SurfaceHolder，顾名思义，它里面保存了一个队Surface对象的引用，而我们执行绘制方法就是操作这个 Surface，SurfaceHolder因为保存了对Surface的引用，所以使用它来处理Surface的生命周期，说到底 SurfaceView的生命周期其实就是Surface的生命周期，因为SurfaceHolder保存对Surface的引用，所以使用 SurfaceHolder来处理生命周期的初始化。首先我们先看看建立一个SurfaceView的大概步骤，先看看代码：
&nbsp;
DemoSurfaceView.java：
&nbsp;
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
 1 package com.android777.demo.uicontroller.graphics;  
 2    
 3 import android.content.Context;  
 4 import android.view.SurfaceHolder;  
 5 import android.view.SurfaceHolder.Callback;  
 6 import android.view.SurfaceView;  
 7    
 8 public class DemoSurfaceView extends SurfaceView  implements Callback{  
 9    
10     public DemoSurfaceView(Context context) {  
11         super(context);  
12    
13         init(); //初始化,设置生命周期回调方法  
14    
15     }  
16    
17     private void init(){  
18    
19         SurfaceHolder holder = getHolder();  
20         holder.addCallback(this); //设置Surface生命周期回调  
21    
22     }  
23    
24     @Override  
25     public void surfaceChanged(SurfaceHolder holder, int format, int width,  
26             int height) {  
27     }  
28    
29     @Override  
30     public void surfaceCreated(SurfaceHolder holder) {  
31     }  
32    
33     @Override  
34     public void surfaceDestroyed(SurfaceHolder holder) {  
35     }  
36    
37 }  
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
上面代码我们在SurfaceView的构造方 法中执行了init初始化方法，在这个方法里，我们先获取SurfaceView里的 SurfaceHolder对象，然后通过它设置Surface的生命周期回调方法，使用DemoSurfaceView类本身作为回调方法代理类。 surfaceCreated方法，是当SurfaceView被显示时会调用的方法，所以你需要再这边开启绘制的线 程，surfaceDestroyed方法是当SurfaceView被隐藏会销毁时调用的方法，在这里你可以关闭绘制的线程。上面的例子运行后什么也不 显示，因为还没定义一个执行绘制的线程。下面我们修改下代码，使用一个线程绘制一个逐渐变大的圆圈：
&nbsp;
```python
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
  1 package com.android777.demo.uicontroller.graphics;  
  2    
  3 import android.content.Context;  
  4 import android.graphics.Canvas;  
  5 import android.graphics.Color;  
  6 import android.graphics.Paint;  
  7 import android.view.SurfaceHolder;  
  8 import android.view.SurfaceHolder.Callback;  
  9 import android.view.SurfaceView;  
 10    
 11 public class DemoSurfaceView extends SurfaceView  implements Callback{  
 12    
 13     LoopThread thread;  
 14    
 15     public DemoSurfaceView(Context context) {  
 16         super(context);  
 17    
 18         init(); //初始化,设置生命周期回调方法  
 19    
 20     }  
 21    
 22     private void init(){  
 23    
 24         SurfaceHolder holder = getHolder();  
 25         holder.addCallback(this); //设置Surface生命周期回调  
 26         thread = new LoopThread(holder, getContext());  
 27     }  
 28    
 29     @Override  
 30     public void surfaceChanged(SurfaceHolder holder, int format, int width,  
 31             int height) {  
 32     }  
 33    
 34     @Override  
 35     public void surfaceCreated(SurfaceHolder holder) {  
 36         thread.isRunning = true;  
 37         thread.start();  
 38     }  
 39    
 40     @Override  
 41     public void surfaceDestroyed(SurfaceHolder holder) {  
 42         thread.isRunning = false;  
 43         try {  
 44             thread.join();  
 45         } catch (InterruptedException e) {  
 46             e.printStackTrace();  
 47         }  
 48     }  
 49    
 50     /** 
 51      * 执行绘制的绘制线程 
 52      * @author Administrator 
 53      * 
 54      */  
 55     class LoopThread extends Thread{  
 56    
 57         SurfaceHolder surfaceHolder;  
 58         Context context;  
 59         boolean isRunning;  
 60         float radius = 10f;  
 61         Paint paint;  
 62    
 63         public LoopThread(SurfaceHolder surfaceHolder,Context context){  
 64    
 65             this.surfaceHolder = surfaceHolder;  
 66             this.context = context;  
 67             isRunning = false;  
 68    
 69             paint = new Paint();  
 70             paint.setColor(Color.YELLOW);  
 71             paint.setStyle(Paint.Style.STROKE);  
 72         }  
 73    
 74         @Override  
 75         public void run() {  
 76    
 77             Canvas c = null;  
 78    
 79             while(isRunning){  
 80    
 81                 try{  
 82                     synchronized (surfaceHolder) {  
 83    
 84                         c = surfaceHolder.lockCanvas(null);  
 85                         doDraw(c);  
 86                         //通过它来控制帧数执行一次绘制后休息50ms  
 87                         Thread.sleep(50);  
 88                     }  
 89                 } catch (InterruptedException e) {  
 90                     e.printStackTrace();  
 91                 } finally {  
 92                     surfaceHolder.unlockCanvasAndPost(c);  
 93                 }  
 94    
 95             }  
 96    
 97         }  
 98    
 99         public void doDraw(Canvas c){  
100    
101             //这个很重要，清屏操作，清楚掉上次绘制的残留图像  
102             c.drawColor(Color.BLACK);  
103    
104             c.translate(200, 200);  
105             c.drawCircle(0,0, radius++, paint);  
106    
107             if(radius > 100){  
108                 radius = 10f;  
109             }  
110    
111         }  
112    
113     }  
114    
115 }  
<a title="复制代码"><img src="https://common.cnblogs.com/images/copycode.gif" alt="复制代码"></a>```
```
&nbsp;
上面代码编写了一个使用SurfaceView 制作的动画效果，它的效果跟上面自定义View的一样，但是这边的SurfaceView可以控制动 画的帧数。在SurfaceView中内置一个LoopThread线程，这个线程的作用就是用来绘制图形，在SurfaceView中实例化一个 LoopThread实例，一般这个操作会放在SurfaceView的构造方法中。然后通过在SurfaceView中的SurfaceHolder的 生命周期回调方法中插入一些操作，当Surface被创建时(SurfaceView显示在屏幕中时)，开启LoopThread执行绘 制，LoopThread会一直刷新SurfaceView对象，当SurfaceView被隐藏时就停止改线程释放资源。这边有几个地方要注意下：
&nbsp;
1.因为SurfaceView允许自定义的线 程操作Surface对象执行绘制方法，而你可能同时定义多个线程执行绘制，所以当你获取 SurfaceHolder中的Canvas对象时记得加同步操作，避免两个不同的线程同时操作同一个Canvas对象，当操作完成后记得调用 SurfaceHolder.unlockCanvasAndPost方法释放掉Canvas锁。
&nbsp;
2.在调用doDraw执行绘制时，因为SurfaceView的特点，它会保留之前绘制的图形，所以你需要先清空掉上一次绘制时留下的图形。(View则不会，它默认在调用View.onDraw方法时就自动清空掉视图里的东西)。
&nbsp;
3. 记得在回调方法：onSurfaceDestroyed方法里将后台执行绘制的LoopThread关闭，这里是使用join方法。这涉及到线程如何关闭 的问题，多数人建议是通过一个标志位：isRunning来判断线程是否该停止运行，如果你想关闭线程只需要将isRunning改成false即可，线 程会自动执行完run方法后退出。
&nbsp;
&nbsp;
&nbsp;
### 总结：
&nbsp;
通过上面的分析，现在大家应该会简单使用SurfaceView了，总的归纳起来SurfaceView和View不同之处有：
&nbsp;
1. SurfaceView允许其他线程更新视图对象(执行绘制方法)而View不允许这么做，它只允许UI线程更新视图对象。
&nbsp;
2. SurfaceView是放在其他最底层的视图层次中，所有其他视图层都在它上面，所以在它之上可以添加一些层，而且它不能是透明的。
&nbsp;
3. 它执行动画的效率比View高，而且你可以控制帧数。
&nbsp;
4. 因为它的定义和使用比View复杂，占用的资源也比较多，除非使用View不能完成，再用SurfaceView否则最好用View就可以。(贪吃蛇，俄罗斯方块，棋牌类这种帧数比较低的可以使用View做就好)
&nbsp;
&nbsp;
&nbsp;
以前在做一个视频监控项目的时候，刚开始客户没 提到要支持P2P，因为服务端是我们自己写的，为了便于处理一些逻辑，全部采用转发的方式，后来客户要求支持P2P，没办法了，后来自己部署了一个 STUN服务器（不过也有很多开源STUN服务器，不过用起来会有些肖问题），客户端取到NAT类型和ip地址后，自己根据这些信息进行打洞处理，搞得有 点复杂，其实按照ICE协议就比较简单了，主要分成两个部分：地址获取与连通性检查，详细介绍如下：
说明：下文是转载的，转载自哪里我也不知道，貌似经过很多层转载了，在这里先对原创者表示感谢，同时为了便于阅读和理解，我也对文本格式进行了调整，以及加入了自己的一些理解在里面. **&nbsp;**cnblogs RTC.Blacker
&nbsp;
&nbsp; &nbsp; &nbsp;基于IP的语音、数据、视频等业务在NGN网络中所面临的一个实际困难就是如何有效地穿透各种NAT/FW的问题。对此，会话初始化协议SIP以往的解 决方法有ALGs，STUN，TURN等方式。本文探讨了一种新的媒体会话信令穿透NAT/FW的解决方案—交互式连通建立方式(ICE)。它通过综合利 用现有协议，以一种更有效的方式来组织会话建立过程，使之在不增加任何延迟同时比STUN等单一协议更具有健壮性、灵活性。本文详细介绍了ICE算法，并 设计一个实例针对SIP信令协议穿透Symmetric NAT流程进行了描述，最后总结了ICE的优势及应用前景。&nbsp; &nbsp; &nbsp;
&nbsp;
&nbsp;
&nbsp;
1 问题背景
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 多媒体会话信令协议是在准备建立媒体流传输的代理之间交换信息的协议，例如SIP、RTSP、H.323等。媒体流与信令流截然不同，它们所采用的网络通 道也不一致。由于协议自身设计上的原因，使得媒体流无法直接穿透网络地址转换/防火墙(NAT/FW)。因为它们生存期的目标只是为了建立一个在信息中携 带IP地址的分组流，这在遇到NAT/FW 时会带来许多问题。而且这些协议的目标是通过建立P2P(Peer to Peer)媒体流以减小时延，而协议本身很多方面却与NAT存在兼容性问题，这也是穿透 NAT/FW的困难所在。&nbsp; &nbsp; 
&nbsp;
而 NAT仍是解决当前公用IP地址紧缺和网络安全问题的最有力手段，它主要有四种类型：完全圆锥型NAT(Full Cone NAT)，地址限制圆锥型NAT (Address Restricted Cone NAT)，端口限制圆锥型NAT (Port Restricted Cone NAT)，对称型NAT (Symmetric NAT)。前三种NAT，映射与目的地址无关，只要源地址相同，映射就相同，而对称型NAT的映射则同时关联源地址和目的地址，所以穿透问题最为复杂。
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 不少方案已经被应用于解决穿透NAT问题，例如：ALGs(Application Layer Gateways)、Middlebox Control Protocol、STUN (Simple Traversal of UDP through NAT)、TURN(Traversal Using Relay NAT)、RSIP(Realm Specific IP)、symmetric RTP等。然而，当这些技术应用于不同的网络拓扑时都有着显著的利弊，以至于我们只能根据不同的接入方式来应用不同的方案，所以未能很好地解决All- NAT与Efficiency的问题，同时还会给系统引入了许多复杂性和脆弱性因素。所以我们目前需要一种综合的足够灵活的方法，使之能在各种情况下对 NAT/FW的信令穿透问题提供最优解。事实上，ICE正是符合这样要求的一种良好的解决方案。
&nbsp;
# <a name="t2"></a><a name="t2"></a><br>2 ICE技术
&nbsp;
## ICE简介


&nbsp;
&nbsp; &nbsp; &nbsp; 
交互式连通建立方式ICE(Interactive Connectivity 
Establishment)并非一种新的协议，它不需要对STUN、TURN或RSIP进行扩展就可适用于各种NAT。ICE是通过综合运用上面某几种
协议，使之在最适合的情况下工作，以弥补单独使用其中任何一种所带来的固有缺陷。对于SIP来说，ICE只需要定义一些SDP(Session 
Description Protocol)附加属性即可，对于别的多媒体信令协议也需要制定一些相应的机制来实现。本文仅就SIP问题展开讨论。
&nbsp;
## 多媒体信令


&nbsp;
&nbsp; &nbsp; &nbsp;媒
体流穿透NAT的过程是独立于某种具体的信令协议的。通信发生在两个客户端－会话发起者和会话响应者。初始化信息(Initiate 
Message)包含了描述会话发起者媒体流的配置与特征，并经过信令调停者(也叫信令中继)，最后到达会话响应者。假设会话响应者同意通信，接受信息
(Accept 
Message)将产生并反馈至会话初始者，媒体流建立成功。此外，信令协议还对媒体流参数修改以及会话终止消息等提供支持。对于SIP，会话发起者即
UAC(User Agent Client)，会话响应者即UAS(User Agent 
Server)，初始化消息对应SDP请求里面的INVITE，接受消息对应于SDP应答里面的200 OK，终止消息对应于BYE。
&nbsp;
## 算法流程


&nbsp;
### 收集传输地址


&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 
会话发起者需要收集的对象包括本地传输地址(Local Transport Address)和来源传输地址(Derived Transport 
Address)。本地传输地址通常由主机上一个物理(或虚拟)接口绑定一个端口而获得。会话发起者还将访问提供UNSAF(Unilateral 
self-address 
fixing)的服务器，例如STUN、TURN或TEREDO。对于每一个本地传输地址，会话者都可以从服务器上获得一组来源传输地址。
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 显然，实现物理或虚拟连通方式越多，ICE将工作得越好。但为了建立对等通信，ICE通常要求至少有一个来源地址由位于公网上的中继服务器(如TURN)所提供的，而且需要知道具体是哪一个来源传输地址。
&nbsp;
### 启动STUN


&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 
会话发起者获得一组传输地址后，将在本地传输地址启动STUN服务器，这意味着发送到来源地址的STUN服务将是可达的。与传统的STUN不同，客户端不
需要在任何其它IP或端口上提供STUN服务，也不必支持TLS， ICE用户名和密码已经通过信令协议进行交换。
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 
客户端将在每个本地传输地址上同时接受STUN请求包和媒体包，所以发起者需要消除STUN消息与媒体流协议之间的歧义。在RTP和RTCP中实现这个并
不难，因为RTP与RTCP包总是以0b10(v=2)打头，而STUN是0b00。对于每个运行STUN服务器的本地传输地址，客户端都必须选择相应的
用户名和密码。用户名要求必须是全局唯一的，用户名和密码将被包含在初始化消息里传至响应者，由响应者对STUN请求进行鉴别。
&nbsp;
### 确定传输地址的优先级


&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 
STUN服务器启动后，下一步就是确定传输地址的优先级。优先级反映了UA在该地址上接收媒体流的优先级别，取值范围在0到1之间，通常优先级按照被传输
媒体流量来确定。流量小者优先，而且对于相同流量者的Ipv6地址比Ipv4地址具有更高优先级。因此物理接口产生的本地Ipv6传输地址具有最高的优先
级，然后是本地Ipv4传输地址，然后是STUN、RSIP、TEREDO来源地址，最后是通过VPN接口获得的本地传输地址。
&nbsp;
### 构建初始化信息(Initiate Message)


&nbsp;
&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; 
初始化消息由一系列媒体流组成，每个媒体流都有一个缺省地址和候选地址列表。缺省地址通常被Initiate消息映射到SIP信令消息传递地址上，而候选
地址列表用于提供一些额外的地址。对于每个媒体流来说，任意Peer之间实现最大连通可能性的传输地址是由公网上转发服务器(如TURN)提供的地址，通
常这也是优先级最低的传输地址。客户端将可用的传输地址编成一个候选地址列表(包括一个缺省地址)，并且为每个候选元素分配一个会话中唯一的标识符。该标
识符以及上述的优先级都被编码在候选元素的id属性中。一旦初始化信息生成后即可被发送。
&nbsp;
### 响应处理：连通性检查和地址收集


&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 
会话应答方接收到初始化信息Initiate 
Message后，会同时做几个事情：首先，执行2.3.1中描述的地址收集过程。这些地址可以在呼叫到达前预收集，这样可以避免增加呼叫建立的时间。当
获得来源地址以后，应答方会发送STUN Bind请求，该请求要求必须包含Username属性和Password属性，属性值为从 
“alt”中得到的用户名和密码。STUN Bind请求还应包括一个Message-Integrity属性，它是由Initiate 
Message中候选元素的用户名和密码计算得来的。此外，STUN 
Bind请求不应有Change-Request或Response-Address属性。
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 
当一个客户端收到Initiate Message时，它将通过其中缺省地址和端口发送媒体流。如果STUN 
Bind请求消息引起错误应答，则需要检查错误代码。如果是401，430，432或500，说明客户端应该重新发送请求。如果错误代码是400，431
和600，那么客户端不必重试，直接按超时处理即可。
&nbsp;
### 生成接受信息(Accept Message)


&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 应答者可以决定是接受或拒绝该通信，若拒绝则ICE过程终止，若接受则发送Accept消息。Accept消息的构造过程与Initiate Message类似。
&nbsp;
### 接受信息处理


&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 
接受过程有两种可能。如果Initiate Message的接受者不支持ICE，则Accept 
Message将只包含缺省的地址信息，这样发起方就知道它不用执行连通性检查了。然而如果本地配置信息要求发起者通过TURN服务器发包来进行连通性检
查，这将意味着那些直接发给响应者的包会被对方防火墙丢弃。为解决这个问题，发起者需要重新分配一个TURN来源地址，然后使用Send命令。一旦
Send命令被接受，发起者将发送所有的媒体包到TURN服务器，由服务器转发至响应者。如果Accept 
Message包含候选项，则发起方处理Accept Message的过程就与响应方处理Initiate Message很相似了。
&nbsp;
### 附加ICE过程


&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; Initiate或Accept消息交换过程结束后，双方可能仍将继续收集传输地址，这通常是由于某些STUN事务过长而未结束引起，另一种可能是由于Initiate/Accept消息交换时提供了新的地址。
&nbsp;
### ICE到SIP的映射


&nbsp;
&nbsp;&nbsp; &nbsp; &nbsp;  &nbsp;  使用
ICE方式穿透NAT，必须映射ICE定义的参数到SIP消息格式中，同时对其SDP属性进行简单扩展—在SDP的Media块中定义一个新的属性
“alt”来支持ICE。它包含一个候选IP地址和端口，SDP的接受端可以用该地址来替换m和c中的地址。Media块中可能会有多个alt属性，
&nbsp;
这时每个alt应该包括不重复的IP地址和端口。语法属性如下：<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alt-attribute = "alt" ":" id SP qvalue SP derived-from SP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; username SP password SP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unicast-address SP port [unicast-address SP port]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;qvalue from RFC 3261<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;unicast-address, port from RFC 2327<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; username = non-ws-string<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; password = non-ws-string<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id = token<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; derived-from = ":" / id<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Symmetric NAT/FW
&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 下面设计一个简化的基于ICE的对称式网络地址转换/防火墙(Symmetric NAT/FW)的穿透实例，进一步说明ICE的工作流程。
&nbsp;
<br>此主题相关图片如下：<br>图1 Symmetric NAT/FW网络拓扑图
&nbsp;
<img src="http://hi.csdn.net/attachment/201110/27/0_13196785677411.gif" alt="" width="516" height="197">
&nbsp;
&nbsp;假设通信双方同时处于对称式NAT/FW内
部，现在SIP终端A要与B进行VoIP通信。A所在的内部地址是10.0.1.9，外部地址是211.35.29.30；B的内部地址是
192.168.1.6，外部地址是202.205.80.130；STUN/TURN服务器的地址是218.65.228.110。<br>首先A发起请求，进行地址收集，如图所示。生成A的Initiate Message如下：
&nbsp;
v=0<br>o=Dodo 2890844730 2890844731 IN IP4 host.example.com<br>s=<br>c=IN IP4 218.65.228.110<br>t=0 0<br>m=audio 8076 RTP/AVP 0<br>a=alt:1 1.0 : user 9kksj== 10.0.1.9 1010
&nbsp;
a=alt:2 0.8 : user1 9kksk== 211.35.29.30 9988<br>a=alt:3 0.4 : user2 9kksl== 218.65.228.110 8076
&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 其中本地地址的优先级为1.0,STUN地址的优先级为0.8,TURN地址优先级为0.4。当B收到消息后，也进行地址收集，过程和A类似。然后B开始执行连通性检查，可是<br>我
们不难发现，到10.0.1.9:1010的STUN请求和到211.35.29.30:9988的STUN请求都将不可避免地失败。因为前者是一个不可
路由的保留地址；而后者由于Symmetric 
NAT会对于每一个STUN/TURN请求都将分配不同的Binding，当数据包抵达A的NAT时，NAT会发现传输地址
211.35.29.30:9988已经映射218.65.228.110:3478了。而此时STUN请求的源地址并非
218.65.228.110:3478，所以数据包必然会被A的NAT/FW所丢弃。然而，到218.65.228.110:8076的STUN请求却
是成功的，因为TURN服务器用它收集到的原始地址来发送TURN请求。
&nbsp;
<br>当A收到应答后，它也执行连通性检查，如图所示：<br>图2 ：A的地址收集过程时序图<br>此主题相关图片如下：
&nbsp;
<img src="http://hi.csdn.net/attachment/201110/27/0_1319678725O6dr.gif" alt="" width="392" height="434">
&nbsp;
图3 ：B的地址收集过程时序图
&nbsp;
此主题相关图片如下：
&nbsp;
<img src="http://hi.csdn.net/attachment/201110/27/0_1319678821htXV.gif" alt="" width="369" height="463">
&nbsp;
图4 ：B的连通性检查
&nbsp;
<strong style="line-height: 1.5"><img src="http://hi.csdn.net/attachment/201110/27/0_1319678891x9Sx.gif" alt="" width="659" height="390">**
&nbsp;
&nbsp;
&nbsp;
完成连通性检查后，B产生的应答消息如下：<br>v=0
&nbsp;
o= Vincent 2890844730 289084871 IN IP4 host2.example.com<br>s=<br>c=IN IP4 218.65.228.110<br>t=0 0<br>m=audio 8078 RTP/AVP 0<br>a=alt:4 1.0 : peer as88jl 192.168.1.6 23766<br>a=alt:5 0.8 : peer1 as88kl 202.205.80.130 10892<br>a=alt:6 0.4 : peer2 as88ll 218.65.228.110 8078<br>a=alt:7 0.4 3 peer3 as88ml 218.65.228.110 5556
&nbsp;
&nbsp;
&nbsp;
此主题相关图片如下：<br>图5： A的连通性检查
&nbsp;
<img src="http://hi.csdn.net/attachment/201110/27/0_1319678994cCmA.gif" alt="" width="626" height="473">
&nbsp;
&nbsp; &nbsp; 
和前面一样，对于B的私有地址和STUN来源地址的连通性检查结果均为失败，而到B的TURN来源地址和到B的peer-derived地址成功(本例中
它们都具有相同的优先级0.4)。相同优先级下我们通常采用peer-derived地址，所以A发送到B的媒体流将使用
218.65.228.110:5556地址，而B到A的媒体流将发送至218.65.228.110:8076地址。以上为基于ICE方式解决
Symmetric NAT/FW穿透问题的一个简化后的典型实例。
&nbsp;
4 结束语
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
ICE方式的优势是显而易见的，它消除了现有的UNSAF机制的许多脆弱性。例如传统的STUN有几个脆弱点，其中一个就是发现过程需要客户端自己去判断
所在NAT类型，这实际上不是一个可取的做法。而应用ICE之后，这个发现过程已经不需要了。另一点脆弱性在于STUN、TURN等机制都完全依赖于一个
附加的服务器，而ICE利用服务器分配单边地址的同时，还允许客户端直接相连，因此即使STUN或TRUN服务器中有任何一个失败了，ICE方式仍可让呼
叫过程继续下去。此外，传统的STUN最大的缺陷在于它不能保证在所有网络拓扑结构中都正常工作，最典型的问题就是Symmetric 
NAT。对于TURN或类似转发方式工作的协议来说，由于服务器的负担过重，很容易出现丢包或者延迟情况。而ICE方式正好提供了一种负载均衡的解决方
案，它将转发服务作为优先级最低的服务，从而在最大程度上保证了服务的可靠性和灵活性。此外，ICE的优势还在于对Ipv6的支持，目前Cisco等公司
正在设计基于ICE方式的NAT/FW解决方案。由于广泛的适应能力以及对未来网络的支持，ICE作为一种综合的解决方案将有着非常广阔的应用前景。
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
这篇文章主要介绍XMPP与SIP,很多人容易混淆这两个概念,转载请说明出处（博客园RTC.Blacker）.
&nbsp;
简介:XMPP和SIP都是应用层协议,主要用于互联网上发送语音和即时通讯. SIP在<a href="http://www.ietf.org/rfc/rfc3261.txt" target="_blank">RFC 3621</a>中定义,XMPP在<a href="http://tools.ietf.org/html/rfc3920" target="_blank">RFC 3920</a>中定义,
XMPP是从即时通讯中演变而来,SIP是从VOIP中演变而来,XMPP为了会话协商添加了一个扩展叫做Jingle,SIP为了即时通讯业务添加了一个扩展叫做SIMPLE.
&nbsp;
**SIP (Session Initiation Protocol)**
SIP是一个应用层协议,是用在类似VOIP这样的场合,用来建立,修改,中止会话,同时在多人会议中他也能在已有会话中加入新的会话.&nbsp;
基本上SIP是VOIP中的信令协议,它处理呼叫建立,呼叫转移和产生CDR(Call Detail Record,供通话计费用).
&nbsp;
**XMPP (Extensible Messaging Presence Protocol)**
XMPP是一个为即时通讯和请求响应业务服务的XML协议.
最早由Jabber开源社区在1999年开发,2002年XMPP工作组为了更适合即时通讯对Jabber进行了扩展.&nbsp;
&nbsp;
**SIMPLE&nbsp; (SIP for Instant Messaging and Presence Leveraging Extensions)**
由IETF制定的SIMPLE（SIP for Instant Messaging and Presence Leveraging Extensions）协议簇对SIP协议进行了扩展，以使其支持IM服务。
SIMPLE增加了MESSAGE、SUBSCRIBE和NOTIFY方法，它们的作用分别如下：```
MESSAGE：用来发送一次性的短消息，即寻呼机模式的IM。```
SUBSCRIBE：用于申请者向服务器申请获得用户的呈现信息（Presence Information，通常指IM客户端在线状态信息）。```
NOTIFY：用于传输呈现信息。```

## **SIMPLE** 对比SIP新增的逻辑实体
SIMPLE中为呈现服务（Presence Service）新增了一些逻辑实体：```

### 呈现用户代理PUA
```
呈现用户代理PUA（Presence User Agent）生成用户的呈现信息。每一个用户可能含有多个PUA，他们可以产生不同的呈现信息。它不接收SUBSCRIBE和发送NOTIFY信息，只需能够发送REGISTER消息。```

### 呈现代理PA
```
呈现代理PA（Presence Agent）：类似于SIP协议中的UA，能够接收和应答SUBSCRIBE请求，并且当PUA公布新的呈现状态时，向申请者发出NOTIFY应答。它是 一个逻辑实体，实际上为了能够获得用户的呈现信息，PA功能可以选择有下面两个实体扩展呈现：一是SIP中的代理服务器/注册服务器；二是PUA。```

### 呈现服务器PS
```
呈现服务器PS（Presence Server）：可以实现PA的功能，同时可以和注册服务器共同实现查找呈现数据库的功能。```

### 申请者
```
申请者（Watcher）：能够发送SUBSCRIBE消息和接收来自PA的NOTIFY消息，并且能够中止整个过程。```
```
&nbsp;
**SIP和XMPP的异同**
其实我们不能简单地拿SIP和XMPP做比对,就像我们不能直接比较比较苹果和橘子,前者主要是为了会话协商,后者主要是为了结构化数据交换,只不过随着各自对Simple和Jingle的引入,他们有了一些相似.
1,SIP提供连接的建立、修改和终止，而XMPP在客户端内部提供流管道，交换结构化数据。
也就是说：SIP的重点是终端之间连接的建立和维护，连接以后的数据和信息传送他不关注；而XMPP重点是考虑终端内部的数据交换，连接建立是基本的功能，而不是重点。所以，XMPP对应用的支持和扩展性的考虑很充分,比SIP天生要好.
2,SIP 的信令和消息传送是基于文本的，不太好解析,或者说解析起来缺少规律性,在新增数据消息体的时候缺少继承性,需要开发新的代码来封装和解析,原有代码的继 承性比较差。而XMPP采用XML，是一种结构化的消息结构，能够方便地表达层次化的内容，以及内容之间的内在逻辑。这种XML结构对应用的扩展和内容的 解析带来极大的方便，大量软件代码可以复用。
3,SIP信令由header和body两部分组成，也就是说，SIP报文格式的header已经包含了部分内容,类似于HTTP,与具体的上层应用直接关联，而不是通用的报文格式；而XMPP所有信息都是采用XML在流管道之间透明传送。
SIP的连接建立通道与数据传送通道是各自独立的，连接建立在SIP client与Server之间，而数据传送通道是在Client--Client之间直接进行的。这个对视频、语音和文件传送业务很合适，但是不适合其他形式的应用。
XMPP的控制和数据通道是一体的，Clent 只与Server建立连接，而Client与Client之间是没有之间连接的。Client之间传送的通道是：Client1---〉 Server1---〉Server2---〉Client2。这种方式看起来扩展性差，server压力很大，但是能够实现很好的业务功能，比如留言、 广播、群聊、状态更新、Blog、微博、数据共享等等。
这种C-S模型，很多业务的控制在Server上完成，新功能的增加在server上实现，在server上定义新的XML对象和逻辑，客户端只要负责XML数据流的解析和呈现就可以了, 所以，终端实现简单
4,SIP可以使用UDP,TCP,TLS进行传送,而XMPP仅仅使用TCP和TLS进行发送.
5,SIP 是双向对称，客户端和服务器都可以主动发起连接请求并响应，这种对称连接的方式在穿越NAT和Firewall的时候很麻烦，无法保证穿越NAT。而 XMPP是单向的连接，只有Client可以向Server发起连接请求，Server不会向Client发起连接。这样便于NAT和Firewall的 穿越。
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
折腾了一个多星期终于将kurento的环境搭建好（开发阶段的产品，有些BUG要自己解决），所以单独写篇文件来介绍。
&nbsp;
下面开始介绍kurento，文章来自博客园RTC.Blacker，转载请说明出处。
&nbsp;
&nbsp;
&nbsp;
一、kurento是什么？
&nbsp;
搞视频会议就会涉及一对多、多对多、广播、转码、混音、合屏、录制，这就需要用到流媒体服务器，而kurento就具有这些功能。
&nbsp;
他主要用来作为webrtc的流媒体服务器，因为BUG多，目前不适于商用，不过前景可期，具体说明见下图：
&nbsp;
<img src="https://images0.cnblogs.com/blog/77236/201501/182038355421751.png" alt="">
&nbsp;
说明：
&nbsp;
1、看到这里您可不要讲他的功能和ICE服务器的功能给搞混了哦，后者主要用来做NAT穿透和转发的。
&nbsp;
&nbsp;
&nbsp;
二、kurento架构
&nbsp;
<img src="https://images0.cnblogs.com/blog/77236/201501/182050223703191.png" alt="">
&nbsp;
说明：
&nbsp;
1、客户端对音视频数据的采集和播放等是通过webrtc来处理的，传输模块就是kurento的。
&nbsp;
2、流媒体服务是他的核心服务，可以进行编解码，混音，录制，计算机视觉，视觉增强等等。
&nbsp;
&nbsp;
&nbsp;
三、特色功能---计算机视觉
&nbsp;
<img src="https://images0.cnblogs.com/blog/77236/201501/182103066989531.png" alt="">
&nbsp;
说明：
&nbsp;
1、服务端可以对收到的视频流进行处理，如人脸识别，这些扩展下去应用前景就很广泛了，期待！
&nbsp;
2、因为他对图像进行了处理，所以延迟会比较大，识别率还存在些问题，而且会造成图像闪动（可能也是跟延迟有关）。
&nbsp;
3、其他功能如一对一，广播就不重复了，很多其他流媒体服务都具有这些功能。
&nbsp;最后：虽然kurento目前问题很多，但我看好他，后面会继续分享相关内容，也会和他们一起去完善这个东西。
&nbsp;
&nbsp;
&nbsp;
&nbsp;
### 开源项目
<a href="http://baike.baidu.com/view/2919586.htm" target="_blank">开源软件无线电</a>技术对通信的各个行行业业影响颇深，SIP也不例外。GNU Radio 是免费的<a href="http://baike.baidu.com/view/973702.htm" target="_blank">软件开发工具</a>套件。它提供信号运行和处理模块，用它可以在易制作的低成本的射频（RF）硬件和<a href="http://baike.baidu.com/view/1315649.htm" target="_blank">通用微处理器</a>上 实现软件定义无线电。这套套件广泛用于业余爱好者，学术机构和商业机构用来研究和构建无线通信系统。GNU Radio 的应用主要是用 Python 编程语言来编写的。但是其核心信号处理模块是C++在带浮点运算的微处理器上构建的。因此，开发者能够简单快速的构建一个实时、高容量的无线通信系统。尽 管其主要功用不是仿真器，GNU Radio 在没有射频 RF 硬件部件的境况下支持对预先存储和（信号发生器）生成的数据进行信号处理的算法的研究。```
### <a class="anchor-2" name="7_2"></a><a class="anchor-2" name="sub8100741_7_2"></a><a class="anchor-2" name="相关技术_5Java"></a>5Java
在这里,我只讨论与java相关的SIP技术，其实实现SIP的技术有多种，比如CGI.```
java为SIP提供了非常好的支持，JCP（Java Community Process）组织推动开发的一套基于Java技术的API:JAIN API(Java API for Integrated Networks),它包含JAIN SIP(JAIN SIP Lite)和SIP Servlet(JSR 116),SIP for J2ME,三个规范.```
以下为与java相关的SIP技术：```
JAIN SIP API (JSR 32)```
SIP Servlet API (JSR 116)```
JAIN SIP Lite (JSR 125)```
SIP API for J2ME (JSR 180)```
JAIN SIMPLE Presence (JSR 164)```
JAIN SIMPLE Instant Messaging (JSR 165)```
JAIN SDP (JSR 141) SIP描述协议```
Java Media Framework for RTP (J2SE可选包，并非JAIN的)```
SIP for J2ME:(JSR 180 )```
JAIN SIP API主要提供了J2SE平台的<a href="http://baike.baidu.com/view/2506631.htm" target="_blank">SIP协议栈</a>的 实现，主要面向桌面的J2SE应用；SIP Servlet API主要为面向服务端的SIP程序提供了一个API规范，如今实现了该规范的应用服务器有BEA Weblogic SIP Server和Micromethod,还有Jiplet Container,至于如何开发sip servlet,可参见参考资料.SIP for J2ME主要为面向手机的CLDC设备的J2ME客户端.它们之间的差别在参考资料[6]中讲解得很详细.```
其它Java相关技术：```
jiplet: 一个支持sip servlet的应用服务器```
nist-sip SIP Libraries and Tools```
JAIN Service Logic Execution Environment (SLEE)```


```


```