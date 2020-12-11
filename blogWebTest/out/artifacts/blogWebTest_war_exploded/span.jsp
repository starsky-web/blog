<%@ page import="com.blog.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/11 0011
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="img/logo.ico">
    <title>Title</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/content/spn.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/content/index.js"></script>
</head>
<body>
<div class="container-fluid" style="padding-top: 5px">
    <div class="row">
        <div class="col-lg-1 spn"></div>
        <div class="col-lg-1 spn"><a href="#"><img src="img/blackLogo.png"> </a></div>
        <div class="col-lg-1 spn"><a href="index.jsp">首页</a></div>
        <div class="col-lg-1 spn"><a href="#">关于</a></div>
        <div class="col-lg-5 spn find">
            <div class="input-group">
                <%--        <input id="input1" type="text" value placeholder="博客点击开始" autocomplete="off" name="search" onkeydown="onKeyDown(event)">--%>
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
</body>
</html>
