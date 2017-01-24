//
//  HZDataHandler.h
//  KuaiCare
//
//  Created by tang on 17/1/9.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZDataHandler : NSObject

@property(nonatomic,strong)NSString *nameStr;
@property(nonatomic, strong) NSString *medicId;
@property(nonatomic, strong) NSString *hospital;
@property(nonatomic, strong) NSString *phone;

+(instancetype)sharedHadle;

@end
