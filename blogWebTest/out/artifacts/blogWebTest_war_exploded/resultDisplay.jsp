<%@ page import="java.util.List" %>
<%@ page import="com.blog.entity.Articles" %><%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/10 0010
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Articles>  searchResults= (List<Articles>) session.getAttribute("searchResult");%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<style>
    *{
        /*border: red solid 1px;*/
        margin: 0px;
        padding: 0px;

    }
    html{
        position:relative;
    }
    body{
        /*background-color: #f6f6f6;*/
        background-color: #999aaa;
    }
    .content{
        min-height: 625px;
        width: 1200px;
        margin: 5px auto;
        background-color: white;
    }
    .searchUnit{
        width: 100%;
        height: 125px;
        font-size: 18px;

    }
    .searchTitle{
        margin-top: 20px;
    }
    .searchUnitText{
        margin-top: 15px;
        width: 100%;
        height: 40px;
        margin-bottom: 10px;
        color:#999aaa;
    }
    .viewCounter{
        margin-left: 15px;
    }
</style>
<%@include file="span.jsp"%>
<div class="content">
<%if (searchResults!=null){ %>
<%for (Articles searchResult : searchResults) {%>
   <div class="searchUnit">
       <div class="searchTitle"><a href="otherMdShowServlet?id=<%=searchResult.getUser_id()%>&&mdName=<%=searchResult.getArticle_content()%>"><%=searchResult.getArticle_title()%></a> </div>
        <div class="searchUnitText">
            <%=searchResult.getArticle_preview()%>
        </div>
       <div class="date">
           <span class="year"><%=searchResult.getArticle_date()%></span><span class="viewCounter"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px;color: #cfcfda"></span><%=searchResult.getArticle_views()%></span>
       </div>
   </div>
    <hr style="border-top:0.5px dashed #b1b1b1;" width="100%" color="#b1b1b1" size=1>
 <%}%>
<%}else{ %>
    啥也不是
<%}%>
</div>
<%@include file="foot.jsp"%>
</body>
</html>
