//
//  North.m
//  KuaiCare
//
//  Created by macbook user on 2016/12/12.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "North.h"

@implementation North
+(North*)parseNorthwithdict:(NSDictionary*)dict
{
    North *north = [[North alloc] init];
    north.phone = [dict objectForKey:@"phone"];
    north.score = [dict objectForKey:@"score"];
    north.rowid = [dict objectForKey:@"id"];
    north.age = [dict objectForKey:@"age"];
    north.count = [dict objectForKey:@"count"];
    north.head = [dict objectForKey:@"head"];
    north.sex = [dict objectForKey:@"sex"];
    north.name = [dict objectForKey:@"name"];
    north.hospital = [dict objectForKey:@"hospital"];
    return north;
}
@end
