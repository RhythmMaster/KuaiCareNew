//
//  SelectdoctorViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock) (NSString *str);
@interface SelectdoctorViewController : UIViewController
@property (nonatomic ,copy) myBlock block1;
@property (nonatomic ,copy) myBlock block2;
@property (nonatomic ,copy) myBlock block3;
@property (nonatomic ,copy) myBlock block4;
@property (nonatomic ,copy)NSString *datetimestr;
@end
