# 24、线程安全

------



# 1、线程安全问题概述

多个线程在调用同一共享资源时可能会出现访问到不存在的数据或重复访问某个数据的问题

# 2、解决方法一、同步代码块

格式

```java
synchronized(锁对象){
	可能出问题的代码
};
```

锁对象可以是任意对象，需在synchronized代码块外定义，执行代码块内容时会先获取锁对象，但锁对象只有一个，后来的线程就会进入等待状态。

即可保证共享资源中只有一个线程在访问

# 3、解决方法二、同步方法

思路与方法一相似，只是把访问了共享数据的代码放在方法中

使用步骤：

1. 把访问了共享数据的代码抽取出来，放到一个方法中
2. 在方法上添加修饰符：synchronized

格式：

```java
修饰符 synchronized 返回值 方法名(){}
```

注意：此方法实际也使用了锁对象，锁对象是方法调用者

# 4、解决方法三、Lock锁

Lock锁比前两种更好用，使用更广泛

Lock接口中有两种常用方法

```java
void lock();//获取锁
void unlock();//释放锁
```

步骤

1. 在成员位置，创建lock的实现类Reentrantiock的对象
2. 在出安全问题的代码前使用lock方法
3. 在代码后用unlock方法

示例

```java
Lock l = new ReentrantLock(); //创建锁对象

    @Override
    public void run() {
        while (true) {
            l.lock();//获取锁
            if (ticket > 0) {
                //提高安全问题出现的概率，使用睡眠
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println(Thread.currentThread().getName() + "正在卖第" + ticket + "张票");
                ticket--;
            }
            l.unlock();//解锁
        }
    }
```



