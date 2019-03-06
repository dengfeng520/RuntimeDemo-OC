<h1><center>iOS Runtime消息处理机制</center></h1>
###1、类方法和实例方法调用
在开发中常用到的类方法和实例方法有什么区别呢？下面通过代码来说明:

(1)、新建一个工程，在`main.m`中新增代码`TestClass`

```
@interface TestClass : NSObject
//
+(void)testNameWithString:(NSString *)name;
//
-(void)testLogWithString:(NSString *)name;
@end

@implementation TestClass
+(void)testNameWithString:(NSString *)name{
NSLog(@"类方法=============%@",self);
}

-(void)testLogWithString:(NSString *)name{
NSLog(@"实例方法==============%@",self);
}
```
```
int main(int argc, char * argv[]) {
@autoreleasepool {
//===============================
TestClass *test = [[TestClass alloc]init];
[test testLogWithString:@"消息发送"];
[TestClass testNameWithString:@"消息发送"];
return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
}
}
```
运行代码，观察打印结果:
```
实例方法==============<TestClass: 0x600000649c40>
```
```
类方法=============TestClass
``` 
从上面的打印结果看出类方法和实例方法的区别：**实例方法打印出了`TestClass`这个对象的指针，类方法打印出来就是`TestClass`这个类**。

（2）、试想，如果我反其道而行之呢，用类对象调用实例方法 实例对象调用类方法，使用`performSelector`实现,下面用代码来测试一下:
```
[test performSelector:@selector(testNameWithString:) withObject:@"实例对象调用类方法"]; 

[TestClass performSelector:@selector(testLogWithString:) withObject:@"类对象调用实例方法"];
```
编译没有问题，但是运行之后就报错了，无法识别相关的实例方法和类方法,可以得出结论**类对象只能调用类方法，实例对象只能调用实例方法**。
```
-[TestClass testNameWithString:]: unrecognized selector sent to instance 0x600003a648e0
```
```
+[TestClass testLogWithString:]: unrecognized selector sent to class 0x10ab756d0
```
（3）、那么问题来了，为什么类对象只能调用类方法，实例方法只能调用实例方法呢？下面通过代码来验证，首先介绍要用到的几个`Runtime`的方法，可以在`Runtime.h`文件的注释中看到这些方法的左右:

| `class_getMethodImplementation` |    `Returns the function pointer that would be called if a particular message were sent to an instance of a class.`  | 从指定的类方法类表中查找某个方法，返回此方法的指针地址|
| :-------------:|:-------------:| :-------------:| 
|`objc_getMetaClass `|`Returns the metaclass definition of a specified class.`|返回指定类的元类|
|`class_getName `|`Returns the name of a class` |返回类名|

在`testClass`类中新增两个方法:
```
+(void)testLog{
//===============================
NSLog(@"调用类方法=============testLog");
}
-(void)testLog{    
//===============================
NSLog(@"调用实例方法=============testLog");
}
```
```
//=============================== 实例方法
SEL sel = @selector(testLog);
IMP imp = class_getMethodImplementation([TestClass class], sel);
imp();
//=============================== 类方法
SEL testSel = @selector(testLog);
IMP testImp = class_getMethodImplementation(objc_getMetaClass(class_getName([TestClass class])), testSel);
testImp();
```

运行代码，通过`Log`可以看出这两个方法已经被执行了，通过以上的代码在`TestClass`的实例类或者元类中查找到相关的方法，类方法`testLog`是在`TestClass`元类方法列表中，实例方法`testLog`是在`test`实例方法列表中的。

最后，对实例方法和类方法的调用机制做一个总结:

**1、类对象只能调用类方法**
**2、实例对象只能调用实例方法**
**3、实例方法里的`self`，是对象的指针**
**4、类方法里的`self`,是`Class`，这个方法所属的类**
**5、类方法在元类方法列表中**
**6、实例方法在实例对象方法列表中**



---
###2、objc_msgSend方法简单使用
一般情况下，如果调用一个方法,其本质是利用`objc_msgSend`方法发送一条消息，代码如下：
```
TestClass *test = [TestClass new];
[test testLogWithString:@"test name"];
```
导入`objc/message.h`可以看到使用`objc_msgSend`要传参数：
```
objc_msgSend(void /* id self, SEL op, ... */ )
```
* `id`表示调用方法的对象
* `SEL`表示被调用的方法
* 后面的`...`表示要传的参数，
---

```
SEL sel = @selector(testLogWithString:);
objc_msgSend(test, sel, @"test");
```
如果直接使用`objc_msgSend`会报错，需要强制转换为对应的指针类型，
```
SEL sel = @selector(testLogWithString:);
((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel, @"test name");
```
```
// objc_msgSend多个参数调用
SEL secondSel = @selector(testLogWithMultipleString:groupWithString:);
objc_msgSend(test, secondSel,@"frist",@"second");
```
也可以将`enable strict checking of obj_msgSend Calls`设置为`NO`，此时Xcode就不会严格检查`obj_msgSend`的类型，就不会报错了。

![enable strict checking of obj_msgSend Calls](https://upload-images.jianshu.io/upload_images/1214383-d6f1356a1fe8aa60.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
此外还有其他的`objc_msgSend`的函数:


| `objc_msgSend_stret` |    `Sends a message with a data-structure return value to an instance of a class.`  | 返回一个结构体|
| :-------------:|:-------------:| :-------------:| 
|`objc_msgSend_fpret`|`Sends a message with a floating-point return value to an instance of a class.`|返回一个浮点数|
|`objc_msgSend_fp2ret`||返回一个浮点数|
|`objc_msgSendSuper`|`Sends a message with a simple return value to the superclass of an instance of a class.`|给父类发消息|
|`objc_msgSendSuper_stret`|`Sends a message with a data-structure return value to the superclass of an instance of a class.`|调用父类方法，返回一个结构体|


在`objc/message.h`文件中可以看到调用`objc_msgSendSuper`函数时需要传哪些参数，


```
objc_msgSendSuper(struct objc_super * _Nonnull super, SEL _Nonnull op, ...)
```
`struct objc_super * _Nonnull super`表示一个结构体的指针，
```
// 给父类发消息
SubTestClass *subTest = [SubTestClass new];
struct objc_super objSuper;
objSuper.receiver = subTest;
objSuper.super_class = [TestClass class];
objc_msgSendSuper(&objSuper, secondSel, @"fristtest", @"secondtest");
```

###3、Runtime消息发送流程
![消息发送流程图](https://upload-images.jianshu.io/upload_images/1214383-74104277b7a9a55e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---
###4 、消息发送流程
---
###5、类方法动态消息解析
---
###6、实例方法动态消息解析
---
###7、重定向
---
###8、转发
---
###9、模拟多继承


此时，需要导入系统提供的`#import <objc/message.h>`


使用`clang`语法，可以看到编译后的伪代码，打开终端:
`cd`到工程目录下，输入
```
xcrun -sdk iphonesimulator12.1 clang -rewrite-objc main.m
```
`iphonesimulator12.1`表示我的模拟器是iOS 12.1的版本，


编译完成之后，打开工程文件，可以看到又一个`main.cpp`文件，打开这个文件发现有几万行代码，但只要找到重点就行，看`Objective-C`消息发送是如何实现的,其实重要的就下面几行代码:
```
//初始化
TestClass *test = ((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("alloc")), sel_registerName("init"));
//调用实例方法
((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("testLog:"), (NSString *)(NSString *)&__NSConstantStringImpl__var_folders_gp_h7c55tvj3qn0_7fvm6fqlvc40000gn_T_main_08c1cf_mi_2);
//调用类方法
((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("testLog:"), (NSString *)&__NSConstantStringImpl__var_folders_gp_h7c55tvj3qn0_7fvm6fqlvc40000gn_T_main_08c1cf_mi_3);
```


