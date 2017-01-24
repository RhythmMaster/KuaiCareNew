//
//  HZOrderListModel.h
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZOrderListOrderListModel;
@interface HZOrderListModel : NSObject

@property(nonatomic) NSInteger allCount;
@property(nonatomic) NSInteger msgCount;
@property(nonatomic) NSArray<HZOrderListOrderListModel *> *orderList;
@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger state;

@end

@interface HZOrderListOrderListModel : NSObject

@property(nonatomic) NSString *address;
@property(nonatomic) NSString *addressInfo;
@property(nonatomic) NSString *hospital;
@property(nonatomic) NSString *head;
@property(nonatomic) NSString *appointmentTime;
@property(nonatomic) NSString *createTime;
@property(nonatomic) NSString *file;
@property(nonatomic) NSString *ID;
@property(nonatomic) NSInteger isComplaint;
@property(nonatomic) NSInteger isEvaluate;
@property(nonatomic) NSString *itemClassifyName;
@property(nonatomic) NSString *itemName;
@property(nonatomic) NSString *medicName;
@property(nonatomic) NSString *medicPhone;
@property(nonatomic) NSString *orderMoney;
@property(nonatomic) NSInteger orderStatus;
@property(nonatomic) NSString *orderStatusName;
@property(nonatomic) NSString *payMoney;
@property(nonatomic) NSString *personName;
@property(nonatomic) NSString *refundStatus;
@property(nonatomic) NSString *refundTime;
@property(nonatomic) NSString *serviceName;








@end
