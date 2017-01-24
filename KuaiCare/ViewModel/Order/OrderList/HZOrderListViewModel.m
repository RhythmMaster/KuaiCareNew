//
//  HZOrderListViewModel.m
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderListViewModel.h"

@implementation HZOrderListViewModel

- (instancetype)initWithOrderType:(OrderType)orderType {
    if (self = [super init]) {
        self.orderType = orderType;
    }
    return self;
}

- (NSMutableArray<HZOrderListOrderListModel *> *)orderList {
    if (!_orderList) {
        _orderList = [NSMutableArray new];
    }
    return _orderList;
}

- (void)getContentWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
    [HZOrderListNetManager getOrderListWithOrderType:self.orderType page:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"15" completionHandler:^(HZOrderListModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.orderList removeAllObjects];
            } else {
                
            }
            [self.orderList addObjectsFromArray:model.orderList];
            _page = tmpPage;
            self.orderModel = model;
            
        }
        !completionHandler ?: completionHandler(error);
        
    }];
}

- (NSInteger)rowNumber {
    return self.orderList.count;
}

- (HZOrderListOrderListModel *)getContentWithRow:(NSInteger)row {
    return self.orderList[row];
}


- (NSString *)getOrderStatusNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].orderStatusName;
}
- (NSInteger)getOrderStatusWithRow:(NSInteger)row {
    return [self getContentWithRow:row].orderStatus;
}

- (NSString *)getItemNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].itemName;
}
- (NSString *)getItemClassifyNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].itemClassifyName;
}
- (NSString *)getFileWithRow:(NSInteger)row {
    return [self getContentWithRow:row].file;
}
- (NSString *)getMedicNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].medicName;
}

- (NSString *)getMedicPhoneWithPhone:(NSInteger)row {
    return [self getContentWithRow:row].medicPhone;
}

- (NSString *)getHospitalWithRow:(NSInteger)row {
    return [self getContentWithRow:row].hospital;
}
- (NSString *)getServiceNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].serviceName;
}
- (NSString *)getOrderMoneyWithRow:(NSInteger)row {
    return [self getContentWithRow:row].orderMoney;
}
- (NSString *)getPersonNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].personName;
}
- (NSString *)getAddressWithRow:(NSInteger)row {
    return [self getContentWithRow:row].addressInfo;
}
- (NSString *)getCreateTimeWithRow:(NSInteger)row {
    return [self getContentWithRow:row].createTime;
}
- (NSString *)getAppointmentTimeWithRow:(NSInteger)row {
    return [self getContentWithRow:row].appointmentTime;
}
- (NSString *)getIdWithRow:(NSInteger)row {
    return [self getContentWithRow:row].ID;
}
- (NSString *)getRefundStatusWithRow:(NSInteger)row {
    return [self getContentWithRow:row].refundStatus;
}

- (BOOL)isEvaluateWithRow:(NSInteger)row {
    return [self getContentWithRow:row].isEvaluate;
}

- (NSInteger)getMsgCount {
    return self.orderModel.msgCount;
}










@end
