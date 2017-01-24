//
//  HZMyCenterIndexNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/30.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZHZMyCenterIndexModel.h"

@interface HZMyCenterIndexNetManager : NSObject

+ (id)getMyCenterIndexWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

//关于我们
+ (id)getAboutUSWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
