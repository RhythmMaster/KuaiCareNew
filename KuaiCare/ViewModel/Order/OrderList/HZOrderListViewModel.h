//
//  HZOrderListViewModel.h
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderListNetManager.h"

typedef NS_ENUM(NSUInteger, VMRequestMode){
    VMRequestModeRefresh,
    VMRequestModeMore,
};


@interface HZOrderListViewModel : NSObject

@property(nonatomic) NSMutableArray<HZOrderListOrderListModel *> *orderList;
@property(nonatomic) NSInteger rowNumber;
@property(nonatomic) NSInteger page;
@property(nonatomic) OrderType orderType;
@property(nonatomic) HZOrderListModel *orderModel;

- (instancetype)initWithOrderType:(OrderType)orderType;

- (void)getContentWithRequestMode:(VMRequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;
- (HZOrderListOrderListModel *)getContentWithRow:(NSInteger)row;


- (NSInteger)getMsgCount;

- (NSString *)getOrderStatusNameWithRow:(NSInteger)row;
- (NSString *)getItemNameWithRow:(NSInteger)row;
- (NSString *)getItemClassifyNameWithRow:(NSInteger)row;


- (NSString *)getFileWithRow:(NSInteger)row;
- (NSString *)getMedicNameWithRow:(NSInteger)row;
- (NSString *)getMedicPhoneWithPhone:(NSInteger)row;
- (NSString *)getHospitalWithRow:(NSInteger)row;
- (NSString *)getServiceNameWithRow:(NSInteger)row;
- (NSString *)getOrderMoneyWithRow:(NSInteger)row;

- (NSString *)getPersonNameWithRow:(NSInteger)row;
- (NSString *)getAddressWithRow:(NSInteger)row;
- (NSString *)getCreateTimeWithRow:(NSInteger)row;
- (NSString *)getAppointmentTimeWithRow:(NSInteger)row;

- (NSInteger)getOrderStatusWithRow:(NSInteger)row;

//传到详细页的参数
- (NSString *)getIdWithRow:(NSInteger)row;
- (NSString *)getRefundStatusWithRow:(NSInteger)row;

- (BOOL)isEvaluateWithRow:(NSInteger)row;

@end
