//
//  Jifen.m
//  KuaiCare
//
//  Created by macbook user on 16/11/17.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "Jifen.h"

@implementation Jifen
+(Jifen*)parseJifenWithDictionary:(NSDictionary *)dict
{
    Jifen *jifen = [[Jifen alloc] init];
    jifen.change_type = [dict objectForKey:@"change_type"];
    jifen.integral_number = [[dict objectForKey:@"integral_number"] stringValue];
    jifen.create_date = [dict objectForKey:@"create_date"];
    return jifen;
}
@end
