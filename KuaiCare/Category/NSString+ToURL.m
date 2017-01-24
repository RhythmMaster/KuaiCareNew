//
//  NSString+ToURL.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "NSString+ToURL.h"

@implementation NSString (ToURL)

- (NSURL *)tzl_URL{
    return [NSURL URLWithString:self];
}

@end
