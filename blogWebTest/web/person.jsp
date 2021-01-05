<%@ page import="com.blog.entity.User" %>
<%@ page import="com.blog.entity.Articles" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.entity.PersonInfo" %>
<%@ page import="com.blog.entity.Comments" %>
<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/2 0002
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="error.jsp" %>
<%PersonInfo info = (PersonInfo) session.getAttribute("personInfo");%>
<%User user = (User) session.getAttribute("user");%>
<%List<Articles> allMd = (List<Articles>) session.getAttribute("allMd");%>
<%int pageCount = (int) session.getAttribute("pages");%>
<%if (user==null){%>
    <%request.getRequestDispatcher("login.jsp").forward(request,response);%>
<%}%>
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
    <link href="css/content/foot-1.css" rel="stylesheet" type="text/css">
    <link href="css/content/spn.css" rel="stylesheet" type="text/css">
    <script src="js/clickEffect.js"></script><%--点击特效--%>
    <!--鼠标跟随-->
    <span class="js-cursor-container"></span>
    <script src="js/follow.js"></script>
    <script src="js/content/person.js"></script>
    <link rel="shortcut icon" href="img/logo.ico" type="image/x-icon"/>
    <title>Blog</title>
    <style>
        #hotText a{
            text-decoration: none;
            color: #0f0f0f;
        }
        #hotText a:hover{
            text-decoration: none;
            color: #0f0f0f;
        }
        .fixed{
            position: fixed;
            top:10px;
            width: 285px;
            /*left: 100px;*/
        }
    </style>
    <style>
        /*鼠标悬浮时的灰膜样式设置*/
        .headerSpan {
            position: relative;
            z-index: 1;
            display: inline-block;
        }
        .headerSpan:after {
            content: "";
            background:rgba(0,0,0,0.4);
            z-index:2;
            -webkit-transition: 0.2s;
            -moz-transition: 0.2s;
            -ms-transition: 0.2s;
            -o-transition: 0.2s;
            transition: 0.2s;
            position: absolute;
            border-radius: 45px;
            top: 0px;
            right: -0.8px;
            width: 4.4rem;
            height: 4.4rem;
            opacity: 0;
            filter: alpha(opacity=0);
        }
        .headerSpan:hover:after {
            opacity: 100;
            filter: alpha(opacity=0);
            cursor: pointer;
        }

        /*// 更换头像字的样式设置*/
           .headerSpan:before {
               content: "更换头像";
               display: inline-block;
               float: right;
               position: absolute;
               z-index: 5;
               top: 24px;
               right: 0.5rem;
               width: 3.5rem;
               height: 1.5rem;
               opacity: 0;
               color: white;
               filter: alpha(opacity=0);
           }
        .headerSpan:hover:before {
            opacity: 100;
            filter: alpha(opacity=0);
            cursor: pointer;
        }
        .hiddenInput {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 70px;
            height: 70px;
            z-index: 6;
            opacity: 0;
            cursor: pointer;
            border-radius: 45px;
        }

    </style>


</head>
<body>
<!--个人主页，左侧部分有个效果还未完成-->
<!-- 模仿网站：https://blog.csdn.net/starsky__?spm=1000.2115.3001.5113  -->
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
                function searchLimitId() {
                    $.ajax({
                        url:"searchLimitIdServlet",//请求路径
                        type:"post",//请求方式
                        //data:"username=jack",//请求参数
                        data:{
                            "SLI":$('#SLI').val(),
                            "id":"<%=user.getUser_id()%>"
                        },
                        success:function (data) {
                            location.href="resultDisplay.jsp";
                        },//响应成功后的回调函数
                        error:function () {

                        },//表示如果请求响应出现错误，会执行的回调函数
                        dataType:"text"//设置接收到的响应数据的格式
                    });
                }
                function sub(d) {
                    $.ajax({
                        url:"mdShowServlet",
                        type:"post",
                        data:{
                            "mdName":d
                        },
                        success:function () {
                            location.href="personShow.jsp";
                        },
                        error:function () {

                        }
                    });
                }

            </script>
        </div>
        <div class="col-lg-1 spn"><a href="mdEditor.jsp" class="a1"><i class="li1"></i>创作中心</a></div>
        <div class="col-lg-1 spn" id="spnTou">
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

<div id="content" class="container-fluid no-gutter">
    <div class="row">
        <div id="left" class="col-lg-4 js-affix">
            <div id="leftFirst">
                <div class="head">
                    <%if (user.getUser_profile_photo()!=null){%>
                    <img src="UserFile/headPhoto/<%=user.getUser_profile_photo()%>" style="border-radius: 50%;float: left;width: 48px;height: 48px;display: block" id="userHead">
                    <form enctype="multipart/form-data" id="headInput">
                    <input type="file" class="hiddenInput" onchange="changeHeadPhoto()" name="file">
                    </form>
                    <%}else{%>
                    <img src="UserFile/headPhoto/default.png" style="border-radius: 50%;float: left;width: 48px;height: 48px;display: block">
                    <form enctype="multipart/form-data" id="headInput">
                        <input type="file" class="hiddenInput" onchange="changeHeadPhoto()" name="file">
                    </form>
                    <%}%>
                    <span class="name"><%=user.getUser_name()%></span>
                    <div><span>码龄1年</span><span style="margin-left: 20px"><img src="img/person/nocErtification.png" style="margin-right: 4px;width: 12px;height: 14px"></span>
                        <span>暂无认证</span>
                    </div>
                </div>
                <script>
                    function changeHeadPhoto() {
                        var file = $("input[name='file']").prop("files")[0];
                        var formData = new FormData();
                        formData.append("file",file);

                        $.ajax({
                            // enctype:"multipart/form-data",
                            contentType: false,
                            // 告诉jQuery不要去设置Content-Type请求头
                            processData: false,
                            // 告诉jQuery不要去处理发送的数据
                            url:"uploadServlet",
                            type:"post",
                            data: formData,
                            beforeSend :function(xmlHttp){
                                xmlHttp.setRequestHeader("If-Modified-Since","0");
                                xmlHttp.setRequestHeader("Cache-Control","no-cache");
                            },
                            success:function () {
                                alert("上传成功")
                                <%user=(User) session.getAttribute("user");%>
                                $('#userHead').attr('src','UserFile/headPhoto/<%=user.getUser_profile_photo()%>')
                                location.reload()
                            },
                            error:function () {

                            }
                        });
                    }
                </script>

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
<%--                <div class="infoBottom" style="text-align: center">--%>
<%--                    --%>
<%--                </div>--%>
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
<%--                <div class="hotTextUnit">--%>
<%--                    <a href="#">--%>
<%--                        Mysql数据表设计，三大范式<span class="glyphicon glyphicon-eye-open hotEye"></span>--%>
<%--                    </a>--%>
<%--                </div>--%>
                <% for (Articles hotMd : info.getHotMd()) {%>
                <div class="hotTextUnit">
                    <a onclick="sub('<%=hotMd.getArticle_content()%>')">
                        <%=hotMd.getArticle_title()%></a><img class="read1-1" src="img/yanjing.png" alt><span class="read1"><%=hotMd.getArticle_views()%>

                </div>
                <%}%>
            </div>
            <%}%>

            <!--分类专栏-->

            <!--最新评论-->
            <div id="f">
            <%if (newCommentsExist){%>
            <div id="newComment">
                <div class="title">
                    最新评论
                </div>
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
                var offsetT=$("#f").offset().top;
                $(window).scroll(function(){
                    console.log(offsetT)
                    var scrollT=$(document).scrollTop();
                    if(scrollT>=offsetT){
                        $("#f").addClass("fixed")
                    }else{
                        $("#f").removeClass("fixed")
                    }
                })
            </script>
        </div>


        <div id="right" class="col-lg-8" >
            <div style="background: white;padding-left: 25px">
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
            </div>
            <script>
                function deleteSub(article_id) {
                    $.ajax({

                        url:"delete",
                        type:"post",
                        data: {
                            "article_id":article_id
                        },
                        success:function () {
                            alert("删除成功")
                            location.reload()
                        },
                        error:function () {

                        }
                    });
                }
                function change(id) {
                    $.ajax({
                        url:"mdChangeServlet",
                        type:"post",
                        data: {
                            "id":id
                        },
                        success:function () {
                            location.href="change.jsp"
                        },
                        error:function () {

                        },
                        dataType:"text"
                    });
                }
            </script>



            <div style="background: white;padding-left: 25px">
                <style>
                    .rightUnitBtn{
                        margin-right: 5px;
                    }
                </style>
            <%if (allMd!=null){ %>
            <% for (Articles md:allMd) {%>
                    <div class="rightUnit">
                        <div class="rightUnitTitle">
                            <a style="display: block" onclick="sub('<%=md.getArticle_content()%>') "><span class="design">原创</span><%=md.getArticle_title()%></a>
                        </div>
                        <div class="rightUnitText">
                            <%=md.getArticle_preview()%>
                        </div>
                        <div class="date">
                            <span class="year"><%=md.getArticle_date()%></span><span class="viewCounter"><img class="read1-1" src="img/yanjing.png" alt><%=md.getArticle_views()%></span>
                            <div style="float: right;padding-right: 20px">
                            <span style="display: block;float: right" onclick="change('<%=md.getArticle_id()%>')" class="rightUnitBtn">修改</span>
                            <span style="display: block;float: right" onclick="deleteSub('<%=md.getArticle_id()%>')" class="rightUnitBtn">删除</span>
                            </div>
                        </div>
                    </div>

                <%}%>
                <style>
                    #pagination{
                        padding: 16px;
                        background-color: white;
                        width: 100%;
                        height: 60px;
                    }
                    #pagination ul{
                        list-style: none;
                        text-align: center;
                    }
                    #pagination ul li{
                        border: none;
                        list-style: none;
                        color: #e8e8ed;

                    }
                </style>
                <div id="pagination">
                    <div align="center">
                        <%for (int i=1;i<=pageCount;i++){%>
                            <a href="Person?page=<%=i%>"><%=i%></a>
                        <%}%>
                    </div>
                </div>


            <%}else{ %>
                <style>
                    #e{
                        text-decoration: none;
                        color: white;
                        display: block;
                    }
                    #e:hover{
                        text-decoration: none;
                        color: white;
                        display: block;
                    }
                </style>
                <div style="width: 100%;height: 430px;margin-top: 10px;margin-bottom: 10px;text-align: center;padding-top: 100px">
                    <div style="height: 200px;width: 100%;text-align: center;">
                        <img src="img/monkeyWhite.png" width="120" height="120">
                        <p>这里啥都没有</p>
                        <button type="button" class="btn btn-danger" style="width: 150px"> <a href="mdEditor.jsp" id="e">去创作</a></button>


                    </div>

                </div>
            <%}%>
            </div>


            <div class="foot--">
                <%@include file="foot-min.jsp"%>
            </div>
        </div>



    </div>
</div>

</body>
</html>
