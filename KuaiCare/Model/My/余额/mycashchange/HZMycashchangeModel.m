//
//  HZMycashchangeModel.m
//  dddd
//
//  Created by tang on 16/12/13.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMycashchangeModel.h"

@implementation HZMycashchangeModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"allCount": @"ALLCOUNT",
             @"content": @"CONTENT",
             @"msg": @"MSG",
             @"state": @"STATE"
             };
}
+ (NSDictionary *)getInnerClassFromArray {
    return @{
             @"content": [HZMycashchangeContentModel class]
             };
}

@end

@implementation HZMycashchangeContentModel
+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"cashReserve": @"cash_reserve",
             @"changeType": @"change_type",
             @"createDate": @"create_date",
             @"realityMoney": @"reality_money"
             };
}


@end
