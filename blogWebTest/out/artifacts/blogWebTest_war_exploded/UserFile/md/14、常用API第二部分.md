# 14、常用API第二部分

------



# 1、object类

## 1.1、tostring

用于返回对象的字符串表示，比如数组，使用该方法后可以查看对应的字符串表示而无需遍历

```java
String s = Arrays.toString(dest);
```



## 1.2、equals方法

用于比较两个参数是否相等，返回布尔类型

```java
A.equals(B)
```

这个方法在object中，原始的代码对于引用数据类型来说只会比较地址值，没有意义。所以其他的类中（如String）重写了该方法，使得它可以比较引用数据类型的属性。

以下为String类中重写该方法的代码

```java
    public boolean equals(Object anObject) {
        if (this == anObject) {
            return true;
        }
        if (anObject instanceof String) {
            String anotherString = (String)anObject;
            int n = value.length;
            if (n == anotherString.value.length) {
                char v1[] = value;
                char v2[] = anotherString.value;
                int i = 0;
                while (n-- != 0) {
                    if (v1[i] != v2[i])
                        return false;
                    i++;
                }
                return true;
            }
        }
        return false;
    }

```

# 2、Date类

与时间和日期相关的类（单位是毫秒）

时间原点：1970年1月1日0点（格林威治时间）

## 2.1、无参构造

```java
Date date = new Date();
//直接输出date可查看当前时间
```

## 2.2、带参构造

```java
Date date = new Date(0L);
//传递一个long类型的毫秒值，获得一个对应时间的date对象
```

## 2.3、gettime()方法

```java
date.getTime()
//返回date对象到时间原点的毫秒值
```

# 3、DateFormat类

对日期进行格式化的类，是一个抽象类，功能借助子类SimpleDateFormat实现

日期模式：y年  M月  d日  H时 m分  s秒（区分大小写）

使用这些字母组合成日期的表达模式

## 3.1、SimpleDateFormat类

构造

传递一个模式作为构造方法，例如

```java
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-mm-ss");
```

常用方法：

格式化:

```java
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-mm-ss");
        //创建对象并传递模式
        Date date = new Date();//获取一个时间
        String format = sdf.format(date);//格式化并存储
        System.out.println(date);//输出格式化之前的
        System.out.println(format);//输出格式化之后的
```

如上format方法将日期按模式转换为对应模式的字符串

解析：按模式将字符串解析成日期（模式和字符串不符会抛出异常）

```java
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-mm-ss");
        //注意，解析的字符串如果跟模式不一样，会给异常
        Date parse = sdf.parse("2020-03-10-14-07");
        System.out.println(parse);
```

# 3、Calendar类

日历类，可以操作年月日等属性

是个抽象类，通过静态方法getInstance可以直接获得子类对象（多态）

常用成员方法：

```java
*     get(int field)
*           返回给定日历字段的值。
*     set(int field, int value)
*           将给定的日历字段设置为给定值。
*     add(int field, int amount)
*           根据日历的规则，为给定的日历字段添加或减去指定的			时间量。
*     getTime()
*           返回一个表示此 Calendar 时间值（从历元至现在的			毫秒偏移量）的 Date 对象。
```

演示：

get方法

```java
/**
     * public int get(int field)，返回给定日历字段的值
     * 参数：传递指定日历字段（YEAR,MONTH。。。）
     * 返回值：日历字段代表的具体的值
     */
    private static void demo01() {
        //getDemo
        //使用getinstance方法
        Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);//获取当前年份
        System.out.println(year);

        int mouth = c.get(Calendar.MONTH);//获取月份
        System.out.println(mouth);//注意，月份为西方月份，从0到11

        int date = c.get(Calendar.DATE);//获取日
        System.out.println(date);
    }
```

set方法：

```java
private static void demo02() {
        //steDemo
        /**
         * public void set(int field,int value)将给定日历字段设置为给定值
         * 参数：
         *      同get
         */
        Calendar c = Calendar.getInstance();//获取对象
        //设置年为9999
        c.set(Calendar.YEAR,9999);//设置对象的年份
        int year = c.get(Calendar.YEAR);
        System.out.println(year);

        //同时设置年月日
        c.set(8888,8,8);
    }
```

add方法：

```java
private static void demo03() {
        //addDemo
        /**
         * 根据日历的规则，为给定的日历字段增加或减少相应的值
         * 正数增加，负数减少
         */
        Calendar c = Calendar.getInstance();
        //增加两年
        c.add(Calendar.YEAR,2);
        int year = c.get(Calendar.YEAR);
        System.out.println(year);
    }
```

getTime方法：

```java
private static void demo04() {
        //getTimeDemo,把Calendar的时间值转化成Date对象
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        System.out.println(date);
    }
```

# 4、System类

可以获取与系统相关信息或系统级操作

这里介绍获取当前时间和复制数组两个方法

## 4.1、currentTimeMillis方法

可以获取当前时间（毫秒级）可用于测试程序运行时间

```java
private static void demo01() {
        /**
         * currentTimeMillis；返回毫秒级单位的当前时间
         * 用来测试程序运行耗时
         * 执行前获取一次，执行后获取一次
         * 下面以测试for循环输出1-9999为例，看耗时多少
         */
        long s = System.currentTimeMillis();
        //获取第一次时间
        for (int i = 0; i < 9999; i++) {
            System.out.println(i);
        }
        long s2 = System.currentTimeMillis();
        //获取第二次时间
        System.out.println(s2-s);
        //输出测试结果
    }
```

## 4.2、copyarray方法

将数组中指定的数据拷贝到另一数组

```java
public static void arraycopy(Object src,int srcPos,Object dest,int destPos,int length)
```

参数含义如下

```java
src - 源数组。
srcPos - 源数组中的起始位置。
dest - 目标数组。
destPos - 目标数据中的起始位置。
length - 要复制的数组元素的数量。
```

举例，将src数组中的前三个元素复制到dest数组的前三位

```java
//定义原数组
int[] src = {1,2,3,4,5};
int[] dest = {6,7,8,9,10};

System.arraycopy(src,0,dest,0,3);
 String s = Arrays.toString(dest);
System.out.println(s);//dest的前三个被替换了
```

# 5、StringBuilder类

字符串缓冲区，可看做长度可变的字符串，可以提高字符串的操作效率



## 5.1、构造方法：

```java
StringBuilder()构造一个不带任何字符的字符串生成器，其初始容量为 16 个字符。
StringBuilder(String str)构造一个字符串生成器，并初始化为指定的字符串内容。可用于将字符串转化成StringBuilder
```

## 5.2、append方法：

```java
private static void demo01() {
        StringBuilder bu = new StringBuilder();
        //使用append方法
        //返回的是this 调用方法的对象
        StringBuilder bu2 = bu.append("abc");//把bu的地址值给了bu2，其实不用接受返回值
        System.out.println(bu);
        System.out.println(bu2);
        System.out.println(bu==bu2);//比较的是地址
    }
```

append方法可接受任何类型的字符串形式

## 5.3、toString方法

```java
private static void demo02() {
        //toString
        /**
         * StringBuilder可以和String相互转换
         *      String-->StringBuilder可以使用StringBuilder的构造方法
         *      StringBuilder-->String使用StringBuilder中的toString
         */
        //String-->StringBuilder
        String str = "hello";
        System.out.println(str);
        StringBuilder bu =new StringBuilder(str);
        //添加数据
        bu.append("world");
        System.out.println(bu);

        //StringBuilder-->String
        String s = bu.toString();
        System.out.println(s);
    }
```

# 6、包装类

用一个类把基本数据类型包装起来，使其可以被当成对象使用

装箱：把基本数据类型的数据放到包装类中

方法：

```java
构造方法：Integer(int value)构造一个新的Integer对象，表示指			定的int值
		Integer(String s)构造一个新分配的Integer对象，注			意：传入的参数必须为基本类型的字符串，否则异常
静态方法：valueOf(String s)
    	valueOf(String s, int radix)返回一个 Integer 对			象，该对象中保存了用第二个参数提供的基数进行解析时从			指定的 String 中提取的值。
```

示范

```java
		//传整数建立对象
        Integer in1 = new Integer(1);//方法过时了
        System.out.println(in1);

        //传字符串建对象
        Integer in2 = new Integer("1");
        System.out.println(in2);

        //传整数
        Integer in3 = Integer.valueOf(1);//过时
        System.out.println(in3);

        //传字符串
        Integer in4 = Integer.valueOf("1");
        System.out.println(in4);
```

拆箱：在包装类中取出基本数据类型

```java
成员方法：inValue()
```

示范：

```java
  //拆箱
        int i = in1.intValue();
        System.out.println(i);
```

## 6.1、自动拆箱与装箱：

```java
//自动装箱,相当于Integer in = new Integer(1);
        Integer in = 1;

        //自动拆箱,包装类无法进行计算，因此在计算时会拆箱,但是计算完后又会自动装箱
        in = in+2;

```

## 6.2、基本数据类型与字符串之间的转换

````java
/**
 * 基本数据类型与字符串类型之间的相互转换
 * 基本类型-->字符串：
 *      1、基本类型的值+“”  最简单的
 *      2、包装类的静态方法toString(参数),
 *      3、String类的静态方法valueof(参数)
 * 字符串-->基本类型：
 *      1、包装类的静态方法parsexxx("数字类的字符串")
 *          Integer类：static int parseInt(String s)
 */
````

示范：

```java
public class translateDemo {
    public static void main(String[] args) {
        int i1 = 100;
        String s1 = i1 + "";
        System.out.println(s1);

        String s2 = Integer.toString(100);
        System.out.println(s2);

        String i3 = String.valueOf(1);
        System.out.println(i3);


        int i = Integer.parseInt(s1);
        System.out.println(i-10);
    }
}

```

## 6.3、拓展

**Character类中的方法**

```java
static boolean isDigit(char ch)判断是不是数字
static boolean isLetter(char ch)判断是不是字母
static boolean isLetter(char ch)判断是不是数字或字母
```

