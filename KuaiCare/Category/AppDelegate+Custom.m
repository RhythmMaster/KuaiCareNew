//
//  AppDelegate+Custom.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/25.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "AppDelegate+Custom.h"

@implementation AppDelegate (Custom)

- (void)addGlobalConfig{
    // 1.使用AF发送网络请求时，在状态栏有菊花提示
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // 2.启动网络状态监测 
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    //启动网络状态监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    
    //4.解决iOS右滑返回失效，因为自定义导航栏按钮导致  MLTransitionGestureRecognizerTypeScreenEdgePan：边缘滑动
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    
}

- (BOOL)isOnLine{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    //手机网络或者WIFI都属于在线状态
    return status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
