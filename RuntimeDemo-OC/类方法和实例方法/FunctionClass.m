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
    // 实例方法调用
//    [test testLogWithString:@"消息发送"];
    // 类方法调用
//    [TestClass testNameWithString:@"消息发送"];
    //=============================== 测试 反其道而行之，类对象调用实例方法 实例对象调用类方法
//    [test performSelector:@selector(testNameWithString:) withObject:@"实例对象调用类方法"];
//    [TestClass performSelector:@selector(testLogWithString:) withObject:@"类对象调用实例方法"];



    
    /*
     * class_getMethodImplementation : 从指定的类方法类表中查找指定的方法，返回此方法的地址
     * objc_getMetaClass : 获取对象的元类
     * class_getName : 获取类名 
     */
    //=============================== 实例方法
//    SEL sel = @selector(testLog);
//    IMP imp = class_getMethodImplementation([TestClass class], sel);
//    imp();
//    //=============================== 类方法
//    SEL testSel = @selector(testLog);
//    NSString *className = [NSString stringWithFormat:@"%s",class_getName([TestClass class])];
//    NSLog(@"className===============%@",className);
//    IMP testImp = class_getMethodImplementation(objc_getMetaClass(class_getName([TestClass class])), testSel);
//    testImp();
    
   

}
@end
