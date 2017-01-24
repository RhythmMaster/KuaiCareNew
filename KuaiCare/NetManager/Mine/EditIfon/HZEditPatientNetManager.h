//
//  HZEditPatientNetManager.h
//  KuaiCare
//
//  Created by tang on 17/1/16.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZSeePatientInfoModel.h"

@interface HZEditPatientNetManager : NSObject

//就诊人修改
+ (id)modifyPatientWithID:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;


//就诊人保存
+ (id)savePatientInfoWithName:(NSString *)name tel:(NSString *)tel sex:(NSString *)sex birthday:(NSString *)birthday IdCard:(NSString *)IdCard mediCcareCard:(NSString *)medicCareCard completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
