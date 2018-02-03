//
//  Model.h
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/11.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * sex;


+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
