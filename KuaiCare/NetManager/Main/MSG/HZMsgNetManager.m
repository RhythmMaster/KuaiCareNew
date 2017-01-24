//
//  HZMsgNetManager.m
//  KuaiCare
//
//  Created by tang on 17/1/4.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZMsgNetManager.h"

@implementation HZMsgNetManager

+ (id)getMsgWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyMsgPath];
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZMsgModel parseJSON:jsonObj], error);
    }];
}

+ (id)getViewMsgWithID:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kViewMsgPath];
    NSDictionary *parameters = @{@"id": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZViewMsgModel parseJSON:jsonObj], error);
    }];
}

@end
