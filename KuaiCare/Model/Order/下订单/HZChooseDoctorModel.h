//
//  HZChooseDoctorModel.h
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZChooseDoctorDetailModel;
@interface HZChooseDoctorModel : NSObject

@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger retype;
@property(nonatomic) NSArray<HZChooseDoctorDetailModel *> *north;
@property(nonatomic) NSArray<HZChooseDoctorDetailModel *> *south;

@property(nonatomic) NSInteger userTime;
@property(nonatomic) NSInteger state;


@end

@interface HZChooseDoctorDetailModel : NSObject

@property(nonatomic) NSString *phone;
@property(nonatomic) NSString *score;
@property(nonatomic) NSString *ID;
@property(nonatomic) NSInteger age;
@property(nonatomic) NSString *count;
@property(nonatomic) NSString *hospital;
@property(nonatomic) NSString *sex;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *head;


@end
