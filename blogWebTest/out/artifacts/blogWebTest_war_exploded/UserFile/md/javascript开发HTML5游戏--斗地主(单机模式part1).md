　 &nbsp; 最近学习使用了一款HTML5游戏引擎(<a href="http://www.zuoyouxi.com/" target="_blank">青瓷引擎</a>)，并用它尝试做了一个斗地主的游戏，简单实现了单机对战和网络对战，代码可已放到github上，在此谈谈自己如何通过引擎来开发这款游戏的。
　<a href="https://github.com/liyl1991/landlord" target="_blank">客户端代码</a>
&nbsp; &nbsp;<a href="https://github.com/liyl1991/landlordServer" target="_blank">服务端代码</a>

&nbsp;　　　　　　　
本篇文章为第一部分，主要包括单机模式的开始布局设计准备。主要内容如下：

<ol>
- 斗地主游戏介绍
- 创建工程与主场景
- 单机模式场景布局
- 添加图形资源
</ol>


## 二、创建工程与主场景
　　使用<a href="http://www.zuoyouxi.com/" target="_blank">青瓷引擎</a>的编辑器很容易帮我完成整个游戏界面的布局。做这个游戏之前我从事java开发，也做过一段时间的前端开发，对js和前端布局算是比较熟悉。结合官方的手册、demo，我大概花了两三天时间把这些过了遍，尝试修改完善一些demo的内容，接下来我就开始自己尝试做这个游戏了。个人感觉有强大的编辑器，布局可以比较迅速的完成，然后专注地进行逻辑编写。
　　我的想法是把单机和多人对战分成两个场景，创建项目工程landlord和主场景，其中main是主场景，single是单机版的场景，online是在线对战的场景。
<img src="https://images2015.cnblogs.com/blog/870330/201512/870330-20151231142702010-1550700131.png" alt="">
### 　　入口与游戏的初始化
　　　　在Scripts下创建start.js，并配置为入口脚本，`此脚本首先定义了名字空间，将全局的数据都记录在这里`。代码如下：
&nbsp;
```python<img id="code_img_closed_d9d2d459-bfc9-4a93-896c-a661463429a8" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_d9d2d459-bfc9-4a93-896c-a661463429a8" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1 // 定义本工程的名字空间
 2 qc.landlord = {};
 3 
 4 // 用来存放所有的全局数据（函数、变量等）
 5 window.G = qc.landlord.G = {};
 6 
 7 // 初始化逻辑
 8 qc.initGame = function(game) {
 9     game.log.trace('Start the game landlord.');
10     // 将game实例的引用记录下来，方便在其他逻辑脚本模块中访问
11     G.game = game;
12     //游戏规则
13     G.gameRule = new qc.landlord.GameRule();
14 
15     G.online = new qc.landlord.Online();
16     //AI逻辑
17     //G.AILogic = new qc.landlord.AILogic();
18     String.prototype.trim = function() {  return this.replace(/(^\s*)|(\s*$)/g,'');  };
19 };
```
View Code```
&nbsp;
　　　　点击start.js脚本，在右侧的Inspector面板下点击edit，把start.js拖入并放置到第一的位置就成为入口脚本了。
### 　　主场景设计
　　　　
```python<img id="code_img_closed_33cc2b96-6f08-444b-b377-299de9435b98" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_33cc2b96-6f08-444b-b377-299de9435b98" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

  1 /**
  2  * 主场景脚本
  3  * @method defineBehaviour
  4  */
  5 var MainUI = qc.defineBehaviour('qc.engine.MainUI', qc.Behaviour, function() {
  6     this.singleBtn = null;
  7     this.multiBtn = null;
  8     this.singleScene = null;
  9 }, {
 10     singleBtn : qc.Serializer.NODE,
 11     multiBtn: qc.Serializer.NODE,
 12     enterNameBtn : qc.Serializer.NODE,
 13     backBtn: qc.Serializer.NODE,
 14     nameField: qc.Serializer.NODE,
 15     enterNamePanel: qc.Serializer.NODE,
 16     message: qc.Serializer.NODE,
 17     singleScene: qc.Serializer.STRING,
 18     multiScene: qc.Serializer.STRING
 19 });
 20 
 21 // Called when the script instance is being loaded.
 22 MainUI.prototype.awake = function() {
 23     var self = this;
 24     //单机按钮事件
 25     self.addListener(self.singleBtn.onClick, function(){
 26         self.game.state.load(self.singleScene, false, function() {
 27             //牌组管理
 28             G.cardMgr = new qc.landlord.Card();
 29             //玩家本人
 30             G.ownPlayer = new qc.landlord.Player('QCPlayer');
 31             G.ownPlayer.isAI = false;
 32             var storage = G.game.storage;
 33             var ownScore = storage.get('QCPlayer');
 34             G.ownPlayer.score = ownScore ? ownScore : 500;
 35             //电脑玩家(左)
 36             G.leftPlayer = new qc.landlord.Player('AI_Left');
 37             var leftScore = storage.get('AI_Left');
 38             G.leftPlayer.score = leftScore ? leftScore : 500;
 39             //电脑玩家(右)
 40             G.rightPlayer = new qc.landlord.Player('AI_Right');
 41             var rightScore = storage.get('AI_Right');
 42             G.rightPlayer.score = rightScore ? rightScore : 500;
 43 
 44             //指定玩家顺序
 45             G.ownPlayer.nextPlayer = G.rightPlayer;
 46             G.rightPlayer.nextPlayer = G.leftPlayer;
 47             G.leftPlayer.nextPlayer = G.ownPlayer;
 48 
 49             //底牌
 50             G.hiddenCards = [];
 51             //当前手牌
 52             G.currentCards = [];
 53         }, function() {
 54             console.log(self.singleScene + '场景加载完毕。');
 55         });
 56     }, self);
 57 
 58     //多人对战按钮事件
 59     self.addListener(self.multiBtn.onClick, function(){
 60 
 61         var uid = G.game.storage.get('uid');
 62         if(uid){
 63             self.showMessage(self.MSG_WAITING);
 64             self.enterGame(uid);
 65         } else {
 66             var np = self.enterNamePanel.getScript('qc.TweenAlpha');
 67             np.from = 0;
 68             np.to = 1;
 69             np.resetToBeginning();
 70             self.enterNamePanel.visible = true;
 71             np.playForward();
 72         }
 73 
 74     }, self);
 75 
 76     //确认按钮事件
 77     self.addListener(self.enterNameBtn.onClick, function(){
 78         var nickname = self.nameField.text.trim();
 79         if(nickname){
 80             self.showMessage(self.MSG_WAITING);
 81             var result = G.online.register(nickname);
 82             result.then(function(data){
 83                 if(data.uid){
 84                     G.game.storage.set('uid', data.uid);
 85                     G.game.storage.save();
 86                     self.enterGame(data.uid);
 87                 } else if(err === G.online.ERR_EXIST_NAME){
 88                     self.showMessage(self.MSG_EXIST_NAME);
 89                 }
 90             }).catch(function(err){
 91                 if(err === G.online.ERR_EXIST_NAME){
 92                     self.showMessage(self.MSG_EXIST_NAME);
 93                 }
 94             });
 95         }
 96     }, self);
 97 
 98     //返回按钮事件
 99     self.addListener(self.backBtn.onClick, function(){
100         var np = self.enterNamePanel.getScript('qc.TweenAlpha');
101         np.from = 1;
102         np.to = 0;
103         np.resetToBeginning();
104         //self.enterNamePanel.visible = true;
105         np.playForward();
106         np.onFinished.addOnce(function (){
107             self.enterNamePanel.visible = false;
108         }, self);
109         window.onbeforeunload = undefined;
110     }, self);
111 };
112 
113 MainUI.prototype.enterGame = function(uid) {
114     var self = this;
115     G.ownPlayer = new qc.landlord.Player(null);
116     G.ownPlayer.uid = uid;
117     window.onbeforeunload = function (){
118         var warning="确认退出游戏?";
119         return warning;
120     };
121     G.online.joinGame(G.ownPlayer.uid).then(function(data){
122         var player = data.seats ? data.seats[data.ownSeatNo] : data.desk.seats[data.ownSeatNo];
123         G.ownPlayer.deskNo = player.deskNo;
124         G.ownPlayer.name = player.name;
125         G.ownPlayer.seatNo = data.ownSeatNo;
126         G.netInitData = data;
127         self.game.state.load(self.multiScene, false, function() {
128         }, function() {
129             console.log(self.multiScene + '场景加载完毕。');
130         });
131     });
132 };
133 
134 MainUI.prototype.showMessage = function(m) {
135     var self = this;
136     if(m){
137         self.message.text = m;
138         self.message.visible = true;
139     } else {
140         self.message.visible = false;
141     }
142 };
143 
144 MainUI.prototype.MSG_WAITING = '请稍等';
145 MainUI.prototype.MSG_EXIST_NAME = '您输入的昵称已被使用，请重试';
```
View Code```
## 三、单机模式场景布局
### 　　游戏主体
　　斗地主主要的主体就是玩家、纸牌，制作主场景之前，先编写好这两个实体类
　　玩家类设计：在Scripts/logic创建player.js代码如下：
```python<img id="code_img_closed_d364f03e-b34d-4a33-b37f-7b3ec4bbcad6" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_d364f03e-b34d-4a33-b37f-7b3ec4bbcad6" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1 // define a user behaviour
 2 var Player = qc.landlord.Player = function (n){
 3     var self = this;
 4     // 玩家名
 5     self.name = n ? n : 'Player';
 6     //是否是地主
 7     self.isLandlord = false;
 8     //是否是AI玩家
 9     self.isAI = true;
10     //牌组
11     self.cardList = [];
12     //下一家
13     self.nextPlayer = null;
14     //以下属性用于多人对战
15     self.uid = null;
16     self.deskNo = null;
17     self.seatNo = null;
18     //是否已经准备
19     self.isReady = false;
20     //是否已经离开
21     self.isLeave = false;
22 };
23 Object.defineProperties(Player.prototype, {
24     score: {
25         get: function(){
26             return this._score;
27         },
28         set: function(v){
29             this._score = v;
30             var storage = G.game.storage;
31             storage.set(this.name, v);
32             storage.save();
33         }
34     }
35 });
```
View Code```
　　牌组类设计：在Scripts/logic/clone创建card.js代码如下：
```python<img id="code_img_closed_260f41a9-b9ee-44cc-a4b1-3fe22e56fe9f" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_260f41a9-b9ee-44cc-a4b1-3fe22e56fe9f" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1 // define a user behaviour
 2 var Card = qc.landlord.Card = function (){
 3     this.data = [
 4         {icon: 'j1.jpg', type: '0', val: 17},
 5         {icon: 'j2.jpg', type: '0', val: 16},
 6         {icon: 't1.jpg', type: '1', val: 14},
 7         {icon: 't2.jpg', type: '1', val: 15},
 8         {icon: 't3.jpg', type: '1', val: 3},
 9         {icon: 't4.jpg', type: '1', val: 4},
10         {icon: 't5.jpg', type: '1', val: 5},
11         {icon: 't6.jpg', type: '1', val: 6},
12         {icon: 't7.jpg', type: '1', val: 7},
13         {icon: 't8.jpg', type: '1', val: 8},
14         {icon: 't9.jpg', type: '1', val: 9},
15         {icon: 't10.jpg', type: '1', val: 10},
16         {icon: 't11.jpg', type: '1', val: 11},
17         {icon: 't12.jpg', type: '1', val: 12},
18         {icon: 't13.jpg', type: '1', val: 13},
19         {icon: 'x1.jpg', type: '2', val: 14},
20         {icon: 'x2.jpg', type: '2', val: 15},
21         {icon: 'x3.jpg', type: '2', val: 3},
22         {icon: 'x4.jpg', type: '2', val: 4},
23         {icon: 'x5.jpg', type: '2', val: 5},
24         {icon: 'x6.jpg', type: '2', val: 6},
25         {icon: 'x7.jpg', type: '2', val: 7},
26         {icon: 'x8.jpg', type: '2', val: 8},
27         {icon: 'x9.jpg', type: '2', val: 9},
28         {icon: 'x10.jpg', type: '2', val: 10},
29         {icon: 'x11.jpg', type: '2', val: 11},
30         {icon: 'x12.jpg', type: '2', val: 12},
31         {icon: 'x13.jpg', type: '2', val: 13},
32         {icon: 'h1.jpg', type: '3', val: 14},
33         {icon: 'h2.jpg', type: '3', val: 15},
34         {icon: 'h3.jpg', type: '3', val: 3},
35         {icon: 'h4.jpg', type: '3', val: 4},
36         {icon: 'h5.jpg', type: '3', val: 5},
37         {icon: 'h6.jpg', type: '3', val: 6},
38         {icon: 'h7.jpg', type: '3', val: 7},
39         {icon: 'h8.jpg', type: '3', val: 8},
40         {icon: 'h9.jpg', type: '3', val: 9},
41         {icon: 'h10.jpg', type: '3', val: 10},
42         {icon: 'h11.jpg', type: '3', val: 11},
43         {icon: 'h12.jpg', type: '3', val: 12},
44         {icon: 'h13.jpg', type: '3', val: 13},
45         {icon: 'k1.jpg', type: '4', val: 14},
46         {icon: 'k2.jpg', type: '4', val: 15},
47         {icon: 'k3.jpg', type: '4', val: 3},
48         {icon: 'k4.jpg', type: '4', val: 4},
49         {icon: 'k5.jpg', type: '4', val: 5},
50         {icon: 'k6.jpg', type: '4', val: 6},
51         {icon: 'k7.jpg', type: '4', val: 7},
52         {icon: 'k8.jpg', type: '4', val: 8},
53         {icon: 'k9.jpg', type: '4', val: 9},
54         {icon: 'k10.jpg', type: '4', val: 10},
55         {icon: 'k11.jpg', type: '4', val: 11},
56         {icon: 'k12.jpg', type: '4', val: 12},
57         {icon: 'k13.jpg', type: '4', val: 13}
58     ];
59 };
60 //拷贝牌组，返回一组新的牌组
61 Card.prototype.getNewCards = function () {
62     return this.data.slice(0);
63 };
```
View Code```
### 　　添加预制
　　在开始做主场景之前，需要做一些预制(<a href="http://docs.zuoyouxi.com/manual/Prefab/index.html" target="_blank">点击我看文档</a>)，方便后面调用。主要还是围绕玩家、纸牌进行，引擎在这方面也给我们提供了很强大的支持：
<ol>
- 首先是纸牌预制，纸牌比较简单，只是张图片，默认显示的是纸牌的背面图案，我们在图片节点下挂载一个脚本，Scripts/ui下创建CardUI.js并挂载，代码如下：
</ol>
```python<img id="code_img_closed_3b214bce-3273-4117-a0f4-f2f47d31ca11" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_3b214bce-3273-4117-a0f4-f2f47d31ca11" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1 /**
 2  * 卡牌规则
 3  */
 4 var CardUI = qc.defineBehaviour('qc.engine.CardUI', qc.Behaviour, function() {
 5     this.isSelected = false;
 6     this.info = null;
 7 }, {
 8     // fields need to be serialized
 9 });
10 
11 /**
12   *显示纸牌，
13   *@property info 卡牌信息，
14   *@property isSelect 是否选中
15   */
16 CardUI.prototype.show = function (info, isSelect){
17     var self = this,
18         o =self.gameObject;
19     if(info){
20         o.frame = info.icon;
21         o.resetNativeSize();
22         o.visible = true;
23         self.info = info;
24     }
25 };
26 
27 /**
28   * 选中纸牌，纸牌上移
29   */
30 CardUI.prototype.onClick = function (){
31     var self = this;
32     if(self.isSelected){
33         this.gameObject.anchoredY = 0;
34     } else {
35         this.gameObject.anchoredY = -28;
36     }
37     self.isSelected = !self.isSelected;
38     var ui = window.landlordUI ? window.landlordUI : window.olLandlordUI;
39     if(ui.getReadyCardsKind()){
40         ui.playBtn.state = qc.UIState.NORMAL;
41     } else {
42         ui.playBtn.state = qc.UIState.DISABLED;
43     }
44 };
```
View Code```
　
　　每个玩家下都要挂载一个脚本，主要是方便我们后面去查找它的内容，这个比如修改分数，修改手牌数之类的操作，代码如下：

```python<img id="code_img_closed_83114eb1-5a04-4d15-9d5d-8d448c384ca3" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_83114eb1-5a04-4d15-9d5d-8d448c384ca3" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1 // define a user behaviour
 2 var PlayerUI = qc.defineBehaviour('qc.engine.PlayerUI', qc.Behaviour, function() {
 3     // need this behaviour be scheduled in editor
 4     //this.runInEditor = true;
 5     this.player = null;
 6 }, {
 7     headPic : qc.Serializer.NODE,
 8     playerScore : qc.Serializer.NODE,
 9     cardContainer : qc.Serializer.NODE
10 });
```
View Code```
　　3、信息预制：这个预制只是个文字，做这个预制主要用于叫分出牌的时候，比如给某个玩家显示 2分 、不叫、 不出之类的信息，这样直接加入不需要再去设置字体大小的信息。
### 　　布局设计
　　单机模式场景，我大致划分为以下几个模块，具体可以使用<a href="http://www.zuoyouxi.com/" target="_blank">青瓷引擎</a>编辑器打开，这种所见即所得的工具应该很快就能了解整个场景界面的布局设计,如图：
　
　　
## 四、添加图形资源
&nbsp;
　　导入图形资源并打包图集(<a href="http://docs.zuoyouxi.com/manual/Atlas/index.html" target="_blank">点击我看文档</a>),
　　将所有的扑克牌图形资源到Assets/atlas/poker@atlas下,身份头像图形资源到Assets/atlas/landlord@atlas,按钮图形资源到Assets/atlas/btn@atlas。
### 　 &nbsp;做完这些准备我们就可以进行做发牌的了，我将会在下一篇文章分享这些内容
&nbsp;
&nbsp;
&nbsp;
&nbsp;
　　