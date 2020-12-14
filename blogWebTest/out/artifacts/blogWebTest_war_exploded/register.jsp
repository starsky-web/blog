<%--
  Created by IntelliJ IDEA.
  User: WJF
  Date: 2020/11/29 0029
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/content/register.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/content/register.js"></script>
    <link href="css/content/login.css" rel="stylesheet" type="text/css">
    <link href="css/content/spn.css" rel="stylesheet" type="text/css">
    <title>Title</title>
</head>
<body>

<script>
    function DateSelector(selYear, selMonth, selDay) {//定义函数
        this.selYear = selYear;
        this.selMonth = selMonth;
        this.selDay = selDay;
        this.selYear.Group = this;
        this.selMonth.Group = this;
// 给年份、月份下拉菜单添加处理onchange事件的函数
        if (window.document.all != null) // IE
        {
            this.selYear.attachEvent("onchange", DateSelector.Onchange);
            this.selMonth.attachEvent("onchange", DateSelector.Onchange);
        }
        else // Firefox
        {
            this.selYear.addEventListener("change", DateSelector.Onchange, false);
            this.selMonth.addEventListener("change", DateSelector.Onchange, false);
        }
        if (arguments.length == 4) // 如果传入参数个数为4，最后一个参数必须为Date对象
            this.InitSelector(arguments[3].getFullYear(), arguments[3].getMonth() + 1, arguments[3].getDate());
        else if (arguments.length == 6) // 如果传入参数个数为6，最后三个参数必须为初始的年月日数值
            this.InitSelector(arguments[3], arguments[4], arguments[5]);
        else // 默认使用当前日期
        {
            var dt = new Date();
            this.InitSelector(dt.getFullYear(), dt.getMonth() + 1, dt.getDate());
        }
    }
    // 增加一个最小年份的属性--最老年份
    DateSelector.prototype.MinYear = 1960;
    // 增加一个最大年份的属性--最新年份，即当前时期getFullYear()
    DateSelector.prototype.MaxYear = (new Date()).getFullYear();
    // 初始化年份
    DateSelector.prototype.InitYearSelect = function () {
// 循环添加OPION元素到年份select对象中
        for (var i = this.MaxYear; i >= this.MinYear; i--) {
// 新建一个OPTION对象
            var op = window.document.createElement("OPTION");
// 设置OPTION对象的值
            op.value = i;
// 设置OPTION对象的内容
            op.innerHTML = i;
// 添加到年份select对象
            this.selYear.appendChild(op);
        }
    }
    // 初始化月份
    DateSelector.prototype.InitMonthSelect = function () {
// 循环添加OPION元素到月份select对象中
        for (var i = 1; i < 13; i++) {
// 新建一个OPTION对象
            var op = window.document.createElement("OPTION");
// 设置OPTION对象的值
            op.value = i;
// 设置OPTION对象的内容
            op.innerHTML = i;
// 添加到月份select对象
            this.selMonth.appendChild(op);
        }
    }
    // 根据年份与月份获取当月的天数
    DateSelector.DaysInMonth = function (year, month) {
        var date = new Date(year, month, 0);
        return date.getDate();
    }
    // 初始化天数
    DateSelector.prototype.InitDaySelect = function () {
// 使用parseInt函数获取当前的年份和月份
        var year = parseInt(this.selYear.value);
        var month = parseInt(this.selMonth.value);
// 获取当月的天数
        var daysInMonth = DateSelector.DaysInMonth(year, month);
// 清空原有的选项
        this.selDay.options.length = 0;
// 循环添加OPION元素到天数select对象中
        for (var i = 1; i <= daysInMonth; i++) {
// 新建一个OPTION对象
            var op = window.document.createElement("OPTION");
// 设置OPTION对象的值
            op.value = i;
// 设置OPTION对象的内容
            op.innerHTML = i;
// 添加到天数select对象
            this.selDay.appendChild(op);
        }
    }
    // 处理年份和月份onchange事件的方法，它获取事件来源对象（即selYear或selMonth）
    // 并调用它的Group对象（即DateSelector实例，请见构造函数）提供的InitDaySelect方法重新初始化天数
    // 参数e为event对象
    DateSelector.Onchange = function (e) {
        var selector = window.document.all != null ? e.srcElement : e.target;
        selector.Group.InitDaySelect();
    }
    // 根据参数初始化下拉菜单选项
    DateSelector.prototype.InitSelector = function (year, month, day) {
// 由于外部是可以调用这个方法，因此我们在这里也要将selYear和selMonth的选项清空掉
// 另外因为InitDaySelect方法已经有清空天数下拉菜单，因此这里就不用重复工作了
        this.selYear.options.length = 0;
        this.selMonth.options.length = 0;
// 初始化年、月
        this.InitYearSelect();
        this.InitMonthSelect();
// 设置年、月初始值
        this.selYear.selectedIndex = this.MaxYear - year;
        this.selMonth.selectedIndex = month - 1;
// 初始化天数
        this.InitDaySelect();
// 设置天数初始值
        this.selDay.selectedIndex = day - 1;
    }
</script>
<!-- 模仿网站:https://passport.csdn.net/login?code=public  二维码的位置直接写表单即可 -->
<!--导航栏-->
<div class="container-fluid spnContent" style="padding-top: 5px">
    <div class="row">
        <div class="col-lg-1 spn"></div>
        <div class="col-lg-1 spn"><a href="#"><img src="img/blackLogo.png"> </a></div>
        <div class="col-lg-1 spn"><a href="#">首页</a></div>
        <div class="col-lg-1 spn"><a href="#">关于</a></div>
        <div class="col-lg-5 spn find">
            <div class="input-group">
                <input id="input1" type="text" value placeholder="博客点击开始" autocomplete="off" onkeydown="onKeyDown(event)">
                <button id="shosuo"></button>

                </span>
            </div>
            <!--搜索处理，放在js中-->
            <!--            <script>-->
            <!--                /* 搜索框  */-->
            <!--                function onKeyDown(event){-->
            <!--                    //执行搜索点击事件-->

            <!--                }-->
            <!--            </script>-->
        </div>
        <div class="col-lg-1 spn"><a href="#"class="a1"><i class="li1"></i>创作中心</a></div>
        <div class="col-lg-1 spn" id="spnTou"><a href="#">头像</a>
            <ul>
                <li><a href="#"> 我的博客</a></li>
                <li><a href="#">更多</a></li>
                <li><a href="#">退出</a></li>
            </ul>
        </div>
        <div class="col-lg-1 spn"></div>
    </div>
</div>
<!--控制头像下列表-->
<script>
    $(document).ready(
        $('#spnTou').mouseover(
            function(){
                $("#spnTou ul li").css("display","block")
            }
        ),
        $('#spnTou').mouseout(
            function(){
                $("#spnTou ul li").css("display","none")
            }
        )
    )
</script>
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
                            <label  class="el-form-item__label" style="width: 80px;">昵称</label>
                            <div class="el-form-item__content" style="margin-left: 80px;">
                                <div class="el-input">
                                    <input type="text" autocomplete="off" placeholder="请设置昵称" class="el-input__inner" name="user_name">
                                    <span class="el-input__suffix">
                        <span class="el-input__suffix-inner"></span>
                        <i class="el-input__icon el-input__validateIcon el-icon-circle-close"></i>
                    </span></div>
                                <div class="el-form-item__error" style="height: 16px;width: 155px" >
                                    昵称长度需在 2 到 20 个字符
                                </div>
                            </div>
                        </div>
                        <div data-v-165b75c4="" class="el-form-item el-form-item--feedback is-error">
                            <label  class="el-form-item__label" style="width: 80px;">密码</label>
                            <div class="el-form-item__content" style="margin-left: 80px;">
                                <div data-v-165b75c4="" class="el-input">
                                    <input type="password" autocomplete="off" placeholder="请设置密码" class="el-input__inner" name="user_password">
                                    <span class="el-input__suffix">
                        <span class="el-input__suffix-inner"></span>
                        <i class="el-input__icon el-input__validateIcon el-icon-circle-close"></i>
                    </span></div>
                                <div class="el-form-item__error" style="height: 16px;width: 155px">
                                    密码长度需在 2 到 20 个字符
                                </div>
                            </div>
                        </div>
                        <div data-v-165b75c4="" class="el-form-item el-form-item--feedback is-error">
                            <label  class="el-form-item__label" style="width: 80px;">电话号码</label>
                            <div class="el-form-item__content" style="margin-left: 80px;">
                                <div data-v-165b75c4="" class="el-input">
                                    <input type="text" autocomplete="off" placeholder="请输入电话号码" class="el-input__inner" name="user_telephone_number">
                                    <span class="el-input__suffix">
                        <span class="el-input__suffix-inner"></span>
                        <i class="el-input__icon el-input__validateIcon el-icon-circle-close"></i>
                    </span></div>
                                <div class="el-form-item__error" style="height: 16px;width: 155px">
                                    手机号码需 11 个数字
                                </div>
                            </div>
                        </div>
                        <div class="birthdaySelect">
                            <select id="selYear" class="birthdaySel" name="birthdayYear"></select>年
                            <select id="selMonth" class="birthdaySel" name="birthdayMouth"></select>月
                            <select id="selDay" class="birthdaySel" name="birthdayDay"></select>日
                        </div>
                        <!--完成出生日期的选择--需写在</body>前-->
                        <script>
                            var selYear = window.document.getElementById("selYear");
                            var selMonth = window.document.getElementById("selMonth");
                            var selDay = window.document.getElementById("selDay");
                            // 新建一个DateSelector类的实例，将三个select对象传进去
                            // new DateSelector(selYear, selMonth, selDay, 1995, 1, 17);
                            new DateSelector(selYear,selMonth,selDay,1995,1,17);
                        </script>
<%--                        <div style="margin-left: 100px">--%>
<%--                        年龄:--%>
<%--                        <input type="text" name="user_age" ><br>--%>
<%--                        </div>--%>
                        <input type="submit" value="注册" style="text-align: center;margin-left: 150px;margin-top: 10px">
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
