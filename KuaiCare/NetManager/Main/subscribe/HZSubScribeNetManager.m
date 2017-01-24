//
//  HZSubScribeNetManager.m
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZSubScribeNetManager.h"

@implementation HZSubScribeNetManager

+ (id)getSubScribeWithCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", KCBaseURLString, kItemInfoPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler([HZItemInfoModel parseJSON:jsonObj], error);
    }];
}

@end
