//
//  NSArray+Name.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/8.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import "NSArray+Name.h"
#import <objc/message.h>



static const char kName;

@implementation NSArray (Name)



- (void)setName:(NSString *)name
{
    objc_setAssociatedObject([self class], &kName, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject([self class], &kName);
}


@end
