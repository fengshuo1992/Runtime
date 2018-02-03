//
//  NSMutableArray+SafeArray.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/8.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import "NSMutableArray+SafeArray.h"
#import <objc/message.h>

@implementation NSMutableArray (SafeArray)

+ (void)load
{
    SEL systemSel = @selector(addObject:);
    SEL swizingSel = @selector(FS_safeAddobject:);
    
    Method systemMehtod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), systemSel);
    Method swizingMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), swizingSel);
    method_exchangeImplementations(systemMehtod, swizingMethod);
    
}

- (void)FS_safeAddobject:(id)object
{
    
    if (object != nil) {
        [self FS_safeAddobject:object];
    }
}


@end
