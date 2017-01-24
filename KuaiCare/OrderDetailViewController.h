//
//  OrderDetailViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/11/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock) ();

@interface OrderDetailViewController : UIViewController
@property(nonatomic) NSString *orderId;
@property(nonatomic) NSString *refundMode;

@property(nonatomic) NSString *gpsaddress;
@property(nonatomic) NSString *addressXY;

@property(nonatomic, copy) refreshBlock block;



@end
