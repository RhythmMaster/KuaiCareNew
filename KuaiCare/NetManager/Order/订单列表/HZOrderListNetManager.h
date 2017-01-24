//
//  HZOrderListNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderListModel.h"


typedef NS_ENUM(NSUInteger, OrderType) {
    OrderTypeAll,
    OrderTypeOn,
    OrderTypeOver
};


@interface HZOrderListNetManager : NSObject

+ (id)getOrderListWithOrderType:(OrderType)orderType page:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
