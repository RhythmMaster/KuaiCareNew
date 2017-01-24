//
//  ChooseCityViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/10/28.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock) (NSString *str);
@interface ChooseCityViewController : UIViewController
@property (nonatomic ,copy) myBlock block;
@end
