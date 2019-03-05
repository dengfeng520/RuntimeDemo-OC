//
//  FunctionClass.m
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "FunctionClass.h"
#import <objc/message.h>
#import "TestClass.h"

@implementation FunctionClass


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //===============================
    TestClass *test = [[TestClass alloc]init];
    [test testLogWithString:@"消息发送"];
    [TestClass testNameWithString:@"消息发送"];
    //=============================== 测试 反其道而行之，类对象调用实例方法 实例对象调用类方法
//    [test performSelector:@selector(testNameWithString:) withObject:@"实例对象调用类方法"];
//    [TestClass performSelector:@selector(testLogWithString:) withObject:@"类对象调用实例方法"];

//    [test testLog:@"test Name"];
//    test.name = @"test Name";
//    [TestClass testLog:@"test name"];

    
    /*
     * class_getMethodImplementation : 从指定的类方法类表中查找指定的方法，返回此方法的地址
     * objc_getMetaClass : 获取对象的元类
     * class_getName : 获取类名
     */
    
    NSString *className = [NSString stringWithFormat:@"%s",class_getName([TestClass class])];
    NSLog(@"className===============%@",className);
    //===============================
    SEL sel = @selector(testLog);
    IMP imp = class_getMethodImplementation([TestClass class], sel);
    imp();
    //===============================
    SEL testSel = @selector(testLog);
    IMP testImp = class_getMethodImplementation(objc_getMetaClass(class_getName([TestClass class])), testSel);
    testImp();
    
    //===============================
//    TestClass *test = ((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("alloc")), sel_registerName("init"));
//    // 调用实例方法
//    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("testLog:"), (NSString *)@"test Name");
//    // 调用类方法
//    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("testLog:"), (NSString *)@"test Name");
//    //
//    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("setName:"), (NSString *)@"test Name");
    //===============================
//    [test performSelector:@selector(testLog:) withObject:@"消息发送"];
//    [TestClass performSelector:@selector(testLog:) withObject:@"消息发送"];

}
@end
