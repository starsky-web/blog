　　音视频开发是个非常复杂的，庞大的开发话题，初涉其中，先看一下结合 <a class="Link ztext-link" href="https://www.cnblogs.com/zhouxin/p/12568967.html" target="_blank" data-offset-key="220tt-1-0" data-editable="true">OEIP</a>(开源项目) 新增例子.
　　
&nbsp;&nbsp;　　可以打开flv,mp4类型文件，以及rtmp协议音视频数据，声音的播放使用SDL。
　　
&nbsp;&nbsp;　　把采集的麦/声卡数据混合并与采集的视频信息写入媒体文件或是RMTP协议中。
## 图片主要属性
　　包含长/宽/通道数/像素格式(U8/U16/F32)，以及排列格式RGBA/YUV。其中通道与像素格式，如在opencv中，CV_8UC1/CV_8UC4，表示1个通道与4个通道的U8格式。而排列格式，简单的分为RGBA类的，如BGRA，BGR，R这些，一般用于游戏里的纹理，RGBA/BGR/R本身有表示通道格式的意思，所以后面组合RGBA32,RGBAF32用来表示通道像素里数据格式。而YUV类型，一般用在媒体类型，如采集设备，音视频文件，推拉流传输等，YUV格式有二个组成部分。一是UV对应像素个数，如YUV420,YUV422,YUV444,他们的相同点就是一个像素点对应一个Y，不同点是，如YUV420表示一个U/V对应4个像素点，422一个UV对应二个像素点，UV444则表示一个UV对应一个像素点，YUV像素点数据格式一般是U8。
　　我们可以来比较一些常用格式最终占用字节大小，如1080P下。

- RGBA32 1920*1080*4=8,294,400‬ 其中4是每个像素包含RGBA四个通道。
- YUV420 1920*1080 + 980*540*2 前面是Y占用大小，后面是UV占用大小。
- YUV422 1920*1080 + 980*1080*2 前面是Y占用大小，后面是UV占用大小
- YUV444 1920*1080*3 每个像素一个YUV三通道。

　　第二是排序格式，如YUV420可以细分YUV420I，YUV420P，YUV420SP(NV12)，简单来说，后缀是P是表示YUV这三个分开存放，而SP是Y单独分开，UV交织在一起，而I就更简单了，YUV交织在一起，简单来说，和RGBA格式差不多排列。
　　YUV420P/YUV422P 一般用来视频文件与推拉流传输上,我想可能原因是Y用来表示亮度，人眼最敏感部分，早期黑白电视只有Y大家一样能看，这种格式最方便兼容，直接把UV丢弃就行,Y/U/V可能在内存分布上不连续。其中YUV420I/YUV422I 这种交织的一般是采集设备所用，内存上连续，方便处理，YUV420SP(NV12) 这种一般也是采集设备所有，这种格式简单来说，一是方便只使用Y，二是UV可以和Y的宽度统一，后面align的话，YUV也是统一一个，内存上也方便连续。
　　在OEIP中的DX11与对应CUDA模块中，可以看到YUV各种格式与RGB转化的相关代码。
## 音频基本属性如下
　　采样率：如人耳听到最高频率是22kHz,如要完全重现频率，需要采样率是频率*2，所以一般来说44100是很常见的采样率。
　　声道数：常见单声道，双声道，也有不常见的更多声道。
　　数据格式：一般是S16(16位有符号整合),F32(32位浮点)，别的不算常用如U8,D64，这二个表示的分贝范围一个太小，一个太大。
　　和图像类型，多个声道的表示方法也有P(平面),I(交织),类似，音频采集数据一般是I，传输P，在OEIP项目中，相应格式一般都转成单声道S16,也就不需要管理是P还是I。
## 音视频开发基本概念
　　有了上面基本认识，我们再来认识一些概念(以下是本人的一些基本理解，如果有错，欢迎大家指出)。
　　编码：把原始音视频数据压缩，简单来说，1080PYUV420的大小1920*1080*3/2=3,110,400 Byte，1秒25桢的话就有差不多78M。视频如YUV->H264,音频PCM->ACC过程就是编码。在FFmpeg中，类似过程就是AVFrame->AVPacket
　　解码：把压缩后的音视频转换成原始音视频数据，H264->YUV,ACC->PCM过程。在FFmpeg中，就是AVPacket->AVFrame.
　　在编码与解码中，图像每桢原始大小取决原始图像大小根据长宽，像素排序和格式组成，而音频每桢对于特定编解码器是每个通道固定多少采样点，如AAC是1024(也有特殊情况2048的)，MP3是1152，相应字段在AVFrame.nb_sampes,AVCodecContext.frame_size里表示.这样AAC中双通道 U16每桢数据量就在2*sizeof(U16)*1024.而码率决定了编码质量，一般情况下，码率高质量好，但是生成文件或是网络占用就好，合适的码率网上有介绍，1080P下一般用4M的码率，你用1M也行，但是画面动的时候可能就糊了，码率控制也有不同的控制策略，根据需求选择自己的控制策略，这部分网上有详细的讲解。
　　媒体文件：FLV/MP4这些，不同媒体格式把编码的信息用不同的方式保存，不同媒体格式支持不同的编码格式，大部媒体格式都支持h264/acc编码信息,所以这二个编码格式比较常用。
　　多媒体协议：RTMP/RTSP这些，在媒体文件之上封装网络传输与控制的相关信息。
　　音视频流：流分为音频流，视频流，字幕流等等这些，其中 媒体文件里可能包含一个或多个音视频流，而每个视频流是相同属性(长宽，像素格式等)的原始视频数据编码成的信息流。
　　复用：举个例子，把一个音频流与一个视频流合成一个媒体文件，就是复用。
　　解复用：如上，把一个媒体文件分解成相应的音频流与视频流。
## FFmpeg主要对象
　　AVFormatContext：多媒体协议或是媒体文件，如果是协议，会解析出协议里包含的媒体文件信息，这个类主要如今读/写压缩包，读/写文件头与文件尾等方法。你可以把这对象认为是一个媒体文件。
　　AVCodec：编解码，注意编码与解码或是用同一codecId,但是对象不同，这个对象主要包含一些函数指针，告诉如何把frame->packet/packet->frame.
　　AVCodecContext：编解码环境，简单来说，AVCodec是说如何编解码，这个就是告诉他相应属性设置，如对应视频来说，长宽，以及编码相应设置是否包含B桢，GOP是多少都在这，可以这么理解，我们假设AVCodec与AVCodecContext如果是一个类，那么AVCodec相当于里面的方法集合，AVCodecContext相当于里面的变量集合。
　　AVStream：媒体文件一般来说至少包含一个音频流或是视频流，在复用/解复用到编解码之间是个承上启下的关系。你可以理解AVStream包含音视频编码的信息列表。AVStream也要包含相应的AVCodecContext包含的编解码信息，后面会讲这二者信息在复用与解复用从那复制到那。
　　AVFrame：音视频原始信息，包含一个定长的数据信息。
　　AVPacket：音视频编码信息，包含一个不定长的数据信息。
## FFmpeg常见API分析
　　读一个媒体文件相应动作与API解析。
　　avformat_open_input 根据媒体文件/协议地址打开AVFormatContext。
　　avformat_find_stream_info 查找AVFormatContext里对应的音视频流索引。
　　avcodec_find_decoder 根据索引打开对应音频与视频流解码器。
　　avcodec_alloc_context3 根据解码器生成解码器环境。
　　avcodec_parameters_to_context 把流的解码器参数(图像长宽,音频基本属性以及frame_size)复制到解码器环境.
　　avcodec_open2 打开解码器环境。
　　av_read_frame 从媒体文件AVFormatContext读每个AVPacket。
　　avcodec_send_packet 根据对应AVPacket的索引，发给对应流的解码器解码。
　　avcodec_receive_frame 得到解码器解码后的原始数据，如在视频流中，因P桢B桢关系，一个AVPacket并不一定能得到一个AVFrame,比如P桢要考虑前后，所以可能到后几个Packet的时候，一下读出多桢数据，所以avcodec_send_packet/avcodec_receive_frame的写法会是这样一个情况。
　　写入媒体文件相应动作与API解析(非IO模式)：
　　avformat_alloc_output_context2 根据对应格式生成一个AVFormatContext，不同格式会固定一些数据，比如上FLV格式，音频流与视频流的时间基就是毫秒，我试着改过这值，后面也会在avformat_write_header之后重新改回来。
　　avcodec_find_encoder/avcodec_find_encoder_by_name 选择自己想要的编码器。
　　avcodec_alloc_context3 选择选择的编码器生成编码器环境，不同与上面 的解码过程，这里我们要自己填充相应信息，如图像编码需要知道长宽，码率，gop等设置。
　　avcodec_open2 打开解码器环境。
　　avformat_new_stream 生成相应音视频流信息，填充对应编码器到AVFormatContext里。
　　avcodec_parameters_from_context 把编码器设置的参数复制到流中。
　　avio_open 协议的解析以及协议的操作指针，如何读写协议信息，协议头，协议内容等。
　　avformat_write_header 写入头信息。
　　avcodec_send_frame 把末压缩数据给编码器。
　　avcodec_receive_packet 拿到编码后的数据，和解码类似，P桢决定不可能一Frame一packet，可能要前后几个Frame,才能得到一系列的packet.
　　av_interleaved_write_frame 把编码后的音视频数据交叉写入媒体文件中
　　av_write_trailer 结束写入，根据写入的所有数据填充一部分需要计算的值。
　　还有一种IO模式，可以利用关键桢图像与音频数据直接写入IO中，然后直接从桢中读取相应音视频流的属性拿来直接用，用来不确定视频流长宽等情况下使用。
　　从API可以看读写的差异，读的媒体文件AVFormatContext里面的信息全有，读到流，从流里得到解码信息，打开解码器，从AVFormatContext读每个包，用解码器解码包。写入媒体文件就是生成一个空白的AVFormatContext，然后打开选择的编码器，生成流，然后写入流中每桢数据，使用编码器编码后定稿文件。
　　图像上相关的坑，媒体文件一般使用是YUV的P格式，这个格式YUV分块保存，还有相应align的概念，举个例子，假设你宽是1080，但是在YUV分块中，Y宽度可能是1088(假设当时使用32定齐)，其中每行数据索引处1080-1087以0填充，相应的图像处理我全部提出来在OEIP处理，在OEIP中图像数据全给GPU处理，需要的是紧湊数据，所以需要用av_image_copy_to_buffer/av_image_fill_arrays处理。
　　音频上相关的坑，媒体文件多声道也是用的P格式，而音频采集与播放设备一般用的I格式，所以一般要用swr_convert转换，注意一定要理解相应音频参数，传入的值会影响生成的BUFFER块大小，可能会导致闪退等问题，音频播放使用SDL库，就几个API调用就行，在这就不说了，可以查看相应OEIP里的代码处理，音频采集Winodws用的是WASAPI。
　　时间基的概念：音视频流都有一个时间基的概念，这个比较重要，flv的音视频都是(1,1000),如果是mp4,视频的时间基为(1,90000),音频一般设为对应采样率。时间基，你可以简单理解为1秒内刻度，flv的流对应就是毫秒，而mp4视频流的时间基对应的是1/90毫秒，什么意义了，比如你视频对应的是25桢，在flv里，每桢相隔40个时间基，而在mp4里，相隔360个时间基，在编码时，我们需要把frams上的pts/dts/duration以对应时间基为单位，注意转换，在OEIP中，我们把所有转出/转入与用户有关的时间全是毫秒，其中转换我们内部自己处理。
　　故到此 <a href="https://www.cnblogs.com/zhouxin/p/12568967.html" target="_blank">OEIP</a> 中，可用的输入输出源新增媒体文件/协议，同样，这些功能在Unity3D/UE4里很方便展示，比如把媒体文件/协议里的内容直接展示成对应Unity3D/UE4里的Texture2D显示，或是把Unity3D/UE4里的Texture2D/RTT里的数据保存视频或是推送出去。
　　参考：<br>　　https://www.cnblogs.com/leisure_chn/category/1351812.html 叶余 FFmpeg开发