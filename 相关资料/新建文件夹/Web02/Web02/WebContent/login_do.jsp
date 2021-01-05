<%@page import="com.sikiedu.model.User"%>
<%@page import="com.siki.edu.DBUtil"%>
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
String username = request.getParameter("username");
String password = request.getParameter("password");

User user = DBUtil.verifyAccount(username, password);
	if(user==null){
		//out.print("登录失败，用户名或密码错误");
		request.setAttribute("message", "登录失败，用户名或密码错误");
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}else{
//		out.print("登录成功");
session.setAttribute("user", user);
request.getRequestDispatcher("personCenter.jsp").forward(request, response);

	}
%>
</body>
</html>