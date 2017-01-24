//
//  HZOrderDetailNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderDetailModel.h"

@interface HZOrderDetailNetManager : NSObject


+ (id)getOrderInfoWithOrderId:(NSString *)orderId refundMode:(NSString *)refundMode completionHandler:(void(^)(id model, NSError *error))completionHandler;




+ (id)getOrderAlipayWithOrderId:(NSDictionary *)data completionHandler:(void(^)(id model, NSError *error))completionHandler;



@end
