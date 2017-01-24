//
//  HZOrderDetailViewModel.m
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderDetailViewModel.h"

@implementation HZOrderDetailViewModel

- (NSArray *)orderInfoArr {
    if (!_orderInfoArr) {
        _orderInfoArr = [NSArray new];
    }
    
    NSMutableArray *temArr = [NSMutableArray new];
    
    if (_orderDetailModel.orderStatus.integerValue == 7 || _orderDetailModel.orderStatus.integerValue == 8) {
        [temArr removeAllObjects];
        if (self.orderDetailModel.orderCode.length) {
            [temArr addObject:[NSString stringWithFormat:@"订单号: %@", self.orderDetailModel.orderCode]];
        }
        if (self.orderDetailModel.loginerPhone.length) {
            [temArr addObject:[NSString stringWithFormat:@"购买手机号码: %@", self.orderDetailModel.loginerPhone]];
        }
        if (self.orderDetailModel.createTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"下单时间: %@", self.orderDetailModel.createTime]];
        }
        if (self.orderDetailModel.cancelTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"取消时间: %@", self.orderDetailModel.cancelTime]];
        } else if (self.orderDetailModel.refuseTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"拒单时间: %@", self.orderDetailModel.refuseTime]];
        }
        if (self.orderDetailModel.refundTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"退款时间: %@", self.orderDetailModel.refundTime]];
        }
        _orderInfoArr = temArr.copy;
    } else {
        [temArr removeAllObjects];
        if (self.orderDetailModel.orderCode.length) {
            [temArr addObject:[NSString stringWithFormat:@"订单号: %@", self.orderDetailModel.orderCode]];
        }
        if (self.orderDetailModel.loginerPhone.length) {
            [temArr addObject:[NSString stringWithFormat:@"购买手机号: %@", self.orderDetailModel.loginerPhone]];
        }
        if (self.orderDetailModel.createTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"下单时间: %@", self.orderDetailModel.createTime]];
        }
        if (self.orderDetailModel.receiveTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"接单时间: %@", self.orderDetailModel.receiveTime]];
        }
        if (self.orderDetailModel.serviceTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"开始服务: %@", self.orderDetailModel.serviceTime]];
        }
        if (self.orderDetailModel.finishServiceTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"完成服务: %@", self.orderDetailModel.finishServiceTime]];
        }
        if (self.orderDetailModel.patientConfirmTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"确认服务: %@", self.orderDetailModel.patientConfirmTime]];
        }
        if (self.orderDetailModel.evaluateTime.length) {
            [temArr addObject:[NSString stringWithFormat:@"评价服务: %@", self.orderDetailModel.evaluateTime]];
        }
        _orderInfoArr = temArr.copy;
    }
    
    
    
    return _orderInfoArr;
}

- (HZOrderDetailModel *)orderDetailModel {
    if (!_orderDetailModel) {
        _orderDetailModel = [HZOrderDetailModel new];
    }
    return _orderDetailModel;
}

- (NSInteger)numberOfProject {
    return self.orderDetailModel.list.count;
}




- (void)getOrderInfoWithOrderId:(NSString *)orderId refundMode:(NSString *)refundMode completionHandler:(void (^)(NSError *))completionHandler {
    
    [HZOrderDetailNetManager getOrderInfoWithOrderId:orderId refundMode:refundMode completionHandler:^(HZOrderDetailModel *model, NSError *error) {
       
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            self.orderDetailModel = model;
            
        }
        !completionHandler ?: completionHandler(error);
        
    }];
}


- (NSString *)getTel {
    NSString *tel = self.orderDetailModel.tel;
    NSString *toTel = nil;
    if (tel.length > 4) {
        toTel = [tel substringToIndex:4];
        return [NSString stringWithFormat:@"%@****", toTel];
    } else {
        return tel;
    }
    
}


- (NSString *)getProjectNameWithIndex:(NSInteger)index {
    return self.orderDetailModel.list[index].name;
}
- (NSString *)getProjectFileWithIndex:(NSInteger)index {
    return self.orderDetailModel.list[index].file;
}
- (NSString *)getProjectPriceWithIndex:(NSInteger)index {
    return self.orderDetailModel.list[index].price;
}
- (NSString *)getProjectQuantityWithIndex:(NSInteger)index {
    return self.orderDetailModel.list[index].quantity;
}
- (NSString *)getProjectPriceTotalWithIndex:(NSInteger)index {
    return self.orderDetailModel.list[index].priceTotal;
}

@end
