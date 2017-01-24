//
//  HZMedicInfoCell.h
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface HZMedicInfoCell : UITableViewCell

@property(nonatomic) UIImageView *headImg;
@property(nonatomic) UILabel *nameAndCareerLb;
@property(nonatomic) UILabel *hospitalLb;
@property(nonatomic) UILabel *receiveOrderNumberLbAndGradeLb;
@property (nonatomic ,strong)HCSStarRatingView *starRatingView;


@end
