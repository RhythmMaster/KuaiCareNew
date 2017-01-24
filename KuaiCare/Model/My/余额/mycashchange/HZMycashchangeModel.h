//
//  HZMycashchangeModel.h
//  dddd
//
//  Created by tang on 16/12/13.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZMycashchangeContentModel;
@interface HZMycashchangeModel : NSObject

@property(nonatomic) NSInteger allCount;
@property(nonatomic) NSArray<HZMycashchangeContentModel *> *content;
@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger state;

@end

@interface HZMycashchangeContentModel : NSObject

@property(nonatomic) NSString *cashReserve;
@property(nonatomic) NSString *changeType;
@property(nonatomic) NSString *createDate;
@property(nonatomic) NSString *realityMoney;

@end
