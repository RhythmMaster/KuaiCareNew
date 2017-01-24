//
//  HZMsgNetManager.h
//  KuaiCare
//
//  Created by tang on 17/1/4.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMsgModel.h"
#import "HZViewMsgModel.h"

@interface HZMsgNetManager : NSObject

//消息
+ (id)getMsgWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;

//查看消息
+ (id)getViewMsgWithID:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;



@end
