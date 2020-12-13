<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/12/11 0011
  Time: 22:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/content/login.css" rel="stylesheet" type="text/css">
    <script src="js/content/login.js"></script>
    <title>Title</title>
</head>
<body>
<!-- 模仿网站:https://passport.csdn.net/login?code=public  二维码的位置直接写表单即可 -->
<!--导航栏-->
<%@include file="span.jsp"%>
<div class="content">
    <div class="login">
        <div id="loginLeft">
            <h2>Elixir</h2>
            <br>
            <p>Elixir发布于2012年,设计者是 Jose valim。它是一个基于 Erlang虚拟机的函数式编程语言,语法灵活,兼具高并发和稳定性。Elixir以 Erlang为基础,支持分布式、
                高容错、实时应用程序的开发,亦可通过宏实现元编程对其进行扩展,并通过协议支持多态。</p>
            <br>

        </div>
        <div id="loginRight">
            <span class="main-title">注册登录CSDN</span>
            <div id="formDiv">
                <form method="post" action="loginServlet">
                    用户名：
                    <input type="text" value="" name="user_name">
                    <br>
                    密码：&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="password" name="password">
                    <br>
                    <input type="checkbox" name="autoLogin">自动登录
                    <br>
                    <input type="submit" value="登录">

                </form>

            </div>
        </div>
    </div>
</div>
<div  id="foot" class="foot-1">
    <div id="foot1" class="foot1-1">
        <ul id="foot2" class="foot2-2">
            <li><a href="//www.csdn.net/company/index.html#about" target="_blank">关于我们</a></li>
            <li><a href="//www.csdn.net/company/index.html#about" target="_blank">招贤纳士</a></li>
            <li><a href="//www.csdn.net/company/index.html#about" target="_blank">广告服务</a></li>
            <li><a href="//www.csdn.net/company/index.html#about" target="_blank">开发助手</a></li>
            <li><img src="img/tel.png" alt style="height: 16px" width="16px"><span>123-456-0123</span></li>
            <li><img src="img/email.png" alt style="height: 16px" width="16px"><a href="mailto:webmaster@csdn.net" target="_blank">kefu@csdn.net</a> </li>
            <li><img src="img/cs.png" alt style="height: 16px" width="16px"><a href="https://csdn.s2.udesk.cn/im_client/?web_plugin_id=29181" target="_blank">在线客服</a></li>
            <li>工作时间&nbsp;8:30-22:00</li>
        </ul>
        <ul  id="foot3" class="foot3-3">
            <li><img src="img/badge.png" alt style="height: 16px" width="16px"><a href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143" rel="noreferrer" target="_blank">公安备案号11010502030143</a> </li>
            <li><a href="http://beian.miit.gov.cn/publish/query/indexFirst.action" rel="noreferrer" target="_blank">京ICP备19004658号</a></li>
            <li><a href="https://csdnimg.cn/release/live_fe/culture_license.png" rel="noreferrer" target="_blank">京网文〔2020〕1039-165号</a></li>
            <li><a href="https://csdnimg.cn/cdn/content-toolbar/csdn-ICP.png" target="_blank">经营性网站备案信息</a></li>
            <li><a href="http://www.bjjubao.org/" target="_blank">北京互联网违法和不良信息举报中心</a></li>
            <li><a href="http://www.cyberpolice.cn/" target="_blank">网络110报警服务</a></li>
            <li><a href="http://www.12377.cn/" target="_blank">中国互联网举报中心</a></li>
            <li><a href="https://download.csdn.net/index.php/tutelage/" target="_blank">家长监护</a></li>
            <li><a href="https://chrome.google.com/webstore/detail/csdn%E5%BC%80%E5%8F%91%E8%80%85%E5%8A%A9%E6%89%8B/kfkdboecolemdjodhmhmcibjocfopejo?hl=zh-CN" target="_blank">Chrome商店下载</a></li>
            <li>©1999-2020北京创新乐知网络技术有限公司</li>
            <li><a href="https://www.csdn.net/company/index.html#statement" target="_blank">版权与免责声明</a></li>
            <li><a href="https://blog.csdn.net/blogdevteam/article/details/90369522" target="_blank">版权申诉</a></li>
        </ul>
    </div>
</div>
</body>
</html>
