//
//  Person.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/8.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

#import "Person.h"

@implementation Person



- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntForKey:@"age"];
        _address = [aDecoder decodeObjectForKey:@""];
        _sex = [aDecoder decodeObjectForKey:@""];
    
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInt:_age forKey:@"age"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_sex forKey:@"sex"];
}


- (void)food
{
    NSLog(@"这个方法会走吗");
}



@end
