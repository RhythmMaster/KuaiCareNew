//
//  HZOrderListModel.m
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderListModel.h"

@implementation HZOrderListModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"allCount": @"ALLCOUNT",
             @"msgCount": @"CONTENT.INFO.msgCount",
             @"orderList": @"CONTENT.LIST",
             @"msg": @"MSG",
             @"state": @"STATE"
             };
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{
             @"orderList": [HZOrderListOrderListModel class]
             };
}

@end

@implementation HZOrderListOrderListModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"address": @"address",
             @"addressInfo": @"address_info",
             @"appointmentTime": @"appointment_time",
             @"createTime": @"create_time",
             @"file": @"file",
             @"ID": @"id",
             @"isComplaint": @"is_complaint",
             @"isEvaluate": @"is_evaluate",
             @"itemClassifyName": @"item_classify_name",
             @"itemName": @"item_name",
             @"medicName": @"medic_name",
             @"medicPhone": @"medic_phone",
             @"orderMoney": @"order_money",
             @"orderStatus": @"order_status",
             @"orderStatusName": @"order_status_name",
             @"payMoney": @"pay_money",
             @"personName": @"person_name",
             @"refundStatus": @"refund_status",
             @"refundTime": @"refund_time",
             @"serviceName": @"service_name"
             };
}

@end
