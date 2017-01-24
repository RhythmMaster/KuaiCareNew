//
//  HZEditPatientNetManager.m
//  KuaiCare
//
//  Created by tang on 17/1/16.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZEditPatientNetManager.h"

@implementation HZEditPatientNetManager

+ (id)modifyPatientWithID:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kSeeDoctorPersonViewPath];
    NSDictionary *parameters = @{@"id": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler([HZSeePatientInfoModel parseJSON:jsonObj], error);
    }];
}



+ (id)savePatientInfoWithName:(NSString *)name tel:(NSString *)tel sex:(NSString *)sex birthday:(NSString *)birthday IdCard:(NSString *)IdCard mediCcareCard:(NSString *)medicCareCard completionHandler:(void(^)(id model, NSError *error))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kEditseedoctorpersonPath];
    if (IdCard.length == 0) {
        IdCard = @"";
    }
    if (medicCareCard.length == 0) {
        medicCareCard = @"";
    }
    NSDictionary *parameters = @{
                                 @"name": name,
                                 @"tel": tel,
                                 @"sex": sex,
                                 @"birthday": birthday,
                                 @"idcard": IdCard,
                                 @"medicareCard": medicCareCard
                                 };
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

@end
