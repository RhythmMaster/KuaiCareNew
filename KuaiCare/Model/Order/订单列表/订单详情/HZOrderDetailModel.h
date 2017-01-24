//
//  HZOrderDetailModel.h
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZOrderDetailListModel;
@interface HZOrderDetailModel : NSObject

@property(nonatomic) NSString *address;
@property(nonatomic) NSString *addressInfo;
@property(nonatomic) NSString *appointmentTime;
@property(nonatomic) NSString *cashReserve;
@property(nonatomic) NSString *createTime;
@property(nonatomic) NSString *finishServiceTime;
@property(nonatomic) NSString *evaluateReason;
@property(nonatomic) NSString *evaluateTime;
@property(nonatomic) NSString *cancelTime;
@property(nonatomic) NSString *refuseTime;
@property(nonatomic) NSString *head;
@property(nonatomic) CGFloat integralConversion;
@property(nonatomic) CGFloat integralReserve;
@property(nonatomic) NSString *isComplaint;
@property(nonatomic) NSString *isEvaluate;
@property(nonatomic) NSString *itemName;
@property(nonatomic) NSString *loginerPhone;
@property(nonatomic) NSString *medicAddress;
@property(nonatomic) NSString *medicHospital;
@property(nonatomic) NSString *medicName;
@property(nonatomic) NSString *medicPhone;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *orderCode;
@property(nonatomic) NSString *orderId;
@property(nonatomic) NSString *orderMoney;
@property(nonatomic) NSString *orderStatus;
@property(nonatomic) NSString *patientConfirmTime;
@property(nonatomic) NSString *payMoney;
@property(nonatomic) NSInteger personAge;
@property(nonatomic) NSString *personName;
@property(nonatomic) NSString *personSex;
@property(nonatomic) NSString *receiveTime;
@property(nonatomic) NSString *refundStatus;
@property(nonatomic) NSString *refundTime;
@property(nonatomic) NSString *serviceTime;
@property(nonatomic) NSString *serviceHotline;
@property(nonatomic) NSString *synthesizeScore;
@property(nonatomic) NSString *tel;
@property(nonatomic) NSArray<HZOrderDetailListModel *> *list;


@end
@interface HZOrderDetailListModel : NSObject

@property(nonatomic) NSString *file;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *price;
@property(nonatomic) NSString *priceTotal;
@property(nonatomic) NSString *quantity;

@end


