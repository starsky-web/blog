<%@ page import="com.blog.entity.User" %>
<%@ page import="com.blog.entity.Articles" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.entity.PersonInfo" %>
<%@ page import="com.blog.entity.Comments" %><%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/7 0007
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%PersonInfo info = (PersonInfo) session.getAttribute("HostInfo");%>
<%User HostUser = (User) request.getAttribute("HostUser");%>
<%List<Articles> allMd = (List<Articles>) session.getAttribute("otherAllMd");%>
<!DOCTYPE html>
<html lang="ZH-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/content/person.css" rel="stylesheet" type="text/css">
    <link href="css/content/spn.css" rel="stylesheet" type="text/css">
    <script src="js/content/person.js"></script>
    <title>Title</title>
    <style>
        #hotText a{
            text-decoration: none;
            color: #0f0f0f;
        }
        #hotText a:hover{
            text-decoration: none;
            color: #0f0f0f;
        }
    </style>
</head>
<body>
<%--导航栏--%>
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
                function searchLimitId() {
                    $.ajax({
                        url:"searchLimitIdServlet",//请求路径
                        type:"post",//请求方式
                        //data:"username=jack",//请求参数
                        data:{
                            "SLI":$('#SLI').val(),
                            "id":"<%=HostUser.getUser_id()%>"
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
                <%User user = (User) session.getAttribute("user");%>
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
        </div>
        <div class="col-lg-1 spn"></div>
    </div>
</div>

<div id="content" class="container-fluid no-gutter">
    <div class="row">
        <div id="left" class="col-lg-4 js-affix">
            <div id="leftFirst">
                <div class="head">
                    <%if (HostUser.getUser_profile_photo()!=null){%>
                    <img src="UserFile/headPhoto/<%=HostUser.getUser_profile_photo()%>" style="border-radius: 50%;float: left;width: 48px;height: 48px;display: block">
                    <%}else{%>
                    <img src="UserFile/headPhoto/default.png" style="border-radius: 50%;float: left;width: 48px;height: 48px;display: block">
                    <%}%>
                    <span class="name"><%=HostUser.getUser_name()%></span>
                    <div><span>码龄1年</span><span style="margin-left: 20px"><img src="img/person/nocErtification.png" style="margin-right: 4px;width: 12px;height: 14px"></span>
                        <span>暂无认证</span>
                    </div>
                </div>

                <div class="infoTop">
                    <div class="infoUnit" style="margin-left: 10px">
                        <div class="infoUnitNum">
                            <%=info.getRanking()%>
                        </div>
                        <div class="infoUnitText">排名</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            <%=info.getCountView()%>
                        </div>
                        <div class="infoUnitText">访问</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            <%=info.getLikeCount()%>
                        </div>
                        <div class="infoUnitText">获赞</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            <%=info.getBlogCount()%>
                        </div>
                        <div class="infoUnitText">总数</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            67
                        </div>
                        <div class="infoUnitText">原创</div>
                    </div>
                </div>
                <div class="infoBottom">
                    <div class="infoUnit" style="margin-left: 10px">
                        <div class="infoUnitNum">
                            67
                        </div>
                        <div class="infoUnitText">原创</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            67
                        </div>
                        <div class="infoUnitText">原创</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            67
                        </div>
                        <div class="infoUnitText">原创</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            67
                        </div>
                        <div class="infoUnitText">原创</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            67
                        </div>
                        <div class="infoUnitText">原创</div>
                    </div>
                </div>
                <!--徽章-->
                <div class="emblem">
                    <span><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                </div>

            </div>
            <div id="search">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for..." id="SLI">
                    <span class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="searchLimitId()"><span class="glyphicon glyphicon-search"></span></button>
                    </span>
                </div>
            </div>
            <!--热门文章-->

            <div id="hotText">
                <div class="title">
                    热门文章
                </div>
                <% for (Articles hotMd : info.getHotMd()) {%>
                <div class="hotTextUnit">
                    <a href="mdShowServlet?mdName=<%=hotMd.getArticle_content()%>">
                        <%=hotMd.getArticle_title()%><span class="glyphicon glyphicon-eye-open hotEye" style="margin-right: 5px;color: #cfcfda"></span><%=hotMd.getArticle_views()%>
                    </a>
                </div>
                <%}%>
            </div>
            <!--分类专栏-->

            <!--最新评论-->
            <div id="newComment">
                <div class="title">
                    最新评论
                </div>
<%--                <div class="newCommentUnit">--%>
<%--                    <div class="newCommentUnitTop">Mysql数据表设计，三大范式</div>--%>
<%--                    <div class="newCommentUnitBottom">最好满足到2NF吗？</div>--%>
<%--                </div>--%>
                <% for (Comments newComment : info.getNewComments()) {%>
                <div class="newCommentUnit">
                    <div class="newCommentUnitTop"><%=newComment.getArticle_title()%></div>
                    <div class="newCommentUnitBottom"><%=newComment.getComment_content()%></div>
                </div>
                <%}%>
            </div>
            <!--最新文章-->
            <div id="newText">
                <div class="title">
                    最新文章
                </div>
                <% for (Articles newMd : info.getNewMd()) {%>
                <div class="newTextUnitTop">
                    <%=newMd.getArticle_title()%>
                </div>
                <%}%>
                <hr style="border-top:0.5px dashed #b1b1b1;" width="100%" color="#b1b1b1" size=1>
                <div class="newTextUnitBottom">
                    <div id="year">2020</div>
                    <div class="newTextUnitBottomUnit">
                        <div class="mouth">6月</div>
                        <div class="num">13篇</div>
                    </div>
                    <div class="newTextUnitBottomUnit">
                        <div class="mouth">6月</div>
                        <div class="num">13篇</div>
                    </div>
                    <div class="newTextUnitBottomUnit">
                        <div class="mouth">6月</div>
                        <div class="num">13篇</div>
                    </div>
                    <div class="newTextUnitBottomUnit">
                        <div class="mouth">6月</div>
                        <div class="num">13篇</div>
                    </div>
                </div>
            </div>
        </div>
        <!--        <script>-->
        <!--            $('.js-affix').affix({-->
        <!--                offset:{-->
        <!--                    top:112,-->
        <!--                    bottom:3680-->
        <!--                }-->
        <!--            });-->
        <!--        </script>-->



        <div id="right" class="col-lg-8" style="background: white;padding-left: 25px">
            <div class="rightTitle">
                <div class="rightTitleUnit">博客</div>
            </div>
            <div class="rightTool">
                <div class="originalOnly">
                    <input onchange="this.checked ? document.getElementById('seeOriginal').submit() : location.href = 'https://blog.csdn.net/starsky__'" type="checkbox" name="t" value="1" id="chkOriginal">
                    只看原创
                </div>
                <div class="sort">
                    排序：<span id="order">按最后发布顺序</span><span id="view">按访问量</span>
                </div>
            </div>

            <%--            <div class="rightUnit">--%>
            <%--                <div class="rightUnitTitle">--%>
            <%--                    <a style="display: block"><span class="design">原创</span>JavaScript学习笔记（5）事件</a>--%>
            <%--                </div>--%>

            <%--                <div class="rightUnitText">--%>
            <%--                    5、事件1、概述某些组件被执行了某些操作后，触发某些代码的执行事件源组件，按钮，输入框监听器代码注册监听将事件，事件源，监听器结合在一起，当事件源上发生了某个事件，就触发某个监听器代码2、常见事件2.1、点击事件onclick 单击事件ondblclick 双击事件2.2、焦点事件onblur：失去焦点onfoc<--%>
            <%--                </div>--%>
            <%--                <div class="date">--%>
            <%--                    <span class="year">2020-06-22&nbsp;&nbsp;14:50:07</span><span class="viewCounter"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span>50</span>--%>
            <%--                </div>--%>
            <%--            </div>--%>
            <% for (Articles md:allMd) {%>
            <div class="rightUnit">
                <div class="rightUnitTitle">
                    <a style="display: block" href="mdShowServlet?mdName=<%=md.getArticle_content()%>"><span class="design">原创</span><%=md.getArticle_title()%></a>
                </div>
                <div class="rightUnitText">
                    <%=md.getArticle_preview()%>
                </div>
                <div class="date">
                    <span class="year"><%=md.getArticle_date()%></span><span class="viewCounter"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span><%=md.getArticle_views()%></span>
                </div>
            </div>

            <%}%>

        </div>
    </div>
</div>
</body>
</html>
