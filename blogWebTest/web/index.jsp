<%@ page import="com.blog.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/11/12 0012
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ZH-cn">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="img/logo.ico">
  <title>Title</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <script src="js/jquery-3.5.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <link href="css/content/index.css" rel="stylesheet" type="text/css">
  <link href="css/content/spn.css" rel="stylesheet" type="text/css">
  <script type="text/javascript" src="js/content/index.js"></script>


</head>
<body>

<!--  模仿网站:https://www.csdn.net/  -->
<script src="js/effect.js" charset="UTF-8"></script>

<!--导航栏-->
<div class="container-fluid" style="padding-top: 5px">
  <div class="row">
    <div class="col-lg-1 spn"></div>
    <div class="col-lg-1 spn"><a href="#"><img src="img/blackLogo.png"> </a></div>
    <div class="col-lg-1 spn"><a href="index.jsp">首页</a></div>
    <div class="col-lg-1 spn"><a href="#">关于</a></div>
    <div class="col-lg-5 spn find">
      <div class="input-group">
        <input id="input1" type="text" value placeholder="博客点击开始" autocomplete="off" name="search">
        <button id="shosuo" onclick="search()"></button>
        </span>
      </div>
      <!--搜索处理，放在js中-->
    <script>
          function search(){
      <!--执行搜索点击事件-->
            $.ajax({
              url:"searchServlet",//请求路径
              type:"post",//请求方式
              //data:"username=jack",//请求参数
              data:{
                "search":$('#input1').val()
              },
              success:function (data) {

                  location.href="resultDisplay.jsp";

              },//响应成功后的回调函数
              error:function () {

              },//表示如果请求响应出现错误，会执行的回调函数
              dataType:"text"//设置接收到的响应数据的格式
            });
      }
      </script>
    </div>
    <div class="col-lg-1 spn"><a href="mdEditor.jsp" class="a1"><i class="li1"></i>创作中心</a></div>
    <div class="col-lg-1 spn" id="spnTou">
      <% User user= (User) session.getAttribute("user");%>
      <% if (user==null){%>
      <a href="login.html">登录</a>/<a href="register.jsp">注册</a>
      <%}else{%>
        <%if (user.getUser_profile_photo()!=null){%>
          <a><img src="UserFile/headPhoto/<%=user.getUser_profile_photo()%>" class="headPhoto" style="border-radius: 50%;width: 32px;height: 32px"></a>
      <ul>
        <li><a href="Person"> 我的博客</a></li>
        <li><a href="#">更多</a></li>
        <li><a href="quitServlet">退出</a></li>
      </ul>
        <%}else{%>
      <a><img src="UserFile/headPhoto/default.png" class="headPhoto" style="border-radius: 50%;width: 32px;height: 32px"></a>
      <ul>
        <li><a href="Person"> 我的博客</a></li>
        <li><a href="#">更多</a></li>
        <li><a href="quitServlet">退出</a></li>
      </ul>
        <%}%>
        <%}%>


<%--      <ul>--%>
<%--        <li><a href="person.jsp"> 我的博客</a></li>--%>
<%--        <li><a href="#">更多</a></li>--%>
<%--        <li><a href="#">退出</a></li>--%>
<%--      </ul>--%>
    </div>
    <div class="col-lg-1 spn"></div>
  </div>
</div>




<!--内容区-->
<!--顶部栏-->
<div class="content container">
  <div class="row">
    <!--顶部栏左侧-->
    <div id="left1" class="col-lg-2">
      <div class="row no-gutter" style="margin-top: 5px">
        <div class="col-lg-4" ><a href="#"><img src="img/index/index.png" style="height: 40px;width: 40px;"></a></div>
        <div class="col-lg-4"><a href="#"> <img src="img/index/dongtai.png" style="height: 40px;width: 40px"></a></div>
        <div class="col-lg-4"><a href="#"> <img src="img/index/paihang.png" style="height: 40px;width: 40px"></a></div>
      </div>
      <div class="row no-gutter" >
        <div class="col-lg-4"><a href="#">首页</a></div>
        <div class="col-lg-4"><a href="#">动态</a></div>
        <div class="col-lg-4"><a href="#">排行</a></div>
      </div>
    </div>
    <!--顶部栏左侧结束-->
    <!--顶部栏中间-->
    <div id="center1" class="col-lg-8">
      <div class="row" style="height: 50%;margin-top: 5px">
        <div class="contentCenter"><a href="otherMdShowServlet?id=3&&mdName=01、安装.md">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
      </div>
      <div class="row" style="height: 50%">
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
        <div class="contentCenter"><a href="#">python</a></div>
      </div>

    </div>
    <!--顶部栏中间结束-->
    <!--顶部栏右侧-->
    <div id="right1" class="col-lg-2">
      <div class="row no-gutter" style="height: 50%;margin-top: 5px">
        <div class="col-lg-6" style="height: 20px"><img src="img/index/20200811110251.png" style="width: 20px;height: 20px">直播</div>
        <div class="col-lg-6" style="height: 20px"><img src="img/index/20200811110139.png" style="width: 20px;height: 20px">专栏</div>
      </div>
      <div class="row no-gutter" style="height: 50%">
        <div class="col-lg-6" style="height: 20px"><img src="img/index/20200811110251.png" style="width: 20px;height: 20px">活动</div>
        <div class="col-lg-6" style="height: 20px"><img src="img/index/20200811110139.png" style="width: 20px;height: 20px">学习</div>
      </div>
    </div>
  </div>
  <!--热门话题-->
  <div class="row">
    <div id="hot" class="col-lg-12" ><img src="img/index/20200704010251.png" style="width: 35px;height:35px"><b>热门话题</b></div>
  </div>
  <div class="row">
    <div  class="fourHot" id="fourHot1">#话题#<br>因未发项目奖金，一名程序员决定删代码泄愤</div>
    <div  class="fourHot" id="fourHot2">#话题#<br>因未发项目奖金，一名程序员决定删代码泄愤</div>
    <div  class="fourHot" id="fourHot3">#话题#<br>因未发项目奖金，一名程序员决定删代码泄愤</div>
    <div  class="fourHot" id="fourHot4">#话题#<br>因未发项目奖金，一名程序员决定删代码泄愤</div>
  </div>
  <!--精选头条-->
  <!--精选头条左侧-->
  <div class="row">
    <div id="tou" class="col-lg-12" ><img src="img/cardList_icon.ba603103.png" style="width: 35px;height:35px"> <b>精选头条</b></div>
  </div>
  <!--精选头条中间-->
  <div class="row">
    <div  class="threeTou" id="threeTou1"><img src="img/index/20201120102939.jpg" style="width: 405px;height: 170px"><br>腾讯AI医学进展破解“秃头”难题，登Nature子刊！
      <br>腾讯AI Lab采用“从头折叠”的蛋白质结构预测方法帮助解析了SRD5A2晶体结构 </div>
    <div  class="threeTou" id="threeTou2">
      <div class="threeTou2-content"><img src="img/index/20201120104851.jpg" style="width: 100px;height: 100px;" align="left"><div style="height: 100px">深入剖析Linux内核反向映射机制<br>Soc芯片BringUp及系统软件开发大佬的分享。</div></div>
      <div class="threeTou2-content"><img src="img/index/20201120104851.jpg" style="width: 100px;height: 100px;" align="left"><div style="height: 100px">深入剖析Linux内核反向映射机制<br>Soc芯片BringUp及系统软件开发大佬的分享。</div></div>
      <div class="threeTou2-content"><img src="img/index/20201120104851.jpg" style="width: 100px;height: 100px;" align="left"><div style="height: 100px">深入剖析Linux内核反向映射机制<br>Soc芯片BringUp及系统软件开发大佬的分享。</div></div>
    </div>
    <!--精选头条右侧-->
    <div  class="threeTou" id="threeTou3"><!--直接设置了背景图--></div>
  </div>
  <!--精彩视频-->
  <div class="row">
    <div id="videoPlate" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>精彩视频</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 50px;padding-left: 20px"><b>视频热榜</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧视频区-->
    <div  class="videoDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="video" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
      <!--下面一行-->
      <div>
        <div class="video" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="videoList">
      <ol>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>

      </ol>
    </div>
  </div>

  <!--技术团队，社区号-->
  <div class="row">
    <div id="community" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>技术团队/社区号</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>遇见Offer</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="communityDisplay">
      <!-- 一行 -->
      <div style="margin-top: 5px">
        <div class="communityGrid" style="margin-right: 15px;">
          <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
          <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
        </div>
        <div class="communityGrid">
          <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
          <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
        </div>

        <div style="margin-top: 5px">
          <div class="communityGrid" style="margin-right: 15px;">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
          <div class="communityGrid">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
        </div>

        <div style="margin-top: 5px">
          <div class="communityGrid" style="margin-right: 15px;">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
          <div class="communityGrid">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
        </div>

        <div style="margin-top: 5px">
          <div class="communityGrid" style="margin-right: 15px;">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
          <div class="communityGrid">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
        </div>

        <div style="margin-top: 5px">
          <div class="communityGrid" style="margin-right: 15px;">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
          <div class="communityGrid">
            <img src="img/index/3_ctrip_tech.jpg" width="48px" height="48px" style="border-radius: 50%;float: left">
            <span style="float: left"><b>携程技术</b></span><span style="float: left;width: 80px;height: 20px"></span> |干货|携程cilium+BGP云原生网络实践<br>原创:118 &nbsp;&nbsp;&nbsp;粉丝146
          </div>
        </div>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="communityAd">
      <img src="img/index/banner_offer@2x.png" style="height: 210px;width: 260px">
      <div style="width: 50%;float: left;height: 130px">微软专场<br>引才入湘<br>腾讯招聘专场<br>paypal专场</div>
      <div style="width: 50%;float: left;height: 130px">研发团队岗位介绍<br>拿一线工资<br>在鹅厂遇见未来<br>五年市值翻五倍!</div>
    </div>
  </div>

  <!--会员精选-->
  <div class="row">
    <div id="vip" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>会员精选</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>领取权益</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="vipDisplay">
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
      <!--下面一行-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="vipAd">
      <img src="img/index/20201113061718.jpg" style="width: 260px;height: 212px;margin-top: 5px">
      <img src="img/index/20201113061718.jpg" style="width: 260px;height: 212px;margin-top: 5px ">
    </div>
  </div>

  <!--推荐专题-->
  <div class="row">
    <div id="recommend" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>推荐专题</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>活动日历</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="recommendDisplay">
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
      <!--下面一行-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="recommendAd">

    </div>
  </div>

  <!--python-->
  <div class="row">
    <div id="python" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>python</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>博客周排行榜</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="pythonDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
      <!--下面一行-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
    </div>
    <!--右侧列表-->
    <div  class="pythonList">
      <ol>
        <li class="pythonHotLi"></li>
        <li class="pythonHotLi"></li>
        <li class="pythonHotLi"></li>
        <li class="pythonHotLi"></li>
        <li class="pythonHotLi"></li>
        <li class="pythonHotLi"></li>
        <li class="pythonHotLi"></li>
        <li class="pythonHotLi"></li>

      </ol>
    </div>
  </div>

  <!--程序人生-->
  <div class="row">
    <div id="life" class="col-lg-12" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>程序人生</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="lifeDisplay">
      <!--左侧内容-->
      <div style="width: 440px;height: 100%;float: left;margin-right: 15px" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><img src="img/index/20201118030109.jpg" style="height: 100px;width: 180px;float: left"><b>13岁创建RISC-V内核</b></div><br>
        <ul>
          <li>漫画: 你们这些奇怪的代码</li>
          <li>程序员的十年之痒</li>
          <li>我在MySQL的那些年</li>
          <li>2020年程序员节杂记</li>
          <li>在美国小公司工作3年的感受</li>
        </ul>
      </div>
      <div style="width: 440px;height: 100%;float: left" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><img src="img/index/20201118030109.jpg" style="height: 100px;width: 180px;float: left"><b>13岁创建RISC-V内核</b></div><br>
        <ul>
          <li>漫画: 你们这些奇怪的代码</li>
          <li>程序员的十年之痒</li>
          <li>我在MySQL的那些年</li>
          <li>2020年程序员节杂记</li>
          <li>在美国小公司工作3年的感受</li>
        </ul>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="lifeAd">
      <img src="img/index/20201120054122.png" style="height: 320px;width: 260px;">
    </div>
  </div>

  <!--大前端-->
  <div class="row">
    <div id="front" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>大前端</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>热门推荐</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="frontDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="pythonVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
      <!--下面一行-->
      <div>
        <div class="frontVideo" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="frontVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="frontVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="frontVideo"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
    </div>
    <!--右侧列表-->
    <div  class="frontList">
      <ol>
        <li class="frontHotLi"></li>
        <li class="frontHotLi"></li>
        <li class="frontHotLi"></li>
        <li class="frontHotLi"></li>
        <li class="frontHotLi"></li>
        <li class="frontHotLi"></li>
        <li class="frontHotLi"></li>
        <li class="frontHotLi"></li>


      </ol>
    </div>
  </div>

  <!--java-->
  <div class="row">
    <div id="java" class="col-lg-12" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>java</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="javaDisplay">
      <div style="width: 440px;height: 100%;float: left;margin-right: 15px" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><img src="img/index/20201118030109.jpg" style="height: 100px;width: 180px;float: left"><b>13岁创建RISC-V内核</b></div><br>
        <ul>
          <li>漫画: 你们这些奇怪的代码</li>
          <li>程序员的十年之痒</li>
          <li>我在MySQL的那些年</li>
          <li>2020年程序员节杂记</li>
          <li>在美国小公司工作3年的感受</li>
        </ul>
      </div>
      <div style="width: 440px;height: 100%;float: left" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><img src="img/index/20201118030109.jpg" style="height: 100px;width: 180px;float: left"><b>13岁创建RISC-V内核</b></div><br>
        <ul>
          <li>漫画: 你们这些奇怪的代码</li>
          <li>程序员的十年之痒</li>
          <li>我在MySQL的那些年</li>
          <li>2020年程序员节杂记</li>
          <li>在美国小公司工作3年的感受</li>
        </ul>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="javaAd">
      <img src="img/index/20201120054122.png" style="height: 320px;width: 260px;">
    </div>
  </div>

  <!--开源技术-->
  <div class="row">
    <div id="openSource" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>开源技术</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>热门推荐</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧视频区-->
    <div  class="videoDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="video" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
      <!--下面一行-->
      <div>
        <div class="video" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="videoList">
      <ol>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>

      </ol>
    </div>
  </div>

  <!--人工智能-->
  <div class="row">
    <div id="AI" class="col-lg-9" ><img src="img/index/20200704010214.png" style="width: 35px;height:35px"><b>人工智能</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>热门推荐</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧视频区-->
    <div  class="videoDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="video" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
      <!--下面一行-->
      <div>
        <div class="video" style="margin-left: 20px"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
        <div class="video"><img src="img/index/1605691532138.png" style="height: 115px;width: 210px">CSS每天进步一点点</div>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="videoList">
      <ol>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>
        <li class="videoHotLi"></li>

      </ol>
    </div>
  </div>
</div>



<!--右侧悬浮区-->
<div class="container1">
  <div id="mon1" class="row1">
    <div id="col-xs-3" class="js-affix">
      <img src="img/monkey.png" width="55px" height="66.78px" alt class="monkey_top">
      <img src="img/下载.png" width="27px" height="6px" alt class="monkey_top1">
      <div class="list-box">
        <div class="list-group1">
            <span>
                <span class="item active"><a href="#" class="nav-list">导航</a></span>
                <span class="item active"><a href="#hot" class="nav-list">热门话题</a></span>
                <span class="item active"><a href="#tou" class="nav-list">精选头条</a></span>
                <span class="item active"><a href="#videoPlate" class="nav-list">精彩视频</a></span>
                <span class="item active"><a href="#community" class="nav-list">技术团队</a></span>
                <span class="item active"><a href="#vip" class="nav-list">会员精选</a></span>
                <span class="item active"><a href="#recommend" class="nav-list">推荐专题</a></span>
                <span class="item active"><a href="#python" class="nav-list">python</a></span>
                <span class="item active"><a href="#life" class="nav-list">程序人生</a></span>
                <span class="item active"><a href="#front" class="nav-list">大前端</a></span>
                <span class="item active"><a href="#java" class="nav-list">java</a></span>
                <span class="item active"><a href="#openSource" class="nav-list">开源技术</a></span>
                <span class="item active"><a href="#AI" class="nav-list">人工智能</a></span>
            </span>


        </div>

      </div>
    </div>
  </div>
  <script>
    $('.js-affix').affix({
      offset:{
        // top:0,
        bottom:150
      }
    });

  </script>
</div>
<!--锚点链接平滑移动-->
<script>
  $('.nav-list').click(function () {
    $('html, body').animate({
      scrollTop: $($.attr(this, 'href')).offset().top
    }, 500);
    return false;
  });

</script>
<!--页脚-->
<div  id="foot" class="foot-1">
  <div id="foot1" class="foot1-1">
    <ul id="foot2" class="foot2-2">
      <li><a href="//www.csdn.net/company/index.html#about" target="_blank">关于我们</a></li>
      <li><a href="//www.csdn.net/company/index.html#about" target="_blank">招贤纳士</a></li>
      <li><a href="//www.csdn.net/company/index.html#about" target="_blank">广告服务</a></li>
      <li><a href="//www.csdn.net/company/index.html#about" target="_blank">开发助手</a></li>
      <li><img src="img/tel.png" alt style="height: 16px" width="16px"><span>123-456-0123</span></li>
      <li><img src="img/email.png" alt style="height: 16px" width="16px"><a href="mailto:webmaster@csdn.net" target="_blank">kefu@csdn.net</a> </li>
      <li><img src="img/cs.png" alt style="height: 16px" width="16px"><a href="https://csdn.s2.udesk.cn/im_client/?web_plugin_id=29181" target="_blank">在线客服</a></li>
      <li>工作时间&nbsp;8:30-22:00</li>
    </ul>
    <ul  id="foot3" class="foot3-3">
      <li><img src="img/badge.png" alt style="height: 16px" width="16px"><a href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143" rel="noreferrer" target="_blank">公安备案号11010502030143</a> </li>
      <li><a href="http://beian.miit.gov.cn/publish/query/indexFirst.action" rel="noreferrer" target="_blank">京ICP备19004658号</a></li>
      <li><a href="https://csdnimg.cn/release/live_fe/culture_license.png" rel="noreferrer" target="_blank">京网文〔2020〕1039-165号</a></li>
      <li><a href="https://csdnimg.cn/cdn/content-toolbar/csdn-ICP.png" target="_blank">经营性网站备案信息</a></li>
      <li><a href="http://www.bjjubao.org/" target="_blank">北京互联网违法和不良信息举报中心</a></li>
      <li><a href="http://www.cyberpolice.cn/" target="_blank">网络110报警服务</a></li>
      <li><a href="http://www.12377.cn/" target="_blank">中国互联网举报中心</a></li>
      <li><a href="https://download.csdn.net/index.php/tutelage/" target="_blank">家长监护</a></li>
      <li><a href="https://chrome.google.com/webstore/detail/csdn%E5%BC%80%E5%8F%91%E8%80%85%E5%8A%A9%E6%89%8B/kfkdboecolemdjodhmhmcibjocfopejo?hl=zh-CN" target="_blank">Chrome商店下载</a></li>
      <li>©1999-2020北京创新乐知网络技术有限公司</li>
      <li><a href="https://www.csdn.net/company/index.html#statement" target="_blank">版权与免责声明</a></li>
      <li><a href="https://blog.csdn.net/blogdevteam/article/details/90369522" target="_blank">版权申诉</a></li>
    </ul>
  </div>
</div>
</body>
</html>