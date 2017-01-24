//
//  HZOrderDetailModel.m
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderDetailModel.h"

@implementation HZOrderDetailModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"address": @"CONTENT.INFO.address",
             @"addressInfo": @"CONTENT.INFO.address_info",
             @"appointmentTime": @"CONTENT.INFO.appointment_time",
             @"cashReserve": @"CONTENT.INFO.cash_reserve",
             @"createTime": @"CONTENT.INFO.create_time",
             @"cancelTime": @"CONTENT.INFO.cancel_time",
             @"refuseTime": @"CONTENT.INFO.refuse_time",
             @"evaluateTime": @"CONTENT.INFO.evaluate_time",
             @"evaluateReason": @"CONTENT.INFO.evaluate_reason",
             @"finishServiceTime": @"CONTENT.INFO.finishServiceTime",
             @"head": @"CONTENT.INFO.head",
             @"integralConversion": @"CONTENT.INFO.integral_conversion",
             @"integralReserve": @"CONTENT.INFO.integral_reserve",
             @"isComplaint": @"CONTENT.INFO.is_complaint",
             @"isEvaluate": @"CONTENT.INFO.is_evaluate",
             @"itemName": @"CONTENT.INFO.item_name",
             @"loginerPhone": @"CONTENT.INFO.loginer_phone",
             @"medicAddress": @"CONTENT.INFO.medic_address",
             @"medicHospital": @"CONTENT.INFO.medic_hospital",
             @"medicName": @"CONTENT.INFO.medic_name",
             @"medicPhone": @"CONTENT.INFO.medic_phone",
             @"name": @"CONTENT.INFO.name",
             @"orderCode": @"CONTENT.INFO.order_code",
             @"orderId": @"CONTENT.INFO.order_id",
             @"orderMoney": @"CONTENT.INFO.order_money",
             @"orderStatus": @"CONTENT.INFO.order_status",
             @"patientConfirmTime": @"CONTENT.INFO.patientConfirmTime",
             @"payMoney": @"CONTENT.INFO.pay_money",
             @"personAge": @"CONTENT.INFO.person_age",
             @"personName": @"CONTENT.INFO.person_name",
             @"personSex": @"CONTENT.INFO.person_sex",
             @"receiveTime": @"CONTENT.INFO.receive_time",
             @"refundStatus": @"CONTENT.INFO.refund_status",
             @"refundTime": @"CONTENT.INFO.refund_time",
             @"serviceTime": @"CONTENT.INFO.serviceTime",
             @"serviceHotline": @"CONTENT.INFO.service_hotline",
             @"synthesizeScore": @"CONTENT.INFO.synthesize_score",
             @"tel": @"CONTENT.INFO.tel",
             @"list": @"CONTENT.LIST"
             };
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{@"list": [HZOrderDetailListModel class]};
}

@end

@implementation HZOrderDetailListModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"file": @"file",
             @"name": @"name",
             @"price": @"price",
             @"priceTotal": @"price_total",
             @"quantity": @"quantity"
             };
}

@end
