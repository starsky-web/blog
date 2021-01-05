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
登录<br>
<hr/>
<%
Object mes = request.getAttribute("message");
if(mes!=null)
	out.print(mes);
%>
<%
Object obj = session.getAttribute("user");
	if(obj!=null){
		User user = (User)obj;
		out.print("当前登录用户为："+user.getUsername()+"<br/>");
	}
%>
<form action="login_do.jsp" method="post" >
用户名:<input type="text" name="username" /><br/>
密码:<input type="password" name="password" /><br/>
<input type="submit" value="登录"  />
</form>
</body>
</html>