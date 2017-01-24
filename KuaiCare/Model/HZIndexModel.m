//
//  HZIndexModel.m
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZIndexModel.h"

@implementation HZIndexModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"msg": @"MSG",
             @"desc": @"CONTENT.description",
             @"ID": @"CONTENT.id",
             @"orderNum": @"CONTENT.orderNum",
             @"nursingSkill": @"CONTENT.nursingSkill",
             @"file": @"CONTENT.file",
             @"userNotice": @"CONTENT.userNotice",
             @"theranyTime": @"CONTENT.therapyTime",
             @"serviceContent": @"CONTENT.serviceContent",
             @"name": @"CONTENT.name",
             @"servicePrice": @"CONTENT.servicePrice"};
}

@end
