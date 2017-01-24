//
//  HZSubScribeNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZItemInfoModel.h"

@interface HZSubScribeNetManager : NSObject

+ (id)getSubScribeWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
