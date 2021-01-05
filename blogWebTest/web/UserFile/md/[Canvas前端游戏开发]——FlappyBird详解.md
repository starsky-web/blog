<blockquote>
一直想自己做点小东西，直到最近看了本《<a href="http://pan.baidu.com/s/1sjXhO2x" target="_blank">HTML5游戏开发</a>》，才了解游戏开发中的一点点入门知识。
本篇就针对学习的几个样例，自己动手实践，做了个FlappyBird，<a href="http://pan.baidu.com/s/1nuigs2l" target="_blank">源码共享在度盘</a>&nbsp;；也可以参考<a href="https://github.com/xinghalo/CodeJS/tree/master/HTML5" target="_blank">github</a>，里面有更多的游戏样例。
</blockquote>
## 游戏截图
<img src="https://images2015.cnblogs.com/blog/449064/201601/449064-20160102144205339-1537559320.png" alt="">
<img src="https://images2015.cnblogs.com/blog/449064/201601/449064-20160102144214542-463896227.png" alt="">
## HTML5之Canvas
Canvas是Html5中用于绘图的元素，它可以绘制各种图形，比如长方形，多边形，圆形等等。如果想要了解Canvas的使用可以参考：
<a href="http://www.w3school.com.cn/tags/html_ref_canvas.asp" target="_blank">http://www.w3school.com.cn/tags/html_ref_canvas.asp</a>
&nbsp;
```python
//如果想要使用canvas,首先需要获得上下文对象：
ctx = document.getElementById('canvas').getContext('2d');
//然后使用这个ctx绘制图形
```
在cavas每个绘制都是独立的操作。比如下图的两个绘制图形，第二个会以覆盖的形式绘制，因此**绘制图形的顺序**就显得十分重要了。
<img src="https://images2015.cnblogs.com/blog/449064/201601/449064-20160102122054917-1970081470.png" alt="">
## canvas之drawImage()
本篇的游戏开发中，主要使用的是依据图片绘制的api:drawImage()，它有两个基本的使用方法：
```python
ctx.drawImage(image,this.bx,this.by,this.bwidth,this.bheight);
ctx.drawImage(image,x,y,width,height,this.px,this.py,this.pwidth,this.pheight);
```
第一个api中，指定Image对象，然后给出绘制图片的x,y坐标以及宽度和高度即可。
第二个api中，第一组x,y,width,height则指定了裁剪图片的坐标尺寸，这在**使用多元素的矢量图**时很常用。比如：
<img src="https://images2015.cnblogs.com/blog/449064/201601/449064-20160102122442073-960923946.png" alt="">
上面的图片中为了减少图片资源的请求数量，把很多的元素放在了一个图片中，此时就需要通过裁剪的方式，获取指定的图片元素。
## FlappyBird原理解析
其实这个游戏很简单，一张图就可以看懂其中的奥妙：
<img src="https://images2015.cnblogs.com/blog/449064/201601/449064-20160102122628417-1254447225.png" alt="">
其中背景和地面是不动的。
小鸟只有上和下两个动作，可以通过控制小鸟的y坐标实现。
上下的管子只会向左移动，为了简单实现，游戏中一个画面仅仅会出现一对管子，这样当管子移出左边的背景框，就自动把管子放在最右边！
```python
if(up_pipe.px+up_pipe.pwidth>0){
                up_pipe.px -= velocity;
                down_pipe.px -= velocity;
            }else{
                up_pipe.px = 400;
                down_pipe.px = 400;
                up_pipe.pheight = 100+Math.random()*200;
                down_pipe.py = up_pipe.pheight+pipe_height;
                down_pipe.pheight = 600-down_pipe.py;
                isScore = true;
            }
```
**很简单吧！**
由于该游戏一共就这几个元素，因此**把他们都放入一个Objects数组中，通过setInteral()方法，在一定间隔时间内，执行一次重绘**。
重绘的时候会先清除画面中的所有元素，然后按照新的元素的坐标一次绘制图形，这样就会出现移动的效果。
## 模拟小鸟重力
由于这个游戏不涉及小鸟横向的运动，因此只要模拟出小鸟下落的动作以及上升的动作就可以了。
<img src="https://images2015.cnblogs.com/blog/449064/201601/449064-20160102123427073-1226787597.png" alt="" width="443" height="279">
**上升**：这个很简单，只要把小鸟的y坐标减去一定的值就可以了
**下落**：其实重力不需要使用gt^2来模拟，可以简单的指定两个变量，v1和gravity，这两个变量与setInterval()中的时间共同作用，就能模拟重力。
```python
ver2 = ver1+gravity;
bird.by += (ver2+ver1)*0.5;
```
## 碰撞检测
游戏中小鸟碰到管子或者地面都会算游戏结束：

其中**条件1上管道**的检测为：
```python
((bird.bx+bird.bwidth>up_pipe.px)&amp;&amp;(bird.by>up_pipe.py)&amp;&amp;(bird.bx+bird.bwidth<up_pipe.px+up_pipe.pwidth)&amp;&amp;(bird.by<up_pipe.py+up_pipe.pheight))||
((bird.bx+bird.bwidth>up_pipe.px)&amp;&amp;(bird.by>up_pipe.py)&amp;&amp;(bird.bx+bird.bwidth<up_pipe.px+up_pipe.pwidth)&amp;&amp;(bird.by<up_pipe.py+up_pipe.pheight))
```
**条件2下管道**的检测为：
```python
((bird.bx>down_pipe.px)&amp;&amp;(bird.by>down_pipe.py)&amp;&amp;(bird.bx<down_pipe.px+down_pipe.pwidth)&amp;&amp;(bird.by<down_pipe.py+down_pipe.pheight))||
((bird.bx>down_pipe.px)&amp;&amp;(bird.by+bird.bheight>down_pipe.py)&amp;&amp;(bird.bx<down_pipe.px+down_pipe.pwidth)&amp;&amp;(bird.by+bird.bheight<down_pipe.py+down_pipe.pheight))
```
**条件3地面**的检测最简单，为：
```python
bird.by+bird.bheight>ground.bgy
```
如果满足这三个条件，就算游戏结束，会清除循环以及提示游戏结束信息。
## 分数计算
分数的计算与碰撞检测类似，设置一个开关，当管子重新出现时，设置为true。当分值加1时，设置为false。
小鸟的最左边的x坐标如果超出了管子的x+width，就认为成功通过。
```python
if(isScore &amp;&amp; bird.bx>up_pipe.px+up_pipe.pwidth){
                score += 1;
                isScore = false;
                if(score>0 &amp;&amp; score%10 === 0){
                    velocity++;
                }
            }
```
通过后，分值加1，速度+1。
## 全部源码
```python<img id="code_img_closed_ab254007-3a21-43bf-8788-6cd849c221c0" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_ab254007-3a21-43bf-8788-6cd849c221c0" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

<!DOCTYPE html>
<html>
<head>
    <title>Flappy Bird</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript">
        // Edit by xingoo
        // Fork on my github:https://github.com/xinghalo/CodeJS/tree/master/HTML5
        var ctx;
        var cwidth = 400;
        var cheight = 600;
        var objects = [];
        var birdIndex = 0;
        var ver1 = 10;
        var ver2;
        var gravity = 2;
        var pipe_height = 200;
        var velocity = 10;
        var tid;
        var score = 0;
        var isScore = false;
        var birds = ["./images/0.gif","./images/1.gif","./images/2.gif"];
        var back = new Background(0,0,400,600,"./images/bg.png");
        var up_pipe = new UpPipe(0,0,100,200,"./images/pipe.png");
        var down_pipe = new DownPipe(0,400,100,200,"./images/pipe.png");
        var ground = new Background(0,550,400,200,"./images/ground.png");
        var bird = new Bird(80,300,40,40,birds);
        objects.push(back);
        objects.push(up_pipe);
        objects.push(down_pipe);
        objects.push(ground);
        objects.push(bird);
        function UpPipe(x,y,width,height,img_src){
            this.px = x;
            this.py = y;
            this.pwidth = width;
            this.pheight = height;
            this.img_src = img_src;
            this.draw = drawUpPipe;
        }
        function DownPipe(x,y,width,height,img_src){
            this.px = x;
            this.py = y;
            this.pwidth = width;
            this.pheight = height;
            this.img_src = img_src;
            this.draw = drawDownPipe;
        }
        function drawUpPipe(){
            var image = new Image();
            image.src = this.img_src;
            ctx.drawImage(image,150,500,150,800,this.px,this.py,this.pwidth,this.pheight);
        }
        function drawDownPipe(){
            var image = new Image();
            image.src = this.img_src;
            ctx.drawImage(image,0,500,150,500,this.px,this.py,this.pwidth,this.pheight);
        }
        function Background(x,y,width,height,img_src){
            this.bgx = x;
            this.bgy = y;
            this.bgwidth = width;
            this.bgheight = height;
            var image = new Image();
            image.src = img_src;
            this.img = image;
            this.draw = drawbg;
        }
        function drawbg(){
            ctx.drawImage(this.img,this.bgx,this.bgy,this.bgwidth,this.bgheight);
        }
        function Bird(x,y,width,height,img_srcs){
            this.bx = x;
            this.by = y;
            this.bwidth = width;
            this.bheight = height;
            this.imgs = img_srcs;
            this.draw = drawbird;
        }
        function drawbird(){
            birdIndex++;
            var image = new Image();
            image.src = this.imgs[birdIndex%3];
            ctx.drawImage(image,this.bx,this.by,this.bwidth,this.bheight);
        }
        function calculator(){
            if(bird.by+bird.bheight>ground.bgy ||
                ((bird.bx+bird.bwidth>up_pipe.px)&amp;&amp;(bird.by>up_pipe.py)&amp;&amp;(bird.bx+bird.bwidth<up_pipe.px+up_pipe.pwidth)&amp;&amp;(    bird.by<up_pipe.py+up_pipe.pheight))||
                ((bird.bx+bird.bwidth>up_pipe.px)&amp;&amp;(bird.by>up_pipe.py)&amp;&amp;(bird.bx+bird.bwidth<up_pipe.px+up_pipe.pwidth)&amp;&amp;(    bird.by<up_pipe.py+up_pipe.pheight))||
                ((bird.bx>down_pipe.px)&amp;&amp;(bird.by>down_pipe.py)&amp;&amp;(bird.bx<down_pipe.px+down_pipe.pwidth)&amp;&amp;(bird.by<down_pipe.py+down_pipe.pheight))||
                ((bird.bx>down_pipe.px)&amp;&amp;(bird.by+bird.bheight>down_pipe.py)&amp;&amp;(bird.bx<down_pipe.px+down_pipe.pwidth)&amp;&amp;(bird.by+bird.bheight<down_pipe.py+down_pipe.pheight))){
                clearInterval(tid);
                ctx.fillStyle = "rgb(255,255,255)";
                ctx.font = "30px Accent";
                ctx.fillText("You got "+score+"!",110,100)
                return;
            }
            ver2 = ver1+gravity;
            bird.by += (ver2+ver1)*0.5;
            if(up_pipe.px+up_pipe.pwidth>0){
                up_pipe.px -= velocity;
                down_pipe.px -= velocity;
            }else{
                up_pipe.px = 400;
                down_pipe.px = 400;
                up_pipe.pheight = 100+Math.random()*200;
                down_pipe.py = up_pipe.pheight+pipe_height;
                down_pipe.pheight = 600-down_pipe.py;
                isScore = true;
            }
            if(isScore &amp;&amp; bird.bx>up_pipe.px+up_pipe.pwidth){
                score += 1;
                isScore = false;
                if(score>0 &amp;&amp; score%10 === 0){
                    velocity++;
                }
            }
            ctx.fillStyle = "rgb(255,255,255)";
            ctx.font = "30px Accent";
            if(score>0){
                score%10!==0?ctx.fillText(score,180,100):ctx.fillText("Great!"+score,120,100);
            }
        }
        function drawall(){
            ctx.clearRect(0,0,cwidth,cheight);
            var i;
            for(i=0;i<objects.length;i++){
                objects[i].draw();
            }
            calculator();
        }
        function keyup(e){
            var e = e||event;
               var currKey = e.keyCode||e.which||e.charCode;
               switch (currKey){
                case 32:
                    bird.by -= 80;
                    break;
            }
        }    
        function init(){
            ctx = document.getElementById('canvas').getContext('2d');
            document.onkeyup = keyup;
            drawall();
            tid = setInterval(drawall,80);
        }
    </script>
</head>
<body onLoad="init();">
<canvas id="canvas" width="400" height="600" style="margin-left:200px;">
    Your browser is not support canvas! 
</canvas>
</body>
</html>
```
View Code```
## 总结
在学习游戏开发的时候，我突然怀念起大学的物理。当时很纳闷，学计算机学什么物理，后来再接触游戏开发才知道，没有一定的物理知识，根本无法模拟游戏中的各个场景。
而通过这个简单的小游戏，也捡起来了很多旧知识。
## 参考
【1】：<a href="http://www.w3school.com.cn/tags/html_ref_canvas.asp" target="_blank">Canvas参考手册</a>
【2】：《<a href="http://pan.baidu.com/s/1sjXhO2x" target="_blank">HTML5游戏开发</a>》
【3】：EdisonChou的<a href="http://www.cnblogs.com/edisonchou/p/4115101.html" target="_blank">FlappyBird</a>