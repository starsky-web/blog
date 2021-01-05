<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/11 0011
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script>
        function addFile() {
            var divTag = document.getElementById("uploadFileDiv");
            //在div中添加一个选择文件的按钮
            divTag.innerHTML += "<div><input type=\"file\" name=\"file\" value=\"浏览文件\"><input type=\"button\" οnclick=\"deleteDiv(this.parentNode)\" value=\"取消\"></div>";
        }
        function deleteDiv(div) {
            <%-- 删除此div --%>
            div.parentNode.removeChild(div);
        }
    </script>
</head>
<body>
<%--  以post请求方式，multipart/form-data的数据格式，发送到UploadServlet  --%>
<%-- ${pageContext.request.contextPath} 是jsp中el表达式，作用是获取项目url --%>
<%--<form action="${pageContext.request.contextPath}/uploadServlet" method="post" enctype="multipart/form-data">--%>
<%--    用户名<input type="text" name="userName"><br>--%>
<%--    密码<input type="password" name="password"><br>--%>
<%--    上传文件:<br>--%>
<%--    <div id="uploadFileDiv">--%>
<%--        &lt;%&ndash; 每次删除一个内嵌的div &ndash;%&gt;--%>
<%--        <div>--%>
<%--            <input type="file" name="file" value="浏览文件">--%>
<%--            &lt;%&ndash; 添加取消按钮，并设置删除上一级的事件 &ndash;%&gt;--%>
<%--            <input type="button" onclick="deleteDiv(this.parentNode)" value="取消">--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <input type="button" onclick="addFile()" value="添加文件">--%>
<%--    <input type="submit" value="提交">--%>
<%--</form>--%>

<form action="uploadServlet" method="post" enctype="multipart/form-data">
    <input type="file" name="file" value="浏览文件">
    <input type="submit" value="提交">
</form>

</body>
</html>
