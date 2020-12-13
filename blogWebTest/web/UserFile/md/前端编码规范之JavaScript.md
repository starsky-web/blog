　　上次浅谈了下<a href="http://www.cnblogs.com/hustskyking/p/css-spec.html" target="_blank">关于CSS的编码规范</a>，大部分童鞋持赞同意见，仍存在一些童鞋不太理解这些规范的意义。
　　如果是个人或者小作坊开发，其实这些所谓的编码规范也没啥意思，因为大家写好的代码直接就给扔到网上去了，很少有打包、压缩、校检等过程，别人来修改你代码的情况也比较少。但是，对于一定规模的团队来说，这些东西还是挺有必要的！**一个是保持代码的整洁美观，同时良好的代码编写格式和注释方式可以让后来者很快地了解你代码的大概思路，提高开发效率。**
　　那么这次，继续**抛砖引玉**，说说Javascript一些需要引起注意的地方（这些东西也是团队开发的时候大家集思广益总结出来的）。
### 不规范写法举例
**1.&nbsp;句尾没有分号**
```python
var isHotel = json.type == "hotel" ? true : false
```
**2.&nbsp;变量命名各种各样**
```python
var is_hotel;
var isHotel;
var ishotel;
```
**3.&nbsp;if 缩写**
```python
if (isHotel)
    console.log(true)
else
    console.log(false)
```
**4.&nbsp;使用 eval**
```python
var json = eval(jsonText);
```
**5.&nbsp;变量未定义到处都是**
```python
function() {
    var isHotel = 'true';
    .......

    var html = isHotel ? '<p>hotel</p>' : "";
}
```
**6.&nbsp;超长函数**
```python
function() {
    var isHotel = 'true';
    //....... 此处省略500行
    return false;
}
```
**7.&nbsp;..........**
&nbsp;
书写不规范的代码让我们难以维护，有时候也让我们头疼。
&nbsp;
**（禁止）、（必须）等字眼，在这里只是表示强调，未严格要求。**
### 前端规范之JavaScript
**&nbsp;1.&nbsp;tab键用（必须）用四个空格代替**
这个原因已经在<a href="http://www.cnblogs.com/hustskyking/p/css-spec.html" target="_blank">前端编码规范之CSS</a>说过了，不再赘述。
&nbsp;
**2. 每句代码后（必须）加";"**
&nbsp;这个是要引起注意的，比如：
```python
a = b        // 赋值
(function(){
    //....
})()         // 自执行函数
```
&nbsp;未加分号，结果被解析成
```python
a = b(function(){//...})()  //将b()()返回的结果赋值给a
```
&nbsp;这是截然不同的两个结果，所以对于这个问题必须引起重视！！！
&nbsp;
**3.&nbsp;变量、常量、类的命名按（必须）以下规则执行：**
　　**1）&nbsp;变量：`必须`采用`骆驼峰`的命名且首字母小写**
```python
 // 正确的命名
  var isHotel,
      isHotelBeijing,
      isHotelBeijingHandian;

  // 不推荐的命名
  var is_Hotel,
      ishotelbeijing,
      IsHotelBeiJing;
```
　　**2）&nbsp;常量：`必须`采用全大写的命名，且单词以`_`分割**，常量通常用于ajax请求url，和一些不会改变的数据
```python
// 正确的命名
  var HOTEL_GET_URL = 'http://map.baidu.com/detail',
      PLACE_TYPE = 'hotel';
```
　　**3）&nbsp;类：`必须`采用`骆驼峰`的命名且首字母大写**，如：
```python
 // 正确的写法
  var FooAndToo = function(name) {
      this.name = name;
  }
```
&nbsp;
**4.&nbsp;空格的使用**
**　　1）`if`中的空格，先上例子**
```python
 //正确的写法
  if (isOk) {
      console.log("ok");
  }

  //不推荐的写法
  if(isOk){
      console.log("ok");
  }
```

- `()`中的判断条件前后都(`必须)`加空格
- `()`里的判断前后(`禁止)`加空格，如：正确的写法:&nbsp;`if (isOk)`；不推荐的写法:&nbsp;`if ( isOk )`

**　　2）`switch`中的空格, 先上例子**
```python
//正确的写法
  switch(name) {
      case "hotel":
          console.log(name);
          break;

      case "moive":
          console.log(name);
          break;

      default:
          // code
  }

  //不推荐的写法
  switch (name) {                     // switch 后不应该有空格, 正确的写法: switch(name) { // code
      case "hotel":
          console.log(name);
      break;                          // break; 应该和console.log对齐
      case "movie":                   // 每个case之前需要有换行
          console.log(name);
      break;                          // break; 应该和console.log对齐

      default:
          // code
  }
```
&nbsp;　　**3）`for`中的空格，先上例子**
```python
 // 正确的写法
  var names = ["hotel", "movie"],
      i, len;

  for (i=0, len=names.length; i < len; i++) {
      // code
  }

  // 不推荐的写法
  var names = ["hotel", "movie"],
      i, len;

  for(i = 0, len = names.length;i < len;i++) {          // for后应该有空格，每个`;`号后需要有空格，变量的赋值不应该有空格
      // code
  }
```

- **`for`**后**（`必须）`**加空格
- 每个`;`后**（`必须）`**加空格
- **`()`**中`禁止`用**`var`**声明变量; 且变量的赋值&nbsp;**`=&nbsp;`**前后**（`禁止）`**加空格

**　　4）`function`&nbsp;中的空格, 先上例子**
```python
 // 正确的写法
  function call(name) {

  }

  var cell = function () {

  };

  // 不推荐的写法
  var call = function(name){ 
      // code
  }
```

- 参数的反括号后**（`必须）`**加空格
- **`function`&nbsp;**后**（`必须）`**加空格

**　　5）`var`&nbsp;中空格及定义，先上例子**
```python
 // 一个推荐的var写法组
  function(res) {
      var code = 1 + 1,
          json = JSON.parse(res),
          type, html;

      // code
  }
```

- 声明变量**&nbsp;**`**=**&nbsp;`前后**（`必须）`**添加空格
- 每个变量的赋值声明以`,`结束后**（`必须）`**换行进行下一个变量赋值声明
- **`（推荐）`**将所有不需要进行赋值的变量声明放置最后一行，且变量之间不需要换行
- **`（推荐）`**当一组变量声明完成后，空一行后编写其余代码

&nbsp;
**5.&nbsp;在同一个函数内部，局部变量的声明`必须`置于顶端**
因为即使放到中间，js解析器也会提升至顶部（hosting）
```python
 // 正确的书写
 var clear = function(el) {
     var id = el.id,
         name = el.getAttribute("data-name");

     .........
     return true;
 }

 // 不推荐的书写
 var clear = function(el) {
     var id = el.id;

     ......

     var name = el.getAttribute("data-name");

     .........
     return true;
 }
```
&nbsp;推荐阅读：<a href="http://www.adequatelygood.com/JavaScript-Scoping-and-Hoisting.html" target="_blank">JavaScript-Scoping-and-Hoisting</a>
&nbsp;
**6.&nbsp;块内函数`必须`用局部变量声明**
```python
// 错误的写法
 var call = function(name) {
     if (name == "hotel") {
         function foo() {
             console.log("hotel foo");
         }
     }

     foo &amp;&amp; foo();
 }

 // 推荐的写法
 var call = function(name) {
     var foo;

     if (name == "hotel") {
         foo = function() {
             console.log("hotel foo");
         }
     }

     foo &amp;&amp; foo();
 }
```
引起的bug：第一种写法`foo`的声明被提前了; 调用`call`时：第一种写法会调用`foo`函数，第二种写法不会调用`foo`函数
 注：不同浏览器解析不同，具体请移步汤姆大叔<a href="http://www.cnblogs.com/TomXu/archive/2012/01/30/2326372.html" target="_blank">深入解析Javascript函数篇</a> 
&nbsp;
**7. （`禁止）`使用eval，采取`$.parseJSON`**
**&nbsp;三个原因：**

- 有**注入**风险，尤其是ajax返回数据
- 不方便**debug**
- **效率低**，eval是一个执行效率很低的函数

**建议：**
　　使用**new Function**来代替eval的使用，最好就别用。
&nbsp;
**8.&nbsp;除了三目运算，`if`,`else`等（`禁止）`简写**
```python
 // 正确的书写
 if (true) {
     alert(name);
 }
 console.log(name);
 // 不推荐的书写
 if (true)
     alert(name);
 console.log(name);
 // 不推荐的书写
 if (true)
 alert(name);
 console.log(name)
```
&nbsp;
**9. （`推荐）`在需要以`{}`闭合的代码段前增加换行，如：`for`&nbsp;`if`**
```python
 // 没有换行，小的代码段无法区分
 if (wl &amp;&amp; wl.length) {
     for (i = 0, l = wl.length; i < l; ++i) {
         p = wl[i];
         type = Y.Lang.type(r[p]);
         if (s.hasOwnProperty(p)) {
             if (merge &amp;&amp; type == 'object') {
                 Y.mix(r[p], s[p]);
             } else if (ov || !(p in r)) {
                 r[p] = s[p];
             }
         }
     }
 }
 // 有了换行，逻辑清楚多了
 if (wl &amp;&amp; wl.length) {

     for (i = 0, l = wl.length; i < l; ++i) {
         p = wl[i];
         type = Y.Lang.type(r[p]);

         if (s.hasOwnProperty(p)) {
             // 处理merge逻辑
             if (merge &amp;&amp; type == 'object') {
                 Y.mix(r[p], s[p]);
             } else if (ov || !(p in r)) {
                 r[p] = s[p];
             }
         }
     }
 }
```
换行可以是空行，也可以是注释
&nbsp;
**10. （`推荐）`使用`Function`进行类的定义，(`不推荐)`继承，如需继承采用成熟的类库实现继承**
```python
// 类的实现
 function Person(name) {
     this.name = name;
 }

 Person.prototype.sayName = function() {
     alert(this.name);
 };

 var me = new Person("Nicholas");

 // 将this放到局部变量self
 function Persion(name, sex) {
     var self = this;

     self.name = name;
     self.sex = sex;
 }
```
&nbsp;平时咱们写代码，基本都是小程序，真心用不上什么继承，而且继承并不是JS的擅长的语言特性，尽量少用。如果非要使用的话，注意一点：
```python
function A(){
    //...
}
function B(){
    //...
}
B.prototype = new A();
B.prototype.constructor = B; **//原则上，记得把这句话加上**
```
&nbsp;继承从原则上来讲，别改变他的构造函数，否则这个继承就显得很别扭了~&nbsp;
&nbsp;
**11. (`推荐)`使用局部变量缓存反复查找的对象(包括但不限于全局变量、dom查询结果、作用域链较深的对象)**
```python
 // 缓存对象
 var getComment = function() {
     var dom = $("#common-container"),               // 缓存dom
         appendTo = $.appendTo,                      // 缓存全局变量
         data = this.json.data;                      // 缓存作用域链较深的对象

 }
```
&nbsp;&nbsp;
**12.&nbsp;当需要缓存`this`时必须使用`self`变量进行缓存**
```python
// 缓存this
 function Row(name) {
     var self = this;

     self.name = name;
     $(".row").click(function() {
         self.getName();
     });
 }
```
&nbsp;self是一个保留字，不过用它也没关系。在这里，看个人爱好吧，可以用**_this**, **that**, **me**等这些词，都行，但是团队开发的时候统一下比较好。
&nbsp;
**13. （`不推荐）`超长函数, 当函数超过100行，就要想想是否能将函数拆为两个或多个函数**
&nbsp;
**14. 等你来填坑~**
&nbsp;
### **小结**
　　规范是死的，罗列这些东西，目的是为了让程序猿们对这些东西引起注意，平时写代码的时候注意格式，不仅仅方便了自己，也让其他阅读者看得舒服。
　　可能还有一些点没有涉及到，<strong style="line-height: 1.5">如果你有好的建议，请提出来，我们一起打造一个良好的前端生态环境！**
&nbsp;
**相关阅读：**<a href="http://www.cnblogs.com/hustskyking/p/css-spec.html" target="_blank">前端编码规范之CSS</a>
&nbsp;&nbsp;