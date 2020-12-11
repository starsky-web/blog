# 7、常用API第一部分

------



# API

API即jdk中提供，可以直接使用的类。

使用方法：

1. 打开帮助文档
2. 学习对应的使用方法
3. 看包，java.lang下的不需要导包
4. 看类的解释和说明
5. 学习构造方法
6. 使用成员方法

# 1、Scanner类

该类作用是获取键盘输入

使用：

1. 导包（IDEA会自动导入）import  包路径.类名称
2. 创建
3. 使用

```java
public static void main(String[] args) {
        //创建scanner类
        //System.in代表从键盘获取输入
        Scanner scanner = new Scanner(System.in);
        //获取键盘输入的int数字
        int a = scanner.nextInt();
        //获取键盘输入的字符串
        String str = scanner.next();
        //注意上面的语句只能获取不带空格的字符串，如有空格，要用下方的代码
        String str2 = scanner.nextLine();
    }
```



# 2、匿名对象

有些情况下，创建对象时可以不写对象名字，这样的对象叫匿名对象

```java
public class Person {//下文举例使用
    String name;
    public void showname(){
        System.out.println(name);
    }
}
```



```java
/**
         * 匿名对象就是只有右边的对象，
         * 没有左边的名字和赋值运算符
         */
        new Person().name = "bob";
        new Person().showname();
        /**
         * 匿名对象只能用一次
         * 下次要重新创建
         * 在某个对象只要用一次是可以使用匿名对象
         */
```

第六行调用的方法输出为null值，即第六行重新创建了对象

匿名对象也可以作为方法的参数和返回值

# 3、Random类

用于生成随机数

使用步骤大致同Scanner类。

```java
import java.util.Random;
public class Random_demo {
    public static void main(String[] args) {
        Random r = new Random();
        int num = r.nextInt();
        System.out.println(num);
    }
}
```

生成的随机数是int范围内随机一个值

指定生成范围：

```java
 int num1 = r.nextInt(3);
        //上面这行生成随机数的范围是[0,3)，即有0,1,2三种可能
```

另一种指定生成范围的方式

```java
//根据int变量n的值，来获取随机数字，范围[1,n],两个都能取到
        int n = 5;
        int num2 = r.nextInt(n) + 1; //本来是[0,n),整体加一就变成了[1,n+1)
        System.out.println(num2);
```

# 4、ArrayList集合

## 对象数组

把对象的地址值存在数组里，可以通过数组来调用对象

```java
 public static void main(String[] args) {
        //先创建一个长度为3的数组，里面用来放Person类型的数组
        Person[] array = new Person[3];
        Person one = new Person("wang",18);
        Person two = new Person("li",28);
        Person three = new Person("gu",31);
        array[0] = one;//将one当中的地址值存到array里
        array[1] = two;
        array[2] = three;

        System.out.println(array[0]);//打印出来为一个地址值
        System.out.println(array[1].getName());
    }
```

这种方法有一个弊端，即数组的长度在程序运行期间不可更改，即一开始需要考虑好数组的长度。

为了解决这个问题，应该把数组换成集合。

数组和集合的最大区别就是长度可不可变

## ArrayList集合

```java
import java.util.ArrayList;
//对于ArratList来说，有一个尖括号<E>表示泛型，也就是在集合中的所有元素全部是什么类型
        //泛型只能是引用类型，不能是基本类型
        ArrayList<String> list = new ArrayList<>();
        System.out.println(list);
        //对于ArrayList集合来说，直接打印得到的是内容，而不是地址
```

使用add方法添加元素

```java
list.add("wang");
```

注意集合的泛型，只能写泛型指定的数据类型

## ArrayList常用方法

1、添加，

```java
public boolean add(E e);
public E get(int index);
public E remove(int index);
public int size();
```

第一行向集合中添加元素，参数的类型和泛型一致

第二行从集合当中获取元素，参数是索引编号，返回值是对应位置的元素

第三行从集合中删除元素，参数是索引编号，返回值是被删除的元素

第四行获取集合的尺寸长度，返回值是集合中包含的元素个数

```java
public static void main(String[] args) {
        ArrayList<String> list = new ArrayList<>();
        System.out.println(list);
        //添加元素,对于ArrayList集合来说，议案家必定成功，但对其他集合就不一定，所以需要返回值
        boolean success = list.add("A");
        System.out.println(list);
        System.out.println("添加的动作是否成功" + success);

        //从集合中获取，索引从0开始
        String a = list.get(0);
        System.out.println(a);

        //从集合中删除元素
        list.remove(0);
        System.out.println(list);

        //得到集合长度
        int size = list.size();
        System.out.println(size);
    }
```

遍历集合

```java
public static void main(String[] args) {
        ArrayList<String> list = new ArrayList<>();
        list.add("A");
        list.add("B");
        list.add("C");
        
        //遍历集合
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i));
        }
    }
```

## 集合存基本类型


要在集合中使用基本类型，要使用对应的包装类

```java
         /**基本类型   包装类（引用类型，位于java.lang包）
         * byte       Byte
         * short      Short
         * int        Integer
         * long       Long
         * float      Float
         * double     Double
         * char       Character
         * boolean    Boolean
         */
```

使用示范

```java
ArrayList<Integer> list = new ArrayList<>();
list.add(100);
list.add(200);
int a = list.get(1);
System.out.println(a);
```

# 5、String类

字符串创建后不可改变（常量）

因为字符串内容不可改变，多以字符串可以共享使用

字符串效果上相当于char类型的数组

**创建字符串常见的3+1种方法**：

1、public String() 创建一个空白字符串，不含内容

2、public String (char[] array);根据字符串数组的内容，来创建对应的字符串

3、public String(byte[] array);根据字节数组的内容，来创建对应的字符串

4、直接创建

## 字符串的常量池

程序中直接写上的双引号字符串，就在池中

对于基本类型== 是进行数值的比较，对于引用对象，时进行地址值的比较

## 常用方法

### 内容比较：

```java
public boolean equals(Object obj);
//参数可以是任何对象，大小写敏感
```

只有参数是字符串，并且内容相同才为true

```java
str1.equals(str2)
"abc".equals(str)
str.equals("abc")//不推荐，str为null时会报错
```

另一种比较方法

```java
public boolean equalsIgnoreCase(String str)
//忽略大小写
```

### 获取相关方法

```java
public int length();//长度
public String concat(String str);//将当前字符串和参数拼接，并返回
public char charAt(int index);//获取指定索引位置的单个字符
public int indexOf(String str);//查找参数字符串在本字符串中首次出现的索引值，如果没有，返回-1
```

### 截取相关方法

```java
public String substring(int indes);
//从参数位置到末尾，返回型字符串
public String substring(int begin,int end);
//截取一个范围，左闭右开区间（结尾取不到）
```

### 转换相关方法

```java
public char[] toCharArray()
//将字符串转换成字符数组
public byte[] getBytes();
//获得当前字符串底层的字节数据
public String replace(CharSequence oldString,Charsequence newString);
//将所有出现的老字符串替换为新字符串,返回替换的结果
```

### 分隔相关方法

```java
public String[] split(String regex);
//按照参数的规则，将字符串切分为若干部分
//参数其实是正则表达式，如果用英文句点，必须用双引号和反斜杠"\\. "
```

使用：

```java
String str1 = "aaa,bbb,ccc";
String[] array1 = str1.split(",")
//每个逗号切分一下
```

# 6、static关键字

用了static关键字，那么这样的内容就**不再属于对象**，而是**属于类**，也就是说该类的所有对象中的该内容都是一样的，且在对象中不可更改

**对于成员变量**：

​	如过一个成员变量使用了static关键字，那么这个成员变量不再属于对象自己，而是属于所在的类。

```java
public class Student {
    private String name;
    private int age;
    static String room;
    }

Student one = new Student("alan",19);
Student two = new Student("bob",16);
one.room = "101教室";
//两个对象打印都为101教室
```

可以用作计数器，在默认的构造方法里让每次创建对象计数器都加1，实现生成序号

**对于成员方法**

```java
public class Myclass {
    public void method(){
        System.out.println("这是一个普通的成员方法");
    }
    public static void methodStatic(){
        System.out.println("这是一个静态方法");
    }
}
```

如果是成员方法，必须创建对象才能用，而静态方法可以通过类名调用

```java
public static void main(String[] args) {
        Myclass obj = new Myclass();
        obj.method();
        //对于静态方法，可以通过对象调用，也可以通过类名调用
        obj.methodStatic();//不推荐
        Myclass.methodStatic();//推荐
    }
```

**注意**：

​	静态只能直接访问静态，不能直接访问非静态

​	静态方法不能用this

**静态代码块**：

用大括号括起来的就是代码块，作用：当第一次用到本类，静态代码块执行唯一一次

```java
public class Person{
	ststic{
		System.out.println("静态代码块执行");
	}
}
```

用途：用来一次性的对静态成员变量赋值

# 7、数组工具类Arrays

```java
public static String toString(数组)//将参数数组变成字符串
public static void sort(数组)//升序排列,字符串按字母升序，如果是自定义的类，需要有comparable或comparator接口的支持
```

# 8、Math类

有大量的静态方法，完成与数学相关的操作

```java
public static double obs(double num);//过去绝对值
public static double ceil(double num);//向上取整
public static double floor(double num);//向下取整
public static Long round(double num);//四舍五入
```

`Math.PI`为近似圆周率