# EL表达式

## 概念

Expression Language

## 作用

替换和简化jsp页面中java代码的编写

## 语法

```
${表达式}
```

## 注意

jsp默认支持EL表达式，要忽略的话在page指令里加上`isELIgnored="true"`或者在$前加 \ 

# 使用方式

## 运算

### 运算符

1、算数运算符

```
+ - * /(div) %(mod)
```



2、比较运算符

```
> < >= <= == !=
```



3、逻辑运算符

```
&&(与) ||(或) !(非)
```



4、空运算符

```
empty
```



## 获取值

### 