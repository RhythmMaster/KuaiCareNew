//
//  SelectRankViewController.h
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock) (NSString *str);
typedef void(^rowOfSelectBlock) (NSInteger row);
@interface SelectRankViewController : UIViewController
@property (nonatomic ,copy) myBlock block1;
@property (nonatomic ,copy) myBlock block2;
@property (nonatomic ,copy)NSString *rowID;

@property(nonatomic, copy) rowOfSelectBlock rowOfSelectBlock;

@end
