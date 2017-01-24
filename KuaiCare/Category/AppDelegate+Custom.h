//
//  AppDelegate+Custom.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/25.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Custom)

- (void)addGlobalConfig;
//只读属性，方便读取当前网络情况
@property (nonatomic, readonly, getter=isOnLine) BOOL onLine;

@end
