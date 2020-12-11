# 1、概述

一个前端开发的框架

​	**框架**：一个半成品软件，开发人员可以在框架基础上二次开发，可以简化编码

​	**好处**：

1. 定义了很多css样式和js插件，开发人员可以直接使用这些样式和插件得到丰富的页面效果
2. 响应式布局，同一套页面可以兼容不同分辨率的设备

# 2、快速入门

1. 下载Bootstrap
2. 在项目中将三个文件夹复制
3. 创建HTML页面，引入必要的资源文件

Bootstrap基本模板

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]-->
<!--    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>-->
<!--    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>-->
    <!--引入对低版本IE的支持，此处可以不用-->
    <!--<![endif]-->
</head>
<body>
<h1>你好，世界！</h1>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
</body>
</html>
```

项目中要有Bootstrap

# 3、响应式布局

同一套页面可以兼容不同分辨率的设备

**实现**：依赖于栅格系统：将一行平均分成12个格子，可以指定元素占几个格子

**步骤**

1. 定义容器，相当于之前的table，容器分类：container（有留白），container-fluid(每一种设备都是百分百宽度)
2. 定义行，相当于之前的table，样式row
3. 定义元素，指定该元素在不同设备上，所占格子的数目,样式：col-设备代号-格子数目

设备代号

1. xs：超小屏幕(<768px)：col-xs-12
2. sm：pad（>=768px）
3. md：电脑桌面(>=992px)
4. lg：大型桌面(>=1200px)



**注意**

1、一行中格子数超过12，超出部分自动换行

2、栅格类属性可以向上兼容

3、如果真实设备宽度小于了设置栅格类属性的设备代码的最小值，会一个元素占满一整行

# 4、css样式和js插件

## 4.1、全局CSS样式

### 按钮

```html
class="btn btn-default"
```

### 图片

```
class="img-responsive"
图片在任意尺寸下都占100%
```

```html
<img src="..." alt="..." class="img-rounded">
<img src="..." alt="..." class="img-circle">
<img src="..." alt="..." class="img-thumbnail">
图片形状
```

### 表格

```html
table 基本
table-bordered  带边框
table-hover 悬浮变色
```

### 表单

给表单项添加`class=form-control`

让每一行都在`class="form-group"`中

## 4.2、组件

### 导航条



### 分页条

## 4.3、插件

### 轮播图

