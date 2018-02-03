//
//  UIViewController+FSViewController.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/11.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import "UIViewController+FSViewController.h"
#import <objc/message.h>


@implementation UIViewController (FSViewController)

//runtime  实用的方法  在做工程的时候 如果想找个某一些 方法的使用情况就 可以使用交换方法 去 吧系统的方法交换  然后在新的方法中 做一些想要做的操作

//我想让每个View 刚出来的时候 都会打印一下这个Controller的名字

+ (void)load
{
    Method systemMethod =  class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method fsmethod =class_getInstanceMethod([self class], @selector(fs_logViewControllerName));
    method_exchangeImplementations(systemMethod, fsmethod);
}

- (void)fs_logViewControllerName
{
    NSLog(@"%@", NSStringFromClass([self class]));
    
}


@end
