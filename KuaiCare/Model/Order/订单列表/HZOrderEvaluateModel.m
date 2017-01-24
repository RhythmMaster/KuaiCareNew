//
//  HZOrderEvaluateModel.m
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderEvaluateModel.h"

@implementation HZOrderEvaluateModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"classifyName": @"CONTENT.classifyName",
             @"classifyTime": @"CONTENT.classifyTime",
             @"file_0": @"CONTENT.file_0",
             @"file_1": @"CONTENT.file_1",
             @"ifile": @"CONTENT.ifile",
             @"itemName": @"CONTENT.itemName",
             @"medicName": @"CONTENT.medicName",
             @"payMoney": @"CONTENT.payMoney",
             @"msg": @"MSG",
             @"state": @"STATE",
             @"evaluateReason": @"CONTENT.evaluate_reason",
             @"onTime": @"CONTENT.on_time",
             @"nursingTechnique": @"CONTENT.nursing_technique",
             @"serviceAttitude": @"CONTENT.service_attitude"
             };
}

@end
