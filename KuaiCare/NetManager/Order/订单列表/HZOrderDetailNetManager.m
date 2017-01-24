//
//  HZOrderDetailNetManager.m
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderDetailNetManager.h"

@implementation HZOrderDetailNetManager
+ (id)getOrderInfoWithOrderId:(NSString *)orderId refundMode:(NSString *)refundMode completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kOrderInfoPath];
    NSDictionary *parameters = nil;
    
    if (refundMode.length) {
        parameters = @{@"orderId": orderId, @"refund_mode": refundMode};
    } else {
        parameters = @{@"orderId": orderId};
    }
    
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler([HZOrderDetailModel parseJSON:jsonObj], error);
        
    }];
}


+ (id)getOrderAlipayWithOrderId:(NSDictionary *)data completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kAliPayPath];
    NSDictionary *parameters = data;
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}







@end
