//
//  HZSeePatientInfoModel.m
//  KuaiCare
//
//  Created by tang on 17/1/17.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZSeePatientInfoModel.h"

@implementation HZSeePatientInfoModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"birthday": @"CONTENT.birthday",
             @"head": @"CONTENT.head",
             @"ID": @"CONTENT.id",
             @"idCard": @"CONTENT.idcard",
             @"medicareCard": @"CONTENT.medicareCard",
             @"name": @"CONTENT.name",
             @"sex": @"CONTENT.sex",
             @"tel": @"CONTENT.tel",
             @"msg": @"MSG",
             @"state": @"STATE"
             };
}

@end
