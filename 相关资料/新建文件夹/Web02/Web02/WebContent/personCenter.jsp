<%@page import="com.sikiedu.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Object obj = session.getAttribute("user");
	if(obj!=null){
		User user = (User)obj;
		out.print("当前登录用户为："+user.getUsername()+"<br/>");
	}
%>
<%
	User user =(User)session.getAttribute("user");
%>
用户名<%= user.getUsername() %><br>
年龄 <%= user.getAge() %><br>
性别 <%= user.getSex() %><br>
</body>
</html>