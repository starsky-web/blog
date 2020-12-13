记得在WP7上玩一个游戏有段动画很有趣，是背景在进行昼夜交替，一会儿白天太阳出来白天了，一会儿月亮蹦出来夜晚了，在以前做C++程序的时候曾经实现过类似的效果，今天早上移植了一下到Silverlight当中效果还是不错，当然了，有了Blend神器，就完全不用通过代码的方式实现，真的方便了很多。
以前的效果预览：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131415562688.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="00" border="0" alt="00" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131415576700.jpg" width="448" height="310"></a>
由于条件所限定，本篇中实现的效果仅仅为一个引子，更细的细节，还需要自行制作，请注意，本篇的程序尺寸为600x400的标准。
为了方便起见，就不用Blend来画太阳和月亮了，直接使用了两张图片：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131415581618.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="1" border="0" alt="1" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131415598487.jpg" width="252" height="183"></a>
加入工程后，打开MainPage控件，添加两个Rectangle，分别来表示天空和海面：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416018256.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="2" border="0" alt="2" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416028996.jpg" width="702" height="278"></a>
上面的两个矩形都填充了渐变颜色，暂时表示一下。
添加月亮进来，移动到中间
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416045974.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="3" border="0" alt="3" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416052254.jpg" width="431" height="263"></a>
下面是一个小的布局技巧，为了避免月亮随着布局而发生怪异的变化，把宽高定死，并且设定为绝对中间对齐
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416089448.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="4" border="0" alt="4" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416106808.jpg" width="412" height="274"></a>
然后太阳也是这么添加到界面中，现在将海移动到前面来，为了在后面的动画中挡住太阳和月亮：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416128529.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="5" border="0" alt="5" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416134493.jpg" width="449" height="191"></a>
那么现在开始制作动画了，新建一个故事板动画，名字为ANI_Loop，然后为太阳和月亮添加关键帧，并且移动到海面之下：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416157293.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="6" border="0" alt="6" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416179670.jpg" width="474" height="225"></a>
现在把月亮移动上来，毕竟一天之际在于午夜时分么。
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416188981.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="7" border="0" alt="7" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416196897.jpg" width="502" height="241"></a>
在2秒的地方添加一个关键帧，把月亮拉到海面以下：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416246958.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="8" border="0" alt="8" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416251286.jpg" width="526" height="276"></a>
下面就是把太阳升起来：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416263106.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="9" border="0" alt="9" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416284893.jpg" width="446" height="253"></a>
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416291696.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="10" border="0" alt="10" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416304072.jpg" width="461" height="179"></a>
好了，现在形成一个交替循环，选择ANI_Loop把自动回放选上，把播放测试设为Forever
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416338476.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="11" border="0" alt="11" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416356642.jpg" width="559" height="335"></a>
现在可以播放一下，看看是不是循环的出来下去呢，为了增加一些动感，我决定加一个缓冲效果，现在选择所有的帧，看好，可是所有帧哦。
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/20110213141636970.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="12" border="0" alt="12" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416373346.jpg" width="495" height="215"></a>
选择Back的第三个缓冲效果。
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416382898.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="13" border="0" alt="13" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/20110213141639606.jpg" width="238" height="244"></a>
现在播放起来看看，是否很有趣了呢，太阳和月亮真的就是“蹦”出来的，当然了，你可以尝试其余的缓冲效果，看看是否能形成更有趣的感觉。
不过大家肯定不会就此满意，因为这天空海面实在太丑了，而且太阳和月亮出来也没有变化，现在下面就开始完成这个问题：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/2011021314164227.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="14" border="0" alt="14" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416452238.jpg" width="585" height="305"></a>
现在把时间轴移动到开始，开始调天空和海面的颜色，大家可以依据自己的想法调整，直到自己满意，此时可以用月亮做参照。
同样，再将第2秒，即清晨的颜色调出来，此事不需要关闭动画，在Silverlight里Color是可以作为动画的的类型之一。
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416466533.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="15" border="0" alt="15" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416501643.jpg" width="412" height="281"></a>
以及在最后一帧的白天设置出来。
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416553133.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="16" border="0" alt="16" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416564429.jpg" width="441" height="263"></a>
有的时候你可能需要美术设计师的支持，才能得到最佳的表现效果，现在播放一下，看看是否不错呢，日月交替，昼夜交替，如果你想拉长<font style="background-color: rgba(255, 215, 0, 1)">时间</font>，只需要把关键帧调整即可。
我们在下面加一下小细节，让整个的效果看起来更加真实：月亮的泛光、海面、小星星的制作
为了不产生混乱，现在将动画的编辑模式关闭，点击界面上方的小红色按钮关闭。
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416573458.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="17" border="0" alt="17" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131416584198.jpg" width="312" height="164"></a>
选择月亮，为它添加一个投影的Effect
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417009474.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="18" border="0" alt="18" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417022930.jpg" width="497" height="236"></a>
参数设置如下：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417048272.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="19" border="0" alt="19" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417056470.jpg" width="499" height="306"></a>
月亮看起来更加真实了，而海面的话，需要一张海面的波纹图片，添加到海面的Rectangle的下面，并将海面的透明度降低：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417082269.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="20" border="0" alt="20" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417103434.jpg" width="519" height="387"></a>
关于星星的制作会用上另外一个Effect效果——模糊，画一个小圆圈，5x5就够了，然后添加模糊效果，将参数设置如下：
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417137281.jpg"><img style="background-image: none; border-width: 0; padding-left: 0; padding-right: 0; display: inline; padding-top: 0" title="21" border="0" alt="21" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417151477.jpg" width="665" height="266"></a>
我在旁边放了一个小参照，看看是不是很像呢：）
当然了这些细节将会增加更多的设计和编码时间，例如白天星星是不会出现的、波纹只是不动肯定不会好看、甚至太阳和月亮的在海面上的投影，这些细节都决定这个场景的真实性，我相信各位能够做的更好。
最后不要忘记在构造函数中添加一个Begin，否则这个动画不会自动的运行。
<a href="http://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417175805.jpg"><img style="display: inline" title="22" alt="22" src="https://images.cnblogs.com/cnblogs_com/nowpaper/201102/201102131417182641.jpg" width="467" height="216"></a>
本篇工程源代码下载地址如下：<a href="http://files.cnblogs.com/nowpaper/TheDay.rar">点击直接下载</a>

<object border="1" data="data:application/x-oleobject;base64,QfXq3+HzJEysrJnDBxUISgAJAAADPgAAVykAAAAAAAAAAAAAAAAAAAAAAABaAAAAaAB0AHQAcAA6AC8ALwBmAGkAbABlAHMALgBjAG4AYgBsAG8AZwBzAC4AYwBvAG0ALwBuAG8AdwBwAGEAcABlAHIALwBUAGgAZQBEAGEAeQAuAHgAYQBwAAAAPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAGAAAADQALgAwAC4ANQAwADQAMAAxAC4AMAAAAAoAAAB0AHIAdQBlAAAAAAAAAAAAAAAAAAAA" width="600" type="application/x-silverlight-2" height="400">


<a style="text-decoration: none" href="http://go.microsoft.com/fwlink/?LinkID=149156"> <img alt="获取 Microsoft Silverlight" src="http://go.microsoft.com/fwlink/?LinkId=161376"> </a></object>
本篇文章的作者：<a href="http://www.cnblogs.com/nowpaper/" target="_blank">Nowpaper</a>
推荐Silverlight游戏开发博客：<a href="http://www.cnblogs.com/alamiye010/" target="_blank">深蓝色右手</a>