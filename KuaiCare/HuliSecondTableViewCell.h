//
//  HuliSecondTableViewCell.h
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZIsClickBtn.h"

@interface HuliSecondTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *selectlabel;
@property (nonatomic ,strong)UIButton *selectButton1;
@property (nonatomic ,strong)UIButton *selectButton2;
@property (nonatomic ,strong)UILabel *hulibaoLabel;
@property (nonatomic ,strong)UILabel *shabuLabel;


@property(nonatomic) HZIsClickBtn *careBagBtn;
@property(nonatomic) UILabel *careBagPriceLb;


@property(nonatomic) HZIsClickBtn *cartridgeBagBtn;
@property(nonatomic) UILabel *cartridgeBagPriceLb;



@end
