//
//  HZMsgViewModel.m
//  dddd
//
//  Created by NSX443 on 16/11/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMsgViewModel.h"

@implementation HZMsgViewModel

- (NSMutableArray<HZMsgContentModel *> *)msgConent {
    if (!_msgConent) {
        _msgConent = [NSMutableArray new];
    }
    return _msgConent;
}
- (HZMsgModel *)msgModel {
    if (!_msgModel) {
        _msgModel = [HZMsgModel new];
    }
    return _msgModel;
}

- (void)getMsgWithRequestMode:(VMMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMMRequestModeMore) {
        tmpPage = _page + 1;
    }
    [HZMsgNetManager getMsgWithPage:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"15" completionHandler:^(HZMsgModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMMRequestModeRefresh) {
                [self.msgConent removeAllObjects];
            }
            self.msgModel = model;
            [self.msgConent addObjectsFromArray:model.content];
            _page = tmpPage;
            
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSInteger)rowNumber {
    return self.msgConent.count;
}
- (HZMsgContentModel *)getMsgContentModelForRow:(NSInteger)row {
    return self.msgConent[row];
}
- (NSString *)getMsgTypeForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].msgType;
}
- (NSString *)getMsgTypeNameForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].msgTypeName;
}
- (NSString *)getMsgContentForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].msgContent;
}
- (NSString *)getCreateTimeForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].createTime;
}
- (BOOL)getIsReadForRow:(NSInteger)row {
    return [self getMsgContentModelForRow:row].isRead;
}

- (NSString *)getIDWithIndex:(NSInteger)index {
    return [self getMsgContentModelForRow:index].ID;
}







- (void)getViewMsgWithID:(NSString *)ID completionHandler:(void (^)(NSError *))completionHandler {
    [HZMsgNetManager getViewMsgWithID:ID completionHandler:^(HZViewMsgModel *model, NSError *error) {
        if (!error) {
            self.viewMsgContentModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSString *)getViewMsgMsgTypeName {
    return self.viewMsgContentModel.msgTypeName;
}
- (NSString *)getViewMsgMsgContent {
    return self.viewMsgContentModel.msgContent;
}






@end
