//
//  ZhifuViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/11/4.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock) ();

@interface ZhifuViewController : UIViewController

@property(nonatomic) NSString *nurseName;
@property(nonatomic) NSString *nursePhone;
@property(nonatomic) NSString *address;

@property(nonatomic) NSString *patientName;
@property(nonatomic) NSString *patientSex;
@property(nonatomic) NSString *patientAge;

@property(nonatomic) NSString *nurseStr;
@property(nonatomic) NSString *head;
@property(nonatomic) NSString *appointmentTime;

@property(nonatomic) NSArray *projectArr;
@property(nonatomic) NSString *zhifuid;

@property(nonatomic) NSString *gpsaddress;

@property(nonatomic) NSString *addressxy;


@property(nonatomic, copy) refreshBlock block;

@end
