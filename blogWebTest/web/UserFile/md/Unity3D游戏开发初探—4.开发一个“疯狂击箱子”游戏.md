# 一、预备知识—对象的”生“与”死“
　　（1）如何在游戏脚本程序中创建对象而不是一开始就创建好对象？->使用GameObject的静态方法：**CreatePrimitive()**
**　　**以上一篇的博文中的“指哪打哪”例子为基础，在AddForce脚本写入以下代码：
```python<img id="code_img_closed_4a50fc2c-aa56-4abb-af81-3a62a4613e81" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_4a50fc2c-aa56-4abb-af81-3a62a4613e81" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1     void Update()
 2     {
 3         // Demo3:点击鼠标左键自动创建Cube对象
 4         if (Input.GetMouseButtonDown(0))
 5         {
 6             CreateCube();
 7         }
 8     }
 9 
10     void CreateCube()
11     {
12         GameObject goCube = GameObject.CreatePrimitive(PrimitiveType.Cube);
13         goCube.transform.position = new Vector3(0, 0, 0);
14         goCube.AddComponent<Rigidbody>();
15     }
```
View Code ```
　　其中在CreateCube方法中，使用GameObject.CreatePrimitive方法来创建Cube类型的游戏对象实例，设置了它出现的坐标并为它增加刚体组件。这里可以看下AddComponent方法，它的参数是一个泛型，也就是说我们在属性面板中看到的那些组件，例如刚体、音频源甚至脚本等组件对象都可以通过AddComponet方法来动态地添加。现在来看看在游戏中点击鼠标左键创建Cube对象的效果：<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/131605343761453.gif" alt="">
**　　**（2）细心的读者会发现，当我们创建了无数个Cube对象之后，计算机的内存占用率会逐步上升。机智的你肯定会想到，适时销毁创建的游戏对象，释放内存资源。不要担心，Unity3D为我们提供了一个非常方便的方法：**Destroy()。**这个函数提供了两个重载：第一个你可以直接传递一个游戏对象的ID（比如我们在上个例子中创建了一个Plane，它的ID也为Plane）；第二个你可以传递两个参数，一个是刚刚提到的游戏对象的ID，另一个是延迟销毁的秒数（也就是说可以在规定的秒数之后再从屏幕中消失，从内存中销毁）；
　　下面我们重新修改一下刚刚的AddForce脚本为如下代码：
```python<img id="code_img_closed_73b3c64b-461a-4621-9fdc-8f84c3692042" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_73b3c64b-461a-4621-9fdc-8f84c3692042" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1     void Update()
 2     {
 3 
 4         // Demo4:点击鼠标左键自动销毁Plane对象
 5         if(Input.GetMouseButtonDown(0))
 6         {
 7             DestroyGameObject("Plane");
 8         }
 9     }
10 
11     void DestroyGameObject(string objectName)
12     {
13         GameObject goCube = GameObject.Find(objectName);
14         // 延时2秒之后才销毁该对象
15         Destroy(goCube, 2);
16     }
```
View Code ```
　　这里我们将销毁游戏对象的代码封装成了一个方法：DestroyGameObject()，它首先通过GameObject.Find方法找到指定ID的游戏对象，然后调用销毁游戏对象的方法Destroy将其销毁掉，这里使用了第二个重载，为其传递了一个2秒的延迟时间。也就是说，当我们点击鼠标左键后2秒，Plane对象才会被销毁，我们的Sphere球体对象便会跌落深渊！现在我们来看看效果如何：<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/131632321779498.gif" alt="">
　　在预览效果的同时，你可以观察左侧Hierarchy中的对象列表，Plane在什么时刻消失了？
　　好了，预备知识到此结束，现在我们真正开始**CrazySphere**(简称：**CS**，听起来高大上吧，么么嗒！)—“**疯狂击箱子**”游戏的开发之旅！
# 二、疯狂击箱子—CrazySphere的实现之路
　　既然我们的“CS”是击箱子，木有箱子怎么能行呢！现在，我们就来创建一些箱子，作为我们击打的对象。
　　首先，考虑到要初始化的箱子足足有16个，我们需要在程序中来创建这些箱子，并将它们放在Plane中，组成箱子墙，让我们的小球来击打。
　　（1）在Hierarchy中Create以下对象：一个Direction Light，一个Plane；将Plane的Position设置为（0,1,-6），这样看起来清楚一点；
　　（2）准备工作：
　　①在Assets中Create以下文件夹（Folder）：一个Images文件夹用来存放贴图文件，一个Musics文件夹用来存放背景音乐和音效MP3，一个Scripts文件夹用来存放C#脚本文件，见下图所示：<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/132308415341906.jpg" alt="">
　　②往Images里边导入一些贴图，我这里在网上找了几张愤怒的小鸟的图片，用来给Plane、Sphere以及Cube对象做渲染材质贴图，这样游戏对象看起来好看一点。（具体的文件请下载附件中的源码，找到Assets/Images/）<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/132311279374544.jpg" alt="">
　　③往Musics里边导入一首背景音乐和一首音效文件，背景音乐作为游戏背景音乐默认且循环播放，音效音乐作为小球冲击箱子的音效在小球发出时播放。这里背景音乐我选择的是萨克斯经典—回家，是不是很文艺？音效呢，我就上网随便找了个炮弹发射的音效。（具体的文件请下载附件中的源码，找到Assets/Musics/）<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/132317160353489.jpg" alt="">
　　然后，选中Hierarchy中的Main Camera，选择主菜单栏中的Component->Audio->Audio Source，在属性中的Audio Source块中选择导入的背景音乐（这里是GoHome-Sax），并勾选Play On Awake（是否默认播放）以及Loop（是否循环播放）复选框，我们在游戏一开始时就会播放GoHome-Sax.mp3文件。<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/132352582392811.jpg" alt="">
　　最后，按照上面的步凑为Plane增加Audio Source，将其选择为Bomb作为初始化音效。<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/132357370266317.jpg" alt="">
　　④在Scripts中Create两个C# Script，一个命名为**InitScene**，另一个命名为**AutoDestroy**。InitScene脚本用于初始化游戏场景，也就是4*4的箱子矩阵。而AutoDestroy脚本则用于销毁超出主摄像机可视范围的游戏对象，也就是当我们的小球或被击中的箱子超出Plane的地面范围或跌落后就将其自动销毁。<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/132324130062041.jpg" alt="">
　　（3）首先来编写AutoDestroy脚本，利用我们在 预备知识 里边学到的自动销毁对象的方法。这个AutoDestroy脚本是需要附加到需要自动销毁的游戏对象上才会有意义，所以后边会在初始化场景的主脚本中为自动创建的对象附加此脚本（利用AddComponent提供的泛型方法）。
```python<img id="code_img_closed_a1cee254-59db-4b64-84c8-3a6fd1ce2e62" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_a1cee254-59db-4b64-84c8-3a6fd1ce2e62" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1 using UnityEngine;
 2 using System.Collections;
 3 
 4 public class AutoDestroy : MonoBehaviour
 5 {
 6 
 7     // Use this for initialization
 8     void Start()
 9     {
10 
11     }
12 
13     // Update is called once per frame
14     void Update()
15     {
16 
17     }
18 
19     // 当离开摄像头可视范围时触发的事件
20     void OnBecameInvisible()
21     {
22         // 销毁当前游戏对象
23         Destroy(this.gameObject);
24     }
25 }
```
View Code ```
<blockquote>
PS：OnBecameInvisible()方法是Unity3D中自带的方法，它在具体的游戏对象在游戏屏幕上不可见时触发。你可以理解它就类似于ASP.NET WebForm中Global文件中的Application_End()事件。这里，我们在游戏对象不可见时，销毁具体的游戏对象。注意，这里销毁的方法参数是this.GameObject而不是this！
</blockquote>
　　（4）现在我们来编写InitScene脚本，这个是重点！**编写完成后，把此脚本附加到Main Camera对象中！**
```python<img id="code_img_closed_8c757d5a-d51e-442f-a98a-78fcfa86e673" class="code_img_closed" src="https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif" alt=""><img id="code_img_opened_8c757d5a-d51e-442f-a98a-78fcfa86e673" class="code_img_opened" style="display: none" src="https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif" alt="">

 1 using UnityEngine;
 2 using System.Collections;
 3 
 4 public class InitScene : MonoBehaviour
 5 {
 6     private GameObject goPlane;
 7 
 8     // Use this for initialization
 9     void Start()
10     {
11         // 获取Plane对象
12         goPlane = GameObject.Find("Plane");
13         // 初始化4*4个箱子群
14         CreateCubes();
15     }
16 
17     void CreateCubes()
18     {
19         // 创建4*4个Cube立方体作为箱子
20         for (int i = 0; i < 4; i++)
21         {
22             for (int j = 0; j < 4; j++)
23             {
24                 GameObject goCube = GameObject.CreatePrimitive(PrimitiveType.Cube);
25                 goCube.transform.position = new Vector3(i - 1, j, -1);
26                 // 增加刚体组件使其具有重力
27                 goCube.AddComponent<Rigidbody>();
28                 // 增加脚本使对象自动销毁
29                 goCube.AddComponent<AutoDestroy>();
30                 // 增加渲染贴图
31                 goCube.renderer.material.mainTexture =
32                     Resources.LoadAssetAtPath("Assets/Images/CubeImage.jpg", typeof(Texture)) as Texture;
33             }
34         }
35     }
36 
37     // Update is called once per frame
38     void Update()
39     {
40         // 控制Sphere朝着鼠标指定的坐标发起冲击
41         if (Input.GetMouseButtonDown(0))
42         {
43             // 创建要发出的小球Sphere
44             GameObject goBullet = GameObject.CreatePrimitive(PrimitiveType.Sphere);
45             goBullet.transform.position = Camera.main.transform.position;
46             goBullet.AddComponent<Rigidbody>();
47             goBullet.AddComponent<AutoDestroy>();
48             goBullet.renderer.material.mainTexture =
49                 Resources.LoadAssetAtPath("Assets/Images/AngryBird.jpg", typeof(Texture)) as Texture;
50 
51             // 获取目标位置的世界坐标
52             Vector3 targetPos = Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x,
53                 Input.mousePosition.y, 3));
54             Vector3 dirPos = targetPos - Camera.main.transform.position;
55 
56             // 进击吧！疯狂的小球！
57             goBullet.rigidbody.AddForce(dirPos * 10, ForceMode.Impulse);
58 
59             // 播放爆炸音效
60             goPlane.GetComponent<AudioSource>().Play();
61         }
62     }
63 
64 }
```
View Code ```
　　现在我们一一来分析这段脚本代码：
　　①CreateCubes()方法定义了初始化4*4个箱子的实现过程，每循环一次通过CreatePrimitive创建Cube类型的立方体，然后为每个立方体设置position坐标、增加刚体组件、增加脚本使其能够自动销毁以及为其渲染贴图。
　　②在Update()方法中控制小球朝着鼠标指定的坐标发起冲击：当用户点击鼠标左键时即刻创建一个Sphere小球，仍然是设置坐标、增加刚体组件、渲染贴图、增加脚本使其能够自动销毁。这里需要注意的是，小球的坐标应该为摄像头的位置，因为小球是从摄像头飞出去的。然后，通过屏幕坐标向世界坐标的转换获取目标向量，再通过目标所在向量-摄像头所在向量=方向向量（这里涉及到向量减法，不明白的读者可以看看本文第二篇3D模型基础，或者去复习下高中向量减法的几何意义）。最后，为小球添加一个往鼠标点击的方向的多大的力，它就会往那个方向去走（这里是“飞“）。为了突出效果，这里还为小球添加了音效效果，在发出时播放。
　　（5）到这里，一个基本的CrazySphere就可以实现了，现在我们来看下效果：可以让小球按照我们制定的坐标发射，发射时还会有炮弹的音效，而且背景音乐一直在循环播放着，一个demo就差不多完成了，是不是很快！
　　<img src="https://images0.cnblogs.com/blog/381412/201402/140008325308176.gif" alt="">
　　（6）但是大家是否觉得我们的游戏背景太单调了，没关系，Unity3D为我们提供了Skyboxes-天空盒子，让我们的背景一秒变为灿烂的蓝天！（有关天空盒子的详细内容请参阅参考文献中关于天空盒子的介绍，这里不再阐述）这里我们向场景中添加一个Sunny的天空盒子：
　　①在Assets处单击鼠标右键，选择Import Package->Skyboxes，在弹出的选择框中选择Sunny1的mat、与Sunny1有关的tif资源。这里注意不要将全部的天空盒子都导进来，那样文件会很大！<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/140024359289563.jpg" alt="">
<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/140024525082662.jpg" alt="">
　　②点击主菜单栏Edit->Render Settings，在右侧的属性栏中找到Skybox Material：<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/140017281219403.jpg" alt="">
　　单机右侧的选择按钮，在弹出的选择框中即可看到我们刚刚导入的Sunny1这个天空盒子，双机选中它，这样我们就让游戏背景一秒变为阳光灿烂的蓝天，是不是心旷神怡啊！<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/140026113078207.jpg" alt="">
　　（6）现在，我们再来看看游戏效果：是不是变为蓝天啦？这样，我们的CrazySphere v1.0就开发好了！
　　<img src="https://images0.cnblogs.com/blog/381412/201402/140028147401214.gif" alt="">
# 三、总结
　　通过几天的Unity3D初探学习，我们学习了Unity3D的基本知识、3D模型基础、物理引擎基础，并综合这些知识做了一个小游戏：CrazySphere-疯狂击箱子的游戏，还实现了背景音乐、音效效果的播放，加入天空盒子让游戏背景好看。当然，本系列作为初探，不可能学的很深入，但至少我们可以入门，可以初步领略到Unity3D的强大魅力以及我们.NET程序员的学习优势。
　　不知不觉之间，已经写了四篇关于Unity3D的学习笔记了，同时这也是我的**第一个系列**的博文，对我的博客生涯具有重要的意义，再次感谢给我鼓励的园友们，让我作为一个新人倍感荣幸。另外，本文是基于传智播客的Unity3D的两次公开课为基础，整理而成的，衷心感谢传智播客以及杨中科的分享，还有老杨的鼓励。马上就要开学了，又要回成都了，苦逼的研究生生涯还得继续，好想早点毕业啊！被学校派到外边实习，老师（实验室指导老师，非我的导师，我的导师还是蛮不错的）也不准时发工资，每天还干的累死累活的。但是，还是想在此**祝愿各位园友码年吉祥，2014越码越健康**！
　　明天就是我外婆70岁的生日了，在此也祝愿她老人家生日快乐，身体健康！
　　本文最后会附上本次小游戏案例的Demo文件供下载，里面有本次用到的所有素材。另外，该Demo中还使用了GUI自定义了鼠标显示，将鼠标显示替换为一张瞄准星的贴图，如下图所示：<img style="margin-right: auto; margin-left: auto; display: block" src="https://images0.cnblogs.com/blog/381412/201402/140132599493402.jpg" alt="">
# 参考文献与资料
　　（1）传智播客Unity3D公开课：<a href="http://net.itcast.cn/subject/Unity3D/index.html">http://net.itcast.cn/subject/Unity3D/index.html</a>
　　（2）XieXuan2007，《Unity3D天空盒》：<a href="http://blog.csdn.net/xiexuan2007/article/details/18401075">http://blog.csdn.net/xiexuan2007/article/details/18401075</a>
　　（3）丁小未，《Unity3D开发类似保龄球游戏》：<a href="http://blog.csdn.net/dingxiaowei2013/article/details/9734935">http://blog.csdn.net/dingxiaowei2013/article/details/9734935</a>
# 附件&nbsp;
　　Demo文件下载：<a href="https://github.com/EdisonChou/CrazySphere" target="_blank">https://github.com/EdisonChou/CrazySphere</a>
&nbsp;

作者：<a href="http://www.cnblogs.com/edisonchou/">周旭龙</a>
出处：<a href="http://www.cnblogs.com/edisonchou/" target="_blank">http://www.cnblogs.com/edisonchou/</a>
本文版权归作者和博客园共有，欢迎转载，但未经作者同意必须保留此段声明，且在文章页面明显位置给出原文链接。
```