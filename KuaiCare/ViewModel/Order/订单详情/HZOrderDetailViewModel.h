//
//  HZOrderDetailViewModel.h
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderDetailNetManager.h"

@interface HZOrderDetailViewModel : NSObject

@property(nonatomic) HZOrderDetailModel *orderDetailModel;
@property(nonatomic) NSInteger numberOfProject;


@property(nonatomic) NSArray *orderInfoArr;

- (void)getOrderInfoWithOrderId:(NSString *)orderId refundMode:(NSString *)refundMode completionHandler:(void(^)(NSError *error))completionHandler;


//- (NSString *)getName;
//- (NSString *)getTel;
//- (NSString *)getAddressInfoWithIndex:(NSInteger)index;
//- (NSString *)getPersonNameWithIndex:(NSInteger)index;
//- (NSString *)getPersonSexWithIndex:(NSInteger)index;
//- (NSString *)getPersonAgeWithIndex:(NSInteger)index;
//
//
//
//- (NSString *)getMedicNameWithIndex:(NSInteger)index;
//- (NSString *)getMedicHospitalWithIndex:(NSInteger)index;
//- (NSString *)getMedicAddressWithIndex:(NSInteger)index;
//- (NSString *)getAppointmentTimeWithIndex:(NSInteger)index;
//- (NSString *)getMedicPhoneWithIndex:(NSInteger)index;

- (NSString *)getTel;



- (NSString *)getProjectNameWithIndex:(NSInteger)index;
- (NSString *)getProjectQuantityWithIndex:(NSInteger)index;
- (NSString *)getProjectPriceWithIndex:(NSInteger)index;
- (NSString *)getProjectPriceTotalWithIndex:(NSInteger)index;
- (NSString *)getProjectFileWithIndex:(NSInteger)index;

@end
