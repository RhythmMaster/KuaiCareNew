//
//  HZHealthCareViewModel.h
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HZHealthCareNetManager.h"

@interface HZHealthCareViewModel : NSObject

- (void)getHealtherWithTime:(NSString *)time name:(NSString *)name completonHandler:(void(^)(NSError *error))completionHandler;

@property(nonatomic) NSArray<HZChooseDoctorDetailModel *> *northContentArr;
@property(nonatomic) NSArray<HZChooseDoctorDetailModel *> *southContentArr;

@property(nonatomic) NSInteger northNumberOfRow;
@property(nonatomic) NSInteger southNumberOfRow;

@property(nonatomic) HZChooseDoctorModel *chooseDataModel;

- (HZChooseDoctorDetailModel *)getNorthContentModelWithIndex:(NSInteger)index;
- (HZChooseDoctorDetailModel *)getSouthContentModelWithIndex:(NSInteger)index;

//当前时间的数据
- (NSString *)getNorthPhoneWithIndex:(NSInteger)index;
- (NSString *)getNorthScoreWithIndex:(NSInteger)index;
- (NSString *)getNorthIDWithIndex:(NSInteger)index;
- (NSInteger)getNorthAgeWithIndex:(NSInteger)index;
- (NSString *)getNorthCountWithIndex:(NSInteger)index;
- (NSString *)getNorthHospitalWithIndex:(NSInteger)index;
- (NSString *)getNorthSexWithIndex:(NSInteger)index;
- (NSString *)getNorthNameWithIndex:(NSInteger)index;
- (NSString *)getNorthHeadWithIndex:(NSInteger)index;
//今日有时间的数据
- (NSString *)getSouthPhoneWithIndex:(NSInteger)index;
- (NSString *)getSouthScoreWithIndex:(NSInteger)index;
- (NSString *)getSouthIDWithIndex:(NSInteger)index;
- (NSInteger)getSouthAgeWithIndex:(NSInteger)index;
- (NSString *)getSouthCountWithIndex:(NSInteger)index;
- (NSString *)getSouthHospitalWithIndex:(NSInteger)index;
- (NSString *)getSouthSexWithIndex:(NSInteger)index;
- (NSString *)getSouthNameWithIndex:(NSInteger)index;
- (NSString *)getSouthHeadWithIndex:(NSInteger)index;

@end
