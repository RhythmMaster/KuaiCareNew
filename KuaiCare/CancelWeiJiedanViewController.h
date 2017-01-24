//
//  CancelWeiJiedanViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/11/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock) ();

@interface CancelWeiJiedanViewController : UIViewController
@property (nonatomic)NSString *rowid;
@property(nonatomic) NSString *gpsaddress;//gps定位地址
@property(nonatomic) NSString *addressXY;//医患下单时手机定位经纬度

@property(nonatomic, copy) refreshBlock block;

@end
