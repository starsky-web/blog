　　"字是门面书是屋"，我们不会去手写代码，但是敲出来的代码要好看、有条理，这还必须得有一点约束~
　　团队开发中，每个人的编码风格都不尽相同，有时候可能存在很大的差异，为了便于压缩组件对代码进行压缩以及书写样式的规范统一和美观，很有必要大家一起来研究一套基本规范（模板）！
　　我先抛砖引玉。**（禁止）、（必须）等字眼，在这里只是表示强调，未严格要求。**
&nbsp;
### 前端规范之CSS
**1. tab键用（必须）四个空格代替**
　　因为在不同系统的编辑工具对tab解析不一样，windows下的tab键是占四个空格的位置，而在linux下会变成占八个空格的位置（除非你自己设定了tab键所占的位置长度）。
　　一些童鞋可能会有疑问，tab键换成四个空格，多麻烦啊~
　　其实不然，我平时用sublime text比较多，在这个工具中可以对tab键进行设置。
<img src="https://images0.cnblogs.com/blog/387325/201308/09141737-747feb02ee5140f8956f9b70ce9f1aae.png" alt="">
　　选择Indent Using Spaces，Tab Width：4两项即可。
&nbsp;
**2. 每个样式属性后**（必须）**加 ";"**
方便压缩工具"断句"。
&nbsp;
**3. Class命名中（禁止）出现大写字母，（必须）采用” - “对class中的字母分隔，如：**
```python
 /* 正确的写法 */
 .hotel-title {
     font-weight: bold;
 }

 /* 不推荐的写法 */
 .hotelTitle {
     font-weight: bold;
 }
```

- 用"-"隔开比使用驼峰是更加清晰。
- 产品线-产品-模块-子模块，命名的时候也可以使用这种方式（@Artwl）

&nbsp;
**4. 空格的使用，以下规则（必须）执行：**
```python
 .hotel-content {
     font-weight: bold;
 }
```

- 选择器与&nbsp;`{&nbsp;`之前（`必须）`要有空格
- 属性名的&nbsp;`:&nbsp;`后（`必须）`要有空格
- 属性名的&nbsp;`:&nbsp;`前（`禁止）`加空格

一个原因是美观，其次IE 6存在一个bug， 戳<a href="http://www.cnblogs.com/hustskyking/articles/css-bug-in-IE6.html" target="_blank">bug</a>
&nbsp;
**5.多选择器规则之间（`必须）`换行**
当样式针对多个选择器时每个选择器占一行
```python
 /* 推荐的写法 */
 a.btn,
 input.btn,
 input[type="button"] {
     ......
 }
```
&nbsp;
**6. （`禁止）`将样式写为单行, 如**
```python
.hotel-content {margin: 10px; background-color: #efefef;}
```
单行显示不好注释，不好备注，这应该是压缩工具的活儿~
&nbsp;
**7. （`禁止）`向&nbsp;`0&nbsp;`后添加单位, 如：**
```python
.obj {
    left: 0px;
}
```
只是为了统一。记住，绿色字表强调，不表强制！
&nbsp;
**8. （`禁止）`使用css原生`import`**
使用css原生import有很多弊端，比如会增加请求数等....
**推荐文章**：<a href="http://www.stevesouders.com/blog/2009/04/09/dont-use-import/" target="_blank">Don't use @import</a>
&nbsp;
**9. （`推荐）`属性的书写顺序, 举个例子:**
```python
.hotel-content {
     /* 定位 */
     display: block;
     position: absolute;
     left: 0;
     top: 0;
     /* 盒模型 */
     width: 50px;
     height: 50px;
     margin: 10px;
     border: 1px solid black;
     / *其他* /
     color: #efefef;
 }
```

- 定位相关, 常见的有：`display`&nbsp;`position`&nbsp;`left`&nbsp;`top`&nbsp;`float`&nbsp;等
- 盒模型相关, 常见的有：`width`&nbsp;`height`&nbsp;`margin`&nbsp;`padding`&nbsp;`border`&nbsp;等
- 其他属性

&nbsp;　 &nbsp;按照这样的顺序书写可见提升浏览器渲染dom的性能
　　简单举个例子，网页中的图片，如果没有设置width和height，在图片载入之前，他所占的空间为0，但是当他加载完毕之后，那块为0的空间突然被撑开了，这样会导致，他下面的元素重新排列和渲染，造成重绘（repaint）和回流（reflow）。我们在写css的时候，把元素的定位放在前头，首先让浏览器知道该元素是在文本流内还是外，具体在页面的哪个部位，接着让浏览器知道他们的宽度和高度，border等这些占用空间的属性，其他的属性都是在这个固定的区域内渲染的，差不多就是这个意思吧~(@frec)
**&nbsp;推荐文章**：<a href="http://css-tricks.com/poll-results-how-do-you-order-your-css-properties/" target="_blank">Poll Results: How do you order your CSS properties?</a>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://www.mozilla.org/css/base/content.css" target="_blank">http://www.mozilla.org/css/base/content.css</a>
&nbsp;
**10. 小图片（必须）sprite 合并**
**推荐文章**：<a class="blogTitle btitle" title="NodeJs智能合并CSS精灵图工具iSpriter" href="http://www.alloyteam.com/2012/09/update-ispriter-smart-merging-css-sprite/" rel="bookmark" target="_blank">NodeJs智能合并CSS精灵图工具iSpriter</a>
&nbsp;
**11. （`推荐）`当编写针对特定html结构的样式时，使用`元素名`&nbsp;+&nbsp;`类名`**
```python
/* 所有的nav都是针对ul编写的 */
 ul.nav {
     ......
 }
```
".a div"和".a div.b"，为什么后者好？如果需求有所变化，在".a"下有多加了一个div，试问，开始的样式是不是会影响后来的div啊~
&nbsp;
**12. （推荐）IE Hack List**
```python
 /* 针对ie的hack */
 selector {
     property: value;     /* 所有浏览器 */ 
     property: value\9;   /* 所有IE浏览器 */ 
     property: value\0;   /* IE8 */
     +property: value;    /* IE7 */
     _property: value;    /* IE6 */
     *property: value;    /* IE6-7 */
 }
```
当使用hack的时候想想能不能用更好的样式代替
&nbsp;
**13. （`不推荐）`ie使用`filter`,（&nbsp;`禁止）`使用`expression`**
这里主要是效率问题，应该当格外注意，咱们要少用烧CPU的东西~&nbsp;
&nbsp;
**14. （禁止）使用行内（inline）样式**
```python
<p style="font-size: 12px; color: #FFFFFF">靖鸣君</p>
```
像这样的行内样式，最好用一个class代替。又如要隐藏某个元素，可以给他加一个class
```python
.hide {
    display: none;
}
```
尽量做到样式和结构分离~
&nbsp;
**15. （推荐）reset.css样式**
**推荐网站：<a href="http://www.cssreset.com/" target="_blank">http://www.cssreset.com/</a>**
&nbsp;
**16.（禁止）使用"*"来选择元素**
```python
/*别这样写*/
* {
    margin: 0;
    padding: 0;
}
```
这样写是没有必要的，一些元素在浏览器中默认有margin或padding值，但是只是部分元素，没有必要将所有元素的margin、padding值都置为0。
&nbsp;
**17. 链接的样式，（务必）按照这个顺序来书写**
```python
a:link -> a:visited -> a:hover -> a:active
```
&nbsp;
**18. 等你补充...**&nbsp;
&nbsp;
### 应该说在前面的话

- 对于不同的团队、不同的需求，编码规范上有一些差异，这个很正常。
- 最后上线的代码肯定不是上述遵从规范的，上线的代码都会经过打包和压缩。
- 不同的人有不同的编码风格，当你是一个人作战的时候，你可以不用考虑这些，但是如果是团队开发，有一个规范还是很有指导价值的~

&nbsp;
　　这些规范是在团队开发过程中，集思广益总结出来的，不是很全面，**如果你有好的建议，请提出来，我们一起打造一个良好的前端生态环境！**
　　后面我会陆续把HTML、JavaScript和LESS等规范罗列出来，大家共同进步！！！
&nbsp;
**相关阅读：**<a href="http://www.cnblogs.com/hustskyking/p/javascript-spec.html" target="_blank">前端编码规范之JavaScript</a>
&nbsp;&nbsp;