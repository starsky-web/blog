## 前言：
　　近期，小弟根据GitHub、前端社区、掘金等平台对当前流行的前端UI框架的进行了小小的整理和汇总（ps：前端UI框架的应用是通过GitHub star数，社区热度和使用范围等进行的粗略的汇总【不分先后】）。希望对寻找UI框架的小伙伴们提供点帮助。
　　以下对前端UI框架的移动端、PC端和混合APP的应用进行了列举。
&nbsp;
## 移动端UI框架
### Mint UI（饿了么团队）
　　中文官网：<a href="http://mint-ui.github.io/#!/zh-cn" target="_blank">http://mint-ui.github.io/#!/zh-cn</a>
　　描述：基于vue的移动端UI框架<br>　　基于vue<br>　　组件库：　　　　
　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093135271-588425539.png" alt="">
　　GitHub地址：<a href="https://github.com/ElemeFE/mint-ui/" target="_blank">https://github.com/ElemeFE/mint-ui/</a><br>　　star：8705，fork：1810<br>　　latest commit 2017.12.6 6pm<br>　　32 contributors<br>　　预览：<br>　　　　<a href="http://elemefe.github.io/mint-ui/#/" target="_blank">http://elemefe.github.io/mint-ui/#/</a><br>　　基础引入：<br>　　　　CDN:
```python
<!-- 引入样式 -->
<link rel="stylesheet" href="https://unpkg.com/mint-ui/lib/style.css">
<!-- 引入组件库 -->
<script src="https://unpkg.com/mint-ui/lib/index.js"></script>
```
　　　　npm:<br>　　　　　　npm i mint-ui -S<br>　　观点：可按需加载组件
&nbsp;
### SUI Mobile（阿里巴巴共享业务事业部UED团队）
 　　官网：<a href="http://m.sui.taobao.org/" target="_blank">http://m.sui.taobao.org/</a><br>        　　描述：一套基于 Framework7 开发的UI库。基于IOS风格。它非常轻量、精美，只需要引入我们的CDN文件就可以使用，<br>        并且能兼容到 iOS 6.0+ 和 Android 4.0+，非常适合开发跨平台Web App。<br>        　　基于zepto<br>        　　IOS风格<br>        　　预览：<br>            　　　　<a href="http://m.sui.taobao.org/demos/" target="_blank">http://m.sui.taobao.org/demos/</a><br>        　　组件库：<br>            　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093413959-63270572.png" alt=""><br>        　　GitHub地址：<a href="https://github.com/sdc-alibaba/SUI-Mobile" target="_blank">https://github.com/sdc-alibaba/SUI-Mobile</a><br>        　　star：5242，fork：1466<br>        　　lastest commit 2016.11.10 11am<br>        　　14 contributors<br>        　　基础引入：<br>            　　　　CDN:
```python
<link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
```
&nbsp;
&nbsp;
### Weui（微信官方设计团队）
　　描述：WeUI 为微信 Web 服务量身设计,是一套同微信原生视觉体验一致的基础样式库，由微信官方设计团队为微信 Web 开发量身设计，可以令用户的使用感知更加统一。<br>    包含button、cell、dialog、 progress、 toast、article、actionsheet、icon等各式元素。<br>    　　GitHub地址：<a href="https://github.com/weui/weui" target="_blank">https://github.com/weui/weui</a><br>    　　star:16804,fork:4683<br>    　　latest commit 2017.11.2 8pm<br>    　　20 contributors<br>    　　预览：<br>        　　　　UI组件<br>            　　　　　　<a href="https://weui.io" target="_blank">https://weui.io</a><br>            　　　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093527740-130068490.png" alt=""><br>        　　　　JS组件<br>            　　　　　　<a href="https://github.com/weui/weui" target="_blank">https://github.com/weui/weui</a><br>            　　　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093542631-410913742.png" alt=""><br>　　　基础引入：<br>        　　　　CDN：
```python
<link rel="stylesheet" href="https://res.wx.qq.com/open/libs/weui/1.1.2/weui.min.css">
<script type="text/javascript" src="https://res.wx.qq.com/open/libs/weuijs/1.1.3/weui.min.js"></script>
```
 　　　　npm：<br>            　　　　　　npm install --save weui
&nbsp;
### YDUI Touch
    　　官网：<a href="http://www.ydui.org/" target="_blank">http://www.ydui.org/</a><br>    　　描述：一只注重审美，且性能高效的移动端&amp;微信UI。<br>    　　基于jQuery<br>    　　兼容性：<br>        　　　　兼容绝大多数移动端设备（兼容Android4.0+、IOS6.0+）；<br>        　　采用 flexbox 布局，因低版本安卓及部分特殊浏览器不兼容flex-basis、flex-wrap、inline-flex属性，YDUI 将采取其他解决方案；<br>    　　基础引入：<br>        　　　　download：<br>            　　　　　　引入YDUI样式：ydui.css<br>            　　　　　　引入YDUI自适应解决方案类库：ydui.flexible.js<br>            　　　　　　引入jQuery2.0+<br>            　　　　　　引入YDUI脚本：ydui.js<br>    　　组件库：<br>        　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093608318-58007497.png" alt=""><br>    　　预览：
　　　　 <a href="http://m.ydui.org" target="_blank">http://m.ydui.org</a><br>            　　　　&nbsp;<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093623818-343053843.png" alt=""><br>    　　GitHub地址：<a href="https://github.com/ydcss/ydui" target="_blank">https://github.com/ydcss/ydui</a><br>    　　star：420，fork：117<br>    　　latest commit 2017.10.23 2pm<br>    　　1 contributors<br>    　　个人观点：自定义keyBoard插件为亮点
&nbsp;
### GMU（百度GMU小组开发）
　　描述：基于zepto的轻量级mobile UI组件库，符合jquery ui使用规范，提供webapp、pad端简单易用的UI组件。<br>    兼容iOS3+ / android2.1+，支持国内主流移动端浏览器，如safari, chrome, UC, qq等。<br>　　GitHub地址：<a href="https://github.com/fex-team/GMU" target="_blank">https://github.com/fex-team/GMU</a><br>    　　star:1106,fork:461<br>　　latest commit 2017.4.18 2pm<br>    　　8 contributors<br>    　　基础引入：<br>        　　　　download<br>            　　　　　　引入reset.css：https://github.com/fex-team/GMU/blob/master/dist/reset.css<br>            　　　　　　引入gmu.css：https://github.com/fex-team/GMU/blob/master/dist/gmu.css<br>            　　　　　　引入zepto.js：https://github.com/fex-team/GMU/blob/master/dist/zepto.js<br>            　　　　　　引入gmu.js：https://github.com/fex-team/GMU/blob/master/dist/gmu.js
&nbsp;
### FrozenUI（QQVIP  FD团队• Alloyteam团队） 
　　官方地址：<a href="http://frozenui.github.io/" target="_blank">http://frozenui.github.io/</a><br>　　描述：简单易用，轻量快捷，为移动端服务的前端框架。基于手Q样式规范。应用在腾讯手Q增值业务。<br>    兼容android 2.3 +，ios 4.0 + 。<br>    　　GitHub地址：<a href="https://github.com/frozenui/frozenui" target="_blank">https://github.com/frozenui/frozenui</a><br>    　　star：2330，fork：645<br>    　　latest commit 2017.11.30<br>    　　7 contributors<br>    　　观点：JS组件库相对简洁<br><br>移动优先
### Foundation
    　　中文官网：<a href="http://www.foundcss.com/" target="_blank">http://www.foundcss.com/</a><br>　　描述：Foundation是国外最流行的 HTML、CSS 和 JS 框架，用于开发响应式布局、移动设备优先的 WEB 项目。<br>    　　GitHub地址：<a href="https://github.com/zurb/foundation-sites" target="_blank">https://github.com/zurb/foundation-sites</a><br>    　　star：26751，fork：5751<br>    　　latest commit 2017.10.5 7am<br>    　　955 contributors<br>    　　基础引入：　　<br>        　　　　CDN:
```python
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/css/foundation.min.css" integrity="sha256-itWEYdFWzZPBG78bJOOiQIn06QCgN/F0wMDcC4nOhxY=" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.4.3/js/foundation.min.js" integrity="sha256-Nd2xznOkrE9HkrAMi4xWy/hXkQraXioBg9iYsBrcFrs=" crossorigin="anonymous"></script>
```
　　观点：无很多中文官方文档，不便于中国开发者
&nbsp;
### Amaze UI
 　　官方地址：<a href="http://amazeui.org/" target="_blank">http://amazeui.org/</a><br>　　描述：中国首个开源 HTML5 跨屏前端框架。Amaze UI 关注中文排版，根据用户代理调整字体，<br>    实现更好的中文排版效果。<br>    　　基于jQuery<br>    　　GitHub：<a href="https://github.com/amazeui/amazeui" target="_blank">https://github.com/amazeui/amazeui</a><br>    　　star:10949,fork:2397<br>    　　latest commit 2017.3.4 8pm<br>    　　24 contributors<br>    　　组件库：<br>        　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093704584-80548608.png" alt=""><br>    　　基础引入：<br>        　　　　CDN:
```python
http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css
http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css
http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.js
http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.min.js
http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.js
http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.min.js
http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.js
http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.min.js
```
　　观点：适合PC端更多(例如分页的实现)
### Pure
　　中文官网：<a href="https://www.purecss.cn/" target="_blank">https://www.purecss.cn/</a><br>    　　描述：纯CSS<br>　　美国雅虎公司出品的一组轻量级、响应式纯css模块，适用于任何Web项目。<br>    　　GitHub：<a href="https://github.com/yahoo/pure/" target="_blank">https://github.com/yahoo/pure/</a><br>    　　star：17880，fork：1969<br>    　　latest commit 2017.11.26 10pm<br>    　　51 contributors<br>    　　基础引入：<br>        　　　　CDN:
```python
<link rel="stylesheet" href="https://unpkg.com/purecss@0.6.1/build/pure-min.css" integrity="sha384-CCTZv2q9I9m3UOxRLaJneXrrqKwUNOzZ6NGEUMwHtShDJ+nCoiXJCAgi05KfkLGY" crossorigin="anonymous">
```
## <br>PC 端 UI框架
### iView
 　　官网地址：<a href="https://www.iviewui.com/" target="_blank">https://www.iviewui.com/</a><br>    　　描述：一套基于 Vue.js 的高质量 UI 组件库。iView 是一套基于 Vue.js 的开源 UI 组件库，主要服务于 PC 界面的中后台产品。<br>    　　GitHub地址：<a href="https://github.com/iview/iview" target="_blank">https://github.com/iview/iview</a><br>    　　star：11421，fork：1745<br>    　　latest commit 2017.12.4 11am<br>    　　组件库：<br>        　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093727849-969816799.png" alt=""><br>    　　基础引入：<br>        　　　　CDN：
```python
<!-- import Vue.js -->
<script src="//vuejs.org/js/vue.min.js"></script>
<!-- import stylesheet -->
<link rel="stylesheet" href="//unpkg.com/iview/dist/styles/iview.css">
<!-- import iView -->
<script src="//unpkg.com/iview/dist/iview.min.js"></script>
```
 　　　　npm：<br>            　　　　　　npm install iview --save
&nbsp;
### Element UI（饿了么团队）
　　官方地址：<a href="http://element-cn.eleme.io/#/zh-CN" target="_blank">http://element-cn.eleme.io/#/zh-CN</a><br>　　描述：基于 Vue 2.0 的桌面端组件库<br>　　GitHub：<a href="https://github.com/ElemeFE/element" target="_blank">https://github.com/ElemeFE/element</a><br>　　star：20657，fork：3777<br>　　latest commit 2017.12.5 11am<br>　　254 contributors<br>　　组件库：<br>　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093746396-881886483.png" alt=""><br>　　基础引入：<br>　　　　CDN:
```python
<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
```
　　　　npm：<br>　　　　　　npm i element-ui -S
&nbsp;
### SUI（阿里巴巴国际UED团队-商家业务事业部）
        　　官网地址：<a href="http://sui.taobao.org/" target="_blank">http://sui.taobao.org/</a><br>　　描述：一套基于bootstrap开发的前端组件库，同时她也是一套设计规范。<br>        　　基于jquery<br>        　　组件库：<br>            　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093804662-1834176655.png" alt=""><br>        　　GitHub：<a href="https://github.com/sdc-alibaba/sui" target="_blank">https://github.com/sdc-alibaba/sui</a><br>        　　star：322，fork：135<br>        　　latest commit 2015.7.23 3pm<br>        　　4 contributors<br>        　　基础引入：<br>            　　　　CDN:
```python
<link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
<script type="text/javascript" src="http://g.alicdn.com/sj/lib/jquery/dist/jquery.min.js"></script>
<script type="text/javascript" src="http://g.alicdn.com/sj/dpl/1.5.1/js/sui.min.js"></script>
```
　　观点：偏向设计规范，组件库相对简单。
&nbsp;
### H-ui
 　　官方地址：<a href="http://www.h-ui.net/" target="_blank">http://www.h-ui.net/</a><br>　　描述：轻量级前端框架，简单免费，兼容性好，服务中国网站。<br>    　　基于jQuery<br>    　　GitHub地址：<a href="https://github.com/jackying/h-ui" target="_blank">https://github.com/jackying/h-ui</a><br>        　　star：432，fork：196<br>        　　latest commit 2017.11.16 3pm<br>        　　1 contributors<br>        　　组件库：<br>            　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093823209-727974237.png" alt=""><br>    　　观点：无亮点,借鉴第三方插件完成
### <br>layui
    　　官方地址：<a href="http://www.layui.com/" target="_blank">http://www.layui.com/</a><br>　　描述：更多是为服务端程序员量身定做，你无需涉足各种前端工具的复杂配置，只需面对浏览器本身，<br>    让一切你所需要的元素与交互，从这里信手拈来。<br>    　　layui 兼容人类正在使用的全部浏览器（IE6/7除外），可作为 PC 端后台系统与前台界面的速成开发方案。<br>    经典模块化前端框架<br>    　　组件库：<br>        　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211093847443-1388642604.png" alt=""><br>    　　GitHub：<a href="https://github.com/sentsin/layui/" target="_blank">https://github.com/sentsin/layui/</a><br>    　　star:10278,fork:2909<br>    　　latest commit 2017.12.7 9pm<br>    　　11 contributors<br>    　　基础引入：<br>        　　　　layui.css<br>        　　　　layui.js
&nbsp;
### uiKit（YOOtheme 团队）
　　官网地址：<a href="http://www.getuikit.net/" target="_blank">http://www.getuikit.net/</a><br>　　描述：一款轻量级、模块化的前端框架，可快速构建强大的web前端界面。<br>    UIkit 兼容 IE9 以上现代浏览器。在 IE8 及其以下版本中，所有JavaScript 都会失效。<br>    　　依赖jQuery<br>    　　组件库：<br>        　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211094020177-175512814.png" alt=""><br>    　　GitHub地址：<a href="https://github.com/uikit/uikit" target="_blank">https://github.com/uikit/uikit</a><br>    　　star：11146，fork：1811<br>    　　latest commit 2017.12.8 4pm<br>    　　21 contributors<br>    　　基础引入：<br>        　　　　CDN:
```python
<link rel="stylesheet" href="//cdn.bootcss.com/uikit/2.25.0/css/uikit.css" />
<script src="//cdn.bootcss.com/uikit/2.25.0/js/uikit.js"></script>
```
&nbsp;
### Bootstrap
 　　中文官网：<a href="http://www.bootcss.com/" target="_blank">http://www.bootcss.com/</a><br>　　描述：简洁、直观、强悍的前端开发框架，让web开发更迅速、简单。<br>    　　组件库<br>        　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211094108584-383432937.png" alt=""><br>    　　GitHub地址：<a href="https://github.com/twbs/bootstrap" target="_blank">https://github.com/twbs/bootstrap</a><br>    　　star：118971，fork：56198<br>    　　latest commit 2017.12.8 2pm<br>    　　958contributors<br>    　　基础引入：<br>        　　　　CDN：
```python
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
```
 　　　　npm:<br>            　　　　　　npm install bootstrap@3<br>    　　其他基于bootstrap衍生出来的模块：<br>    　　　　Ace Admin后台管理系统模板：基于bootstrap3；<a href="http://ace.jeka.by/" target="_blank">http://ace.jeka.by/</a><br>    　　　　Metronic后台管理模板：<a href="http://www.metronic.com/" target="_blank">http://www.metronic.com/</a><br>    　　　　H+:<a href="http://www.zi-han.net/theme/hplus/" target="_blank">http://www.zi-han.net/theme/hplus/</a><br>    　　　　jQuery UI+Bootstrap：<a href="https://github.com/jquery-ui-bootstrap/jquery-ui-bootstrap/" target="_blank">https://github.com/jquery-ui-bootstrap/jquery-ui-bootstrap/</a>
　　　　更多：<a href="http://www.cssmoban.com/cssthemes/houtaimoban/" target="_blank">http://www.cssmoban.com/cssthemes/houtaimoban/</a>
### <br>jQuery UI
    　　官方网址：<a href="http://jqueryui.com/" target="_blank">http://jqueryui.com/</a><br>    　　组件库：<br>        　　　　<img src="https://images2017.cnblogs.com/blog/1141454/201712/1141454-20171211094154037-1329993551.png" alt=""><br>    　　其他基于jQuery衍生出来的模板：<br>        　　　　BUI：基于jQuery+KISSY UI:<a href="http://www.builive.com/" target="_blank">http://www.builive.com/</a><br>        　　　　EasyUI:：<a href="http://www.jeasyui.net/" target="_blank">http://www.jeasyui.net/</a><br>        　　　　　　描述：使用easyui你不需要写很多代码，你只需要通过编写一些简单HTML标记，就可以定义用户界面。<br>        　　　　DWZ JUI:<a href="http://jui.org/" target="_blank">http://jui.org/</a>
## <br>混合开发 UI框架
### ionic
    　　中文官网网址：<a href="http://www.ionic-china.com/" target="_blank">http://www.ionic-china.com/</a>
　　基于angular<br>　　描述：ionic是一个强大的 HTML5应用程序开发框架(HTML5 Hybrid Mobile App Framework)。<br>    ionic 主要关注外观和体验，以及和你的应用程序的 UI 交互，特别适合用于基于 Hybird 模式的 HTML5 移动应用程序开发。<br>    ionic是一个轻量的手机UI库，具有速度快，界面现代化、美观等特点。
### <br>Framework7
    　　官网地址：<a href="http://framework7.cn/" target="_blank">http://framework7.cn/</a><br>　　描述：Framework7 是一个开源免费的框架可以用来开发混合移动应用（原生和HTML混合）或者开发 iOS &amp; Android 风格的WEB APP。<br>    　　也可以用来作为原型开发工具，可以迅速创建一个应用的原型。<br>    　　她只专注于为 iOS 和 Google Material 设计提供最好的体验。<br>    　　GitHub：<a href="https://github.com/framework7io/framework7" target="_blank">https://github.com/framework7io/framework7</a><br>    　　star：11304，fork：2439<br>    　　latest commit2017.11.7 5pm<br>    　　77 contributors
### <br>OnsenUI
    　　官网地址：<a href="https://onsen.io/" target="_blank">https://onsen.io/</a><br>    　　描述：用来构建混合移动端APP的 HTML5 UI 框架<br>    　　GitHub地址：<a href="https://github.com/OnsenUI/OnsenUI" target="_blank">https://github.com/OnsenUI/OnsenUI</a><br>    　　star：5706，fork：716<br>    　　latest commit 2017.11.30 6pm<br>    　　83 contributors
&nbsp;
## APP 框架（拓展）
### react-native
    　　中文官网地址：<a href="http://reactnative.cn/" target="_blank">http://reactnative.cn/</a><br>    　　描述：React Native使你能够在Javascript和React的基础上获得完全一致的开发体验，构建世界一流的原生APP。<br>    React Native着力于提高多平台开发的开发效率 —— 仅需学习一次，编写任何平台。(Learn once, write anywhere)<br>    　　GitHub地址：<a href="https://github.com/facebook/react-native" target="_blank">https://github.com/facebook/react-native</a><br>    　　star：56938，fork：13206<br>    　　1544contributors
###  weex 
    　　官网地址：<a href="http://weex.apache.org/cn/" target="_blank">http://weex.apache.org/cn/</a><br>　　描述：Weex 提供强大的跨平台能力，可以使用相同的 API 开发 Web，Android 和 iOS 应用。<br>    同时，我们对接口了丰富的扩展能力。
#### &nbsp;
### 更多
更多基于vue的UI框架：<br>    　　<a href="https://www.awesomes.cn/subject/vue#Dom-%E6%A1%86%E6%9E%B6" target="_blank">https://www.awesomes.cn/subject/vue#Dom-%E6%A1%86%E6%9E%B6</a><br>更多基于bootstrap的UI框架：<br>    　　<a href="https://www.awesomes.cn/subject/bootstrap#Dom-%E6%A1%86%E6%9E%B6" target="_blank">https://www.awesomes.cn/subject/bootstrap#Dom-%E6%A1%86%E6%9E%B6</a><br>更多基于React的UI框架：<br>    　　<a href="https://www.awesomes.cn/subject/react#Dom-%E6%A1%86%E6%9E%B6" target="_blank">https://www.awesomes.cn/subject/react#Dom-%E6%A1%86%E6%9E%B6</a><br>更多基于Angular的UI框架：<br>    　　<a href="https://www.awesomes.cn/subject/angular#Dom-%E6%A1%86%E6%9E%B6" target="_blank">https://www.awesomes.cn/subject/angular#Dom-%E6%A1%86%E6%9E%B6</a>
### <br>结束语
　　关于混合APP和APP开发方面，小弟没有很多的经验，只是进行了粗略的了解。以上就是汇总到的一些关于移动端UI框架、PC端及混合APP开发UI框架方面的资料。当然，当今前端飞速发展，关于UI框架方面的很多都没有总结和汇总到，希望小伙伴们有了解到的可以留言喔。
<br><br><br>