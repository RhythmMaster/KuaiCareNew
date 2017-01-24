//
//  HZMsgModel.m
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMsgModel.h"

@implementation HZMsgModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allCount": @"ALLCOUNT",
             @"content": @"CONTENT",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE"};
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{@"content": [HZMsgContentModel class]};
}

@end

@implementation HZMsgContentModel
+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"createTime": @"create_time",
             @"ID": @"id",
             @"isRead": @"is_read",
             @"msgContent": @"msg_content",
             @"msgType": @"msg_type",
             @"msgTypeName": @"msg_type_name"};
}


@end