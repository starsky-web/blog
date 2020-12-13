**引子**
Patrick Catanzariti 是一名Web开发工程师，最近他在 <a href="http://www.sitepoint.com/">sitepoint</a> 发表了《<a href="http://www.sitepoint.com/javascript-beyond-web-2014/">JavaScript Beyond the Web in 2014</a>》，介绍了JavaScript在物联网中的应用，非常有意思。做为JavaScript的爱好者和从业者，我在这里把它翻译了，以飨读者。 顺便说一下，就在上周，我们团队的最新力作“真正的JavaScript控件集”----《**<a href="http://www.gcpowertools.com.cn/company/news_wijmo5release.htm">新一代JavaScript控件Wijmo 5正式发布</a>**》啦。
### 前言
近十年来Javascript的发展速度非常快，伴随着Ajax，Node.js等技术的出现，Javascript已经成为编程语言中的一等公民，在Web应用、移动应用以及Web Server端，都可以看见Javascript。在另外一个领域：物联网（Internet of Things）、智能家居领域，Javascript也有很广泛的应用。最激动人心的是通过Javascript你可以用来控制移动电话、开关灯具、机器人等等。
去年我写了一篇文章《<a href="http://www.sitepoint.com/javascript-beyond-web/">JavaScript Beyond the Web</a>》介绍了Javascript在物联网内的应用。一年过去了，很多新的技术以及智能设备涌现，接下来我们会回顾一下Javascript在这些智能设备上的应用，透过这些这能设备，也许你会有更多的发现。
过去的几个月内，具有Javascript交互能力的智能设备在逐渐增多。通过智能设备厂商公布的Javascript API文档，以及社区技术的推进力量，我们确实可以发现越来越多的设备正在具有Javascript交互能力。
### 智能家居产品
### Ninja Sphere
<a href="https://images0.cnblogs.com/blog/139239/201410/141120316072375.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141120333735946.png" alt="image" width="592" height="344" border="0"></a>
Ninja Sphere 是由来自澳大利亚的Ninja Blocks团队推出的下一代的智能家居控制器，这个智能设备可以把各种各样的电子设备加入物联网，并且通过它可以一一控制这些设备。Ninja Sphere能够远程操控已连接的设备，可以通过手势控制以及查看设备所在位置等等。目前Ninja Sphere可以支持包括具有Bluetooth，BLE，Wi-Fi，Zigbee连接的设备。
##### JavaScript交互能力
Javascript开发人员可以通过 Ninja Sphere Node.js library 来进行Ninja Sphere应用程序的开发，甚至通过Javascript可以在Ninja Sphere中编写设备驱动以及设备定义，这无疑是Javascript开发人员的梦想。
#### Leap Motion
<a href="https://images0.cnblogs.com/blog/139239/201410/141120459662127.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141120482167014.png" alt="image" width="657" height="328" border="0"></a>
<a href="https://www.evernote.com/OutboundRedirect.action?dest=https%3A%2F%2Fwww.leapmotion.com%2F">Leap Motion</a> 是一个非常好玩的小装置，可以通过手势来控制设备以及应用程序。它可以感知双手在空气中的自然移动，精确跟踪手和手指的运动。以及手指的动作。
##### 在V2版本他们提高了手指追踪的稳定性，现在甚至可以单独追踪手指上的每一个手骨。另外V2版本还提供了另外一个激动人心的特性：虚拟现实，把你的双手带进虚拟的3D世界。更多参见：Leap Motion ＋ 虚拟现实。
##### Leap Motion为Javascript开发人员提供了一个Javascript SDK，并且提供了详尽的文档以及大量的例子，更多参见Leap Motion JavaScript framework 。
#### Pebble Watch
<a href="https://images0.cnblogs.com/blog/139239/201410/141120504197887.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141120516697602.png" alt="image" width="674" height="406" border="0"></a>
##### 我个人是一个非常狂热的<a href="http://getpebble.com/">Pebble watch</a>爱好者，在Apple Watch和Google Wear出现之前，Prebble watch就是一款真正的智能手表，易于使用，但是有着难以置信的功能，同时支持iOS和Android平台。采用了E-Paper显示屏，即便在阳光直射下也容易读取，耗电量也很低，每周需要冲一次。
#### JavaScript交互能力
PebbleKit JavaScript framework ：这个框架允许开发人员从云上获取数据，获取设备的物理位置信息等等，为Pebble Watch来构建用户体验非常好的应用程序。手表端的App开发需要一些C代码，但是无需太多的C代码程序编写经验，你可以从官方的例子出发，通过Javascript来构建功能非常强大的手表应用。下面的几篇文章介绍了如何通过Javascript来编写Pebble Watch应用：

- <a href="http://www.sitepoint.com/pebble-watch-development-javascript/">Pebble Watch Development with JavaScript</a> – Pebble手表Javascript编程入门。
- <a href="http://www.sitepoint.com/advanced-pebble-watch-configuration/">Advanced Pebble Watch Configuration</a> – 如何配置Pebble Javascript手表应用。
- Pebble.js – Pebble官方发布的Javascript框架，目前还是beta版本，未来几个月会发布正式版本。

#### Oculus Rift
<a href="https://images0.cnblogs.com/blog/139239/201410/141120527941047.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141120535916689.png" alt="image" width="627" height="422" border="0"></a>
虚拟现实头盔Oculus Rift让我们比以往任何时候都更加接近虚拟现实，今年他们发布新版机器：“Crescent Bay”，以及最新的开发工具包：<a href="http://www.oculus.com/dk2/">The Developer Kit 2</a>。与此同时Oculus 与三星联合发布了<a href="http://www.36kr.com/p/212486.html">移动式虚拟现实头戴设备Gear VR</a>，该设备可与三星手机配套使用，实现虚拟现实互动效果。
#### JavaScript交互能力
#### OculusBridge ：一个桌面应用程序，包含了一个Javascript库，开发人员可以基于 Three.js 来构建Oculus Rift Web体验，支持Windows和Max OSX，可以在Chrome 28，Safari 6以及Firefox 22以上的版本工作。它并没有提到IE浏览器，我不能缺失它是否支持IE。
#### vr.js ：一个Chrome和Firefox插件，可以操作Oculus Rift虚拟现实头盔，但是它需要NPAPI接口，而Google Chrome已经放弃对该标准的支持，建议使用OculusBridge代替。
#### Babylon.js and IE11 ：如果你正在使用Windows以及IE 11，你可以通过<a href="http://www.babylonjs.com/">Babylo</a><a href="http://www.babylonjs.com/">n.js</a>创建一个3D环境，可以构建Oculus Rift虚拟现实体验。
#### Cylon
<a href="https://images0.cnblogs.com/blog/139239/201410/141120594664451.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121004987866.png" alt="image" width="664" height="378" border="0"></a>
<a href="http://cylonjs.com/">Cylon.js</a> 是一个 JavaScript 框架，用来进行机器人以及物联网开发。Cylon.js 使得开发人员可以使用同样的API来操纵不同的设备，这些设备的名单正在逐渐扩大，包括Leap Motion，Pebble手表，Arduinos和Raspberry Pis等等。
##### Arduino YUN
<a href="https://images0.cnblogs.com/blog/139239/201410/141121019517110.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121046389299.png" alt="image" width="661" height="489" border="0"></a>
##### Arduino YUN 是Arduino发布的最新新列的无线产品，合并了 Arduino 架构和 Linux 系统，Arduino 希望借此产品整合 Linux 强大的功能和 Arduino 的易用性。
Javascript交互能力

- <a href="http://www.appsaloon.be/blog/node-js-arduino-yun/">Installing Node.js on the Arduino YUN</a> ： 对于Javascript开发人员来讲，Linux意味着可以安装 Node.js 到Arduino上，然后执行Javascript代码。
- <a href="http://cylonjs.com/documentation/platforms/yun/">Cylon.js module</a>：支持Arduino YUN的Cylon模块。

#### Spark OS
<a href="https://images0.cnblogs.com/blog/139239/201410/141121072948542.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121095605903.png" alt="image" width="638" height="472" border="0"></a>
Spark OS 是一个基于云的，物联网操作系统。该团队还拥有Spark Core，Spark Core 是一款完全兼容 Arduino的WiFi开发板，可以让工程师开发出任意与网络连接的硬件设备。通过Spark OS云服务可以给Spark Core设备发送指令。
Javascript交互能力

- <a href="http://docs.spark.io/javascript/">Official Spark JavaScript SDK</a>：官方的Javascript SDK。
- spark-ii：用来与Spark设备交互的IO库。
- Sparky：一个非常简单的 Node.js 库。
- <a href="http://cylonjs.com/documentation/platforms/spark/">Cylon.js module</a>：支持Spark OS的Cylon模块。

#### Tessel
<a href="https://images0.cnblogs.com/blog/139239/201410/141121119661603.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121142166490.png" alt="image" width="585" height="435" border="0"></a>
Tessel 是一款与 Arduino 和 Spark Core 很类似的板子，但是 Tessel可以直接运行Javascript代码，几乎专门为Javascript开发人员设计。它完全兼容基于 Node.js 的各种 package包，可以很好的利用现有的很多资源。
Javascript交互能力

- Official Tessel docs ：官方文档，非常多的例子。
- <a href="http://cylonjs.com/documentation/platforms/tessel">Cylon.js module</a>：支持Tessel的Cylon模块。

#### Espruino
<a href="https://images0.cnblogs.com/blog/139239/201410/141121159664292.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121179983880.png" alt="image" width="581" height="446" border="0"></a>
Espruino是一个微处理器的JavaScript解释器，号称是全球第一款面向初学者或专家级玩家的Javascript单片机，可以实时的执行你的Javascript。
Javascript交互能力

- <a href="http://www.espruino.com/Quick+Start">Official Espruino docs</a> ：官方文档。
- node-espruino ：一个第三方的Node库，借助于它可以通过Node.js与Espruino进行交互。

#### Intel Galileo
<a href="https://images0.cnblogs.com/blog/139239/201410/141121197945695.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121234041799.png" alt="image" width="595" height="420" border="0"></a>
Intel Galileo是Intel推出的采用x86 构架的 Arduino 开发板，与Arduino YUN一样，Galileo在板子上也运行着Linux。
Javascript交互能力

- The “bigger” Linux image with Node.js：来自SparkFun的文章，介绍了Intel Galileo如何使用SD卡启动Linux。
- <a href="http://bocoup.com/weblog/intel-galileo-javascript-nodejs/">Intel Galileo Programming with JavaScript and Node.js</a> ：非常好的参考文章关于Intel Galileo，Javascript以及Node.js。
- <a href="http://cylonjs.com/documentation/platforms/galileo/">Cylon</a>：支持Intel Galileo的Cylon模块。
- Galileo-IO module for Johnny-Five：Javascript IO交互模块。

#### Google Cardboard
<a href="https://images0.cnblogs.com/blog/139239/201410/141121285443702.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121303885233.png" alt="image" width="597" height="431" border="0"></a>
今年的Google I/O大会上最有趣的话题就是：Google Cardboard。一款虚拟现实的纸盒，它的外形虽不起眼，但在完全组装完成后，Cardboard可以利用用户的智能手机和内置的一副镜片，为用户提供虚拟现实体验。官方的文章主要在讲述如何进行原生的Andriod开发，但是通过Javascript也可以在Chrome进行虚拟现实的体验。
##### JavaScript交互能力

- <a href="http://vr.chromeexperiments.com/">Cardboard Chrome Experiments</a> ：包含了大量的演示程序，以及代码示例。

#### Myo Armband
<a href="https://images0.cnblogs.com/blog/139239/201410/141121318106233.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121347942278.png" alt="image" width="624" height="392" border="0"></a>
炫酷手势臂环 Myo Armband 允许用户戴在胳膊前臂上，可以通过动作命令来控制电脑，通过对动作和脑电活动的检测，Myo Armband可以识别出用户的手势活动。
##### JavaScript交互能力

- MyoJS：一个非官方的Myo Armband Javascript 框架。

#### Nest
<a href="https://images0.cnblogs.com/blog/139239/201410/141121361698264.png"><img style="background-image: none; padding-top: 0; padding-left: 0; display: inline; padding-right: 0; border-width: 0" title="image" src="https://images0.cnblogs.com/blog/139239/201410/141121372168450.png" alt="image" width="539" height="543" border="0"></a>
Nest 团队现在有两种智能设备，智能温控器（Nest thermostat）和烟雾报警器（Nest Protect）。今年他们推出了Nest开发者计划，并且公布了Nest API。尽管并没有Javascript API的说明文档，但是提供了Javascript操作Nest API的两个示例程序。
Javascript交互能力

- Official sample JS for the Nest Thermostat：智能温控器官方示例。
- Official sample JS for the Nest Protect：烟雾报警器官方示例。
- <a href="http://cylonjs.com/documentation/platforms/nest">Cylon.js </a>模块：支持Nest的Cylon模块。

#### 结论
如同你看到的，大量的具有Javascript交互能力的智能设备正在快速增长，限于篇幅本文只列举了上面的设备。在物联网领域Javascript开发人员还有很多可以做的事情，那么就先从你的设备开始吧！
&nbsp;
**相关阅读：**
<a href="http://www.cnblogs.com/powertoolsteam/p/Angular_Wijmo.html" target="_blank">开放才能进步！Angular和Wijmo一起走过的日子</a>
<a href="http://www.cnblogs.com/powertoolsteam/p/angular_react.html" target="_blank">Angular vs React 最全面深入对比</a>
<a href="http://wijmo.gcpowertools.com.cn/wijmo-build-5-20171-293-available/" target="_blank">Wijmo已率先支持Angular4 &amp; TypeScript 2.2</a>
&nbsp;