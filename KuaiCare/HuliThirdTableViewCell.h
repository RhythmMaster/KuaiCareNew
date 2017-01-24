//
//  HuliThirdTableViewCell.h
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZIsClickBtn.h"

@interface HuliThirdTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *agressLabel;
@property (nonatomic ,strong)UIButton *freeButton;
@property (nonatomic ,strong)HZIsClickBtn *rightButton;
@property (nonatomic ,strong)HZIsClickBtn *wrongButton;

@end
