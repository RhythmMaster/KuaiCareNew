//
//  HZItemInfoModel.h
//  KuaiCare
//
//  Created by tang on 16/12/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZItemInfoListModel, HZItemInfoItemListModel;
@interface HZItemInfoModel : NSObject

@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger rtype;
@property(nonatomic) NSString *desc;
@property(nonatomic) NSString *ID;
@property(nonatomic) NSInteger orderNum;
@property(nonatomic) NSString *file;
@property(nonatomic) NSString *nursingSkill;
@property(nonatomic) NSInteger isDel;
@property(nonatomic) NSString *userNotice;
@property(nonatomic) NSString *code;
@property(nonatomic) NSString *theraplTime;
@property(nonatomic) NSString *serviceContent;
@property(nonatomic) NSInteger isEnable;
@property(nonatomic) NSString *servicePrice;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *commonName;
@property(nonatomic) NSString *commonTel;
@property(nonatomic) NSString *commonAddress;
@property(nonatomic) NSString *commonAddressInfo;
@property(nonatomic) NSString *jzrName;
@property(nonatomic) NSString *jzrTel;
@property(nonatomic) NSString *jzrSex;
@property(nonatomic) NSString *jzrAge;
@property(nonatomic) NSString *jzrId;

@property(nonatomic) NSArray<HZItemInfoListModel *> *list;

@property(nonatomic) NSArray<HZItemInfoItemListModel *> *itemList;

@property(nonatomic) NSInteger state;





@end

@interface HZItemInfoItemListModel : NSObject

@property(nonatomic) NSString *desc;
@property(nonatomic) NSString *ID;
@property(nonatomic) NSInteger orderNum;
@property(nonatomic) NSString *file;
@property(nonatomic) NSString *nursingSkil;
@property(nonatomic) NSString *isDel;
@property(nonatomic) NSString *code;
@property(nonatomic) NSString *therapyTime;
@property(nonatomic) NSString *serviceContent;
@property(nonatomic) NSString *isEnable;
@property(nonatomic) NSString *servicePrice;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *itemId;

@end

@interface HZItemInfoListModel : NSObject

@property(nonatomic) NSString *itemId;
@property(nonatomic) NSString *ID;
@property(nonatomic) NSString *code;
@property(nonatomic) NSString *file;
@property(nonatomic) NSString *price;
@property(nonatomic) NSInteger orderNum;
@property(nonatomic) NSString *desc;
@property(nonatomic) NSString *isDel;
@property(nonatomic) NSString *isEnable;
@property(nonatomic) NSString *name;







@end
