<%@ page import="com.blog.entity.Articles" %>
<%@ page import="com.blog.entity.User" %>
<%@ page import="com.blog.entity.PersonInfo" %>
<%@ page import="com.blog.entity.Comments" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/7 0007
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="error.jsp"%>
<%PersonInfo info = (PersonInfo) session.getAttribute("HostInfo");%>
<%List<Comments> comments = (List<Comments>) session.getAttribute("comments");%>
<%User HostUser = (User) session.getAttribute("HostUser");%>
<%String mdName = (String) session.getAttribute("mdName");%>
<%
    boolean hotmdExist = false;
    boolean newCommentsExist = false;
    boolean newMdExist = false;
    if (info!=null){
        if (info.getHotMd()!=null&&info.getHotMd().size()>0){
            hotmdExist=true;
        }
        if (info.getNewComments()!=null&&info.getNewComments().size()>0){
            newCommentsExist = true;
        }
        if (info.getNewMd()!=null&&info.getNewMd().size()>0){
            newMdExist = true;
        }
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/content/comment.css" rel="stylesheet" type="text/css">
    <link href="css/content/person.css" rel="stylesheet" type="text/css">
    <link href="css/content/mdUtil.css" rel="stylesheet" type="text/css">
    <link href="css/content/foot-1.css" rel="stylesheet" type="text/css">
    <link href="css/content/spn.css" rel="stylesheet" type="text/css">
    <script src="js/content/person.js"></script>
    <script src="js/clickEffect.js"></script><%--点击特效--%>
    <script src="js/yinhua.js"></script><%--樱花--%>
    <!--鼠标跟随-->
    <span class="js-cursor-container"></span>
    <script src="js/follow.js"></script>
    <link rel="shortcut icon" href="img/logo.ico" type="image/x-icon"/>
    <title>Blog</title>
    <style>
        .fixed{
            position: fixed;
            top:10px;
            width: 285px;
            /*left: 100px;*/
        }
    </style>
    <script>
        function ajax() {
            //使用$.ajax()发送异步请求
            $.ajax({
                url:"mdLikeServlet",//请求路径
                type:"post",//请求方式
                //data:"username=jack",//请求参数
                data:{"mdName":"<%=mdName%>"},
                success:function (data) {
                        $('#mdUtil-text-default').text("已赞")
                        $('#mdUtil-text-active').text("已赞")
                },//响应成功后的回调函数
                error:function () {

                },//表示如果请求响应出现错误，会执行的回调函数
                dataType:"text"//设置接收到的响应数据的格式
            });
        }
        function sub(id,maName) {
            $.ajax({
                url:"otherMdShowServlet",
                type:"post",
                data:{
                    "id":id,
                    "mdName":maName
                },
                success:function () {
                    location.href="otherPersonShow.jsp";
                },
                error:function () {

                }
            });
        }

    </script>
    <script>
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
<% if (user!=null){ %>
<script>
    function comment() {
        $.ajax({
            url:"CommentServlet",
            type: "post",
            data:{
                "mdName":"<%=mdName%>",
                "comment":$('.comment-box-textarea').val(),
                "userId":"<%=user.getUser_id()%>"
            },
            success:function (data) {
                location.reload();
            },
            error:function () {

            },
            dataType:"text"
        });
    }

</script>
<%}%>
<div id="content" class="container-fluid no-gutter">
    <div class="row">
        <div id="left" class="col-lg-4 js-affix">
            <div id="leftFirst">
                <div class="head">
                    <%if (HostUser.getUser_profile_photo()!=null){%>
                    <a href="ToOtherPersonServlet?id=<%=HostUser.getUser_id()%>"><img src="UserFile/headPhoto/<%=HostUser.getUser_profile_photo()%>" style="border-radius: 50%;float: left;width: 48px;height: 48px;display: block"></a>
                    <%}else{%>
                    <a href="ToOtherPersonServlet?id=<%=HostUser.getUser_id()%>"><img src="UserFile/headPhoto/default.png" style="border-radius: 50%;float: left;width: 48px;height: 48px;display: block"></a>
                    <%}%>
                    <span class="name"><%=HostUser.getUser_name()%></span>
                    <div><span>码龄1年</span><span style="margin-left: 20px"><img src="img/person/nocErtification.png" style="margin-right: 4px;width: 12px;height: 14px"></span>
                        <span>暂无认证</span>
                    </div>
                </div>

                <div class="infoTop">
                    <div class="infoUnit" style="margin-left: 10px">
                        <div class="infoUnitNum">
                            <% try{%>
                            <%=info.getRanking()%>
                            <% } catch (NullPointerException e){%>
                            0
                            <%}%>
                        </div>
                        <div class="infoUnitText">排名</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            <% try{%>
                            <%=info.getCountView()%>
                            <% } catch (NullPointerException e){%>
                            0
                            <%}%>
                        </div>
                        <div class="infoUnitText">访问</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            <% try{%>
                            <%=info.getLikeCount()%>
                            <% } catch (NullPointerException e){%>
                            0
                            <%}%>
                        </div>
                        <div class="infoUnitText">获赞</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            <% try{%>
                            <%=info.getBlogCount()%>
                            <% } catch (NullPointerException e){%>
                            0
                            <%}%>
                        </div>
                        <div class="infoUnitText">总数</div>
                    </div>
                    <div class="infoUnit">
                        <div class="infoUnitNum">
                            <% try{%>
                            <%=info.getCommentCounter()%>
                            <% } catch (NullPointerException e){%>
                            0
                            <%}%>
                        </div>
                        <div class="infoUnitText">评论</div>
                    </div>
                </div>
                <div class="item-rank"> </div>
                <!--徽章-->
                <div class="emblem">
                    <span class="infoUnit1"><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span class="infoUnit1"><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span class="infoUnit1"><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span class="infoUnit1"><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
                    <span class="infoUnit1"><img src="img/person/qiandao50@240.png" class="badgeUnit"> </span>
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
            <%if (hotmdExist){%>
            <div id="hotText">
                <div class="title">
                    热门文章
                </div>
                <% for (Articles hotMd : info.getHotMd()) {%>
                <div class="hotTextUnit">
                    <a onclick="sub('<%=hotMd.getUser_id()%>','<%=hotMd.getArticle_content()%>')">
                        <%=hotMd.getArticle_title()%><img class="read1-1" src="img/yanjing.png" alt><%=hotMd.getArticle_views()%>
                    </a>
                </div>
                <%}%>
            </div>
            <%}%>
            <!--分类专栏-->
            <!--最新评论-->
            <div id="f3">
            <%if (newCommentsExist){%>
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
            <%}%>
            <!--最新文章-->
            <%if (newMdExist){%>
            <div id="newText">
                <div class="title">
                    最新文章
                </div>
                <% for (Articles newMd : info.getNewMd()) {%>
                <div class="newTextUnitTop">
                    <a onclick="sub('<%=newMd.getUser_id()%>','<%=newMd.getArticle_content()%>')" class="newTextUnitTopA">
                        <%=newMd.getArticle_title()%>
                    </a>
                </div>
                <%}%>
<%--                <hr style="border-top:0.5px dashed #b1b1b1;" width="100%" color="#b1b1b1" size=1>--%>
<%--                <div class="newTextUnitBottom">--%>
<%--                    <div id="year">2020</div>--%>
<%--                    <div class="newTextUnitBottomUnit">--%>
<%--                        <div class="mouth">6月</div>--%>
<%--                        <div class="num">13篇</div>--%>
<%--                    </div>--%>
<%--                    <div class="newTextUnitBottomUnit">--%>
<%--                        <div class="mouth">6月</div>--%>
<%--                        <div class="num">13篇</div>--%>
<%--                    </div>--%>
<%--                    <div class="newTextUnitBottomUnit">--%>
<%--                        <div class="mouth">6月</div>--%>
<%--                        <div class="num">13篇</div>--%>
<%--                    </div>--%>
<%--                    <div class="newTextUnitBottomUnit">--%>
<%--                        <div class="mouth">6月</div>--%>
<%--                        <div class="num">13篇</div>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
            <%}%>
        </div>
        <script>
            var offsetT=$("#f3").offset().top;
            $(window).scroll(function(){
                console.log(offsetT)
                var scrollT=$(document).scrollTop();
                if(scrollT>=offsetT){
                    $("#f3").addClass("fixed")
                }else{
                    $("#f3").removeClass("fixed")
                }
            })
        </script>
        </div>
        <!--        <script>-->
        <!--            $('.js-affix').affix({-->
        <!--                offset:{-->
        <!--                    top:112,-->
        <!--                    bottom:3680-->
        <!--                }-->
        <!--            });-->
        <!--        </script>-->



        <div id="right" class="col-lg-8" >
            <div id="md" style="min-height: 670px">
            <%@include file="mdShow.jsp"%>
            </div>
            <div id="mdUtil">
                <span id="mdUtil-span-default">
                <img src="img/show/tobarThumbUp.png" height="22px" width="22px" style="margin-right: 4px">
                <span id="mdUtil-text-default">点赞</span>
                </span>

                <span id="mdUtil-span-active" onclick="ajax()">
                <img src="img/show/tobarThumbUpactive.png" height="22px" width="22px" style="margin-right: 4px">
                <span style="color: red" id="mdUtil-text-active">点赞</span>
                </span>
                <script>
                    $('#mdUtil-span-default').mouseover(
                        function () {
                            $('#mdUtil-span-default').css("display","none")
                            $('#mdUtil-span-active').css("display","block")
                        }
                    )
                    $('#mdUtil-span-active').mouseout(
                        function () {
                            $('#mdUtil-span-default').css("display","block")
                            $('#mdUtil-span-active').css("display","none")
                        }
                    )
                </script>

            </div>


            <%--评论区--%>
            <%--css在单独文件中--%>
            <% if (user!=null){ %>
            <div class="comment">
                <%--输入框--%>
                <div class="comment-box">
                    <img src="UserFile/headPhoto/<%=user.getUser_profile_photo()%>" class="comment-box-headPhoto">

                    <input class="comment-box-textarea" placeholder="请输入评论">
                    <button onclick="comment()">发表</button>

                </div>
                <%--评论展示--%>
                <div>
                    <% if (comments!=null){ %>
                    <div class="comment_show">
                        <%--                        <div class="comment-unit">--%>
                        <%--                        loginTest:评论<span class="comment-date">2020</span>--%>
                        <%--                        </div>--%>
                        <% for (Comments comment : comments) {%>
                        <div class="comment-unit">
                            <%=comment.getUser_name()%>&nbsp;&nbsp;:<%=comment.getComment_content()%><span class="comment-date"> <%=comment.getComment_date()%></span>
                        </div>
                        <%}%>
                    </div>
                    <%}%>
                </div>
            </div>
            <%} else{%>
            <div class="comment-box">
                <a href="login.jsp">登录</a>

                <input class="comment-box-textarea" placeholder="请先登录">
                <button>发表</button>

            </div>
            <%}%>
            <div class="foot--">
                <%@include file="foot-min.jsp"%>
            </div>
        </div>
    </div>
</div>

</body>
</html>
