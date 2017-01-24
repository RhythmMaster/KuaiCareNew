//
//  HZViewMsgModel.h
//  dddd
//
//  Created by tang on 16/12/22.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZViewMsgModel : NSObject

@property(nonatomic) NSString *createTime;
@property(nonatomic) NSString *ID;
@property(nonatomic) BOOL isRead;
@property(nonatomic) NSString *msgContent;
@property(nonatomic) NSString *msgType;
@property(nonatomic) NSString *msgTypeName;
@property(nonatomic) NSString *msg;
@property(nonatomic) BOOL state;

@end
