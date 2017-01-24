//
//  UIView+HUD.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/28.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)
//忙提示
- (void)showBusyHUD;
//文字提示
- (void)showWarning:(NSString *)warning;
//隐藏提示
- (void)hideBusyHUD;
@end
