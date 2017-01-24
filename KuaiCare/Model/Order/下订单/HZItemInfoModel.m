//
//  HZItemInfoModel.m
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZItemInfoModel.h"

@implementation HZItemInfoModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"msg": @"MSG",
             @"rtype": @"RETTYPE",
             @"desc": @"CONTENT.INFO.description",
             @"ID": @"CONTENT.INFO.id",
             @"orderNum": @"CONTENT.INFO.orderNum",
             @"file": @"CONTENT.INFO.file",
             @"nursingSkill": @"CONTENT.INFO.nursingSkill",
             @"isDel": @"CONTENT.INFO.isDel",
             @"userNotice": @"CONTENT.INFO.userNotice",
             @"jzrAge": @"CONTENT.INFO.jzrAge",
             @"code": @"CONTENT.INFO.code",
             @"theraplTime": @"CONTENT.INFO.therapyTime",
             @"serviceContent": @"CONTENT.INFO.serviceContent",
             @"isEnable": @"CONTENT.INFO.isEnable",
             @"servicePrice": @"CONTENT.INFO.servicePrice",
             @"name": @"CONTENT.INFO.name",
             @"itemList": @"CONTENT.INFO.itemlist",
             @"list": @"CONTENT.LIST",
             @"state": @"STATE",
             @"commonName": @"CONTENT.INFO.commonName",
             @"commonTel": @"CONTENT.INFO.commonTel",
             @"commonAddress": @"CONTENT.INFO.commonAddress",
             @"commonAddressInfo": @"CONTENT.INFO.commonAddressInfo",
             @"jzrName": @"CONTENT.INFO.jzrName",
             @"jzrTel": @"CONTENT.INFO.jzrTel",
             @"jzrSex": @"CONTENT.INFO.jzrSex",
             @"jzrId": @"CONTENT.INFO.jzrId"
             };
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{
             @"list": [HZItemInfoListModel class],
             @"itemList": [HZItemInfoItemListModel class]
             };
}


@end

@implementation HZItemInfoListModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"ID": @"id",
             @"desc": @"description"
             };
}

@end


@implementation HZItemInfoItemListModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"ID": @"id",
             @"desc": @"description"
             };
}

@end

