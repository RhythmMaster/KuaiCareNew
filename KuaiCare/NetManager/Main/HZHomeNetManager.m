//
//  HZHomeNetManager.m
//  KuaiCare
//
//  Created by tang on 16/12/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZHomeNetManager.h"

@implementation HZHomeNetManager

+ (id)getOrderInfoWithPage:(NSInteger)page rows:(NSInteger)rows orderStatus:(NSString *)orderStatus completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kOrderInfoPath];
    NSDictionary *parameters = nil;
    [parameters setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [parameters setValue:[NSNumber numberWithInteger:rows] forKey:@"rows"];
    
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

@end
