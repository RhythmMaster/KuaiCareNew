//
//  HZHomeNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZHomeNetManager : NSObject

+ (id)getOrderInfoWithPage:(NSInteger)page rows:(NSInteger)rows orderStatus:(NSString *)orderStatus completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
