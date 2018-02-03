//
//  Person.h
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/8.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic) int age;
@property (nonatomic, copy) NSString * address;

- (void)food;


@end
