//
//  HZIndexViewModel.h
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndexNetManager.h"

@interface HZIndexViewModel : NSObject

@property(nonatomic) HZIndexModel *indexModel;

- (void)getIndexModelWithCompletionHandler:(void(^)(NSError *error))completionHandler;

@end
