//
//  NSObject+ParseJSON.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ParseJSON)<YYModel>

+ (id)parseJSON:(id)json;
+ (NSDictionary *)getInnerClassFromArray;
+ (NSDictionary *)replacedKeyFromPropertyNameJSON;


@end
