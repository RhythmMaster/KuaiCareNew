//
//  AppDelegate.h
//  KuaiCare
//
//  Created by macbook user on 16/10/24.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

typedef NS_ENUM(NSUInteger, TZLAlipayType){
    TZLAlipayTypeOrderMode,
    TZLAlipayTypeRechangeMode,
};

@property (strong, nonatomic) UIWindow *window;
- (void)showHomeViewController;

@property(nonatomic) BOOL haveLogin;

@property(nonatomic) NSInteger loginState;

@property(nonatomic, strong) NSString *rechange;

@property(nonatomic) TZLAlipayType alipayType;

@property(nonatomic, strong) NSDictionary *orderDic;

@end

