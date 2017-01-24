//
//  HZHealthCareNetManager.m
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZHealthCareNetManager.h"

@implementation HZHealthCareNetManager

+ (id)getHealthCaceDoctorShowWithTime:(NSString *)time completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kHealthCarePath];
    NSDictionary *parameters = @{@"dateStr":  time};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler([HZChooseDoctorModel parseJSON:jsonObj], error);
    }];
}


+ (id)getMedicDisplayWithMedicId:(NSString *)medicId page:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kMedicDisplayPath];
    NSDictionary *parameters = @{@"medicId": medicId, @"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler([HZMedicDisplayModel parseJSON:jsonObj], error);
        
    }];
}

+ (id)getHealthCaceDoctorShowWithTime:(NSString *)time name:(NSString *)name completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kHealthCarePath];
    NSDictionary *parameters = @{@"dateStr": time, @"name": name};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZChooseDoctorModel parseJSON:jsonObj], error);
    }];

}

@end
