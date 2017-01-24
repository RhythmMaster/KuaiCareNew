//
//  HZMedicDisplayModel.h
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HZMedicDisplayListModel;
@interface HZMedicDisplayModel : NSObject

@property(nonatomic) NSString *auditStatus;
@property(nonatomic) NSInteger count;
@property(nonatomic) NSString *goodAtField;
@property(nonatomic) NSString *head;
@property(nonatomic) NSString *hospital;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *phone;
@property(nonatomic) NSString *postName;
@property(nonatomic) NSString *score;
@property(nonatomic) NSArray<HZMedicDisplayListModel *> *list;
@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger state;

@end

@interface HZMedicDisplayListModel : NSObject

@property(nonatomic) NSString *evaluateReason;
@property(nonatomic) NSString *evaluateTime;
@property(nonatomic) NSString *head;
@property(nonatomic) NSString *itemName;
@property(nonatomic) NSString *nickName;
@property(nonatomic) NSString *phone;
@property(nonatomic) NSString *synthesizeScore;

@end
