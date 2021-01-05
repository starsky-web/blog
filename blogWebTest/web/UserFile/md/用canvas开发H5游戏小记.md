　　自神经猫风波之后，微信中的各种小游戏如雨后春笋般目不暇接，这种低成本，高效传播的案例很是受开发者青睐。作为一名前端，随手写个这样的小游戏出来应该算是必备技能吧。恰逢中秋节，部门决定上线一个小游戏，在微信里传播一下与用户互动互动。这任务自然落在了我头上。前段时间用DOM+CSS3写了个小游戏，在Android机器上巨卡无比，有了上次的经验，这次决定用canvas来写。其实这些小游戏在业界也都是canvas来做，已经有很成熟的技术和框架，由于不会频繁修改DOM树，所有的动画都是在一块画布上完成，所以在手机上的效果比DOM要优秀很多。```
　　楼主本人用canvas做游戏的经验为0，只在大学的时候鼓捣过一次，知识全部忘却了。这次也是边学边做，鉴于游戏逻辑比较简单，鼓捣了一天，终于搞出一个能玩的了。在此把实现原理记录一下。也给像我这样的初上手的一些参考资料。```
　　先来说说这个游戏，名字叫玉兔吃月饼，很有中秋的氛围哈~玩法非常简单，用手指触控屏幕来控制一只开着飞碟的兔子移动，天上会不停掉月饼，有好月饼和坏月饼之分，吃到好月饼就得分，吃到坏月饼就挂掉。主要逻辑就这么简单。看一下游戏的截图：```
<img src="https://images0.cnblogs.com/blog/520134/201409/191232326909802.jpg" alt="" width="272" height="498">```
　　<a href="http://idoube.com/proj/tuzibenyue/" target="_blank">游戏demo在这里</a>，点击试玩。

　　下面就把整个游戏的实现细节来说一下，其实整体来看还是没有什么难度的。```

&nbsp;```
**游戏舞台的尺寸**```
&nbsp; &nbsp; &nbsp;先从最基本的来说起。游戏的舞台就是我们的canvas元素，这个元素的尺寸应该如何设置呢？既然要适配各种手机屏幕，那我在css中给它宽高都设为100%不就可以喽。其实这个朴素的想法是错误的，canvas元素的使用与普通的html元素并不相同，它有一个默认尺寸300*150，在css中设置宽高只能改变canvas的显示宽高，而并没有改变画布绘制时的尺寸，所以要为canvas设置绘制的尺寸，必须写在元素标签上。例如，我的canvas元素是这样的：```

```python
<div id="gamepanel">
     <canvas id="stage" width="320" height="568"></canvas>
</div>
```
　　这里你可能要问了，为什么尺寸是320*568呢？这里有必要说一下，我们在做手机端页面时，给iPhone的容器宽度是320px，给Android的容器宽度是360px，这里想要兼容两者，所以只能取最小的320了，否则iPhone出现滚动条是很蛋疼的。至于安卓设备，我们只能委屈它一下了，给一个较窄的宽度，然后让整个容器居中对齐，游戏容器的样式如下：```

```python
#gamepanel{
     width: 320px;
     margin: 0 auto;
     height: 568px;
     position: relative;
     overflow: hidden;
}
```

　　宽度整好了，那height值为568又是什么原因呢？其实我也没有研究过，只是看到别人代码里这么写，就抄过来了。```
&nbsp; &nbsp; &nbsp;就在楼主写这篇文章的时候，看到了cocos2d-js生成的canvas是这样的规则：```
&nbsp; &nbsp; &nbsp;Android设备：360*640```
&nbsp; &nbsp; &nbsp;iphone5：320*568```
&nbsp; &nbsp; &nbsp;iphone4：320*480```
&nbsp; &nbsp; &nbsp;所以以后在不用框架的时候，可以用js判断来确定canvas的尺寸，这里算是学到的一点小知识。```

&nbsp;```
**滚动的背景**```
**&nbsp; &nbsp; &nbsp;**我们有一张天空的图片来做背景，并且要不停向下移动，这样感觉飞碟在不停的向前飞行。如何让背景图片连续不间断的移动呢？```
&nbsp; &nbsp; &nbsp;首先定义了一个全局对象gameMonitor，游戏控制需要用到的参数、方法，都定义为它的属性，用来组织游戏的整体逻辑。其中，滚动背景的函数rollBg定义如下：```

```python
rollBg : function(ctx){
          if(this.bgDistance>=this.bgHeight){
               this.bgloop = 0;
          }
          this.bgDistance = ++this.bgloop * this.bgSpeed;
          ctx.drawImage(this.bg, 0, this.bgDistance-this.bgHeight, this.bgWidth, this.bgHeight);
          ctx.drawImage(this.bg, 0, this.bgDistance, this.bgWidth, this.bgHeight);
     },
```
　　有两个变量bgloop和bgDistance分别记录背景的重绘次数和移动了的距离，每次重绘让bgloop自增，乘以速度就是新的距离。为了实现背景图片的无缝滚动，我们需要调用两次drawImage来绘制两张图片上去，绘制的位置关系如下图所示：```
　　<img src="https://images0.cnblogs.com/blog/520134/201409/191237115509808.jpg" alt="">```
　　
　　这样才能保证背景滚动的过程中不会闪烁也不会中断。```

&nbsp;```
**简易的图片加载器**```
**&nbsp; &nbsp; &nbsp;**由于游戏一开始并没有把所有的图片都加载下来，所以后续要用到的图片，比如飞碟、兔子都是需要延迟加载进来的，所以需要实现一个图片加载器，大体的功能就是让浏览器加载图片，然后在别的代码中调用可以直接使用图片，代码如下：```

```python
function ImageMonitor(){
     var imgArray = [];
     return {
          createImage : function(src){
               return typeof imgArray[src] != 'undefined' ? imgArray[src] : (imgArray[src] = new Image(), imgArray[src].src = src, imgArray[src])
          },
          loadImage : function(arr, callback){
               for(var i=0,l=arr.length; i<l; i++){
                    var img = arr[i];
                    imgArray[img] = new Image();
                    imgArray[img].onload = function(){
                         if(i==l-1 &amp;&amp; typeof callback=='function'){
                              callback();
                         }
                    }
                    imgArray[img].src = img
               }
          }
     }
}
```

　　返回的对象有两个方法，第一个createImage，返回当前数组中对应的图片，如果不存在该图片，则new一个来返回。第二个loadImage接收一个数组和一个回调函数，把数组中的图片路径逐一加载，保存到一个数组中，最后一张图片加载完后执行一个回调函数。```
&nbsp; &nbsp; &nbsp;这段代码其实是我从别人代码中偷来的，稍一推敲，就会发现这段代码其实是有问题的：```
&nbsp; &nbsp; &nbsp;1. createImage方法，在当前imgArray数组中有所需图片时是没问题的，但是如果没有就需要现加载，在别的地方如果调用了这个方法，那么后面的代码应该是放在img的onload函数中执行才对，否则一旦网络较慢，这个时候可能图片还未加载下来，后续代码会报错。```
&nbsp; &nbsp; &nbsp;2. loadImage方法，回调函数的执行是在最后一张图片的onload函数中执行，这也是有可能出问题的，因为浏览器是可以并发请求的，有可能最后一张图片已经加载完了，前面的图片还没加载完（最后一张图片较小，前面的较大，或者是网络的原因），这个时候执行回调的时机也是不准确的。```
&nbsp; &nbsp; &nbsp;开发的时候因为时间紧急我没有改良这段代码，只是避开了可能出问题的用法。那么标准的加载图片，或者说资源管理应该是如何进行呢？我相信业界已经有了标准答案，后续我会搞清楚这个问题。以后写游戏就用框架（像cocos2d-js）来管理这些了，原生的要顾及的东西实在是多。```
&nbsp;```

**实现飞船的绘制、操控**```
&nbsp; &nbsp; &nbsp;接下来就开始实现游戏的主体，飞船。用js面向对象的写法（大家都这么叫，姑且这么叫吧），我们编写一个Ship类，属性有宽高、坐标、游戏图片，有一个paint方法来把自己绘制出来，还有一个controll方法来响应用户的操作，代码如下：```

```python<img id="code_img_closed_d4c6b3e7-d350-480d-8f29-2b6f7608223e" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_d4c6b3e7-d350-480d-8f29-2b6f7608223e" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

function Ship(ctx){
     gameMonitor.im.loadImage(['static/img/player.png']);
     this.width = 80;
     this.height = 80;
     this.left = gameMonitor.w/2 - this.width/2;
     this.top = gameMonitor.h - 2*this.height;
     this.player = gameMonitor.im.createImage('static/img/player.png');

     this.paint = function(){
          ctx.drawImage(this.player, this.left, this.top, this.width, this.height);
     }

     this.setPosition = function(event){
          this.left = event.changedTouches[0].clientX - this.width/2 - 16;
          this.top = event.changedTouches[0].clientY - this.height/2;
          if(this.left<0){
               this.left = 0;
          }
          if(this.left>320-this.width){
               this.left = 320-this.width;
          }
          if(this.top<0){
               this.top = 0;
          }
          if(this.top>gameMonitor.h - this.height){
               this.top = gameMonitor.h - this.height;
          }
          this.paint();
     }

     this.controll = function(){
          var _this = this;
          var stage = $('#gamepanel');
          var currentX = this.left,
               currentY = this.top,
               move = false;
          stage.on('touchstart', function(event){
               _this.setPosition(event);
               move = true;
          }).on('touchend', function(){
               move = false;
          }).on('touchmove', function(event){
               event.preventDefault();
               _this.setPosition(event);
          });
     }
}
```
View Code```
　　代码是一目了然的，paint方法是基础，setPosition其实就是修改飞船的left和top值，并防止移出屏幕，每次移动完后调用paint方法来重现绘制飞船。controll方法则是监听了touch事件，计算得出新的位置。```

&nbsp;```
**实现月饼的绘制、移动**```
**&nbsp; &nbsp; &nbsp;**实现了Ship类，接下来该实现月饼了，我们定义为Food类。与Ship类有些不同，Food的示例会有很多个，因为天上在不停掉月饼嘛，而且月饼有好坏之分，所以Food类多了两属性：id和type，用来标识月饼和它的类型。另外，由于Food类会new很多实例出来，所以方法我们定义在prototype上，这样减少每次创建实例时的内存消耗。代码如下：```

```python<img id="code_img_closed_ce4acc4f-e038-44b1-9ca4-37b9c280b08d" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_ce4acc4f-e038-44b1-9ca4-37b9c280b08d" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

function Food(type, left, id){
     this.speedUpTime = 300;
     this.id = id;
     this.type = type;
     this.width = 50;
     this.height = 50;
     this.left = left;
     this.top = -50;
     this.speed = 0.04 * Math.pow(1.2, Math.floor(gameMonitor.time/this.speedUpTime));
     this.loop = 0;

     var p = this.type == 0 ? 'static/img/food1.png' : 'static/img/food2.png';
     this.pic = gameMonitor.im.createImage(p);
}
Food.prototype.paint = function(ctx){
     ctx.drawImage(this.pic, this.left, this.top, this.width, this.height);
}
Food.prototype.move = function(ctx){
     if(gameMonitor.time % this.speedUpTime == 0){
          this.speed *= 1.2;
     }
     this.top += ++this.loop * this.speed;
     if(this.top>gameMonitor.h){
          gameMonitor.foodList[this.id] = null;
     }
     else{
          this.paint(ctx);
     }
}
```
View Code```

　　另外还有一点要说的是，月饼的速度是在不断增加的，以此来控制游戏的难道逐渐增高。定义一个speedUpTime&nbsp;作为加速的时间间隔，默认为300，游戏的帧率为60，所以每隔5秒就会进行一次加速。新创建的月饼实例在初始化的时候，它的速度要和当前屏幕上的月饼速度一致，所以这个speed是动态的，有一个计算公式。```
&nbsp;```
**随机产生月饼**```
**&nbsp; &nbsp; &nbsp;**有了Food类后，只要我们调用new Food(type, left ,id)，就会创建出一个月饼。接下来，我们需要在屏幕上以一定的频率随机产生月饼。在gameMonitor中定义一个genorateFood方法，让它来管理月饼的生成，代码如下：```

```python
genorateFood : function(){
          var genRate = 50; //产生月饼的频率
          var random = Math.random();
          if(random*genRate>genRate-1){
               var left = Math.random()*(this.w - 50);
               var type = Math.floor(left)%2 == 0 ? 0 : 1;
               var id = this.foodList.length;
               var f = new Food(type, left, id);
               this.foodList.push(f);
          }
     }
```

月饼产生频率genRage默认为50，即不到1秒的时间产生一个月饼，根据实际测试，这个值比较合适。然后把new出来的月饼实例push到gameMonitor的FoodList数组中。FoodList中保存着当前屏幕上的所有月饼，这样，我们每次重绘canvas的时候，只要把foodList中的月饼挨个绘制出来就OK了，同样的道理，当有月饼移出屏幕，或者是被吃掉时，把它从FoodList中删除就OK了。```
&nbsp;```
**兔子吃月饼**```
&nbsp; &nbsp; &nbsp;兔子有了，月饼有了，接下来就该吃了。我们给Ship类添加一个eat方法，表示吃月饼。所谓吃月饼说白了还是做碰撞检测，每次帧刷新的时候，让飞碟与界面上所有的月饼做一次碰撞检测，如果发生了碰撞，判断月饼的类型，好月饼则得分加一，坏月饼则游戏结束。因为飞碟和月饼都是近似圆形，所以按照圆形模型来做碰撞检测就再简单不过了，两圆心的距离小于半径之和，则认为发生了碰撞。Ship的eat方法定义如下：```

```python<img id="code_img_closed_73928e18-3dd6-4310-aee8-34d14b84ce21" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_73928e18-3dd6-4310-aee8-34d14b84ce21" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

this.eat = function(foodlist){
          for(var i=foodlist.length-1; i>=0; i--){
               var f = foodlist[i];
               if(f){
                    var l1 = this.top+this.height/2 - (f.top+f.height/2);
                    var l2 = this.left+this.width/2 - (f.left+f.width/2);
                    var l3 = Math.sqrt(l1*l1 + l2*l2);
                    if(l3<=this.height/2 + f.height/2){
                         foodlist[f.id] = null;
                         if(f.type==0){
                              gameMonitor.stop();
                              $('#gameoverPanel').show();

                              setTimeout(function(){
                                   $('#gameoverPanel').hide();
                                   $('#resultPanel').show();
                                   gameMonitor.getScore();
                              }, 2000);
                         }
                         else{
                              $('#score').text(++gameMonitor.score);
                              $('.heart').removeClass('hearthot').addClass('hearthot');
                              setTimeout(function() {
                                   $('.heart').removeClass('hearthot')
                              }, 200);
                         }
                    }
               }
              
          }
     }
```
View Code```

调用的时候，我们把gameMonitor维护的foodList数组传进来即可。同时要注意，当一个月饼被吃掉后，要从该数组中移除，这样下一帧就不会把它绘制出来了。```
&nbsp;```
**让游戏run起来**```
**&nbsp; &nbsp; &nbsp;**我们该定义的东西也都差不多了，接下来是让游戏跑起来的时候了！所谓的跑起来，就是让canvas不停的重绘而已，在gameMonitor上定义一个方法run，通过setTimeout来递归调用它，延时时间为1000/60，这样可以维持帧率在60。run方法定义如下：```

```python<img id="code_img_closed_e0bb42ee-7e74-448f-b375-5320d026150c" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_e0bb42ee-7e74-448f-b375-5320d026150c" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

run : function(ctx){
          var _this = gameMonitor;
          ctx.clearRect(0, 0, _this.bgWidth, _this.bgHeight);
          _this.rollBg(ctx);

          //绘制飞船
          _this.ship.paint();
          _this.ship.eat(_this.foodList);


          //产生月饼
          _this.genorateFood();

          //绘制月饼
          for(i=_this.foodList.length-1; i>=0; i--){
               var f = _this.foodList[i];
               if(f){
                    f.paint(ctx);
                    f.move(ctx);
               }
              
          }
          _this.timmer = setTimeout(function(){
               gameMonitor.run(ctx);
          }, Math.round(1000/60));

          _this.time++;
     }
```
View Code```

首先我们会执行一次canvas的clearRect方法来把画布清空一下，否则画面会重叠上去。之后绘制背景、飞船、月饼。调用相关的动画方法后，整个游戏就动起来了~```
&nbsp; &nbsp; &nbsp;其实在这里我开发的时候遇到了一个纠结的地方，那就是用setTimeout来控制帧刷新，在上篇文章中，我有介绍用requestAnimationFrame也是可以控制帧刷新的，写这个小游戏的时候我一开始也是用了这个方法，但是在测试的时候遇到了一个现象，在iphone4上，当用手指控制飞船移动的时候，帧率就有明显的下降，我不清楚是什么原因造成，后来看别人代码中是setTimeout的，就抄了过来解决问题。所以在此我也抛出一个问题：setTimeout与requestAnimationFrame到底该选择哪个，是否与canvas有关，有大牛知道也望请指点。```
&nbsp;```
**总结一下**```
&nbsp; &nbsp; &nbsp;通过以上几个步骤，游戏的基本功能就完成了，其他一些游戏流程控制，包括开始、结束、得分计算等在此就不叙述了。总体感觉用canvas做一个小游戏的难度也不算大，不过我写的这个游戏也确实特别简单，可以作为入门的例子。```
&nbsp; &nbsp; &nbsp;这次当做多原生canvas的一次学习，以后做游戏的话，我也不打算用原生canvas了，准备学习下cocos2d-js，最近也发布了其正式版本，正是上手的最佳时间。```
&nbsp; &nbsp; &nbsp;本游戏的源代码扔在了github上：<a href="https://github.com/Double-Lv/tuzibenyue" target="_blank">https://github.com/Double-Lv/tuzibenyue</a>```
　　本文仓促完成，有些观点和写法可能不正确，如有问题，欢迎留言指导~```



