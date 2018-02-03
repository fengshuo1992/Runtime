//
//  Test.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2018/1/10.
//  Copyright © 2018年 杭州米发. All rights reserved.
//

#import "Test.h"
#import <objc/message.h>

@implementation Test

- (instancetype)init
{
    if (self = [super init]) {
        [self getIMPFromSelector:@selector(aaa)];
        [self getIMPFromSelector:@selector(test)];
        [self getIMPFromSelector:@selector(test1)];
    
    }
    return self;
}

- (void)test{
    NSLog(@"实例方法");
}

+ (void)test1{
    NSLog(@"类方法");
}

- (void)getIMPFromSelector:(SEL)aselector
{
    
    IMP instanceIMP = class_getMethodImplementation(objc_getClass("Test"), aselector);
    IMP classIMP = class_getMethodImplementation(objc_getMetaClass("Test"), aselector);
    
    Method instanceMethod =class_getInstanceMethod(objc_getClass("Test"), aselector);
    IMP instanceIMP2 =method_getImplementation(instanceMethod);
    
    Method classMethod = class_getClassMethod(objc_getMetaClass("Test"), aselector);
    IMP classIMP2 = method_getImplementation(classMethod);
    
    NSLog(@"instance:%p, instance:%p, class1:%p, class2:%p",instanceIMP, instanceIMP2, classIMP, classIMP2 );
    
}



@end
