//
//  UIBarButtonItem+KCBarButtonItem.m
//  KuaiCare
//
//  Created by macbook user on 16/10/24.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "UIBarButtonItem+KCBarButtonItem.h"

@implementation UIBarButtonItem (KCBarButtonItem)
+(UIBarButtonItem*)withBarItem:(NSString *)imageName name:(NSString*)name target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:name  forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
@end
