**一、前言**
　　在目前的**移动应用开发**大潮下，使用**web技术**进行移动应用开发正变得越来越流行，它主要使用**html5、css3、js**等技术，在**跨平台性、可移植性**方面具有无可比拟的优势，特别适合开发**对性能要求不太高、项目不太庞大**的应用。这对于有过**web经验**及**刚入门移动应用**的同学来说，绝对是福音。
　　接下来的几篇文章主要介绍使用web技术进行移动应用开发时，应遵循的一些‘**最佳实践**’。这里所说的最佳实践其实就是一些**建议**，它可以让你的程序更加**高效**，涉及到代码风格、标准等，例如缩进、空格、行宽、命名、代码样式、变量声明和使用……随着开发经验的丰富，我会逐步更新这些文章。
　　使用‘**最佳实践**’的好处：
<ol>
- 提高性能（使用更少的CPU和带宽）
- 提高跨浏览器的兼容性
- 提高代码的可维护性（这对于较大的项目和团队尤其重要）
- 提高代码可读性，以利于日后的审查和重构
- 有利于自动化任务实施，如构建脚本，自动化测试
- 更容易调试，节省时间，减少成本
</ol>
**二、html概述**
　　html即**超文本标记语言**（Hyper Text Markup Language），它并不是一种编程语言，而是使用一套**标记标签**来描述网页。它的主要功能是**展现网页内容**。
　　在经历了几代的标准的进化后，**html5**是目前的最新标准，而且正往这个方向大力推进。下面几个章节中，将重点介绍使用html过程中的最佳实践方案。这里主要参考了**黑莓10的开发指南**和**W3C标准**。
**三、从模板开始**
　　这个，做很多事情都是差不多的。把自己常用的代码片段保存为一个**模板**，随时调用，不仅**节省时间**而且能**加快开发进度**。写**重复的代码**是没有意义的，因此当你创建了一个可以重用的**基本结构**时，就把它保存下来，供日后复用，这样你的效率就越来越高。一个html模板应该包括**web页面的典型元素**。比如：
```python
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, 
            initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, 
            user-scalable=no">
        <title>Heading</title>
        <link href="favicon.ico" rel="icon" type="image/x-icon">
        <link rel="stylesheet" href="css/app.css">
        <style type="text/css">
        </style>
    </head>
    <body>
        <h1>Heading</h1>
        <p>The quick brown fox jumps over the lazy dog.</p>
        <script src="js/app.js"></script>
    </body>
</html>
```
这个模板中，有几个注意点：
<ol>
- 这个应用会设置为全屏显示，因为它包含了以下meta标签：
```python
initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0
```

- Zooming函数被关闭了，因为设置了：
```python
user-scalable=no
```

- 为了提高性能，js脚本部分被放在了body元素的底部，关于这点会在以后的js篇中介绍。
</ol>
**四、指定文档类型（document type）**
　　文档开头的 **DOCTYPE** 声明位于文档中的最前面的位置，处于<html>标签之前。它会告诉浏览器**书写文档的html版本**，这会影响到浏览器对**内容的渲染**。还有就是当你进行<a href="http://validator.w3.org/">html标准校验</a>时，校验器也会根据这个 DOCTYPE 来选择相应的html版本，以确定所写代码是否符合规范。
　　如果你没有包括 DOCTYPE 的声明，那么不同的浏览器就可能出现**不同的渲染结果**。使用这个声明会要求浏览器使用**相应的标准**来解析页面内容。
　　<img alt="">h5是目前的标准，包含了大量的**新特性**，声明是很简单的：
```python
<!DOCTYPE html>
```
　　对于一些**较老**的设备和浏览器，可能需要声明为其他的类型(HTML 4.01 Strict or XHTML 1.0 Strict)：
```python
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "
http://www.w3.org/TR/html4/strict.dtd">
```
```python
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
```
**五、把程序设计为离线下仍然可以使用**
　　能**随时随地**地使用手机设备上应用程序的需求正越来越强，即使在**离线**状况下。对于web应用，你可以使用h5的**缓存功能**<a class="external" href="http://www.whatwg.org/specs/web-apps/current-work/#offline" target="_blank">W3C&nbsp;HTML5 application cache</a>来：
<ol>
- 离线下仍然可以使用
- 把资源缓存在本地以提高速度
- 仅下载更新的或改变的资源以减少加载次数和数据使用
</ol>
　　程序缓存（即**AppCache**）可以让你指定缓存的文件，这样即使离线仍然可以访问。当然你还可以利用开发平台提供的**API**来获取**本地存取文件**的权限。
　　1.创建一个缓存清单（manifest）
　　　　为了使用AppCache，你的web应用必须为浏览器提供一个"**manifest**"，这个清单要列举出在离线情况下你的应用**需要的所有资源**。页面第一次加载后，"manifest"中列举的资源就会从程序缓存中加载，而不是web服务器。"manifest"其实就是一个以**".appcache"**为后缀的**文本文件**（配置文件）。例如：
```python
CACHE MANIFEST
# 2012-03-08:v1
 
# Explicitly cached resources
index.html
css/app.css
js/app.js
 
# offline.html displays if the user is offline
FALLBACK:
/ /offline.html
 
# All other resources require an online connection
NETWORK:
*
 
# Additional cached resources
CACHE:
img/logo.png
```
　　　　你的manifest文件的**mime-type**必须是"**text/cache-manifest**"，因此你需要在web服务器添加一行配置。例如，在Apache的**httpd.conf**文件添加一行：
```python
AddType text/cache-manifest .appcache
```
　　　　为了访问manifest文件，你必须在html文档中**声明**（通过添加html标记的manifest属性，如下），manifest属性指向相应的manifest文件。如果你的应用有**多个页面**，那么**每个页面都要**包含manifest属性，否则这些页面就不会成为AppCache，离线下也就不会工作了。
```python
<html manifest="html5.appcache">
```
　　2.更新appcache
　　　　一旦你的应用被缓存了，它会一直被缓存**直到满足**以下任何一个条件：

- 用户清除了缓存
- manifest文件被改变了。注意：更新服务器上的资源不会触发缓存的更新，你必须修改manifest文件本身
- 程序的缓存被程序自动更新了

　　3.相关资源

- <a class="external" href="http://www.whatwg.org/specs/web-apps/current-work/multipage/offline.html" target="_blank">ApplicationCache API specification</a>
- <a class="external" href="http://www.alistapart.com/articles/application-cache-is-a-douchebag/" target="_blank">Article from A List Apart Magazine</a>
- <a class="external" href="https://developer.blackberry.com/html5/apis/applicationcache.html" target="_blank">BlackBerry WebWorks&nbsp;API reference</a>

**六、使用正确的viewport语法**
　　**viewpoint**是用户在手机设备上可以看到的矩形区域。你可以再**meta**标记中重写viewpoint。但是记住，viewpoint在meta标记中的语法和在CSS中的语法并不一样，你必须用逗号（**commas**）分隔不同的值，而不是分号（semicolons）。例如：
```python
<meta name="viewport" content="width=device-width, 
    initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
```
**七、创建一个站点的图标（icon）**
　　每一个浏览器都会把名为**favicon.ico**的文件作为该站点的**icon**。比如你经常会在地址栏、tab栏、书签栏或者收藏夹看见这些小图标：
<img src="https://images0.cnblogs.com/blog/198460/201301/12171817-0029b673820946149dcd8a13d387ed05.png" alt="">
　　浏览器在加载web页面时，也会发送一个获取favicon.ico的请求，如果没有这个文件，你会在服务器日志中看到**404**的错误。为了避免错误，也为了**页面的美观**，你应该在web应用中包含一个这样的文件。例如：
```python
<link href="favicon.ico" rel="icon" type="image/x-icon">
```
**八、使用外部文件**
　　使用外部的js和css文件有很多好处，最主要的好处是**让页面响应更快**，原因如下：

- 外部文件会被浏览器缓存，这会减少http请求次数，另外，内联的js和css会在每次加载主文档的时候被下载
- 减少主文档大小

　　当然，这并不是对每种情况都适用的，当满足如下两种情况时，就可以考虑将资源放在外部：

- 在多个html文档中都有用到
- 并不经常改变

　　关于使用外部文件，这里有一些建议：

- 把资源转移到一些知名的站点，这样可以减少DNS查询的次数
- 使用另一个域名的资源，对于特定的域名，浏览器有链接次数的限制，使用其他域名的资源，浏览器就可以并行地发送请求
- 对于常用的js库，使用CDN（Content Delivery Network）托管的文件。这样就可以减少延迟，提高缓存利用率和程序性能。例如使用google的CDN-hosted jQuery：
- 
```python
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js">
</script>
```

- 使用<a href="https://developer.blackberry.com/html5/documentation/web_inspector_overview_1553586_11.html">Web Inspector</a>分析web应用的性能。

**九、把css文件放在顶部**
　　另一种**提高页面加载速度**的办法是把css文件放在文档的顶部。把css文件放在**head节点**内，页面就会逐步渲染，这样就会**感觉加载速度变快**，而且能给用户提供**视觉上的反馈**。但是如果放在文档底部，浏览器就会**阻塞渲染过程**以**避免样式改变后的重绘过程**，用户在此时就会看到**白屏**。还有一种好处就是**提高并行化**，不像脚本，css并不需要同步处理。例如：
```python
<!DOCTYPE html>
<html>
    <head>
        ...        
        <link rel="stylesheet" href="styles1.css">
    </head>
    <body>
        ...
    </body>
</html>
```
**十、css中避免使用import**
　　在html文档中使用外部css文件时，要**避免使用&nbsp;**<samp class="codeph">**@import**规则，而是使用<**link**>标签。因为在一些浏览器中，它的效果就像是该css文件处在html文档底部一样，这会阻塞页面的加载。</samp><samp class="codeph"></samp><samp class="codeph"></samp>
```python
<!--Not recommended: Using @import-->
<style>
@import url("styles2.css");
</style>
```
```python
<!--Recommended: Using a LINK tag-->
<link rel="stylesheet" href="styles1.css">
```
　　另外，@import规则还可以嵌套到css文件里，这阻塞了css文件的并行加载，例如：如果style1.css包含了以下
```python
<!--Not recommended: Using @import-->
@import url(styles2.css)
```
**十一、把脚本放在底部**
　　尽管<a class="external" href="http://www.w3.org/TR/html4/interact/scripts.html#h-18.2.1" target="_blank">W3C&nbsp;spec</a>允许你可以把脚本放在**head或body的任意地方**，但是位置不同会影响到页面的渲染，因为浏览器会停下来执行js代码，而后面的内容渲染就会被阻塞。放在body底部就会有更多的内容被渲染，同样有利于并行下载，你还不必担心DOM是否加载完成，因为所有的东西都已经加载完了。
　　除非你使用**不赞成**使用的document.write来产生body元素，你的脚本通常都可以移到html文档的底部。
```python
<!--Recommended: Placing the script near the bottom of the BODY-->
<html lang="en">
    <body>
        ...
        <script src="js/app.js"></script>
    </body>
</html>
```
```python
<!--Not recommended: Placing the script in the HEAD-->
<html lang="en">
    <head>
        <script src="js/app.js"></script>
    </head>
    <body onload="init();">
        ...
    </body>
</html>
```
**十二、推迟脚本加载（defer）**
　　如果不想把脚本放在文档底部，可以使用**defer**属性**延迟脚本的加载**。该属性告诉浏览器在页面**加载完成后才执行脚本**。
```python
<script src="js/app.js" defer></script>
```
　　但是，defer属性在浏览器之间**表现并不一致**。为了避免跨浏览器的差异，可以使用&nbsp;"**lazy loading**"的方法，即**直到用到该脚本时才加载**。例如：
```python
function lazyload() {
    var elem = document.createElement("script");
    elem.type = "text/javascript";
    elem.async = true;
    elem.src = "app.js"; // contains more than 25 uncalled functions
    document.body.appendChild(elem);
}
 
if (window.addEventListener) {
    window.addEventListener("load", lazyload, false);
} else if (window.attachEvent) {
    window.attachEvent("onload", lazyload);
} else {
    window.onload = lazyload;<br>}
```
　　更多资源可参考：

- <a class="external" href="http://code.google.com/apis/analytics/docs/tracking/asyncUsageGuide.html" target="_blank">Google&nbsp;Analytics - Tracking Basics (Asynchronous Syntax)</a>
- <a class="external" href="http://microjs.com/#loader" target="_blank">Microjs</a>

&nbsp;