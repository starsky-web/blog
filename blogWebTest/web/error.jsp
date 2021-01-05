<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/28 0028
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<% response.setHeader("Refresh", "5; URL=index.jsp");%>
<div style="width: 220px;height: 120px;margin: 220px auto 0 auto;text-align: center">
    <img src="img/monkeyWhite.png" width="120" height="120"><br>
    出现问题了，请点击<a href="index.jsp">这里</a>，或5秒后自动跳转至首页
</div>
</body>
</html>
