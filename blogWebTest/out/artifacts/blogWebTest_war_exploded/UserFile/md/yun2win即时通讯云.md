
yun2win官网：<a href="http://www.yun2win.com" target="_blank">www.yun2win.com</a>
SDK下载地址：<a href="http://www.yun2win.com/h-col-107.html" target="_blank">http://www.yun2win.com/h-col-107.html</a>
# &nbsp;
# 简介
yun2win-sdk-web提供web端<a href="http://www.yun2win.com/h-col-117.html" target="_blank">实时音视频功能</a>完整解决方案，方便客户快速集成音视频功能. SDK 提供整套解决方案
&nbsp;
yun2win官网：<a href="http://www.yun2win.com" target="_blank">www.yun2win.com</a>
SDK下载地址：<a href="http://www.yun2win.com/h-col-107.html" target="_blank">http://www.yun2win.com/h-col-107.html</a>
&nbsp;
```

# 开发准备
1、准备Chrome浏览器版本49及以上
2、给网站配置CA证书
3、导入y2wVideo.js文件并添加到main.html
复制```

```prettyprint lang-xml prettyprinted"><span class="pln

<script src="js/core/y2wVideo.js?v=0.1"></script>`
```
4、添加自定义界面videoAudio.html

#### 提醒
本地开发，需要生成CA证书,用https访问，并点击盾牌，选择加载不安全的脚本
```
<img src="http://console.yun2win.com/docs/assets/imgs/load_scriptbg.png" alt="">```

# 创建聊天房间
调用以下代码创建房间：
复制```

```prettyprint lang-javascript prettyprinted"><span class="pln

var y2wVideo = new RTCManager();
//currentUser.id 当前用户ID   currentUser.imToken  当前用户的ImToken
y2wVideo.createVideo(currentUser.id, currentUser.imToken, function (error, channelId) {
            if (error) {
            return;
            }
            //发送通知通知其他人，具体看下面
            y2w.sendVideoMessage(scene, receiverIds, mode, channelId);
           //发起方打开视频语音聊天界面
            window.open("../yun2win/videoAudio.html?userid=" + currentUser.id + "&amp;channelId=" + channelId + "&amp;type=" + mode, "_blank");
});`
```
```

# 群聊视频发起与加入
发起方：
复制```

```prettyprint lang-javascript prettyprinted

//发送通知通知其他人
var receiverIds=[]//已经选择群聊的群成员用户ID
  
for (var i = 0; i < obj.selected.length; i++) {
receiverIds[receiverIds.length] = obj.selected[i].id;
}
y2w.sendVideoMessage('group', receiverIds, 'video', channelId)//channelId 房间ID
//发起方打开视频语音聊天界面
window.open("../yun2win/videoAudio.html?userid=" + currentUser.id + "&amp;channelId=" + channelId + "&amp;type=" + 'video', "_blank");
```
```
接收方:
复制```

```prettyprint lang-javascript prettyprinted

if (syncObj.type == "groupavcall") {
        var receiversIds = syncObj.content.participants.receiversIds;
        if (receiversIds) {
                for (var j = 0; j < receiversIds.length; j++) {
                if (receiversIds[j] == currentUser.id) {
                            y2w.receive_AV_Mesage(syncObj);
                            break;
                        }
                }
        }
        break;
}
```
```
```

# 群聊音频发起与加入
发起方：
复制```

```prettyprint lang-javascript prettyprinted

var receiverIds=[]//已经选择群聊的群成员用户ID
  
for (var i = 0; i < obj.selected.length; i++) {
receiverIds[receiverIds.length] = obj.selected[i].id;
}
//发送通知通知其他人
y2w.sendVideoMessage('group', receiverIds, 'audio', channelId)//channelId 房间ID
//发起方打开视频语音聊天界面
window.open("../yun2win/videoAudio.html?userid=" + currentUser.id + "&amp;channelId=" + channelId + "&amp;type=" + 'audio', "_blank");
```
```
接收方:
复制```

```prettyprint lang-javascript prettyprinted

if (syncObj.type == "groupavcall") {
        var receiversIds = syncObj.content.participants.receiversIds;
        if (receiversIds) {
                for (var j = 0; j < receiversIds.length; j++) {
                if (receiversIds[j] == currentUser.id) {
                            y2w.receive_AV_Mesage(syncObj);
                            break;
                        }
                }
        }
        break;
}
```
```
```

# 一对一视频发起与加入
发起方：
复制```

```prettyprint lang-javascript prettyprinted

var receiverIds=[];
receiverIds[receiverIds.length] = obj//obj 对方用户ID
//发送通知通知其他人
y2w.sendVideoMessage('p2p', receiverIds, 'video', channelId)//channelId 房间ID
//发起方打开视频语音聊天界面
window.open("../yun2win/videoAudio.html?userid=" + currentUser.id + "&amp;channelId=" + channelId + "&amp;type=" + 'video', "_blank");
```
```
接收方:
复制```

```prettyprint lang-javascript prettyprinted

if (syncObj.type == "singleavcall") {
        var receiversIds = syncObj.content.participants.receiversIds;
        if (receiversIds) {
                for (var j = 0; j < receiversIds.length; j++) {
                if (receiversIds[j] == currentUser.id) {
                            y2w.receive_AV_Mesage(syncObj);
                            break;
                        }
                }
        }
        break;
}
```
```
```

# 一对一音频发起与加入
发起方：
复制```

```prettyprint lang-javascript prettyprinted

var receiverIds=[];
receiverIds[receiverIds.length] = obj//obj 对方用户ID
//发送通知通知其他人
y2w.sendVideoMessage('p2p', receiverIds, 'audio', channelId)//channelId 房间ID
//发起方打开视频语音聊天界面
window.open("../yun2win/videoAudio.html?userid=" + currentUser.id + "&amp;channelId=" + channelId + "&amp;type=" + 'audio', "_blank");
```
```
接收方:
复制```

```prettyprint lang-javascript prettyprinted

if (syncObj.type == "singleavcall") {
        var receiversIds = syncObj.content.participants.receiversIds;
        if (receiversIds) {
                for (var j = 0; j < receiversIds.length; j++) {
                if (receiversIds[j] == currentUser.id) {
                            y2w.receive_AV_Mesage(syncObj);
                            break;
                        }
                }
        }
        break;
}
```
```
```

# 桌面共享
发起方：
复制```

```prettyprint lang-javascript prettyprinted

var receiverIds=[];
receiverIds[receiverIds.length] = obj//obj 对方用户ID
//发送通知通知其他人
y2w.sendVideoMessage('sharescreen', receiverIds, 'audio', channelId)//channelId 房间ID
//发起方打开视频语音聊天界面
window.open("../yun2win/videoAudio.html?userid=" + currentUser.id + "&amp;channelId=" + channelId + "&amp;type=" + 'audio', "_blank");
```
```
接收方:
复制```

```prettyprint lang-javascript prettyprinted

if (syncObj.type == "sharescreen") {
        var receiversIds = syncObj.content.participants.receiversIds;
        if (receiversIds) {
                for (var j = 0; j < receiversIds.length; j++) {
                if (receiversIds[j] == currentUser.id) {
                            y2w.receive_AV_Mesage(syncObj);
                            break;
                        }
                }
        }
        break;
}
```
```
```

# 组装地址前准备
1、判断是否已经登录
复制```

```prettyprint lang-javascript prettyprinted"><span class="pln

var currentUserid = localStorage.getItem('y2wIMCurrentUserId');
var currentuserinfo = JSON.parse(localStorage.getItem(currentUserid));
if (currentuserinfo == null) {
        if (window.confirm("您还没有登录，请先登录")) {
              window.location.href = '../yun2win/index.html';
        }
        return;
        //重新登录
}`
```
2、检测浏览器版本
复制```

```prettyprint lang-javascript prettyprinted"><span class="pln

var sUserAgent = navigator.userAgent;
//parseFloat 运行时逐个读取字符串中的字符，当他发现第一个非数字符是就停止  
var appVersion = navigator.appVersion;
var index = appVersion.indexOf('Chrome/');
var sub = appVersion.substring(index+7);
var fAppVersion = parseFloat(sub);
if (fAppVersion < 49) {
     alert('您的浏览器版本太低！为了不影响您的视频聊天，请升级到最新版本');
}`
```

#### 提醒
请记住使用chrome浏览器49版本及以上
```
3、通过登录token获取access_token
复制```

```prettyprint lang-javascript prettyprinted"><span class="pln

var params = {
        grant_type: 'client_credentials',
        client_id: currentuserinfo.key,//用户的app Key
        client_secret: currentuserinfo.secret //密钥
};
var token = currentuserinfo.token//登录token
$.ajax({
    url: config.y2wAutorizeUrl + 'oauth/token',
    type: 'POST',
    data: params,
    dataType: 'json',
    contentType: 'application/x-www-form-urlencoded',
beforeSend: function (req) {
    if (token)
    req.setRequestHeader('Authorization', 'Bearer ' + token);
},
success: function (data) {
var token = data.access_token//获取access_token
        //组装的地址 
        //document.getElementById("iframe_videoaudio").src = "https://av-api.liyueyun.com/media/?userid=" + 
        memberId + "&amp;channelId=" + channelId + "&amp;type=" + initype + "&amp;token=" + token + "&amp;avatarUrl=" + avatarUrl + "&amp;name=" + name;
},
error: function (e) {//验证失败，重新登陆
    if (e.status ==400){
        if (window.confirm("验证失败，请重新登录")) {
           window.location.href = '../yun2win/index.html';
        }
        }
    }
});`
```
```

# 组装地址
复制```

```prettyprint lang-javascript prettyprinted"><span class="pln

//memberId 当前用户ID   channelId 房间ID    
//initype默认开启类型 (video/audio)  token  access_token avatarUrl 用户头像地址 name用户名字
document.getElementById("iframe_videoaudio").src = "https://av-api.liyueyun.com/media/?userid=" + memberId + 
"&amp;channelId=" + channelId + "&amp;type=" + initype + "&amp;token=" + token + "&amp;avatarUrl=" + avatarUrl + "&amp;name=" + name;`
```
```
# &nbsp;