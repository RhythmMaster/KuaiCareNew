//
//  HZMedicDisplayModel.m
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZMedicDisplayModel.h"

@implementation HZMedicDisplayModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"auditStatus": @"CONTENT.INFO.audit_status",
             @"count": @"CONTENT.INFO.count",
             @"goodAtField": @"CONTENT.INFO.good_at_field",
             @"head": @"CONTENT.INFO.head",
             @"hospital": @"CONTENT.INFO.hospital",
             @"name": @"CONTENT.INFO.name",
             @"phone": @"CONTENT.INFO.phone",
             @"postName": @"CONTENT.INFO.post_name",
             @"score": @"CONTENT.INFO.score",
             @"list": @"CONTENT.LIST",
             @"msg": @"MSG",
             @"state": @"STATE"
             };
}


+ (NSDictionary *)getInnerClassFromArray {
    return @{@"list": [HZMedicDisplayListModel class]};
}

@end

@implementation HZMedicDisplayListModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"evaluateReason": @"evaluate_reason",
             @"evaluateTime": @"evaluate_time",
             @"head": @"head",
             @"itemName": @"item_name",
             @"nickName": @"nickname",
             @"phone": @"phone",
             @"synthesizeScore": @"synthesize_score"
             };
}

@end
