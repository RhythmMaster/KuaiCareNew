//
//  HZMyCashchangeViewModel.m
//  dddd
//
//  Created by tang on 16/12/22.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMyCashchangeViewModel.h"

@implementation HZMyCashchangeViewModel

- (NSMutableArray<HZMycashchangeContentModel *> *)myCashchangeContentModel {
    if (!_myCashchangeContentModel) {
        _myCashchangeContentModel = [NSMutableArray new];
    }
    return _myCashchangeContentModel;
}

- (NSInteger)numberOfRow {
    return self.myCashchangeContentModel.count;
}

- (void)getMyCashChangeWithVMRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
    [HZMyMyCashchangeNM getMyCashchangeWithPage:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"15" completionHandler:^(HZMycashchangeModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.myCashchangeContentModel removeAllObjects];
            }
            [self.myCashchangeContentModel addObjectsFromArray:model.content];
            _page = tmpPage;
            self.myCashChangeModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
}


- (HZMycashchangeContentModel *)getMyCashchangeContentModelWithIndex:(NSInteger)index {
    return self.myCashchangeContentModel[index];
}
- (NSString *)getCashReserveWithIndex:(NSInteger)index {
    return [self getMyCashchangeContentModelWithIndex:index].cashReserve;
}
- (NSString *)getChangeTypeWithIndex:(NSInteger)index {
    return [self getMyCashchangeContentModelWithIndex:index].changeType;
}
- (NSString *)getCreateDateWithIndex:(NSInteger)index {
    return [self getMyCashchangeContentModelWithIndex:index].createDate;
}
- (NSString *)getRealityMoneyWithIndex:(NSInteger)index {
    return [self getMyCashchangeContentModelWithIndex:index].realityMoney;
}

@end
