//
//  HZPatientCommentCell.h
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface HZPatientCommentCell : UITableViewCell

@property(nonatomic) UIImageView *headImg;
@property(nonatomic) UILabel *phoneLb;
@property(nonatomic) UILabel *timeLb;
@property(nonatomic) UILabel *itemLbAndGradeLb;
@property (nonatomic ,strong)HCSStarRatingView *starRatingView;
@property(nonatomic) UIButton *oneBtn;
@property(nonatomic) UIButton *twoBtn;
@property(nonatomic) UILabel *commentLb;


@end
