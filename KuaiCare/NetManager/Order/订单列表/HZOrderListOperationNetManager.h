//
//  HZOrderListOperationNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderEvaluateModel.h"

@interface HZOrderListOperationNetManager : NSObject
//删除订单
+ (id)deleteOrderWithOrderId:(NSString *)orderId completionHandler:(void(^)(id model, NSError *error))completionHandler;
//确认服务
+ (id)confirmServiceWithOrderId:(NSString *)orderId address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void(^)(id model, NSError *error))completionHandler;

//评价服务
+ (id)orderEvaluateWithOrderId:(NSString *)orderId completionHandler:(void(^)(id model, NSError *error))completionHandler;

//保存评价
+ (id)evaluateSaveWithOrderId:(NSString *)orderId onTime:(NSString *)onTime nursingTechnique:(NSString *)nursingTechnique serviceAttitude:(NSString *)serviceAttitude evaluateReason:(NSString *)evaluateReason completionHandler:(void(^)(id model, NSError *error))completionHandler;

//查看评价
+ (id)evaluateDisplayWithOrderId:(NSString *)orderId completionHandler:(void(^)(id model, NSError *error))completionHandler;



@end
