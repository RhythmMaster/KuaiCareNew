//
//  OrderPingjiaViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock) ();

@interface OrderPingjiaViewController : UIViewController

@property(nonatomic) NSString *orderId;

@property(nonatomic) BOOL isEvaluate;

@property(nonatomic, copy) refreshBlock block;

@end
