//
//  Model.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/11.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import "Model.h"
#import <objc/message.h>

@implementation Model
+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    
//    id model = [[self alloc] init];
//    unsigned int count = 0;
//
//    Ivar *ivars = class_copyIvarList(self, &count);
//    for (int i = 0 ; i < count; i++) {
//        Ivar ivar = ivars[i];
//
//        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
//
//        //这里注意，拿到的成员变量名为_cid,_age
//        ivarName = [ivarName substringFromIndex:1];
//        id value = dic[ivarName];
//
//        [model setValue:value forKeyPath:ivarName];
//    }
//
//    return model;
//
   


    id model = [[Model alloc] init];
    unsigned int count = 0;
    Ivar * invars = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i< count; i++) {
        Ivar ivar = invars[i];
        NSString * name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //这里注意，拿到的成员变量名为_cid,_age
         name = [name substringFromIndex:1];
        id value = dic[name];
        [model setValue:value forKeyPath:name];
    }
    return model;
    
}
@end
