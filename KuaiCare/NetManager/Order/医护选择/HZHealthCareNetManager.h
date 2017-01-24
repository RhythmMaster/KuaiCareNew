//
//  HZHealthCareNetManager.h
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZChooseDoctorModel.h"
#import "HZMedicDisplayModel.h"

@interface HZHealthCareNetManager : NSObject
//医护选择
+ (id)getHealthCaceDoctorShowWithTime:(NSString *)time completionHandler:(void(^)(id model, NSError *error))completionHandler;
//医护查看
+ (id)getMedicDisplayWithMedicId:(NSString *)medicId page:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;


//
+ (id)getHealthCaceDoctorShowWithTime:(NSString *)time name:(NSString *)name completionHandler:(void(^)(id model, NSError *error))completionHandler;
@end
