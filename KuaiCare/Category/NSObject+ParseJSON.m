//
//  NSObject+ParseJSON.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "NSObject+ParseJSON.h"

@implementation NSObject (ParseJSON)

+ (id)parseJSON:(id)json{
    if ([json isKindOfClass:[NSArray class]]) {
        return [NSArray modelArrayWithClass:[self class] json:json];
    }
    if ([json isKindOfClass:[NSDictionary class]]) {
        return [self modelWithJSON:json];
    }
    return json;
}

+ (NSDictionary *)getInnerClassFromArray{
    return nil;
}
+ (NSDictionary *)replacedKeyFromPropertyNameJSON{
    return nil;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return [self getInnerClassFromArray];
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return [self replacedKeyFromPropertyNameJSON];
}



@end
