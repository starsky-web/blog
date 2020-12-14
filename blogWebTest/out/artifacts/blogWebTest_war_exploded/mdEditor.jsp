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
    response.sendRedirect("login.html");
}%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8" />
    <title>Simple example - Editor.md examples</title>

</head>
<body>
<!-- 导入CSS文件 -->
<link rel="stylesheet" href="static/css/style.css" />
<link rel="stylesheet" href="static/css/editormd.css" />

<!-- 在Body中添加如下代码 -->
<!--<div id="deditor"> &lt;!&ndash; 这里的id很重要的 &ndash;&gt;-->
<!--    <textarea style="display:none;">这里是editor的内容</textarea>-->

<!--</div>-->
<form action="mdUploadServlet" method="post" >
    <textarea name="article_title">这里是文章标题</textarea>
    <div id="deditor"> <!-- 这里的id很重要的 -->
        <textarea style="display:none;" name="article_content">这里是editor的内容</textarea>

    </div>
    <input type="submit" value="提交">
</form>


<!-- 导入JavaScript文件 -->
<script src="static/js/jquery.min.js"></script>
<script src="static/js/editormd.min.js"></script>

<!-- 导入如下的JavaScript代码 -->
<script type="text/javascript">
    var testEditor;
    $(function () {
        testEditor = editormd({
            id:"deditor",//注意：这里是上面DIV的id
            width:"90%",
            height:640,
            syncScrolling: "single",
            path:"static/lib/",
        });});
</script>

</body>
</html>
