//
//  YihuMapViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/11/7.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock) (NSString *str);
@interface YihuMapViewController : UIViewController
@property (nonatomic ,copy) myBlock block;
@end
