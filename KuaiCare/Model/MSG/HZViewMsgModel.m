//
//  HZViewMsgModel.m
//  dddd
//
//  Created by tang on 16/12/22.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZViewMsgModel.h"

@implementation HZViewMsgModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{
             @"createTime": @"CONTENT.create_time",
             @"ID": @"CONTENT.id",
             @"isRead": @"CONTENT.is_read",
             @"msgContent": @"CONTENT.msg_content",
             @"msgType": @"CONTENT.msg_type",
             @"msgTypeName": @"CONTENT.msg_type_name",
             @"msg": @"MSG",
             @"state": @"STATE"
             };
}


@end
