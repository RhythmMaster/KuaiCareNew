//
//  HZWithdrawDepositListViewModel.m
//  dddd
//
//  Created by tang on 16/12/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithdrawDepositListViewModel.h"

@implementation HZWithdrawDepositListViewModel

- (NSArray<HZWithdrawDepositListContentModel *> *)withdrawDepositListContent {
    if (!_withdrawDepositListContent) {
        _withdrawDepositListContent = [NSArray new];
    }
    return _withdrawDepositListContent;
}

- (NSInteger)rowOfNumber {
    return self.withdrawDepositListContent.count;
}

- (void)getWithdrawDepositListWithCompletionHandler:(void (^)(NSError *))completionHandler {
    [HZMyMyCashchangeNM getWithdrawDepositListWithCompletionHandler:^(HZWithdrawDepositListModel *model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.withdrawDepositListContent = model.content;
            self.withdrawDepositListModel = model;
            
        }
        !completionHandler ?: completionHandler(error);
    }];
}
- (HZWithdrawDepositListContentModel *)getWithdrawDepositListModelContentWithIndex:(NSInteger)index {
    return self.withdrawDepositListContent[index];
}

- (NSString *)getAlipayWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].alipay;
}
- (NSString *)getBillTimeWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].billTime;
}
- (NSString *)getDepositMoneyWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].depositMoney;
}
- (NSInteger)getDepositStatusWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].depositStatus;
}
- (NSString *)getDepositTimeWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].depositTime;
}
- (NSString *)getFailureReasonWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].failureReason;
}
- (NSString *)getIDWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].ID;
}
- (NSString *)getPayTimeWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].payTime;
}
- (NSString *)getWithdrawDepositTimeWithIndex:(NSInteger)index {
    return [self getWithdrawDepositListModelContentWithIndex:index].withdrawDepositTime;
}


@end
