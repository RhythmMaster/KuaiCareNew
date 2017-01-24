//
//  South.h
//  KuaiCare
//
//  Created by macbook user on 2016/12/12.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface South : NSObject
@property (nonatomic ,copy)NSString *phone;
@property (nonatomic ,copy)NSString *score;
@property (nonatomic ,copy)NSString *rowid;
@property (nonatomic ,copy)NSString *age;
@property (nonatomic ,copy)NSString *count;
@property (nonatomic ,copy)NSString *head;
@property (nonatomic ,copy)NSString *sex;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *hospital;
+(South*)parseNorthwithdict:(NSDictionary*)dict;
@end
