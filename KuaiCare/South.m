//
//  South.m
//  KuaiCare
//
//  Created by macbook user on 2016/12/12.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "South.h"

@implementation South
+(South*)parseNorthwithdict:(NSDictionary*)dict
{
    South *south = [[South alloc] init];
    south.phone = [dict objectForKey:@"phone"];
    south.score = [dict objectForKey:@"score"];
    south.rowid = [dict objectForKey:@"id"];
    south.age = [dict objectForKey:@"age"];
    south.count = [dict objectForKey:@"count"];
    south.head = [dict objectForKey:@"head"];
    south.sex = [dict objectForKey:@"sex"];
    south.name = [dict objectForKey:@"name"];
    south.hospital = [dict objectForKey:@"hospital"];
    return south;
}
@end
