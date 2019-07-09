//
//  FunctionClass.m
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "FunctionClass.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "TestClass.h"
#import "ExploreViewModel.h"

@implementation FunctionClass


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //===============================
//    TestClass *test = [TestClass new];
    TestClass *test = ((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("alloc")), sel_registerName("init"));
    //===============================
    // 实例方法调用
    [test testLogWithString:@"消息发送"];
    // 类方法调用
    [TestClass testNameWithString:@"消息发送"];
    
    
    //=============================== 测试 反其道而行之，类对象调用实例方法 实例对象调用类方法
//    [test performSelector:@selector(testNameWithString:) withObject:@"实例对象调用类方法"];
    [TestClass performSelector:@selector(testLogWithString:) withObject:@"类对象调用实例方法"];

    //===============================
    [test performSelector:@selector(testNameWithString:) withObject:@"消息发送"];
    [TestClass performSelector:@selector(testNameWithString:) withObject:@"消息发送"];

    //=============================== 属性赋值
    test.name = @"属性赋值";
    
    //===============================
    // 调用实例方法
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("testLogWithString:"), (NSString *)@"test Name");
    // 调用类方法
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("testNameWithString:"), (NSString *)@"test Name");
    // 属性赋值
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("setName:"), (NSString *)@"test Name");


    //=============================== 类方法
    NSString *className = [NSString stringWithFormat:@"%s",class_getName([TestClass class])];
    NSLog(@"className===============%@",className);
    
    
    
    myselfAnimation();
}


void myselfAnimation(void){
    
    /*
     * class_getMethodImplementation : 从指定的类方法类表中查找指定的方法，返回此方法的地址
     * objc_getMetaClass : 获取对象的元类
     * class_getName : 获取类名
     */
    
    /*
     * 如果要调用 IMP 需要把 `Enable Strict Checking of objc_msgSend Calls`设置为YES 才能编译成功，否则会报`Too few
     * arguments to function call, expected at least 2, have 0`的错，具体原因目前未知
     */
    
    //===============================
//    SEL pushSel = @selector(pushSystemSettingViewAnimation);
//    IMP pushImp = class_getMethodImplementation([NSStringFromClass(@"ExploreViewModel") class], pushSel);
//    pushImp();
//
//    //===============================
//    SEL sel = @selector(testLog);
//    IMP imp = class_getMethodImplementation([TestClass class], sel);
//    imp();
//
//    //===============================
//    SEL testSel = @selector(testLog);
//    IMP testImp = class_getMethodImplementation(objc_getMetaClass(class_getName([TestClass class])), testSel);
//    testImp();
}

@end
