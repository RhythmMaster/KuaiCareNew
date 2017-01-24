//
//  HZWithdrawDepositListViewModel.h
//  dddd
//
//  Created by tang on 16/12/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMyCashchangeViewModel.h"

@interface HZWithdrawDepositListViewModel : NSObject


- (void)getWithdrawDepositListWithCompletionHandler:(void(^)(NSError *error))completionHandler;

- (HZWithdrawDepositListContentModel *)getWithdrawDepositListModelContentWithIndex:(NSInteger)index;

@property(nonatomic) NSArray<HZWithdrawDepositListContentModel *> *withdrawDepositListContent;
@property(nonatomic) HZWithdrawDepositListModel *withdrawDepositListModel;

@property(nonatomic) NSInteger rowOfNumber;

- (NSString *)getAlipayWithIndex:(NSInteger)index;
- (NSString *)getBillTimeWithIndex:(NSInteger)index;
- (NSString *)getDepositMoneyWithIndex:(NSInteger)index;
- (NSInteger)getDepositStatusWithIndex:(NSInteger)index;
- (NSString *)getDepositTimeWithIndex:(NSInteger)index;
- (NSString *)getFailureReasonWithIndex:(NSInteger)index;
- (NSString *)getIDWithIndex:(NSInteger)index;
- (NSString *)getPayTimeWithIndex:(NSInteger)index;
- (NSString *)getWithdrawDepositTimeWithIndex:(NSInteger)index;



@end
