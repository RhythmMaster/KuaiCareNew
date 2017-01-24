//
//  IndexNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZIndexModel.h"

@interface IndexNetManager : NSObject

+ (id)getIndex11WithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;
+ (id)getIndexWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
