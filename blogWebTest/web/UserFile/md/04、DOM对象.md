# 4、DOM对象

------



# 1、概念

Document object  model 文档对象模型

将标记语言文档的各个组成部分，封装为对象，可以使用这些对象，对标记语言文档进行CRUD操作

# 2、核心DOM

1. Document：文档对象
2. Element：元素对象
3. Attribute：属性对象
4. Text：文本对象
5. Comment：注释对象
6. Node：节点对象，其他五个的父对象

# 3、Document对象

## 3.1、创建（获取）

找HTML模型中，DOM模型可以使用Window对象来获取

```javascript
window.document
document
```

## 3.2、方法

获取Element对象

```JavaScript
getElementById():根据Id属性值获取元素对象
getElementsByTagName():根据元素名称获取元素对象，返回的是数组
getElementsByClassName():根据类名获取元素对象
getElementsByName():根据name属性值来获取对象
```

创建其他DOM对象

```javascript
createAttribute(name)
createComment()
createElement()
createTaxtNode()
```



## 3.3、属性

### 3.3.1、Element元素对象

**1、获取/创建**

通过document来获取和创建

**2、方法**

1. removeAttribute()删除属性
2. setAttribute()设置属性

### 3.3.2、节点对象

**1、特点**

所有DOM对象都可以认为是节点

**2、方法**

```javascript
appendChild():向节点的子节点列表的结尾添加新的子节点
removeChild():删除(并返回)当前节点的指定子节点
replaceChild():用新节点替换一个子节点
```

**3、属性**

```javascript
parentNode 返回节点的父节点
```

# 4、HTML  DOM

## 4.1、标签体的设置和获取

innerHTML



## 4.2、使用HTML元素对象的属性



## 4.3、控制元素样式

1、使用元素的style属性来设置

 ```javascript
如
div1.style.border = "1px solid red";
 ```

2、提前定义好类选择器的样式，通过元素的ClassName属性来设置其Class值

