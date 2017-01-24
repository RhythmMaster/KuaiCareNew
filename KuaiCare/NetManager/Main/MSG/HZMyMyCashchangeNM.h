//
//  HZMyMyCashchangeNM.h
//  KuaiCare
//
//  Created by tang on 17/1/4.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMycashchangeModel.h"
#import "HZWaitWithdrawModel.h"

#import "HZWithdrawDepositListModel.h"

@interface HZMyMyCashchangeNM : NSObject

//余额明细
+ (id)getMyCashchangeWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;


//提现信息接口
+ (id)getWaitWithdrawDepositWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

//提现接口
+ (id)getWithdrawDepositWithDepositMoney:(NSString *)depositMoney withdrawDepositCase:(NSString *)withdrawDepositCase completionHandler:(void(^)(id model, NSError *error))completionHandler;


//体现历史记录
+ (id)getWithdrawDepositListWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;


//充值
+ (id)getRechargeWithOrderCode:(NSString *)orderCode completionHandler:(void(^)(id model, NSError *error))completionHandler;





@end
