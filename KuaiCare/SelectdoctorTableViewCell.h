//
//  SelectdoctorTableViewCell.h
//  KuaiCare
//
//  Created by macbook user on 2016/12/12.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface SelectdoctorTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headbtn;
@property (nonatomic ,strong)UILabel *namelab;
@property (nonatomic ,strong)UILabel *agelab;
@property (nonatomic ,strong)UILabel *xinglab;
@property (nonatomic ,strong)UILabel *numlab;
@property (nonatomic ,strong)UIImageView *numView;
@property (nonatomic ,strong)UIButton *selectbtn;
@property (nonatomic ,strong)UILabel *hospitalab;
@property (nonatomic ,strong)HCSStarRatingView *starRatingView;
@end
