//
//  HZMyCashchangeViewModel.h
//  dddd
//
//  Created by tang on 16/12/22.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HZMyMyCashchangeNM.h"

typedef NS_ENUM(NSUInteger, VMRequestMode){
    VMRequestModeRefresh,
    VMRequestModeMore,
};

@interface HZMyCashchangeViewModel : NSObject

@property(nonatomic) NSInteger page;
@property(nonatomic) NSInteger numberOfRow;
@property(nonatomic) NSMutableArray<HZMycashchangeContentModel *> *myCashchangeContentModel;
@property(nonatomic) HZMycashchangeModel *myCashChangeModel;

- (void)getMyCashChangeWithVMRequestMode:(VMRequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;

- (HZMycashchangeContentModel *)getMyCashchangeContentModelWithIndex:(NSInteger)index;
- (NSString *)getCashReserveWithIndex:(NSInteger)index;
- (NSString *)getChangeTypeWithIndex:(NSInteger)index;
- (NSString *)getCreateDateWithIndex:(NSInteger)index;
- (NSString *)getRealityMoneyWithIndex:(NSInteger)index;



@end
