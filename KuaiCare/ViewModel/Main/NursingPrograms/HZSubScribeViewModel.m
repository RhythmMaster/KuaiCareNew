//
//  HZSubScribeViewModel.m
//  KuaiCare
//
//  Created by tang on 16/12/19.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZSubScribeViewModel.h"

@implementation HZSubScribeViewModel

- (void)getSubScribeModelWithCompletionHandler:(void (^)(NSError *))completionHandler {
 
    [HZSubScribeNetManager getSubScribeWithCompletionHandler:^(HZItemInfoModel *model, NSError *error) {
        if (!error) {
            self.itemModel = model;
            
        }
        !completionHandler ?: completionHandler(error);
        
    }];
}


@end
