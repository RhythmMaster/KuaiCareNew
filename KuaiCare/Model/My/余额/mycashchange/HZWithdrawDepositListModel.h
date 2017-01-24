//
//  HZWithdrawDepositListModel.h
//  dddd
//
//  Created by tang on 16/12/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZWithdrawDepositListContentModel;
@interface HZWithdrawDepositListModel : NSObject

@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger allCount;
@property(nonatomic) NSArray<HZWithdrawDepositListContentModel *> *content;
@property(nonatomic) NSInteger state;

@end

@interface HZWithdrawDepositListContentModel : NSObject

@property(nonatomic) NSString *alipay;
@property(nonatomic) NSString *ID;
@property(nonatomic) NSString *failureReason;
@property(nonatomic) NSString *withdrawDepositTime;
@property(nonatomic) NSString *depositTime;
@property(nonatomic) NSString *payTime;
@property(nonatomic) NSInteger depositStatus;
@property(nonatomic) NSString *billTime;
@property(nonatomic) NSString *depositMoney;

@end
