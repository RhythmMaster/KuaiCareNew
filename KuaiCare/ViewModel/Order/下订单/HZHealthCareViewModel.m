//
//  HZHealthCareViewModel.m
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZHealthCareViewModel.h"

@implementation HZHealthCareViewModel

- (NSArray<HZChooseDoctorDetailModel *> *)northContentArr {
    if (!_northContentArr) {
        _northContentArr = [NSArray new];
    }
    return _northContentArr;
}

- (NSArray<HZChooseDoctorDetailModel *> *)southContentArr {
    if (!_southContentArr) {
        _southContentArr = [NSArray new];
    }
    return _southContentArr;
}

- (void)getHealtherWithTime:(NSString *)time name:(NSString *)name completonHandler:(void (^)(NSError *))completionHandler {
    if (name.length == 0) {
        [HZHealthCareNetManager getHealthCaceDoctorShowWithTime:time completionHandler:^(HZChooseDoctorModel *model, NSError *error) {
            
            if (error) {
                NSLog(@"%@", error);
            } else {
                self.chooseDataModel = model;
                
                self.northContentArr = model.north;
                self.southContentArr = model.south;
                
            }
            
            !completionHandler ?: completionHandler(error);
            
            
        }];
    } else {
        [HZHealthCareNetManager getHealthCaceDoctorShowWithTime:time name:name completionHandler:^(HZChooseDoctorModel *model, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                self.chooseDataModel = model;
                
                self.northContentArr = model.north;
                self.southContentArr = model.south;
                
            }
            
            !completionHandler ?: completionHandler(error);
        }];
    }
    
}

- (NSInteger)northNumberOfRow {
    return _northContentArr.count;
}

- (NSInteger)southNumberOfRow {
    return _southContentArr.count;
}

- (HZChooseDoctorDetailModel *)getNorthContentModelWithIndex:(NSInteger)index {
    return self.northContentArr[index];
}
- (NSString *)getNorthPhoneWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].phone;
}
- (NSString *)getNorthScoreWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].score;
}
- (NSString *)getNorthIDWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].ID;
}
- (NSInteger)getNorthAgeWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].age;
}
- (NSString *)getNorthCountWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].count;
}
- (NSString *)getNorthHospitalWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].hospital;
}
- (NSString *)getNorthSexWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].sex;
}
- (NSString *)getNorthNameWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].name;
}
- (NSString *)getNorthHeadWithIndex:(NSInteger)index {
    return [self getNorthContentModelWithIndex:index].head;
}


- (HZChooseDoctorDetailModel *)getSouthContentModelWithIndex:(NSInteger)index {
    return self.southContentArr[index];
}
- (NSString *)getSouthPhoneWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].phone;
}
- (NSString *)getSouthScoreWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].score;
}
- (NSString *)getSouthIDWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].ID;
}
- (NSInteger)getSouthAgeWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].age;
}
- (NSString *)getSouthCountWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].count;
}
- (NSString *)getSouthHospitalWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].hospital;
}
- (NSString *)getSouthSexWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].sex;
}
- (NSString *)getSouthNameWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].name;
}
- (NSString *)getSouthHeadWithIndex:(NSInteger)index {
    return [self getSouthContentModelWithIndex:index].head;
}

@end
