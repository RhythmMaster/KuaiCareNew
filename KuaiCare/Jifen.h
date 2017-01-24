//
//  Jifen.h
//  KuaiCare
//
//  Created by macbook user on 16/11/17.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jifen : NSObject
@property (nonatomic ,copy)NSString *change_type;
@property (nonatomic ,copy)NSString *integral_number;
@property (nonatomic ,copy)NSString *create_date;
+(Jifen*)parseJifenWithDictionary:(NSDictionary *)dict;
@end
