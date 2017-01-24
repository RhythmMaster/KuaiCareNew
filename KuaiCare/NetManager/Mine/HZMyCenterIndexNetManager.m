//
//  HZMyCenterIndexNetManager.m
//  KuaiCare
//
//  Created by tang on 16/12/30.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZMyCenterIndexNetManager.h"

@implementation HZMyCenterIndexNetManager

+ (id)getMyCenterIndexWithCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kIndexPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler([HZHZMyCenterIndexModel parseJSON:jsonObj], error);
    }];
}

+ (id)getAboutUSWithCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kAboutUSPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

@end
