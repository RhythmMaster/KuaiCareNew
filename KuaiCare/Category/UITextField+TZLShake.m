//
//  UITextField+TZLShake.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/7/28.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "UITextField+TZLShake.h"

@implementation UITextField (TZLShake)

- (void)shake {
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    keyFrame.duration = 0.4;
    CGFloat x = self.layer.position.x;
    keyFrame.values = @[@(x + 50), @(x - 50), @(x + 40), @(x - 40), @(x + 30), @(x - 30), @(x + 20), @(x - 20), @(x + 10), @(x - 10), @(x + 5), @(x - 5)];
    [self.layer addAnimation:keyFrame forKey:@"shake"];
}

@end
