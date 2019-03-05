//
//  msgSendClassController.m
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "msgSendClassController.h"
#import <objc/message.h>
#import "SubTestClass.h"

@interface msgSendClassController ()

@end

@implementation msgSendClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //===============================
    TestClass *test = [TestClass new];
    [test testLogWithString:@"test name"];
   
    
    
    SEL sel = @selector(testLogWithString:);
    // 使用objc_msgSend()方法 强制转换为指针类型
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel, @"test name");
    // objc_msgSend 调用实例方法
    objc_msgSend(test, sel, @"test");
    // 多个参数调用
    SEL secondSel = @selector(testLogWithMultipleString:groupWithString:);
    objc_msgSend(test, secondSel,@"frist",@"second");
    // objc_msgSend 调用类方法
    SEL thridSel = @selector(testNameWithString:);
    objc_msgSend([TestClass class], thridSel,@"thrid");
    
    
    // 返回一个结构体
//    objc_msgSend_stret(test, secondSel, @"test");
//    // 返回一个浮点数
//    objc_msgSend_fpret(test, secondSel, @"test");
//    // 返回一个浮点数
//    objc_msgSend_fp2ret(test, secondSel, @"test");
    // 给父类发消息
    SubTestClass *subTest = [SubTestClass new];
    // 子类调用父类方法
    [subTest testLogWithMultipleString:@"fristtest" groupWithString:@"secondtest"];
    // 利用objc_msgSendSuper实现子类调用父类方法
    struct objc_super objSuper;
    objSuper.receiver = subTest;
    objSuper.super_class = [TestClass class];
    objc_msgSendSuper(&objSuper, secondSel, @"fristtest", @"secondtest");
//    objc_msgSendSuper_stret(&objSuper, secondSel, @"fristtest", @"secondtest");

    
//    TestClass *test = ((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("alloc")), sel_registerName("init"));
    // 调用实例方法
//    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("testLog:"), (NSString *)@"test Name");
//    // 调用类方法
//    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("testLog:"), (NSString *)@"test Name");
//    //
//    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("setName:"), (NSString *)@"test Name");
//    //===============================
//    [test performSelector:@selector(testLog) withObject:@"消息发送"];
//    [TestClass performSelector:@selector(testLog) withObject:@"消息发送"];
}



@end
