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
//    TestClass *test = [[TestClass alloc]init];
//    [test testLog:@"test Name"];
//    test.name = @"test Name";
//    [TestClass testLog:@"test name"];
    
    //===============================
    TestClass *test = ((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)((TestClass *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("alloc")), sel_registerName("init"));
    // 调用实例方法
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("testLog:"), (NSString *)@"test Name");
    // 调用类方法
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)objc_getClass("TestClass"), sel_registerName("testLog:"), (NSString *)@"test Name");
    //
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)test, sel_registerName("setName:"), (NSString *)@"test Name");
    //===============================
    [test performSelector:@selector(testLog:) withObject:@"消息发送"];
    [TestClass performSelector:@selector(testLog:) withObject:@"消息发送"];
    
    
}
@end
