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
Object mas = request.getAttribute("message");
	if(mas!=null)
		out.print(mas);
%>
<form action="rejister_do.jsp" method="post" >
用户名:<input type="text" name="username" /><br/>
密码:<input type="password" name="password" /><br/>
性别:男<input type="radio" name="sex" value="男" />女<input type="radio" name="sex" value="女" /><br/>
年龄:<input type="text" name="age" /><br/>
<input type="submit" value="注册"  />
</form>
</body>
</html>