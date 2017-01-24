//
//  HZMyMyCashchangeNM.m
//  KuaiCare
//
//  Created by tang on 17/1/4.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZMyMyCashchangeNM.h"

@implementation HZMyMyCashchangeNM

+ (id)getMyCashchangeWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kMycashchangePath];
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZMycashchangeModel parseJSON:jsonObj], error);
    }];
}

+ (id)getWaitWithdrawDepositWithCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kWaitWithdrawDepositPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZWaitWithdrawModel parseJSON:jsonObj], error);
    }];
}
+ (id)getWithdrawDepositWithDepositMoney:(NSString *)depositMoney withdrawDepositCase:(NSString *)withdrawDepositCase completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kWithdrawDepositPath];
    NSDictionary *parameters = @{@"depositMoney": depositMoney, @"withdrawDepositCase": withdrawDepositCase};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getWithdrawDepositListWithCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kWithdrawDepositListPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZWithdrawDepositListModel parseJSON:jsonObj], error);
    }];
}

+ (id)getRechargeWithOrderCode:(NSString *)orderCode completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kRechargePath];
    NSDictionary *parameters = @{@"code": orderCode};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


@end
