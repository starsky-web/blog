移动互联网随着智能手机的普及应用越来越广泛，所谓移动互联网是将移动通信和互联网整合在一起，使移动设备（包括手机和上网本、Pad平台）可以随时随地地访问互联网资源和应用获取相应的信息和处理。
从2011年开始，“三网融合”正式被国务院纳入十二五计划并开始实施。国务院十分明确的把三网融合作为全面提高信息化水平的重要手段进行定位，彰显出三网融合在国家战略层面发展不可替代的重要性，也为三网融合在十二五期间的发展提出了明确的方向和目标。在同一的治理平台下，实现音频、视频、数据信号的传输和管理，提供各种宽带应用和传统电信业务，是一个真正实现宽带窄带一体化、有线无线一体化、有源无源一体化、传输接入一体化的综合业务网络。让一根光纤解决看电视、打电话、上网的梦想变为现实。现在一个网线通过WIFI能把所有的通信设备连接起来，移动互联网又具有随时随地的便利性，未来移动互联网将和传统的互联网平起平坐，甚至有超越的趋势！
根据这个大趋势，小编教大家如何通过Android系统开发音视频
&nbsp; 如何在自己应用程序中播放一个可用的media音频：
1、将文件放到你的工程的res/raw文件夹中，在这个文件夹中，Eclipse插件将会找到它，同时，会将这个资源与你的R
类相关联起来；
2、创建一个MediaPlayer,并使用MediaPlayer.create与资源相关联起来，之后在实例中使用start()方法。
例如：MediaPlayer mp=MediaPlayer.create(context,R.raw.sound_file_1);
mp.start();
如果要想停止播放，使用stop()方法。如果你想稍后重新播放这段media，你必须在再次使用start()方法之前使用
reset()方法和prepare()方法来操作MediaPlayer对象。（create()第一次调用prepare()）
如果想暂停播放，可以使用pause()方法。在你暂停的地方恢复播放功能使用start()方法即可实现。
&nbsp;
播放一个文件
下面介绍如何播放一个文件：
1、用new创建一个MediaPlayer实例；
2、调用setDataSource()方法，这个方法有一个String类型的参数，这个String类型的参数包含了你所要播放的
文件的路径－本地文件系统或者是URL；
3、之后，先调用prepare()方法，然后才是start()方法。
例如：
MediaPlayer mp=new MediaPlayer();
mp.setDataSource(PATH_TO_FILE);
mp.prepare();
mp.start();
需要注意的一点是：如果你传递的是一个URL方式的文件，那么这个文件必须是可以下载的，并且是不间断的，简单地
如何录制media音频资源：
1、使用new创建一个实例android.media.MediaRecorder；
2、创建一个android.content.ContentValues实例并设置一些标准的属性，像TITLE，TIMESTAMP，最重要的是MIME_TYPE;
3、创建一个要放置的文件的路径，这可以通过android.content.ContentResolver在内容数据库中来创建一个入
口，并且自动地标志一个取得这个文件的路径。
4、使用MediaRecorder.setAudioSource()方法来设置音频资源；这将会很可能使用到MediaRecorder.AudioSource.MIC;
5、使用MediaRecorder.setOutputFormat()方法设置输出文件格式；
6、用MediaRecorder.setAudioEncoder()方法来设置音频编码；
7、最后，prepare()和start()所录制的音频，stop()和release()在要结束的时候调用。
recorder=new MediaRecorder();
ContentValues values=new ContentValues(3);
values.put(MediaStore.MediaColumns.TITLE,SOME_NAME_HERE);
values.put(MediaStore.MediaColumns.TIMESTAMP,System.currentTimeMillis());
values.put(MediaStore.MediaColumns.MIME_TYPE,recorder.getMimeContentType();
ContentResolver contentResolver=new ContentResolver();
Uri base=MediaStore.Audio.INTERNAL_CONTENT_URI;
Uri newUri=contentResolver.insert(base,values);&nbsp; //在所给定的URL中向一个表格插入一列数据
//函数原型：final Uri insert(Url,ContentValues values);
if(newUri==null){
&nbsp;&nbsp;&nbsp; //这里需要异常处理，我们在这里不能创建一个新的内容入口
}
String path=contentResolver.getDataFilePath(newUri);
//可以使用setPreviewDisplay()来陈列一个preview 来使View适合
recorder.setAudioSource(MediaRecorder.AudioSource.MIC);
recorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
recorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
recorder.setOutputFile(path);
recorder.prepare();
recorder.start();
停止录制：
recorder.stop();
recorder.release();
&nbsp;
在录制音频资源的过程中，使用到了ContentValues这个类，下面来解说这个类。
ContentValues这个类是用来存储一系列的值的，这些值要求ContentResolver能够process的。
ContentValues(int size)构造函数使用所给定的初始值创建一个空系列的值。
ContentValues(ContentValues from)这个构造函数创建一个从给定的ContentValues中来进行复制所产生的值。
这个类有如下的常用的方法:
void clear()&nbsp; 删除所有的值
boolean containsKey(String key) 如果这个对象有已命名的值就返回真
int describeContents() 描述值类型
Object get(String key) 获得值
void put(String key,Integer value)增加一个值到对应的set中
&nbsp;&nbsp; 小编在开发过程中大部分开发内容是借鉴了AnyChat这个免费的开发文档进行二次开发的。AnyChat在很多下载网址都提供下载。里面用于个人研究和演示是免费的！最主要的是AnyChat SDK是一套多媒体即时通讯平台库，绝大多数需要用到音视频交互的系统都可以采用AnyChat SDK来开发。而且AnyChat SDK的跨平台特性是其与众不同的亮点之一，目前支持Windows、Unix、Linux(x86、ARM)、Android、ios平台等，基本一般用户使用的开发平台都可以使用的，最难能可贵的是支持VC++、Delphi、C#、VB.Net、Qt等开发语言，不得不说是一个开发者借鉴的神奇平台！
可以到网址下载不同的平台版本：<a href="http://www.anychat.cn/">www.anychat.cn</a>
而且还有技术论坛，有任何疑问都可咨询，有专业人会回答的：<a href="http://bbs.anychat.cn/forum.php">http://bbs.anychat.cn/forum.php</a>
&nbsp;&nbsp; 视频录制是Android 视频开发其中之一，音视频的即时通讯、语音佟通信、视频监控、视频路况等开发都是在Android平台上去实现，今后跨平台的Android市场更是丰富多彩-。