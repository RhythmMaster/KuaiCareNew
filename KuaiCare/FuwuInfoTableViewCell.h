//
//  FuwuInfoTableViewCell.h
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuwuInfoTableViewCell : UITableViewCell



@property (nonatomic ,strong)UIImageView *lineView;
@property (nonatomic ,strong)UILabel *leibieLabel;
@property (nonatomic ,strong)UILabel *zhifustatusLabel;

@property (nonatomic ,strong)UIImageView *touxiangView;
@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *xiangmuLabel;
@property (nonatomic ,strong)UILabel *hospitalabel;
@property (nonatomic ,strong)UILabel *pricelabel;
@property (nonatomic ,strong)UILabel *jiuzhenlabel;
@property (nonatomic ,strong)UILabel *addresslabel;
@property (nonatomic ,strong)UILabel *xiadantimelabel;
@property (nonatomic ,strong)UILabel *fuwutimelabel;


@property (nonatomic ,strong)UIButton *dingdanButton;
@property (nonatomic ,strong)UIButton *zhifuButton;

@property (nonatomic ,strong)UILabel *horizonLabel1;
@property (nonatomic ,strong)UILabel *horizonLabel2;



@property(nonatomic) UIView *stateView;
@property(nonatomic) UIView *infoView;
@property(nonatomic) UIView *operationView;





@end
