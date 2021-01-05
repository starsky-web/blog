版权声明：本文为博主原创文章，未经博主允许不得转载。
```

### 前言
随着音视频领域的火热，在很多领域（教育，游戏，娱乐，体育，跑步，餐饮，音乐等）尝试做音视频直播/点播功能，那么作为开发一个小白，如何快速学习音视频基础知识，了解音视频编解码的传输协议，编解码方式，以及如何技术选型，如何解决遇到的坑，本文抛砖引玉，欢迎大咖交流。
### 一. 音视频的基础知识
#### 1.1 基本概念
`视频是什么`
&nbsp;```
​```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.fdf5c63a9d4fa550296f13929c8c0a46" data-original-code="静止的画面叫图像（picture）。连续的图像变化每秒超过24帧（frame）画面以上时，根椐视觉暂留原理，
人眼无法辨别每付单独的静态画面，看上去是平滑连续的视觉效果。这样的连续画面叫视频。
当连续图像变化每秒低于24帧画面时，人眼有不连续的感觉叫动画（cartoon）">`静止的画面叫图像（picture）。连续的图像变化每秒超过24帧（frame）画面以上时，根椐视觉暂留原理，
人眼无法辨别每付单独的静态画面，看上去是平滑连续的视觉效果。这样的连续画面叫视频。
当连续图像变化每秒低于24帧画面时，人眼有不连续的感觉叫动画（cartoon）
```
`流媒体`
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.b1c16969e7b81d2a75544f69679435e8" data-original-code="指采用流式传输的方式在Internet / Intranet播放的媒体格式.流媒体的数据流随时传送随 时播放，只是在开始时有些延迟
边下载边播入的流式传输方式不仅使启动延时大幅度地缩短，而且对系统缓存容量的需求也大大降低，极大地减少用户用在等待的时间">`指采用流式传输的方式在Internet / Intranet播放的媒体格式.流媒体的数据流随时传送随 时播放，只是在开始时有些延迟
边下载边播入的流式传输方式不仅使启动延时大幅度地缩短，而且对系统缓存容量的需求也大大降低，极大地减少用户用在等待的时间
```
`分辨率`
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.08a5acad7f893ba19723d4352fe864b9" data-original-code="分辨率是一个表示平面图像精细程度的概念，通常它是以横向和纵向点的数量来衡量的，表示成水平点数垂直点数的形式，
在计算机显示领域我们也表示成“每英寸像素”（ppi）.在一个固定的平面内，分辨率越高，意味着可使用的点数越多，图像越细致">`分辨率是一个表示平面图像精细程度的概念，通常它是以横向和纵向点的数量来衡量的，表示成水平点数垂直点数的形式，
在计算机显示领域我们也表示成“每英寸像素”（ppi）.在一个固定的平面内，分辨率越高，意味着可使用的点数越多，图像越细致
```
`码流`
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.45a96a7b53fdfad29ac42a7aeb90fc3b" data-original-code=" 数据传输时单位时间传送的数据位数,可以理解其为取样率，单位时间内取样率越大，精度就越高，处理出来的文件就越接近原始文件，但是文件体积与取样率是成正比的
 如何用最低的码率达到最少的失真，一般我们用的单位是kbps即千位每秒">` 数据传输时单位时间传送的数据位数,可以理解其为取样率，单位时间内取样率越大，精度就越高，处理出来的文件就越接近原始文件，但是文件体积与取样率是成正比的
 如何用最低的码率达到最少的失真，一般我们用的单位是kbps即千位每秒
```
`帧率`
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.9aa3a8e024ce5c3642a9cfecd470dd8b" data-original-code="帧/秒（frames per second）的缩写，也称为帧速率，测量用于保存、显示动态视频的信息数量。每一帧都是静止的图象，快速连续地显示帧便形成了运动的假象。
每秒钟帧数 （fps） 愈多，所显示的动作就会愈流畅，可理解为1秒钟时间里刷新的图片的帧数，也可以理解为图形处理器每秒钟能够刷新几次，也就是指每秒钟能够播放（或者录制）多少格画面。">`帧/秒（frames per second）的缩写，也称为帧速率，测量用于保存、显示动态视频的信息数量。每一帧都是静止的图象，快速连续地显示帧便形成了运动的假象。
每秒钟帧数 （fps） 愈多，所显示的动作就会愈流畅，可理解为1秒钟时间里刷新的图片的帧数，也可以理解为图形处理器每秒钟能够刷新几次，也就是指每秒钟能够播放（或者录制）多少格画面。
```
#### 1.2 多媒体的格式分类
&nbsp;```
<pre data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.5691f60e30c0c09214cde312fa3896e2" data-original-code="封装格式(专业上讲叫容器,通俗的叫文件格式),视频编解码,音频编解码
####1.1常见的封装格式
* MPEG : 编码采用的容器，具有流的特性。里面又分为 PS，TS 等，PS 主要用于 DVD 存储，TS 主要用于 HDTV.
* MPEG Audio Layer 3 :大名鼎鼎的 MP3，已经成为网络音频的主流格式，能在 128kbps 的码率接近 CD 音质
* MPEG-4(Mp4) : 编码采用的容器，基于 QuickTime MOV 开发，具有许多先进特性;实际上是对Apple公司开发的MOV格式(也称Quicktime格式)的一种改进.
* MKV: 它能把 Windows Media Video，RealVideo，MPEG-4 等视频音频融为一个文件，而且支持多音轨，支持章节字幕等;开源的容器格式
* 3GP : 3GPP视频采用的格式， 主要用于流媒体传送;3GP其实是MP4格式的一种简化版本,是手机视频格式的绝对主流.
* MOV : QuickTime 的容器，恐怕也是现今最强大的容器，甚至支持虚拟现实技术，Java等，它的变种 MP4,3GP都没有这么厉害;广泛应用于Mac OS操作系统，在Windows操作系统上也可兼容，但是远比不上AVI格式流行
* AVI : 最常见的音频视频容器,音频视频交错（Audio Video Interleaved）允许视频和音频交错在一起同步播放.
* WAV : 一种音频容器，大家常说的 WAV 就是没有压缩的 PCM 编码，其实 WAV 里面还可以包括 MP3 等其他 ACM 压缩编码
等等

封装格式(专业上讲叫容器,通俗的叫文件格式),视频编解码,音频编解码
####1.1常见的封装格式
* MPEG : 编码采用的容器，具有流的特性。里面又分为 PS，TS 等，PS 主要用于 DVD 存储，TS 主要用于 HDTV.
* MPEG Audio Layer 3 :大名鼎鼎的 MP3，已经成为网络音频的主流格式，能在 128kbps 的码率接近 CD 音质
* MPEG-4(Mp4) : 编码采用的容器，基于 QuickTime MOV 开发，具有许多先进特性;实际上是对Apple公司开发的MOV格式(也称Quicktime格式)的一种改进.
* MKV: 它能把 Windows Media Video，RealVideo，MPEG-4 等视频音频融为一个文件，而且支持多音轨，支持章节字幕等;开源的容器格式
* 3GP : 3GPP视频采用的格式， 主要用于流媒体传送;3GP其实是MP4格式的一种简化版本,是手机视频格式的绝对主流.
* MOV : QuickTime 的容器，恐怕也是现今最强大的容器，甚至支持虚拟现实技术，Java等，它的变种 MP4,3GP都没有这么厉害;广泛应用于Mac OS操作系统，在Windows操作系统上也可兼容，但是远比不上AVI格式流行
* AVI : 最常见的音频视频容器,音频视频交错（Audio Video Interleaved）允许视频和音频交错在一起同步播放.
* WAV : 一种音频容器，大家常说的 WAV 就是没有压缩的 PCM 编码，其实 WAV 里面还可以包括 MP3 等其他 ACM 压缩编码
等等

```
#### 1.3 流媒体协议(RTP RTCP RTSP RTMP HLS)
<ol>
- RTP RTCP RTSP
</ol>
&nbsp;```
​```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.7ba8c16ad4a85c4a374f791579170525" data-original-code="RTP :(Real-time Transport Protocol)是用于Internet上针对多媒体数据流的一种传输层协议.RTP协议和RTP控制协议RTCP一起使用，而且它是建立在UDP协议上的
RTCP:Real-time Transport Control Protocol或RTP Control Protocol或简写RTCP）实时传输控制协议,是实时传输协议（RTP）的一个姐妹协议
RTP协议和RTP控制协议RTCP一起使用，而且它是建立在UDP协议上的
RTSP:（Real Time Streaming Protocol）是用来控制声音或影像的多媒体串流协议,RTSP提供了一个可扩展框架，使实时数据，如音频与视频的受控、点播成为可能。
数据源包括现场数据与存储在剪辑中的数据。该协议目的在于控制多个数据发送连接，为选择发送通道，如UDP、多播UDP与TCP提供途径，并为选择基于RTP上发送机制提供方法
传输时所用的网络通讯协定并不在其定义的范围内，服务器端可以自行选择使用TCP或UDP来传送串流内容，比较能容忍网络延迟

RTP不像http和ftp可完整的下载整个影视文件，它是以固定的数据率在网络上发送数据，客户端也是按照这种速度观看影视文件，当影视画面播放过后，就不可以再重复播放，除非重新向服务器端要求数据。
RTSP与RTP最大的区别在于：RTSP是一种双向实时数据传输协议，它允许客户端向服务器端发送请求，如回放、快进、倒退等操作。当然，RTSP可基于RTP来传送数据，还可以选择TCP、UDP、组播UDP等通道来发送数据，具有很好的扩展性。它时一种类似与http协议的网络应用层协议">`RTP :(Real-time Transport Protocol)是用于Internet上针对多媒体数据流的一种传输层协议.RTP协议和RTP控制协议RTCP一起使用，而且它是建立在UDP协议上的
RTCP:Real-time Transport Control Protocol或RTP Control Protocol或简写RTCP）实时传输控制协议,是实时传输协议（RTP）的一个姐妹协议
RTP协议和RTP控制协议RTCP一起使用，而且它是建立在UDP协议上的
RTSP:（Real Time Streaming Protocol）是用来控制声音或影像的多媒体串流协议,RTSP提供了一个可扩展框架，使实时数据，如音频与视频的受控、点播成为可能。
数据源包括现场数据与存储在剪辑中的数据。该协议目的在于控制多个数据发送连接，为选择发送通道，如UDP、多播UDP与TCP提供途径，并为选择基于RTP上发送机制提供方法
传输时所用的网络通讯协定并不在其定义的范围内，服务器端可以自行选择使用TCP或UDP来传送串流内容，比较能容忍网络延迟

RTP不像http和ftp可完整的下载整个影视文件，它是以固定的数据率在网络上发送数据，客户端也是按照这种速度观看影视文件，当影视画面播放过后，就不可以再重复播放，除非重新向服务器端要求数据。
RTSP与RTP最大的区别在于：RTSP是一种双向实时数据传输协议，它允许客户端向服务器端发送请求，如回放、快进、倒退等操作。当然，RTSP可基于RTP来传送数据，还可以选择TCP、UDP、组播UDP等通道来发送数据，具有很好的扩展性。它时一种类似与http协议的网络应用层协议
```
<img title="" src="//upload-images.jianshu.io/upload_images/1791669-b3cf4dbc815392cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt="">
<ol>
- RTMP
</ol>
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.b684d6eec72e1b6d147efba9f6e4f902" data-original-code="RTMP(Real Time Messaging Protocol)实时消息传送协议是Adobe Systems公司为Flash播放器和服务器之间音频、视频和数据传输 开发的开放协议">`RTMP(Real Time Messaging Protocol)实时消息传送协议是Adobe Systems公司为Flash播放器和服务器之间音频、视频和数据传输 开发的开放协议
```
<ol>
- HLS
</ol>
&nbsp;```
​```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.7c1b9a8af6f851c591000ca10547bd0c" data-original-code="HTTP Live Streaming（HLS）是苹果公司(Apple Inc.)实现的基于HTTP的流媒体传输协议，可实现流媒体的直播和点播，主要应用在iOS系统，
为iOS设备（如iPhone、iPad）提供音视频直播和点播方案。HLS点播，基本上就是常见的分段HTTP点播，不同在于，它的分段非常小。
相对于常见的流媒体直播协议，例如RTMP协议、RTSP协议、MMS协议等，HLS直播最大的不同在于，直播客户端获取到的，并不是一个完整的数据流。
HLS协议在服务器端将直播数据流存储为连续的、很短时长的媒体文件（MPEG-TS格式），而客户端则不断的下载并播放这些小文件，
因为服务器端总是会将最新的直播数据生成新的小文件，这样客户端只要不停的按顺序播放从服务器获取到的文件，就实现了直播。
由此可见，基本上可以认为，HLS是以点播的技术方式来实现直播。由于数据通过HTTP协议传输，所以完全不用考虑防火墙或者代理的问题，
而且分段文件的时长很短，客户端可以很快的选择和切换码率，以适应不同带宽条件下的播放。不过HLS的这种技术特点，决定了它的延迟一般总是会高于普通的流媒体直播协议。　">`HTTP Live Streaming（HLS）是苹果公司(Apple Inc.)实现的基于HTTP的流媒体传输协议，可实现流媒体的直播和点播，主要应用在iOS系统，
为iOS设备（如iPhone、iPad）提供音视频直播和点播方案。HLS点播，基本上就是常见的分段HTTP点播，不同在于，它的分段非常小。
相对于常见的流媒体直播协议，例如RTMP协议、RTSP协议、MMS协议等，HLS直播最大的不同在于，直播客户端获取到的，并不是一个完整的数据流。
HLS协议在服务器端将直播数据流存储为连续的、很短时长的媒体文件（MPEG-TS格式），而客户端则不断的下载并播放这些小文件，
因为服务器端总是会将最新的直播数据生成新的小文件，这样客户端只要不停的按顺序播放从服务器获取到的文件，就实现了直播。
由此可见，基本上可以认为，HLS是以点播的技术方式来实现直播。由于数据通过HTTP协议传输，所以完全不用考虑防火墙或者代理的问题，
而且分段文件的时长很短，客户端可以很快的选择和切换码率，以适应不同带宽条件下的播放。不过HLS的这种技术特点，决定了它的延迟一般总是会高于普通的流媒体直播协议。　
```
### 二. android音视频的开发
播放流程: 获取流–>解码–>播放 <br>录制播放路程: 录制音频视频–>剪辑–>编码–>上传服务器 别人播放. <br>直播过程 : 录制音视频–>编码–>流媒体传输–>服务器—>流媒体传输到其他app–>解码–>播放
几个重要的环节
<ol>
- 录制音视频 AudioRecord/MediaRecord
- 视频剪辑 mp4parser 或ffmpeg
- 音视频编码 aac&amp;h264
- 上传大文件 网络框架,进度监听,断点续传
- 流媒体传输 流媒体传输协议rtmp rtsp hls
- 音视频解码 aac&amp;h264
- 渲染播放 MediaPlayer
</ol>
问题 <br>android本身有提供MediaPlayer,那么mediaplayer支持哪些格式的流媒体协议呐?又支持哪些解码器呐?兼容性如何,性功能如何? <br><a href="http://developer.android.com/intl/zh-cn/guide/appendix/media-formats.html">Supported Media Formats</a> <br><a href="http://developer.android.com/intl/zh-cn/guide/topics/media/mediaplayer.html">Media Playback</a>
<img title="" src="//upload-images.jianshu.io/upload_images/1791669-3f42038b580656b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt=""> <br><img title="" src="https://pic2.zhimg.com/83e2db86a440a4f2ca56da7aafea7281_b.jpg" alt="">
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.9f54b7dadb8c49f197e6866d7cbdac7d" data-original-code="MPEG－2：制定于1994年，设计目标为高级工业标准的图像质量以及更高的传输率。这种格式主要应用在DVD/SVCD的制作(压缩)方面，
同时在一些HDTV(高清晰电视广播)和一些高要求视频编辑、处理上面也有相当的应用。使用MPEG-2的压缩算法，可以把一部120分钟长的电影压缩到4到8GB的大小。
这种视频格式的文件扩展名包括.mpg、.mpe、.mpeg、.m2v及DVD光盘上的.vob文件等。
MPEG－4：制定于1998年，MPEG－4是为了播放流式媒体的高质量视频而专门设计的，它可利用很窄的带宽，通过帧重建技术，
压缩和传输数据，以求使用最少的数据获得最佳的图像质量。目前MPEG-4最有吸引力的地方在于它能够保存接近于DVD画质的
小体积视频文件。另外，这种文件格式还包含了以前MPEG压缩标准所不具备的比特率的可伸缩性、动画精灵、交互性甚至版权
保护等一些特殊功能。这种视频格式的文件扩展名包括.asf、.mov和DivX AVI等。">`MPEG－2：制定于1994年，设计目标为高级工业标准的图像质量以及更高的传输率。这种格式主要应用在DVD/SVCD的制作(压缩)方面，
同时在一些HDTV(高清晰电视广播)和一些高要求视频编辑、处理上面也有相当的应用。使用MPEG-2的压缩算法，可以把一部120分钟长的电影压缩到4到8GB的大小。
这种视频格式的文件扩展名包括.mpg、.mpe、.mpeg、.m2v及DVD光盘上的.vob文件等。
MPEG－4：制定于1998年，MPEG－4是为了播放流式媒体的高质量视频而专门设计的，它可利用很窄的带宽，通过帧重建技术，
压缩和传输数据，以求使用最少的数据获得最佳的图像质量。目前MPEG-4最有吸引力的地方在于它能够保存接近于DVD画质的
小体积视频文件。另外，这种文件格式还包含了以前MPEG压缩标准所不具备的比特率的可伸缩性、动画精灵、交互性甚至版权
保护等一些特殊功能。这种视频格式的文件扩展名包括.asf、.mov和DivX AVI等。
```
从上图我们也看到,android平台自身支持的音视频解码是有限的 一般的mp3 mp4….3gp 等等 其他的只能自己解码了。。。 <br>那么如何解码呐? <br>经过一番调研对比,选择乐ijkplayer.
### 三. ijkplayer的引入&amp;介绍&amp;使用
正如上文所说,android本事对音视频流媒体传输协议,以及音视频编解码支持有限.所以对于直播类应用,要自己解码
#### 3.1 调研过程
<a href="https://www.vitamio.org/">vitamio</a> <br><a href="https://webrtc.org/">webRTC</a> <br><a href="https://www.ffmpeg.org/">ffmpeg</a> <br><a href="https://wiki.videolan.org/AndroidCompile">vlc</a> <br><a href="https://github.com/Bilibili/ijkplayer">ijkplayer</a>
先说下 vitamio这个是功能很强大,但是企业收费版的,个人用户可以玩玩. <br>目前WebRtc只适合小范围（8人以内）音视频会议，不适合做直播<a href="https://www.zhihu.com/question/25497090">可以用WebRTC来做视频直播吗？</a> <br>接下来介绍下 ffmpeg vlc ijkplayer以及选择方案
ffmpeg是一个非常强大的音视频编解码开源库,目前市场上流行的播放器,大部分都是基于此开发的,包括暴风,腾讯,等等以及上面提到的vitamio,vlc,ijkplayer <br>关于ffmpeg源码分析,有兴趣的请看<a href="http://blog.csdn.net/leixiaohua1020/article/details/12677129">雷霄骅(leixiaohua1020)的专栏</a>
vlc 支持android开发 ,ijkplayer也支持. 通过反编译网易云音乐,以及YY等音视频app.发现网易云音乐,斗鱼用的ijkplayer,YY用的VLC. <br>那么vlc&amp;ijkplayer相比较各有什么优缺点呐,该如何选择呐?[待深入使用,或者用过的可以交流下] <br>其实这个没有深入分析,ijkplayer是bilibili开源的音视频编解码库,对android,ios进行和很好的抽取封装,易于编译使用.vlc尝试过,稍微复杂些.
#### 3.2 ijkplayer的导入&amp;编译&amp;使用
如果不需要对源码进行修改,在app的build.gradle中加入如下依赖即可
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.d08824b4d10ca48c26d87b891ce17f16" data-original-code="dependencies {
    # required, enough for most devices.
    compile 'tv.danmaku.ijk.media:ijkplayer-java:0.4.5.1'
    compile 'tv.danmaku.ijk.media:ijkplayer-armv7a:0.4.5.1'

    # Other ABIs: optional
    compile 'tv.danmaku.ijk.media:ijkplayer-armv5:0.4.5.1'
    compile 'tv.danmaku.ijk.media:ijkplayer-arm64:0.4.5.1'
    compile 'tv.danmaku.ijk.media:ijkplayer-x86:0.4.5.1'

    # ExoPlayer as IMediaPlayer: optional, experimental
    compile 'tv.danmaku.ijk.media:ijkplayer-exo:0.4.5.1'
}">`dependencies {
    # required, enough for most devices.
    compile 'tv.danmaku.ijk.media:ijkplayer-java:0.4.5.1'
    compile 'tv.danmaku.ijk.media:ijkplayer-armv7a:0.4.5.1'

    # Other ABIs: optional
    compile 'tv.danmaku.ijk.media:ijkplayer-armv5:0.4.5.1'
    compile 'tv.danmaku.ijk.media:ijkplayer-arm64:0.4.5.1'
    compile 'tv.danmaku.ijk.media:ijkplayer-x86:0.4.5.1'

    # ExoPlayer as IMediaPlayer: optional, experimental
    compile 'tv.danmaku.ijk.media:ijkplayer-exo:0.4.5.1'
}
```
当然如何你想对其源码进行修改,采用如下方式 <br>1. 需要 <br>下载配置 NDK r10e <br>配置androidsdk <br># add these lines to your ~/.bash_profile or ~/.profile <br># export ANDROID_SDK= <br># export ANDROID_NDK= <br>2.
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.20f2e1f68eeaaa48b59e1c14298411de" data-original-code="Build Android

git clone https://github.com/Bilibili/ijkplayer.git ijkplayer-android
cd ijkplayer-android
git checkout -B latest k0.4.5.1

./init-android.sh   //此步用于下载ffmpeg,初始化配置

cd android/contrib
./compile-ffmpeg.sh clean
./compile-ffmpeg.sh all

cd ..
./compile-ijk.sh all

然后通过androidstudio把生成的project导入工程
# Android Studio:
#     Open an existing Android Studio project
#     Select android/ijkplayer/ and import
">`Build Android

git clone https://github.com/Bilibili/ijkplayer.git ijkplayer-android
cd ijkplayer-android
git checkout -B latest k0.4.5.1

./init-android.sh   //此步用于下载ffmpeg,初始化配置

cd android/contrib
./compile-ffmpeg.sh clean
./compile-ffmpeg.sh all

cd ..
./compile-ijk.sh all

然后通过androidstudio把生成的project导入工程
# Android Studio:
#     Open an existing Android Studio project
#     Select android/ijkplayer/ and import

```
可以根据需要对音视频编解码库进行裁剪.编译出最小的满足需要的库 <br>bilibili提供三种裁剪方式 <br>If you prefer more codec/format
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.02cb1657757a6ce4315ecbe622c2d79a" data-original-code="cd config
rm module.sh
ln -s module-default.sh module.sh
cd android/contrib
sh compile-ffmpeg clean">`cd config
rm module.sh
ln -s module-default.sh module.sh
cd android/contrib
sh compile-ffmpeg clean
```
If you prefer less codec/format for smaller binary size (include hevc function)
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.d53c1f342bd63f0c427cdaaba10c7099" data-original-code="cd config
rm module.sh
ln -s module-lite-hevc.sh module.sh
cd android/contrib
sh compile-ffmpeg clean">`cd config
rm module.sh
ln -s module-lite-hevc.sh module.sh
cd android/contrib
sh compile-ffmpeg clean
```
If you prefer less codec/format for smaller binary size (by default)
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.47e685c083848389b6de61d016d8a9a6" data-original-code="cd config
rm module.sh
ln -s module-lite.sh module.sh
cd android/contrib
sh compile-ffmpeg clean">`cd config
rm module.sh
ln -s module-lite.sh module.sh
cd android/contrib
sh compile-ffmpeg clean
```
当然也可以根据需要自己裁剪. <br>我们来看下ijkplayer/config/module-lite.sh 即default裁剪模式支持哪些编解码方式 <br>我们可以看到 <br>export COMMON_FF_CFG_FLAGS=”COMMON&nbsp;F&nbsp;F&nbsp;C&nbsp;FG&nbsp;F&nbsp;LAGS–enable−demuxer=hls”exportCOMMON&nbsp;F&nbsp;F&nbsp;C&nbsp;FG&nbsp;F&nbsp;LAGS=”&nbsp; COMMON_FF_CFG_FLAGS –enable-parser=aac” <br>export COMMON_FF_CFG_FLAGS=”COMMON&nbsp;F&nbsp;F&nbsp;C&nbsp;FG&nbsp;F&nbsp;LAGS–enable−parser=h264”exportCOMMON&nbsp;F&nbsp;F&nbsp;C&nbsp;FG&nbsp;F&nbsp;LAGS=”&nbsp; COMMON_FF_CFG_FLAGS –disable-protocol=rtp” <br>export COMMON_FF_CFG_FLAGS=”$COMMON_FF_CFG_FLAGS –enable-protocol=rtmp”
### 四. ijkplayer的java层源码分析
【先占坑，接下来详解】
### 五. 项目中ijkplayer的封装以及mediaview的封装以及使用
【先占坑，接下来详解】
### 六. ijkplayer底层学习
【先占坑，接下来重点学习】
### 七. 开源项目
【接下来仿网易云音乐，写一个开源项目，欢迎多多关注】
### 七. 常见问题以及解决方案
<ol>
- <a href="https://github.com/Bilibili/ijkplayer/issues/210">ijkplayer播放rtmp直播流，延迟明显 </a>
- 全屏播放
- 有时候会开始直播时出现黑屏
- 有时候会出现花屏
- 解码方式设置
- 如何区分点播直播
- 是否需要开启硬件加速
- <a href="https://github.com/Bilibili/ijkplayer/issues/1074">How to set up only listen to the sound does not show video?</a>
- 如何设置后台播放
- 视频加载速度慢 <br>The traffic speed is mostly depending on the quality of video CDN, not player itself.
- 怎么静音 和非静音 <br>mute/unmute system volume.There is no mute/unmute API in ijkplayer.
- 视频黑屏，但是有声音 <br>确定下视频源的编码方式,ijk默认只带了h264解码code
- 适配问题,对于不同的cpu架构,需要编译不同的so库
- 播放视频有的设备声画不同步
- 如何查看m3u8时长 <br>cat game05.m3u8 | grep EXTINF | wc -l 32
- how to change the video quality? <br>Video quality is determined when being encoded.I don’t think it can be changed by player.
- 倍速播放 <br>Not until Android 6.0
- 为什么往前拖动进度条后，还会往后退几秒 <br>seek只支持关键帧，出现这个情况就是原始的视频文件中i 帧比较少，播放器会在拖动的位置找最近的关键帧。
- how to change URL when ijkplayer is playing RTMP video <br>Create new player.
- 怎样添加字幕呢？ <br>如果希望字幕时间精确，可以在native层做解析和时间同步，到了时间后回调给java层,一般字幕文件加载都是在java层做的，解析文件格式，然后按照时间区间来显示。
- 如何设置硬解? <br>ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, “mediacodec”, 1);
</ol>
&nbsp;```
```prettyprint prettyprinted" data-codota-status="done" data-snippet-saved="false" data-snippet-id="ext.a467ce623961c24a44f5ac89027f0897" data-original-code="ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "http-detect-range-support", 0);
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "overlay-format", IjkMediaPlayer.SDL_FCC_RV32);
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "analyzeduration", "2000000");
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "probsize", "4096");
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_CODEC, "skip_loop_filter", 0);">`ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "http-detect-range-support", 0);
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "overlay-format", IjkMediaPlayer.SDL_FCC_RV32);
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "analyzeduration", "2000000");
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_PLAYER, "probsize", "4096");
                ijkMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_CODEC, "skip_loop_filter", 0);
```
### 八. 参考
<a href="http://jlwen.blog.51cto.com/256149/253543">视频基础知识</a> <br><a href="http://zzqhost.github.io/hostwiki/%E5%A4%9A%E5%AA%92%E4%BD%93%E7%9B%B8%E5%85%B3_%E5%A4%9A%E5%AA%92%E4%BD%93%E7%BC%96%E8%A7%A3%E7%A0%81%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86.html">多媒体编解码基础知识</a> <br><a href="http://zzqhost.github.io/hostwiki/%E5%A4%9A%E5%AA%92%E4%BD%93%E7%9B%B8%E5%85%B3_%E6%B5%81%E5%AA%92%E4%BD%93%E4%B8%AD%E7%94%A8%E5%88%B0%E7%9A%84%E5%87%A0%E4%B8%AA%E5%8D%8F%E8%AE%AE%E7%AE%80%E4%BB%8B.html">流媒体中用到的几个协议简介</a> <br><a href="http://blog.csdn.net/tttyd/article/details/12032357">流媒体协议介绍（rtp/rtcp/rtsp/rtmp/mms/hls）</a> <br><a href="http://developer.android.com/intl/zh-cn/index.html">android-developer</a> <br><a href="https://code.google.com/p/android/issues/detail?id=15229">No RTSP keep-alive packets in 2.3 causing streaming server to close the connection</a> <br><a href="http://www.cnblogs.com/mcodec/articles/1780598.html">H264解码器源码(Android 1.6 版)</a> <br><a href="http://www.cnblogs.com/mythou/p/3235698.html">Android VLC播放器二次开发1——程序结构分析</a> <br><a href="https://www.zhihu.com/question/25497090">可以用WebRTC来做视频直播吗？</a> <br><a href="http://www.cnblogs.com/lingyunhu/">WebRTC音视频开发总结</a> <br><a href="http://blog.csdn.net/leixiaohua1020/article/details/12677129">雷霄骅(leixiaohua1020)的专栏</a> <br><a href="http://developer.android.com/intl/zh-cn/reference/android/media/MediaPlayer.html">MediaPlayer</a>
<a href="https://github.com/ayyb1988">github</a> <br><a href="http://weibo.com/2097029985/profile?topnav=1&amp;wvr=6&amp;is_all=1">微博</a> <br>欢迎多多交流
```

```
```

```
```

```