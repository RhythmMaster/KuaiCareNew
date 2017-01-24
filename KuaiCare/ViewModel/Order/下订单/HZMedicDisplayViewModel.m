//
//  HZMedicDisplayViewModel.m
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZMedicDisplayViewModel.h"

@implementation HZMedicDisplayViewModel

- (NSInteger)numberOfRow {
    return self.medicDisplayList.count;
}

- (NSMutableArray<HZMedicDisplayListModel *> *)medicDisplayList {
    if (!_medicDisplayList) {
        _medicDisplayList = [NSMutableArray new];
    }
    return _medicDisplayList;
}

- (void)getMedicDisplayWithRequestMode:(VMRequestMode)requestMode medicId:(NSString *)medicId completionHandler:(void (^)(NSError *))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
    [HZHealthCareNetManager getMedicDisplayWithMedicId:medicId page:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"15" completionHandler:^(HZMedicDisplayModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.medicDisplayList removeAllObjects];
            }
            [self.medicDisplayList addObjectsFromArray:model.list];
            _page = tmpPage;
            self.medicModel = model;
            
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (HZMedicDisplayListModel *)getMedicDisplayListModelWithIndex:(NSInteger)index {
    return self.medicDisplayList[index];
}
- (NSString *)getListEvaluateReasonWithIndex:(NSInteger)index {
    return [self getMedicDisplayListModelWithIndex:index].evaluateReason;
}
- (NSString *)getListEvaluateTimeWithIndex:(NSInteger)index {
    return [self getMedicDisplayListModelWithIndex:index].evaluateTime;
}
- (NSString *)getListHeadWithIndex:(NSInteger)index {
    return [self getMedicDisplayListModelWithIndex:index].head;
}
- (NSString *)getListItemNameWithIndex:(NSInteger)index {
    return [self getMedicDisplayListModelWithIndex:index].itemName;
}
- (NSString *)getListNickNameWithIndex:(NSInteger)index {
    return [self getMedicDisplayListModelWithIndex:index].nickName;
}
- (NSString *)getListPhoneWithIndex:(NSInteger)index {
    return [self getMedicDisplayListModelWithIndex:index].phone;
}
- (NSString *)getListSynthesizeScoreWithIndex:(NSInteger)index {
    return [self getMedicDisplayListModelWithIndex:index].synthesizeScore;
}

@end
