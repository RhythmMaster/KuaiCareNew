//
//  HZWaitWithdrawModel.m
//  dddd
//
//  Created by tang on 16/12/13.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWaitWithdrawModel.h"

@implementation HZWaitWithdrawModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"aliapy": @"CONTENT.alipay",
             @"cashReserve": @"CONTENT.cashReserve",
             @"name": @"CONTENT.name",
             @"withdrawDepositCase": @"CONTENT.withdrawDepositCase",
             @"msg": @"MSG"};
}

@end
