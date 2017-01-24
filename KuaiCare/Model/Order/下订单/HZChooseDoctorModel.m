//
//  HZChooseDoctorModel.m
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZChooseDoctorModel.h"

@implementation HZChooseDoctorModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"north": @"CONTENT.NORTH",
             @"south": @"CONTENT.SOUTH",
             @"userTime": @"usertime",
             @"state": @"STATE"};
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{@"north": [HZChooseDoctorDetailModel class],
             @"south": [HZChooseDoctorDetailModel class]};
}


@end

@implementation HZChooseDoctorDetailModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"ID": @"id"};
}


@end
