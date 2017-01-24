//
//  HZHZMyCenterIndexModel.m
//  KuaiCare
//
//  Created by tang on 16/12/30.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZHZMyCenterIndexModel.h"

@implementation HZHZMyCenterIndexModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"cashReserve": @"CONTENT.cashReserve",
             @"head": @"CONTENT.head",
             @"ID": @"CONTENT.id",
             @"integralReserve": @"CONTENT.integralReserve",
             @"isSign": @"CONTENT.isSign",
             @"nickName": @"CONTENT.nickName",
             @"phone": @"CONTENT.phone",
             @"serviceHotline": @"CONTENT.serviceHotline",
             @"state": @"STATE",
             @"msg": @"MSG"
             };
}

@end
