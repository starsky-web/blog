# 3、BOM对象

------



# BOM简介

功能：控制HTML文档的内容

代码：获取页面的标签（元素）对象Element

```javascript
document.getElenmentById("Id值");
```

操作Element对象：

1. 设置属性值：明确获取的对象是哪一个，查看文档，找哪个属性可以设置
2. 修改标签体内容：属性：innerHTML()

# 事件

功能：某些组件被执行了某些操作后，触发某些代码的执行

## 如何绑定事件

1、直接在HTML标签指定事件属性，属性值是js代码

	1、事件：onclick---单击事件

2、通过js获取元素对象，指定事件属性，设置一个函数

# 1、概述

browser object model 浏览器对象模型

将浏览器各个组成部分封装成对象

# 2、组成

window: 窗口对象

navigator： 浏览器对象

screen： 显示器对象

history： 历史记录对象

location： 地址栏对象

# 3、window弹出方法

## 1、创建

## 2、方法：

### 2.1、与弹出有关的方法

```javascript
alert();//弹警告框
confirm();//显示带有一段消息及确认按钮和取消按钮的对话框
//点确定返回true，点取消返回false
prompt();//显示可提示用户输入的对话框
//可以获取用户输入的值
```

### 2.2、与打开关闭有关的方法

```javascript
open();//打开浏览器窗口
//返回新的window对象
```



```javascript
close();//关闭浏览器窗口
//默认关当前窗口
```

可以接受新窗口的返回值，在通过新窗口调用close来关新窗口

### 2.3、定时器方法

```javascript
setTimeout()//指定的毫秒数后调用指定方法，只执行一次
clearTimeout()//取消setTimeout设置的定时器
setInterval()//按照指定的毫秒数来调用方法，可以循环执行
clearInterval()//取消上面设的定时器
```

使用

```javascript
setTimeout(js代码，毫秒值);
setInterval(js代码，毫秒值);
```





## 3、属性

### 3.1、获取其他BOM对象

​	history

​	location

​	Navicat

​	Screen

### 3.2、获取DOM对象

document

## 4、特点

​	window对象不需要创建，直接使用

```javascript
window.方法名;
```

window引用可以省略，即直接用方法名调用

# 4、Location，地址栏对象

## 4.1、创建

window.location

location

## 4.2、方法

1、reload()  刷新页面

## 4.3、属性

1、href  设置或返回完整URL

# 5、history，历史记录对象

## 5.1、创建

1、window.history

2、hostory

## 5.2、方法

back()  加载history列表中第一个URL

forward()  加载history列表中下一个URL

go()   加载history列表中某个具体的页面

​		正数表前进几个历史记录

​		负数表后退几个历史记录

## 5.3、属性

length  返回当前窗口历史记录列表中URL的个数

