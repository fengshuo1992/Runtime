//
//  UIViewController+Swizzling.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/8.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/message.h>

@implementation UIViewController (Swizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel =@selector(viewWillAppear:);
        SEL customSel = @selector(FS_ViewWillAppear:);
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method customMethod = class_getInstanceMethod([self class], customSel);
        //首先动态添加方法 实现是被交换的方法 返回值便是添加成功或者失败
       BOOL isadd = class_addMethod(self, systemSel, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
         //如果添加成功了 说明这个方法没有被实现
        if (isadd) {
            class_replaceMethod([self class], customSel, (IMP)customMethod, method_getTypeEncoding(systemMethod));
        }else{
            method_exchangeImplementations(systemMethod, customMethod);
        }
        
    });
    
}

-(void)FS_ViewWillAppear:(BOOL)animated
{
    [self FS_ViewWillAppear:animated];
    NSLog(@"这个是自己添加的方法");

}

@end
