//
//  TestClass.m
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass



+(void)testLog{
    //===============================
    NSLog(@"调用类方法=============testLog");
}

-(void)testLog{    
    //===============================
    NSLog(@"调用实例方法=============testLog");
}

-(void)setName:(NSString *)name{
    //===============================
    _name = name;
    NSLog(@"调用了set方法=============%@",name);
}

+(void)testNameWithString:(NSString *)name{
    NSLog(@"类方法=============%@",self);
}

-(void)testLogWithString:(NSString *)name{
    NSLog(@"实例方法==============%@",self);
}

-(void)testLogWithMultipleString:(NSString *)name groupWithString:(NSString *)group{
    
    NSLog(@"多个参数===============%@，%@",name,group);
}

@end
