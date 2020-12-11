# 27、lambda表达式

------



# 1、函数式编程思想

只要能获取到结果，谁去做的、怎么做的都不重要，只重视结果，不重视过程

# 2、lambda的标准格式

由三部分组成

参数，箭头，代码

**格式**

```java
(参数列表) -> {重写方法的代码}
```

**解释**

```java
():接口中抽象方法的参数列表，没有参数就空着，多参数用逗号分隔
-> : 传递的意思，把参数传递给方法
{}: 重写接口的抽象方法
```



# 3、lambda表达式用途

用于替换使用接口时创建的匿名实现类对象，可以简化代码

# 4、使用前提

必须有接口，且接口中只有一个抽象方法

必须具有上下文推断

有且只有一个抽象方法的接口呗称为函数式接口

# 5、使用

**无参无返的接口**

接口如下

```java
public interface Cook {
    //无参无返
    public abstract void makeFood();
}
```

测试类中定义一个调用接口抽象方法的方法

```java
public static void invokeCook(Cook cook){
        cook.makeFood();
    }
```

使用抽象类调用如下

```java
invokeCook(new Cook() {
            @Override
            public void makeFood() {
                System.out.println("吃饭了");
            }
        });
```

使用lambda表达式调用如下

```java
invokeCook(()->{
            System.out.println("吃饭了");
        });
```

分析：

lambda调用中整个lambda表达式相当于匿名内部类调用中的匿名对象，只是省去了很多代码，且无需创建匿名对象

**案例二，调用Arrays类中的sort方法**

```java
//先创建一个名为arr的数组
Arrays.sort(arr,(Person o1,Person o2)->{
            return o1.getAge()-o2.getAge();
        });
```

arr是sort方法的排序对象，后面的lambda表达式则是传递了一个排序器

**案例三，对于有参有返的接口**

接口如下

```java
public interface Calculator {
    //计算两个int整数和的方法并返回结束
    public abstract int calc(int a,int b);
}
```

定义一个使用接口的方法

```java
public static void invokCalc(int a , int b, Calculator c){
        int sum = c.calc(a,b);
        System.out.println(sum);
    }
```

lambda表达式调用

```java
invokCalc(10,20,(int a,int b)->{
            return a+b;
        });
```

lambda表达式作为方法的第三个参数，替代了接口的实现类对象

# 6、lambda表达式的简化

lambda表达式是可推导的，可省略的

凡是根据上下文推导出来的内容，我们都可以省略书写

**可省略的内容**：

1. 参数列表的数据类型
2. 参数列表的参数如果只有一个，那么类型和括号都可以省略
3. {}中的代码如果只有一行，无论时候有返回值，都可以省略{}、return和分号。但这三者必须一起省略

（因为lambda的可推导性才能省略）