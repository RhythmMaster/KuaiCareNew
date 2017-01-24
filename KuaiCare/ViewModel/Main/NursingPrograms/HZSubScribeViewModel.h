//
//  HZSubScribeViewModel.h
//  KuaiCare
//
//  Created by tang on 16/12/19.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZSubScribeNetManager.h"

@interface HZSubScribeViewModel : NSObject

@property(nonatomic) HZItemInfoModel *itemModel;
- (void)getSubScribeModelWithCompletionHandler:(void(^)(NSError *error))completionHandler;



@end
