//
//  HZOrderListOperationNetManager.m
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderListOperationNetManager.h"

@implementation HZOrderListOperationNetManager

+ (id)deleteOrderWithOrderId:(NSString *)orderId completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kDeleteOrderPath];
    NSDictionary *parameters = @{@"orderId": orderId};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)confirmServiceWithOrderId:(NSString *)orderId address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kConfirmServicePath];
    NSDictionary *paramters = @{@"orderId": orderId, @"address": address, @"addressXY": addressXY};
    return [self POST:path parameters:paramters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)orderEvaluateWithOrderId:(NSString *)orderId completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kOrderEvaluatePath];
    NSDictionary *parameters = @{@"orderId": orderId};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZOrderEvaluateModel parseJSON:jsonObj], error);
    }];
}

+ (id)evaluateSaveWithOrderId:(NSString *)orderId onTime:(NSString *)onTime nursingTechnique:(NSString *)nursingTechnique serviceAttitude:(NSString *)serviceAttitude evaluateReason:(NSString *)evaluateReason completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kEvaluateSavePath];
    NSDictionary *dict = @{@"orderId": orderId, @"onTime": onTime, @"nursingTechnique": nursingTechnique, @"serviceAttitude": serviceAttitude, @"evaluateReason": evaluateReason};
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // NSString *string = [NSString stringWithFormat:@"%@", paramters];
    NSDictionary *parameters = @{@"data":myString};

    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZOrderEvaluateModel parseJSON:jsonObj], error);
    }];
}


+ (id)evaluateDisplayWithOrderId:(NSString *)orderId completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kEvaluateDisplayPath];
    NSDictionary *parameters = @{@"orderId": orderId};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZOrderEvaluateModel parseJSON:jsonObj], error);
    }];
}




@end
