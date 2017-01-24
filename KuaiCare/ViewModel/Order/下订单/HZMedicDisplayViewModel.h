//
//  HZMedicDisplayViewModel.h
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZHealthCareNetManager.h"

typedef NS_ENUM(NSUInteger, VMRequestMode) {
    VMRequestModeRefresh,
    VMRequestModeMore
};

@interface HZMedicDisplayViewModel : NSObject

@property(nonatomic) NSInteger page;
@property(nonatomic) NSInteger numberOfRow;
@property(nonatomic) HZMedicDisplayModel *medicModel;
@property(nonatomic) NSMutableArray<HZMedicDisplayListModel *> *medicDisplayList;

- (void)getMedicDisplayWithRequestMode:(VMRequestMode)requestMode medicId:(NSString *)medicId completionHandler:(void(^)(NSError *error))completionHandler;


- (HZMedicDisplayListModel *)getMedicDisplayListModelWithIndex:(NSInteger)index;
- (NSString *)getListEvaluateReasonWithIndex:(NSInteger)index;
- (NSString *)getListEvaluateTimeWithIndex:(NSInteger)index;
- (NSString *)getListHeadWithIndex:(NSInteger)index;
- (NSString *)getListItemNameWithIndex:(NSInteger)index;
- (NSString *)getListNickNameWithIndex:(NSInteger)index;
- (NSString *)getListPhoneWithIndex:(NSInteger)index;
- (NSString *)getListSynthesizeScoreWithIndex:(NSInteger)index;
@end
