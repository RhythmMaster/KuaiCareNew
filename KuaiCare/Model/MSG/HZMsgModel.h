//
//  HZMsgModel.h
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZMsgContentModel;
@interface HZMsgModel : NSObject
//ALLCOUNT
@property(nonatomic) NSInteger allCount;
//CONTENT
@property(nonatomic) NSArray<HZMsgContentModel *> *content;
//MSG
@property(nonatomic) NSString *msg;
//RETTYPE
@property(nonatomic) NSInteger retype;
//STATE
@property(nonatomic) BOOL state;

@end
@interface HZMsgContentModel : NSObject

@property(nonatomic) NSString *createTime;
@property(nonatomic) NSString *ID;
@property(nonatomic) BOOL isRead;
@property(nonatomic) NSString *msgContent;
@property(nonatomic) NSString *msgType;
@property(nonatomic) NSString *msgTypeName;

@end













