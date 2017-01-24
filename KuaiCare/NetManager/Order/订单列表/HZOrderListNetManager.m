//
//  HZOrderListNetManager.m
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderListNetManager.h"

@implementation HZOrderListNetManager


+ (id)getOrderListWithOrderType:(OrderType)orderType page:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kLstOrderPath];
    NSDictionary *parameters = nil;
    switch (orderType) {
        case OrderTypeAll: {
            parameters = @{@"page": page, @"rows": rows};
            break;
        }
        case OrderTypeOn: {
            parameters = @{@"page": page, @"rows": rows, @"order_status":@"1"};
            break;
        }
        case OrderTypeOver: {
            parameters = @{@"page": page, @"rows": rows, @"order_status":@"2"};
            break;
        }
    }
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZOrderListModel parseJSON:jsonObj], error);
    }];
    
}

@end
