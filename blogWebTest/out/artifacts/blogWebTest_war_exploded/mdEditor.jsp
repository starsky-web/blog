<%@ page import="com.blog.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/1 0001
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% User user = (User) session.getAttribute("user");%>
<% if (user==null){
    response.sendRedirect("login.jsp");
}%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="img/logo.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/content/spn.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/content/index.js"></script>
    <meta charset="utf-8" />
    <title>Simple example - Editor.md examples</title>
    <style>
        .mdSubmit{
            padding: 0 16px;
            font-size: 16px;
            color: #fff;
            border: none;
            border-radius: 18px;
            white-space: nowrap;
            background: linear-gradient(92deg,#ffba40,#ff503e 37%,#ff2f50 81%,#ff1b40);
            height: 40px;
        }
        .mdUtilBox{
            margin-top: 5px;
            margin-bottom: 5px;
            height: 40px;
        }
        input{
            -webkit-writing-mode: horizontal-tb !important;
            text-rendering: auto;
            letter-spacing: normal;
            word-spacing: normal;
            text-transform: none;
            text-indent: 0px;
            text-shadow: none;
            display: inline-block;
            text-align: start;
            -webkit-rtl-ordering: logical;
            cursor: text;
            margin: 0em;
            font: 400 13.3333px Arial;
            padding: 1px 2px;
            border-width: 2px;
            border-style: inset;
            border-image: initial;
        }
        #mdUtilInput{
            width: 1200px;
            border-radius: 4px;
            height: 40px;
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
            <%if (user!=null){ %>
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
<!-- 导入CSS文件 -->
<link rel="stylesheet" href="static/css/style.css" />
<link rel="stylesheet" href="static/css/editormd.css" />

<!-- 在Body中添加如下代码 -->
<!--<div id="deditor"> &lt;!&ndash; 这里的id很重要的 &ndash;&gt;-->
<!--    <textarea style="display:none;">这里是editor的内容</textarea>-->

<!--</div>-->
<%--<form action="mdUploadServlet" method="post" >--%>
    <div class="mdUtilBox">
        <input name="article_title" placeholder="请输入文章标题" id="mdUtilInput">
    <button class="mdSubmit" onclick="upload()">发布文章</button>
    </div>
    <div id="deditor"> <!-- 这里的id很重要的 -->
        <textarea style="display:none;" name="article_content" id="mdContent">这里是editor的内容</textarea>

    </div>
<%--</form>--%>
<script>
    function upload() {
        $.ajax({
            url:"mdUploadServlet",
            type:"post",
            data:{
                "article_title":$("#mdUtilInput").val(),
                "article_content":$("#mdContent").val()
            },
            success:function () {
                alert("上传成功")
                location.href="Person"
            },
            error:function () {

            }
        });
    }
</script>


<!-- 导入JavaScript文件 -->
<script src="static/js/jquery.min.js"></script>
<script src="static/js/editormd.min.js"></script>

<!-- 导入如下的JavaScript代码 -->
<script type="text/javascript">
    var testEditor;
    $(function () {
        testEditor = editormd({
            id:"deditor",//注意：这里是上面DIV的id
            // width:"90%",
            width:"100%",
            height:640,
            syncScrolling: "single",
            path:"static/lib/",
        });});
</script>

</body>
</html>
