//
//  TestClass.h
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestClass : NSObject

@property (strong, nonatomic) NSString *name;
///
@property (assign, nonatomic) int age;
///
@property (assign, nonatomic) int sex;

//
- (void)testLog;
//
+ (void)testLogWithClass;

//
+ (void)testNameWithString:(NSString *)name;
//
- (void)testLogWithString:(NSString *)name;
///
- (void)testLogWithMultipleString:(NSString *)name groupWithString:(NSString *)group;
@end

NS_ASSUME_NONNULL_END
