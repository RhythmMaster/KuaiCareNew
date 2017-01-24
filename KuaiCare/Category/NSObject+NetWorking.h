//
//  NSObject+NetWorking.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NetWorking)

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObj, NSError *error))completionHandler;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObj, NSError *error))completionHandler;

@end
