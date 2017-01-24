//
//  HZDataHandler.m
//  KuaiCare
//
//  Created by tang on 17/1/9.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZDataHandler.h"
static HZDataHandler *dataHandle = nil;
@implementation HZDataHandler

+ (instancetype)sharedHadle {
    if (nil == dataHandle) {
        dataHandle = [[HZDataHandler alloc] init];
    }
    return dataHandle;
}

//也可以使用多线程创建
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//    datahandle = [[Datahandle alloc]init];
//    });
//
//   return datahandle;

@end
