//
//  HZOrderDetailPayMoneyCell.h
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZOrderDetailPayMoneyCell : UITableViewCell

@property(nonatomic) UIView *totalView;
@property(nonatomic) UILabel *totalPriceLb;
@property(nonatomic) UIView *payMoneyView;
@property(nonatomic) UILabel *integralLb;
@property(nonatomic) UILabel *integralNumberLb;
@property(nonatomic) UILabel *payLb;
@property(nonatomic) UILabel *payNumberLb;

@property(nonatomic) UISwitch *integralSwitch;

@end
