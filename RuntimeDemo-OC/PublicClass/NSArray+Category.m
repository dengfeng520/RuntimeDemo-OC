//
//  NSArray+Category.m
//  RuntimeDemo-OC
//
//  Created by rp.wang on 2019/3/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "NSArray+Category.h"
#import <objc/runtime.h>

@implementation NSArray (Category)


+ (void)load{
    [super load];
    //---------------------- 不可变数组 objectAtIndex
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    //---------------------- 不可变数组 []
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndexedSubscript:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
    
    //---------------------- 可变数组 objectAtIndex
    Method oldMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndex:));
    method_exchangeImplementations(oldMObjectAtIndex, newMObjectAtIndex);
    //---------------------- 可变数组 []
    Method oldMMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
    Method newMMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndexedSubscript:));
    method_exchangeImplementations(oldMMutableObjectAtIndex, newMMutableObjectAtIndex);
}

// MARK: - 不可变数组 objectAtIndex
- (id)newObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"\n\n------------不可变数组越界了");
            return nil;
        } @finally {
            
        }
    }
    else{
        // !!!: - 此处并不是掉用 newObjectAtIndex 而是掉用系统的objectAtIndex，之前已经做交换了
        return [self newObjectAtIndex:index];
    }
}
// MARK: - 不可变数组 []
- (id)newObjectAtIndexedSubscript:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newObjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            NSLog(@"\n\n------------不可变数组越界了");
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self newObjectAtIndexedSubscript:index];
    }
}
// MARK: - 可变数组 objectAtIndex
- (id)newMutableObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newMutableObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"\n\n------------可变数组越界了");
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self newMutableObjectAtIndex:index];
    }
}
// MARK: - 可变数组 []
- (id)newMutableObjectAtIndexedSubscript:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newMutableObjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            NSLog(@"\n\n------------可变数组越界了");
            return nil;
        } @finally {
        }
    }
    else{
        return [self newMutableObjectAtIndexedSubscript:index];
    }
}


@end
