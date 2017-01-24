//
//  HZIndexViewModel.m
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZIndexViewModel.h"

@implementation HZIndexViewModel

- (void)getIndexModelWithCompletionHandler:(void (^)(NSError *))completionHandler {
    [IndexNetManager getIndexWithCompletionHandler:^(HZIndexModel *model, NSError *error) {
        if (!error) {
            self.indexModel = model;
            
        }
        !completionHandler ?: completionHandler(error);
    }];
}

@end
