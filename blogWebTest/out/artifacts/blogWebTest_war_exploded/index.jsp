<%@ page import="java.util.List" %>
<%@ page import="com.blog.entity.*" %><%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/11/12 0012
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<UserRanking> userRankings = (List<UserRanking>) session.getAttribute("userRanking");%>
<%List<hotRecommend> hotRecommends = (List<hotRecommend>) session.getAttribute("hotRecommend");%>
<%List<indexMd> indexMds = (List<indexMd>) session.getAttribute("indexMd");%>
<%List<indexMd> AIMD = (List<indexMd>) session.getAttribute("AIMD");%>
<%List<indexMd> FrondMD = (List<indexMd>) session.getAttribute("FrondMD");%>
<%List<indexMd> LifeMd = (List<indexMd>) session.getAttribute("LifeMd");%>
<%indexImg indexImg = (com.blog.entity.indexImg) session.getAttribute("indexImg");%>
<!DOCTYPE html>
<html lang="ZH-cn">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="img/logo.ico">
  <title>Title</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <script src="js/content/index.js" charset="UTF-8"></script>
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
      <a href="login.jsp">登录</a>/<a href="register.jsp">注册</a>
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
      <div class="row" style="height: 50%;margin-top: 5px;">
        <div class="contentCenter"><a href="searchServlet?search=python">python</a></div>
        <div class="contentCenter"><a href="searchServlet?search=Java">Java</a></div>
        <div class="contentCenter"><a href="searchServlet?search=架构">架构</a></div>
        <div class="contentCenter"><a href="searchServlet?search=人工智能">人工智能</a></div>
        <div class="contentCenter"><a href="searchServlet?search=移动开发">移动开发</a></div>
        <div class="contentCenter"><a href="searchServlet?search=程序人生">程序人生</a></div>
        <div class="contentCenter"><a href="searchServlet?search=计算机基础">计算机基础</a></div>
        <div class="contentCenter"><a href="searchServlet?search=物联网">物联网</a></div>
        <div class="contentCenter"><a href="searchServlet?search=前端">前端</a></div>
        <div class="contentCenter"><a href="searchServlet?search=区块链">区块链</a></div>
      </div>
      <div class="row" style="height: 50%;">
        <div class="contentCenter"><a href="searchServlet?search=游戏开发">游戏开发</a></div>
        <div class="contentCenter"><a href="searchServlet?search=运维">运维</a></div>
        <div class="contentCenter"><a href="searchServlet?search=5G">5G</a></div>
        <div class="contentCenter"><a href="searchServlet?search=音视频开发">音视频开发</a></div>
        <div class="contentCenter"><a href="searchServlet?search=研发管理">研发管理</a></div>
        <div class="contentCenter"><a href="searchServlet?search=信息安全">信息安全</a></div>
        <div class="contentCenter"><a href="searchServlet?search=考试认证">考试认证</a></div>
        <div class="contentCenter"><a href="searchServlet?search=数据库">数据库</a></div>
        <div class="contentCenter"><a href="searchServlet?search=云计算">云计算</a></div>
        <div class="contentCenter"><a>更多</a></div>

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
    <div  class="fourHot" id="fourHot1" style='background-image: url("img/index/hot/<%=indexImg.getHotTopic().get(0)%>.jpg")'><br><a href="otherMdShowServlet?id=<%=indexMds.get(0).getUser_id()%>&mdName=<%=indexMds.get(0).getArticle_content()%>"><%=indexMds.get(0).getArticle_title()%></a></div>
    <div  class="fourHot" id="fourHot2" style="background-image: url('img/index/hot/<%=indexImg.getHotTopic().get(1)%>.jpg')"><br><a href="otherMdShowServlet?id=<%=indexMds.get(1).getUser_id()%>&mdName=<%=indexMds.get(1).getArticle_content()%>"><%=indexMds.get(1).getArticle_title()%></a></div>
    <div  class="fourHot" id="fourHot3" style="background-image: url('img/index/hot/<%=indexImg.getHotTopic().get(2)%>.jpg')"><br><a href="otherMdShowServlet?id=<%=indexMds.get(2).getUser_id()%>&mdName=<%=indexMds.get(2).getArticle_content()%>"><%=indexMds.get(2).getArticle_title()%></a></div>
    <div  class="fourHot" id="fourHot4" style="background-image: url('img/index/hot/<%=indexImg.getHotTopic().get(3)%>.jpg')"><br><a href="otherMdShowServlet?id=<%=indexMds.get(3).getUser_id()%>&mdName=<%=indexMds.get(3).getArticle_content()%>"><%=indexMds.get(3).getArticle_title()%></a></div>
  </div>
  <!--精选头条-->
  <!--精选头条左侧-->
  <div class="row">
    <div id="tou" class="col-lg-12" ><img src="img/cardList_icon.ba603103.png" style="width: 35px;height:35px"> <b>精选头条</b></div>
  </div>
  <!--精选头条中间-->
  <div class="row">
    <div  class="threeTou" id="threeTou1"><a href="otherMdShowServlet?id=<%=indexMds.get(22).getUser_id()%>&mdName=<%=indexMds.get(22).getArticle_content()%>"><img src="img/index/tou/left/<%=indexImg.getHeadLineLeft().get(0)%>.png" style="width: 405px;height: 170px">
      <%=indexMds.get(22).getArticle_title()%>
    </a></div>
    <div  class="threeTou" id="threeTou2">
      <div class="threeTou2-content"><a href="otherMdShowServlet?id=<%=indexMds.get(23).getUser_id()%>&mdName=<%=indexMds.get(23).getArticle_content()%>"> <img src="img/index/tou/right/<%=indexImg.getHeadLineRight().get(0)%>.jpg" style="width: 100px;height: 100px;" align="left"><div style="height: 100px"><%=indexMds.get(23).getArticle_title()%></div></a></div>
      <div class="threeTou2-content"><a href="otherMdShowServlet?id=<%=indexMds.get(24).getUser_id()%>&mdName=<%=indexMds.get(24).getArticle_content()%>"><img src="img/index/tou/right/<%=indexImg.getHeadLineRight().get(1)%>.jpg" style="width: 100px;height: 100px;" align="left"><div style="height: 100px"><%=indexMds.get(24).getArticle_title()%></div></a></div>
      <div class="threeTou2-content"><a href="otherMdShowServlet?id=<%=indexMds.get(25).getUser_id()%>&mdName=<%=indexMds.get(25).getArticle_content()%>"><img src="img/index/tou/right/<%=indexImg.getHeadLineRight().get(2)%>.jpg" style="width: 100px;height: 100px;" align="left"><div style="height: 100px"><%=indexMds.get(25).getArticle_title()%></div></a></div>
    </div>
    <!--精选头条右侧-->
    <div  class="threeTou" id="threeTou3"><!--直接设置了背景图--></div>
  </div>
  <!--精彩视频-->
<%--已删除--%>

  <!--技术团队，社区号-->
<%--已删除--%>

  <!--会员精选-->
<%--已删除--%>

  <!--推荐专题-->
  <div class="row">
    <div id="recommend" class="col-lg-9" ><img src="img/index/20200704010134.png" style="width: 35px;height:35px"><b>推荐专题</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>活动日历</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="recommendDisplay">
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=indexMds.get(26).getUser_id()%>&mdName=<%=indexMds.get(26).getArticle_content()%>"> <img src="img/index/recommend/<%=indexImg.getRecommend().get(0)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(26).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(27).getUser_id()%>&mdName=<%=indexMds.get(27).getArticle_content()%>"><img src="img/index/recommend/<%=indexImg.getRecommend().get(1)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(27).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(28).getUser_id()%>&mdName=<%=indexMds.get(28).getArticle_content()%>"><img src="img/index/recommend/<%=indexImg.getRecommend().get(2)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(28).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(29).getUser_id()%>&mdName=<%=indexMds.get(29).getArticle_content()%>"><img src="img/index/recommend/<%=indexImg.getRecommend().get(3)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(29).getArticle_title()%></a></div>
      </div>
      <!--下面一行-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=indexMds.get(30).getUser_id()%>&mdName=<%=indexMds.get(30).getArticle_content()%>"> <img src="img/index/recommend/<%=indexImg.getRecommend().get(4)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(30).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(31).getUser_id()%>&mdName=<%=indexMds.get(31).getArticle_content()%>"><img src="img/index/recommend/<%=indexImg.getRecommend().get(5)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(31).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(32).getUser_id()%>&mdName=<%=indexMds.get(32).getArticle_content()%>"><img src="img/index/recommend/<%=indexImg.getRecommend().get(6)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(32).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(33).getUser_id()%>&mdName=<%=indexMds.get(33).getArticle_content()%>"><img src="img/index/recommend/<%=indexImg.getRecommend().get(7)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(33).getArticle_title()%></a></div>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="recommendAd">

    </div>
  </div>

  <!--python-->
  <div class="row">
    <div id="python" class="col-lg-9" ><img src="img/index/20200704010033.png" style="width: 35px;height:35px"><b>python</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>博客周排行榜</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="pythonDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=indexMds.get(35).getUser_id()%>&mdName=<%=indexMds.get(35).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(0)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(35).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(36).getUser_id()%>&mdName=<%=indexMds.get(36).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(1)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(36).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(37).getUser_id()%>&mdName=<%=indexMds.get(37).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(2)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(37).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(38).getUser_id()%>&mdName=<%=indexMds.get(38).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(3)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(38).getArticle_title()%></a></div>
      </div>
      <!--下面一行-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=indexMds.get(39).getUser_id()%>&mdName=<%=indexMds.get(39).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(4)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(39).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(40).getUser_id()%>&mdName=<%=indexMds.get(40).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(5)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(40).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(41).getUser_id()%>&mdName=<%=indexMds.get(41).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(6)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(41).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=indexMds.get(42).getUser_id()%>&mdName=<%=indexMds.get(42).getArticle_content()%>"> <img src="img/index/python/<%=indexImg.getPythonImg().get(7)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(42).getArticle_title()%></a></div>
      </div>
    </div>
    <!--右侧列表-->
    <div  class="pythonList">
      <ul>
        <%int i = 1;%>
        <% for (UserRanking userRanking : userRankings) {%>
          <li class="pythonHotLi">
            <span style="float: left;margin-right: 5px;color: #20232c;padding-left: 8px;font-size: 16px;text-align: center;font-weight: bolder"><%=i%></span>
            <a href="ToOtherPersonServlet?id=<%=userRanking.getUser_id()%>"><img src="UserFile/headPhoto/<%=userRanking.getUser_profile_photo()%>" style="height: 40px;width: 40px;border-radius: 50%;float: left"></a>
            <div style="margin-left: 70px">
            <span style="height: 50%"><%=userRanking.getUser_name()%></span><br>
            <img style="height:16px;width: 16px" src="img/heart.7682c5d8.png"> <span><%=userRanking.getLikeCounter()%></span>
            </div>
          </li>
        <%++i;%>
        <%}%>

      </ul>
    </div>
  </div>

  <!--程序人生--><%--5篇--%>
  <div class="row">
    <div id="life" class="col-lg-12" ><img src="img/index/20200704010012.png" style="width: 35px;height:35px"><b>程序人生</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="lifeDisplay">
      <!--左侧内容-->
      <div style="width: 440px;height: 100%;float: left;margin-right: 15px" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><a href="otherMdShowServlet?id=<%=LifeMd.get(0).getUser_id()%>&mdName=<%=LifeMd.get(0).getArticle_content()%>"> <img src="img/index/life/<%=indexImg.getLife().get(0)%>.jpg" style="height: 100px;width: 180px;float: left"><b><%=LifeMd.get(0).getArticle_title()%></b></a></div><br>
        <ul>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(45).getUser_id()%>&mdName=<%=indexMds.get(45).getArticle_content()%>"><%=indexMds.get(45).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=LifeMd.get(1).getUser_id()%>&mdName=<%=LifeMd.get(1).getArticle_content()%>"><%=LifeMd.get(1).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=LifeMd.get(2).getUser_id()%>&mdName=<%=LifeMd.get(2).getArticle_content()%>"><%=LifeMd.get(2).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=LifeMd.get(3).getUser_id()%>&mdName=<%=LifeMd.get(3).getArticle_content()%>"><%=LifeMd.get(3).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(44).getUser_id()%>&mdName=<%=indexMds.get(44).getArticle_content()%>"><%=indexMds.get(44).getArticle_title()%></a> </li>
        </ul>
      </div>
      <div style="width: 440px;height: 100%;float: left" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><a href="otherMdShowServlet?id=<%=LifeMd.get(4).getUser_id()%>&mdName=<%=LifeMd.get(4).getArticle_content()%>"><img src="img/index/life/<%=indexImg.getLife().get(1)%>.jpg" style="height: 100px;width: 180px;float: left"><b><%=LifeMd.get(4).getArticle_title()%></b></a></div><br>
        <ul>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(46).getUser_id()%>&mdName=<%=indexMds.get(46).getArticle_content()%>"><%=indexMds.get(46).getArticle_title()%></a> </li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(47).getUser_id()%>&mdName=<%=indexMds.get(47).getArticle_content()%>"><%=indexMds.get(47).getArticle_title()%></a> </li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(48).getUser_id()%>&mdName=<%=indexMds.get(48).getArticle_content()%>"><%=indexMds.get(48).getArticle_title()%></a> </li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(49).getUser_id()%>&mdName=<%=indexMds.get(49).getArticle_content()%>"><%=indexMds.get(49).getArticle_title()%></a> </li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(52).getUser_id()%>&mdName=<%=indexMds.get(52).getArticle_content()%>"><%=indexMds.get(52).getArticle_title()%></a> </li>

        </ul>
      </div>
    </div>
    <!--右侧广告-->
    <div  class="lifeAd">
      <img src="img/index/20201120054122.png" style="height: 320px;width: 260px;">
    </div>
  </div>

  <!--大前端--><%--8篇--%>
  <div class="row">
    <div id="front" class="col-lg-9" ><img src="img/index/20200724064659.png" style="width: 35px;height:35px"><b>大前端</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>热门推荐</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="frontDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=FrondMD.get(0).getUser_id()%>&mdName=<%=FrondMD.get(0).getArticle_content()%>"> <img src="img/index/front/<%=indexImg.getFrontImg().get(0)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(0).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=FrondMD.get(1).getUser_id()%>&mdName=<%=FrondMD.get(1).getArticle_content()%>"><img src="img/index/front/<%=indexImg.getFrontImg().get(1)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(1).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=FrondMD.get(2).getUser_id()%>&mdName=<%=FrondMD.get(2).getArticle_content()%>"><img src="img/index/front/<%=indexImg.getFrontImg().get(2)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(2).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=FrondMD.get(3).getUser_id()%>&mdName=<%=FrondMD.get(3).getArticle_content()%>"><img src="img/index/front/<%=indexImg.getFrontImg().get(3)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(3).getArticle_title()%></a></div>
      </div>
<%--      <!--下面一行-->--%>
      <div>
        <div class="pythonVideo" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=FrondMD.get(4).getUser_id()%>&mdName=<%=FrondMD.get(4).getArticle_content()%>"><img src="img/index/front/<%=indexImg.getFrontImg().get(4)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(4).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=FrondMD.get(5).getUser_id()%>&mdName=<%=FrondMD.get(5).getArticle_content()%>"><img src="img/index/front/<%=indexImg.getFrontImg().get(5)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(5).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=FrondMD.get(6).getUser_id()%>&mdName=<%=FrondMD.get(6).getArticle_content()%>"><img src="img/index/front/<%=indexImg.getFrontImg().get(6)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(6).getArticle_title()%></a></div>
        <div class="pythonVideo"><a href="otherMdShowServlet?id=<%=FrondMD.get(7).getUser_id()%>&mdName=<%=FrondMD.get(7).getArticle_content()%>"><img src="img/index/front/<%=indexImg.getFrontImg().get(7)%>.jpg" style="height: 115px;width: 210px"><%=FrondMD.get(7).getArticle_title()%></a></div>
      </div>
    </div>
    <!--右侧列表-->
    <div  class="frontList">
      <ul>
        <%int j = 1;%>
        <% for (hotRecommend hotRecommend : hotRecommends) {%>
          <li class="frontHotLi">
            <span style="float: left;margin-right: 5px;color: #20232c;padding-left: 8px;font-size: 16px;text-align: center;font-weight: bolder"><%=j%></span>
            <a href="ToOtherPersonServlet?id=<%=hotRecommend.getUser_id()%>"><img src="UserFile/headPhoto/<%=hotRecommend.getUser_profile_photo()%>" style="height: 40px;width: 40px;border-radius: 50%;float: left"></a>
            <div style="margin-left: 70px">
            <a href="otherMdShowServlet?id=<%=hotRecommend.getUser_id()%>&mdName=<%=hotRecommend.getArticle_title()%>.md"><span><%=hotRecommend.getArticle_title()%></span><br></a>
            <span><%=hotRecommend.getUser_name()%></span><sapn style="float: right"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px;color: #cfcfda"></span><%=hotRecommend.getArticle_views()%></sapn>
            </div>
          </li>
        <%++j;%>
        <%}%>
      </ul>
    </div>
  </div>

  <!--java--><%--会查询到js--%>
  <div class="row">
    <div id="java" class="col-lg-12" ><img src="img/index/20200724064607.png" style="width: 35px;height:35px"><b>java</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧内容区-->
    <div  class="javaDisplay">
      <div style="width: 440px;height: 100%;float: left;margin-right: 15px" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><a href="otherMdShowServlet?id=<%=indexMds.get(51).getUser_id()%>&mdName=<%=indexMds.get(51).getArticle_content()%>"><img src="img/index/java/<%= indexImg.getJava().get(0)%>.jpg" style="height: 100px;width: 180px;float: left"><b><%=indexMds.get(51).getArticle_title()%></b></a></div><br>
        <ul>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(5).getUser_id()%>&mdName=<%=indexMds.get(5).getArticle_content()%>"><%=indexMds.get(5).getArticle_title()%></a> </li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(13).getUser_id()%>&mdName=<%=indexMds.get(13).getArticle_content()%>"><%=indexMds.get(13).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(14).getUser_id()%>&mdName=<%=indexMds.get(14).getArticle_content()%>"><%=indexMds.get(14).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(15).getUser_id()%>&mdName=<%=indexMds.get(15).getArticle_content()%>"><%=indexMds.get(15).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(16).getUser_id()%>&mdName=<%=indexMds.get(16).getArticle_content()%>"><%=indexMds.get(16).getArticle_title()%></a></li>
        </ul>
      </div>
      <div style="width: 440px;height: 100%;float: left" class="listUlLi">
        <!--图片-->
        <div style="width: 440px;height: 114px"><a href="otherMdShowServlet?id=<%=indexMds.get(50).getUser_id()%>&mdName=<%=indexMds.get(50).getArticle_content()%>"><img src="img/index/java/<%= indexImg.getJava().get(1)%>.jpg" style="height: 100px;width: 180px;float: left"><b><%=indexMds.get(50).getArticle_title()%></b></a></div><br>
        <ul>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(17).getUser_id()%>&mdName=<%=indexMds.get(17).getArticle_content()%>"><%=indexMds.get(17).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(18).getUser_id()%>&mdName=<%=indexMds.get(18).getArticle_content()%>"><%=indexMds.get(18).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(19).getUser_id()%>&mdName=<%=indexMds.get(19).getArticle_content()%>"><%=indexMds.get(19).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(20).getUser_id()%>&mdName=<%=indexMds.get(20).getArticle_content()%>"><%=indexMds.get(20).getArticle_title()%></a></li>
          <li><a href="otherMdShowServlet?id=<%=indexMds.get(21).getUser_id()%>&mdName=<%=indexMds.get(21).getArticle_content()%>"><%=indexMds.get(21).getArticle_title()%></a></li>
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
    <div id="openSource" class="col-lg-9" ><img src="img/index/20200724064948.png" style="width: 35px;height:35px"><b>开源技术</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>热门推荐</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧视频区-->
    <div  class="videoDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="video" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=indexMds.get(4).getUser_id()%>&mdName=<%=indexMds.get(4).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(0)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(4).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=indexMds.get(6).getUser_id()%>&mdName=<%=indexMds.get(6).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(1)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(6).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=indexMds.get(7).getUser_id()%>&mdName=<%=indexMds.get(7).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(2)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(7).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=indexMds.get(8).getUser_id()%>&mdName=<%=indexMds.get(8).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(3)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(8).getArticle_title()%></a></div>
      </div>
      <!--下面一行-->
      <div>
        <div class="video" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=indexMds.get(9).getUser_id()%>&mdName=<%=indexMds.get(9).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(4)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(9).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=indexMds.get(10).getUser_id()%>&mdName=<%=indexMds.get(10).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(5)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(10).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=indexMds.get(11).getUser_id()%>&mdName=<%=indexMds.get(11).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(6)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(11).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=indexMds.get(12).getUser_id()%>&mdName=<%=indexMds.get(12).getArticle_content()%>"><img src="img/index/openSource/<%=indexImg.getOpenSourceImg().get(7)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(12).getArticle_title()%></a></div>
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

  <!--人工智能--><%--7篇--%>
  <div class="row">
    <div id="AI" class="col-lg-9" ><img src="img/index/20200724064520.png" style="width: 35px;height:35px"><b>人工智能</b></div>
    <div class="col-lg-3" style="text-align: left;line-height: 35px;padding-left: 20px"><b>热门推荐</b></div>
  </div>
  <!--两块内容-->
  <div class="row">
    <!--左侧视频区-->
    <div  class="videoDisplay">
      <!--上面一行四个视频-->
      <div>
        <div class="video" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=AIMD.get(0).getUser_id()%>&mdName=<%=AIMD.get(0).getArticle_content()%>"> <img src="img/index/AI/<%=indexImg.getAI().get(0)%>.jpg" style="height: 115px;width: 210px"><%=AIMD.get(0).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=AIMD.get(1).getUser_id()%>&mdName=<%=AIMD.get(1).getArticle_content()%>"><img src="img/index/AI/<%=indexImg.getAI().get(1)%>.jpg" style="height: 115px;width: 210px"><%=AIMD.get(1).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=AIMD.get(2).getUser_id()%>&mdName=<%=AIMD.get(2).getArticle_content()%>"><img src="img/index/AI/<%=indexImg.getAI().get(2)%>.jpg" style="height: 115px;width: 210px"><%=AIMD.get(2).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=AIMD.get(3).getUser_id()%>&mdName=<%=AIMD.get(3).getArticle_content()%>"><img src="img/index/AI/<%=indexImg.getAI().get(3)%>.jpg" style="height: 115px;width: 210px"><%=AIMD.get(3).getArticle_title()%></a></div>
      </div>
      <!--下面一行-->
      <div>
        <div class="video" style="margin-left: 20px"><a href="otherMdShowServlet?id=<%=AIMD.get(4).getUser_id()%>&mdName=<%=AIMD.get(4).getArticle_content()%>"> <img src="img/index/AI/<%=indexImg.getAI().get(4)%>.jpg" style="height: 115px;width: 210px"><%=AIMD.get(4).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=AIMD.get(5).getUser_id()%>&mdName=<%=AIMD.get(5).getArticle_content()%>"><img src="img/index/AI/<%=indexImg.getAI().get(5)%>.jpg" style="height: 115px;width: 210px"><%=AIMD.get(5).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=AIMD.get(6).getUser_id()%>&mdName=<%=AIMD.get(6).getArticle_content()%>"><img src="img/index/AI/<%=indexImg.getAI().get(6)%>.jpg" style="height: 115px;width: 210px"><%=AIMD.get(6).getArticle_title()%></a></div>
        <div class="video"><a href="otherMdShowServlet?id=<%=indexMds.get(34).getUser_id()%>&mdName=<%=indexMds.get(34).getArticle_content()%>"><img src="img/index/AI/<%=indexImg.getAI().get(7)%>.jpg" style="height: 115px;width: 210px"><%=indexMds.get(34).getArticle_title()%></a></div>
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