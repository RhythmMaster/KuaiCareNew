//
//  HZWithdrawDepositListModel.m
//  dddd
//
//  Created by tang on 16/12/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithdrawDepositListModel.h"

@implementation HZWithdrawDepositListModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"msg": @"MSG",
             @"allCount": @"ALLCOUNT",
             @"content": @"CONTENT",
             @"state": @"STATE"};
}
+ (NSDictionary *)getInnerClassFromArray {
    return @{@"content": [HZWithdrawDepositListContentModel class]};
}


@end

@implementation HZWithdrawDepositListContentModel
+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"alipay": @"alipay",
             @"ID": @"id",
             @"failureReason": @"failure_reason",
             @"withdrawDepositTime": @"withdrawDepositTime",
             @"depositTime": @"deposit_time",
             @"payTime": @"pay_time",
             @"depositStatus": @"deposit_status",
             @"billTime": @"bill_time",
             @"depositMoney": @"deposit_money"};
}


@end
