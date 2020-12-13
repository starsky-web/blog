<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/11/29 0029
  Time: 21:36
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
    <script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/content/register.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/content/register.js"></script>
    <link href="css/content/login.css" rel="stylesheet" type="text/css">
    <link href="css/content/spn.css" rel="stylesheet" type="text/css">
    <title>Title</title>
    <style>
        /*.high{color: red;*/
        /*    !*float: right;*!*/
        /*}*/
        .msg{
            font-size: 10px;
        }
        /*.onError{ color: red; }*/
        /*.onSuccess{ color: green; }*/
    </style>
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
            <div class="UerProfile view" >
                <div class="info-box">
                    <header>
                        <div  class="left-title">
                            <span  class="title">账号注册</span>
                            <span class="t-icon"></span>
                        </div>
                        <div class="line-box"></div>
                    </header>
                </div>
                <div  class="contain contain-edit">
                    <form class="el-form demo-ruleForm el-form--label-right" method="post" action="registerServlet">
                        <div class="el-form-item el-form-item--feedback is-error">
                            <label  class="el-form-item__label" style="width: 80px;">用户名</label>
                            <div class="el-form-item__content" style="margin-left: 80px;width: 600px">
                                <div class="el-input">
                                    <input type="text" id="name1" autocomplete="off" placeholder="请设置昵称" class="required" name="user_name">
                                    <span class="el-input__suffix">
                        <span class="el-input__suffix-inner"></span>
                        <i class="el-input__icon el-input__validateIcon el-icon-circle-close"></i>
                    </span></div>
                            </div>
                        </div>

                        <div data-v-165b75c4="" class="el-form-item el-form-item--feedback is-error">
                            <label  class="el-form-item__label" style="width: 80px;">密码</label>
                            <div class="el-form-item__content" style="margin-left: 80px;width: 600px">
                                <div data-v-165b75c4="" class="el-input">
                                    <input type="text"  autocomplete="off" placeholder="请设置密码" class="required1" id="psd1" name="password">
                                    <span class="el-input__suffix">
                        <span class="el-input__suffix-inner"></span>
                        <i class="el-input__icon el-input__validateIcon el-icon-circle-close"></i>
                    </span></div>
                            </div>
                        </div>
                        <div data-v-165b75c4="" class="el-form-item el-form-item--feedback is-error">
                            <label  class="el-form-item__label" style="width: 80px;">电话号码</label>
                            <div class="el-form-item__content" style="margin-left: 80px;width: 600px">
                                <div data-v-165b75c4="" class="el-input">
                                    <input type="text" autocomplete="off" placeholder="请输入电话号码" class="required2" id="telephone1" name="telephone">
                                    <span class="el-input__suffix">
                        <span class="el-input__suffix-inner"></span>
                        <i class="el-input__icon el-input__validateIcon el-icon-circle-close"></i>
                    </span></div>
                            </div>
                        </div>
                        <div class="birthdaySelect">
                            <select id="selYear" class="birthdaySel" name="birthdayYear"></select>年
                            <select id="selMonth" class="birthdaySel" name="birthdayMouth"></select>月
                            <select id="selDay" class="birthdaySel" name="birthdayDay"></select>日
                        </div>
                        <!--完成出生日期的选择--需写在</body>前-->
                        <script type="text/javascript">
                            var selYear = window.document.getElementById("selYear");
                            var selMonth = window.document.getElementById("selMonth");
                            var selDay = window.document.getElementById("selDay");
                            // 新建一个DateSelector类的实例，将三个select对象传进去
                            new DateSelector(selYear, selMonth, selDay, 1995, 1, 17);
                        </script>
                        <input type="submit" value="注册" style="text-align: center;margin-left: 150px;margin-top: 10px">
                        <script>
                            // $("form :input.required").each(function () {
                            //     var $required = $("<strong class='high'><br/>密码不能为空</strong>");
                            //     $(this).parent().append($required);
                            // });
                            // $("form:input").focus(function () {
                            //     var $parent1 = $(this).parent();
                            //     if($(this).is("#name1")){
                            //         if (){}
                            //     }
                            // })
                            $("form :input").blur(function(){
                                var $parent = $(this).parent();
                                $parent.find(".msg").remove();
                                if($(this).is("#name1")){
                                    var nameVal = $.trim(this.value); //原生js去空格方式：this.replace(/(^\s*)|(\s*$)/g, "")
                                    var regName =/^[a-zA-Z][a-zA-Z\d_-]{1,7}$/
                                    if(nameVal == "" ||!regName.test(nameVal)){
                                        var e = "<div><img src='img/green@2x.png' width='18px'height='18px'>不包括空格</div>" +
                                            "<div><img src='img/info@2x.png'width='18px' height='18px'>长度为2-8个字符</div>" +
                                            "<div><img src='img/info@2x.png' width='18px' height='18px'>必须包含字母、数字、字符至少两种</div>";
                                        $parent.append("<span class='msg onError'>" +e+ "</span>");
                                    }
                                    else{
                                        var okMsg='<img src="img/green@2x.png" width="18px" height="18px">';
                                        $parent.find(".high").remove();
                                        $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                                    }
                                }
                                if($(this).is("#psd1")){
                                    var nameVal = $.trim(this.value); //原生js去空格方式：this.replace(/(^\s*)|(\s*$)/g, "")
                                    var regName = /^[\s\S]{6,12}/;
                                    if(nameVal == "" ||!regName.test(nameVal)){
                                        var errorMsg = "<div>长度6-12个字符</div>";
                                        //class='msg onError' 中间的空格是层叠样式的格式
                                        $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                                    }
                                    else{
                                        var okMsg="<img src='img/green@2x.png 'width='18px' height='18px'>";
                                        $parent.find(".high").remove();
                                        $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                                    }
                                }
                                if($(this).is("#telephone1")){
                                    var nameVal = $.trim(this.value); //原生js去空格方式：this.replace(/(^\s*)|(\s*$)/g, "")
                                    var regName = /^1\d{10}$/;
                                    if(nameVal == "" || !regName.test(nameVal)){
                                        var errorMsg = "<div>请输入11位电话号码</div>";
                                        //class='msg onError' 中间的空格是层叠样式的格式
                                        $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                                    }
                                    else{
                                        var okMsg="<img src='img/green@2x.png 'width='18px' height='18px'>";
                                        $parent.find(".high").remove();
                                        $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                                    }
                                }
                            });
                        </script>
                    </form>
                </div>
            </div>

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