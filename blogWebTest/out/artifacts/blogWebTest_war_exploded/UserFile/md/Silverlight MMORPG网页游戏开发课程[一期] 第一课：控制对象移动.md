**引言<o:p></o:p>**
游戏中的主角是精灵，我们可以把游戏中的一切对象均视作精灵；玩家大部分时间都在操控着游戏中对象进行移动。因而本节我们要实现的功能只有一个：通过鼠标控制对象移动。<o:p></o:p>
<strong style="mso-bidi-font-weight: normal">1.1**<strong style="mso-bidi-font-weight: normal">通过Storyboard创建对象移动动画(交叉参考: <a href="http://www.cnblogs.com/alamiye010/archive/2009/06/17/1505332.html" target="_blank"><font color="#3366cc">让物体动起来①</font></a>)<o:p></o:p>**
在序言中我们讲解了如何通过VisualStudio2010创建一个Silverlight4项目，那么我们首先打开这个项目，并将MainPage.xaml中名为LayoutRoot的Grid换成Canvas。<o:p></o:p>
Canvas顾名思义是画布的意思，它是游戏开发中性能最高且最易于用做对象布局及移动的容器控件。<o:p></o:p>
接下来打开MainPage.xaml后台代码MainPage.xaml.cs，创建一个名为rectangle的矩形对象：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// <summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// 填充色为绿色，宽、高各50的矩形<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// </summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rectangle rectangle = new Rectangle() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fill = new SolidColorBrush(Colors.Green),<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Width = 50,<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Height = 50<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p>
然后在MainPage初始化后将该矩形对象(rectangle)作为子控件添加到LayoutRoot画布中，并为LayoutRoot注册(订阅)鼠标左键点击事件：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; public MainPage() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; InitializeComponent();<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //将矩形添加进画布容器中<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LayoutRoot.Children.Add(rectangle);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //注册画布容器的鼠标左键点击事件<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LayoutRoot.MouseLeftButtonDown += new MouseButtonEventHandler(LayoutRoot_MouseLeftButtonDown);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
最后，要实现通过鼠标左键点击来控制对象移动，我们还得在LayoutRoot_MouseLeftButtonDown方法体中编写相应的移动动画实现逻辑(在整个画布任意位置点击左键时，矩形对象rectangle即向该点移动)：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; private void LayoutRoot_MouseLeftButtonDown(object sender, MouseButtonEventArgs e) {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //获取点击处相对于容器的坐标位置<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Point p = e.GetPosition(LayoutRoot);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //创建移动用的动画故事板<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Storyboard storyboard = new Storyboard();<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //创建X轴方向动画<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DoubleAnimation xAnimation = new DoubleAnimation() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //起点<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From = Canvas.GetLeft(rectangle),<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //终点<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To = p.X,<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //花费时间<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Duration = new Duration(TimeSpan.FromMilliseconds(500)),<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp//将X轴方向动画赋予rectangle<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Storyboard.SetTarget(xAnimation, rectangle);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //设置X轴方向动画所影响的对象属性为Canvas.Left<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Storyboard.SetTargetProperty(xAnimation, new PropertyPath("(Canvas.Left)"));<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //将X轴方向动画添加进动画故事板中<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;storyboard.Children.Add(xAnimation);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //创建Y轴方向动画<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DoubleAnimation yAnimation = new DoubleAnimation() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From = Canvas.GetTop(rectangle),<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To = p.Y,<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Duration = new Duration(TimeSpan.FromMilliseconds(500)),<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Storyboard.SetTarget(yAnimation, rectangle);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //设置Y轴方向动画所影响的对象属性为Canvas.Top<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Storyboard.SetTargetProperty(yAnimation, new PropertyPath("(Canvas.Top)"));<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; storyboard.Children.Add(yAnimation);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //播放动画<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; storyboard.Begin();<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
以X轴方向动画实现为例(以上代码黄色部分)，首先创建一个有起点、终点以及总耗时的DoubleAnimation：xAnimation，然后通过Storyboard.SetTarget(xAnimation,rectangle)这句将xAnimation动画过程绑定到矩形对象rectangle，并且通过Storyboard.SetTargetProperty(xAnimation,new PropertyPath(“(Canvas.Left)”))这行代码告诉xAnimation动画它影响的是对象(rectangle)的Canvas.Left属性。这两句话的写法是固定的，有兴趣的朋友可以将(Canvas.Left)换成Opacity试试(注意Opacity不需要括号)，从运行结果去理解体会这两行代码的重要意义。<o:p></o:p>
同样的，Y轴方向的动画依葫芦画瓢，唯一不同的是将Canvas.Left改成了Canvas.Top。<o:p></o:p>
完成后在VisualStudio2010中按下Ctrl+F5进行编译运行(仅F5可进入调试运行)：<o:p></o:p>
<v:shapetype id="_x0000_t75" stroked="f" filled="f" path="m@4@5l@4@11@9@11@9@5xe" o:preferrelative="t" o:spt="75" coordsize="21600,21600"><v:stroke joinstyle="miter"></v:stroke><v:formulas><v:f eqn="if lineDrawn pixelLineWidth 0"></v:f><v:f eqn="sum @0 1 0"></v:f><v:f eqn="sum 0 0 @1"></v:f><v:f eqn="prod @2 1 2"></v:f><v:f eqn="prod @3 21600 pixelWidth"></v:f><v:f eqn="prod @3 21600 pixelHeight"></v:f><v:f eqn="sum @0 0 1"></v:f><v:f eqn="prod @6 1 2"></v:f><v:f eqn="prod @7 21600 pixelWidth"></v:f><v:f eqn="sum @8 21600 0"></v:f><v:f eqn="prod @7 21600 pixelHeight"></v:f><v:f eqn="sum @10 21600 0"></v:f></v:formulas><v:path o:connecttype="rect" gradientshapeok="t" o:extrusionok="f"></v:path><o:lock aspectratio="t" v:ext="edit"></o:lock></v:shapetype><o:p></o:p>
&nbsp;&nbsp;&nbsp; 通过本节的学习，一方面大家要学会使用Storyboard创建对象移动动画；另一方面也要掌握在Canvas画布容器中改变对象位置即X、Y坐标的方法分别是Canvas.SetLeft(对象,x坐标)和Canvas.SetTop(对象,y坐标)。<o:p></o:p>
&nbsp;&nbsp;&nbsp; <o:p></o:p>
&nbsp;&nbsp;&nbsp; 在Silverlight中除了可以使用Storyboard来创建移动动画外，还有另外两个选择：CompositionTarget和DispatcherTimer。<o:p></o:p>
<strong style="mso-bidi-font-weight: normal">1.2**<strong style="mso-bidi-font-weight: normal">通过**<strong style="mso-bidi-font-weight: normal">CompositionTarget**<strong style="mso-bidi-font-weight: normal">创建对象移动动画(交叉参考: <a href="http://www.cnblogs.com/alamiye010/archive/2009/06/17/1505331.html" target="_blank"><font color="#3366cc">让物体动起来②</font></a>)<o:p></o:p>**
CompositionTarget对象可以根据每个帧的回调来创建自定义动画。通俗的讲就是CompositionTarget创建的动画是基于画面每次刷新时触发的，与窗体刷新率保持一致，因而频率是相对固定的（随Silverlight应用程序的FPS而变化），人工无法介入控制。<o:p></o:p>
&nbsp;&nbsp;&nbsp; 那么如何使用它来实现1.1中一模一样的移动动画效果呢？<o:p></o:p>
与1.1的步骤一样，我们首先创建一个矩形对象(当圆角半径(RadiusX、RadiusY）与相应的边长(Width、Height)相等时呈圆形)，并在MainPage初始化后将之添加进画布同时注册画布鼠标左键点击事件：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// <summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// 填充色为蓝色，宽、高、圆角X、Y各50的矩形<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// </summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rectangle rectangle = new Rectangle() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fill = new SolidColorBrush(Colors.Blue),<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Width = 50,<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Height = 50,<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RadiusX = 50,<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RadiusY = 50<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p>
<o:p>&nbsp;</o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; public MainPage() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; InitializeComponent();<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //将矩形添加进画布容器中<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LayoutRoot.Children.Add(rectangle);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //注册画布容器的鼠标左键点击事件<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LayoutRoot.MouseLeftButtonDown += new MouseButtonEventHandler(LayoutRoot_MouseLeftButtonDown);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
因为是基于画面不停的刷新实现的对象位置改变，因此此时的鼠标左键事件中我们需要做的是记录鼠标移动的目的以及每次移动X、Y方向的速度增量(根据三角函数中的等边比例算出)和移动次数，同时依据具体情况注册/注销CompositionTarget.Rendering事件：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool isRendering = false; //是否启动了刷新<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double speed = 10; //每次移动10像素<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double xSpeed, ySpeed; //X、Y方向的速度<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num; //需要移动次数<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int count; //统计移动次数<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; private void LayoutRoot_MouseLeftButtonDown(object sender, MouseButtonEventArgs e) {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!isRendering) {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CompositionTarget.Rendering += new EventHandler(Rendering);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; isRendering = true;<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Point start = new Point(Canvas.GetLeft(rectangle), Canvas.GetTop(rectangle));<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Point end = e.GetPosition(LayoutRoot);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double distance = Math.Sqrt(Math.Pow((end.X - start.X), 2) + Math.Pow((end.Y - start.Y), 2));<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xSpeed = (end.X - start.X) * speed / distance;<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ySpeed = (end.Y - start.Y) * speed / distance;<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num = (int)(distance / speed);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count = 0;<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
最后编写CompositionTarget_Rendering方法体逻辑实现矩形移动：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; private void Rendering(object sender, EventArgs e) {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double x = Canvas.GetLeft(rectangle);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double y = Canvas.GetTop(rectangle);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Canvas.SetLeft(rectangle, x + xSpeed);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Canvas.SetTop(rectangle, y + ySpeed);<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count == num) {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CompositionTarget.Rendering -= Rendering;<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;isRendering = false;<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count++;<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
大体思路是：每次移动后记数count++，当移动到总次数num时将CompositionTarget.Rendering事件注销(取消订阅)掉，从而实现到达目的地时对象自动停止的效果。<o:p></o:p>
<o:p></o:p>
<strong style="mso-bidi-font-weight: normal">1.3**<strong style="mso-bidi-font-weight: normal">通过DispatcherTimer创建对象移动动画(交叉参考: <a href="http://www.cnblogs.com/alamiye010/archive/2009/06/17/1505333.html" target="_blank"><font color="#3366cc">让物体动起来③</font></a>&nbsp; <a href="http://www.cnblogs.com/alamiye010/archive/2009/06/17/1505335.html" target="_blank">实现2D人物动画①</a>&nbsp; <a href="http://www.cnblogs.com/alamiye010/archive/2009/06/17/1505334.html" target="_blank"><font color="#3366cc">实现2D人物动画②</font></a>)<o:p></o:p>**
DispatcherTimer顾名思义是一个计时器，它的Tick事件类似于在Silverlight界面线程中进行Join操作；并且基于Silverlight/WPF的Dispatcher机制，我们无需考虑任何跨线程问题。因此DispatcherTimer在Silverlight游戏开发中应用非常广泛。<o:p></o:p>
同样具备“心跳”特性的DispatcherTimer实现对象移动逻辑非常类似1.2中的CompositionTarget，唯一不同的是DispatcherTimer是完全可控的。于是我们仅仅需要做的是在1.2代码基础上稍动些手脚即可，具体如下：<o:p></o:p>
<font face="Calibri">1）</font>&nbsp; 定义一个间隔为10毫秒的DispatcherTimer对象：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //计时器对象<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DispatcherTimer dispatcherTimer = new DispatcherTimer() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interval = TimeSpan.FromMilliseconds(10)<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p>
2）在MainPage()中注册Tick事件：dispatcherTimer.Tick += new EventHandler(Rendering);
&nbsp;&nbsp;&nbsp; 3）将CompositionTarget.Rendering += new EventHandler(Rendering);修改为dispatcherTimer.Start();
&nbsp;&nbsp;&nbsp; 4）同样的将CompositionTarget.Rendering -= Rendering;修改为dispatcherTimer.Stop();<o:p></o:p>
&nbsp;&nbsp;&nbsp; 很简单对吧。由此可见DispatcherTimer实现动画的原理与CompositionTarget确实非常类似，只是我们可以通过Start()和Stop()更方便的启动/停止DispatcherTimer对象。<o:p></o:p>
以上三种方式均能实现鼠控制对象移动，那么我们该如何将之与游戏联系起来呢？<o:p></o:p>
大家是否已迫不及待的想要把真实的精灵加入到游戏画布中？此时的Rectangle将再次大显身手，我们可以通过为其设置宽、高并填充上PNG图象，转眼间一个华丽的精灵即呈现在我们眼前：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// <summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// 填充为一张宽高均150像素的PNG精灵图片矩形<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// </summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rectangle rectangle = new Rectangle() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fill = new ImageBrush() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ImageSource = new BitmapImage() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UriSource = new Uri(@"/Lesson1.3;component/Res/Sprite.png", UriKind.Relative)<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Width = 150,<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Height = 150<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p>
Silverlight用于图象呈现的载体除Rectangle外还有Image；Image使用起来更智能，它可以根据图像源的宽高自适应尺寸，我们需要做的仅仅是为其设置源文件路径而已：<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// <summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// 图像对象<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /// </summary><o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Image image = new Image() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Source = new BitmapImage() {<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UriSource = new Uri(@"/Lesson1.3;component/Res/Sprite.png", UriKind.Relative)<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p>
<o:p></o:p>
<strong style="mso-bidi-font-weight: normal">本课源码**：<a href="http://www.cnblogs.com/alamiye010/archive/2010/12/29/1920783.html" target="_blank">点击进入目录下载</a>****
**本课视频****：**<a href="http://www.cnblogs.com/alamiye010/archive/2010/12/29/1920783.html" target="_blank">点击进入目录下载</a><strong style="mso-bidi-font-weight: normal">**
<strong style="mso-bidi-font-weight: normal">本课小结**：1.1-1.3详细的介绍了三种动态创建动画的方法。大家可能会比较钟情于使用第一种更为平滑且流畅的Storyboard动画。没错，它不仅直观且使用方便。其实这3种动画都有它特定的使用场合，我们稍做对比分析一下：<o:p></o:p>
Storyboard动画的创建必须依赖关联属性(依赖属性)，为创建一系列高度连续变化的动画提供解决方案，甚至实现更为复杂的KeyFrame关键帧动画。<o:p></o:p>
CompositionTarget动画适合基于全局画面刷新时的时时属性更改，比如游戏循环等等。<o:p></o:p>
&nbsp;&nbsp;&nbsp; DispatcherTimer动画则非常适合运用于对象的自有动作动画中，例如精灵的移动，战斗，施法动作；魔法播放动画等等。<o:p></o:p>
充分理解并区分Storyboard，CompositionTarget以及DispatcherTimer，了解它们不同的应用场合，这将成为我们后续构建Silverlight游戏引擎所不可或缺的重要技术知识。<o:p></o:p>
<strong style="mso-bidi-font-weight: normal">课后作业**：通过键盘控制精灵移动。<o:p></o:p>
<strong style="mso-bidi-font-weight: normal">作业说明**：掌握Silverlight中的键盘操作技术对于未来步入Silverlight手机及移动平台网游开发领域奠定基础。<o:p></o:p>
<strong style="mso-bidi-font-weight: normal">参考资料：<a href="http://www.nxria.com/product/sub_wowommorpg.html" target="_blank"><font color="#3366cc">中游在线[WOWO世界]</font></a> 之 <a href="http://www.cnblogs.com/nowpaper/archive/2010/03/20/1690628.html" target="_blank"><font color="#3366cc">Silverlight C# 游戏开发：游戏开发技术</font></a><o:p></o:p>**
<strong style="mso-bidi-font-weight: normal">教程Demo在线演示地址：<a href="http://silverfuture.cn/" target="_blank">http://silverfuture.cn/</a><o:p></o:p>**