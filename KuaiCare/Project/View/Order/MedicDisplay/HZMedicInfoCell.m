//
//  HZMedicInfoCell.m
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZMedicInfoCell.h"

@implementation HZMedicInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self starRatingView];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [UIImageView new];
        [self.contentView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(48, 48));
        }];
        _headImg.layer.cornerRadius = 24;
        _headImg.image = [UIImage imageNamed:@"默认头像"];
        _headImg.contentMode = UIViewContentModeScaleAspectFill;
        _headImg.clipsToBounds = YES;
    }
    return _headImg;
}

- (UILabel *)nameAndCareerLb {
    if (!_nameAndCareerLb) {
        _nameAndCareerLb = [UILabel new];
        [self.contentView addSubview:_nameAndCareerLb];
        [_nameAndCareerLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).equalTo(8);
            make.top.equalTo(10);
        }];
        _nameAndCareerLb.text = @"鼎折覆餗";
        _nameAndCareerLb.font = [UIFont systemFontOfSize:17];
    }
    return _nameAndCareerLb;
}
- (UILabel *)hospitalLb {
    if (!_hospitalLb) {
        _hospitalLb = [UILabel new];
        [self.contentView addSubview:_hospitalLb];
        [_hospitalLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(self.nameAndCareerLb.mas_left);
        }];
        _hospitalLb.text = @"上海市第一任命医院";
        _hospitalLb.textColor = kGrayColor;
        _hospitalLb.font = [UIFont systemFontOfSize:15];
    }
    return _hospitalLb;
}

- (UILabel *)receiveOrderNumberLbAndGradeLb {
    if (!_receiveOrderNumberLbAndGradeLb) {
        _receiveOrderNumberLbAndGradeLb = [UILabel new];
        [self.contentView addSubview:_receiveOrderNumberLbAndGradeLb];
        [_receiveOrderNumberLbAndGradeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hospitalLb.mas_left);
            make.bottom.equalTo(-12);
        }];
        _receiveOrderNumberLbAndGradeLb.text = @"接单数: 111次  综合评分:";
        _receiveOrderNumberLbAndGradeLb.textColor = kGrayColor;
        _receiveOrderNumberLbAndGradeLb.font = [UIFont systemFontOfSize:15];
    }
    return _receiveOrderNumberLbAndGradeLb;
}

- (HCSStarRatingView *)starRatingView {
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_starRatingView];
        [_starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.receiveOrderNumberLbAndGradeLb.mas_right).equalTo(6);
            make.centerY.equalTo(self.receiveOrderNumberLbAndGradeLb.mas_centerY);
            make.size.equalTo(CGSizeMake(80, 15));
        }];
        _starRatingView.maximumValue = 5;
        _starRatingView.minimumValue = 0;
        _starRatingView.tintColor = kRGBA(246, 161, 44, 1.0);
        _starRatingView.allowsHalfStars = NO;
        _starRatingView.value = 3.0;
        //自己临时加的属性,错了背锅
        _starRatingView.allowClick = NO;
    }
    return _starRatingView;
}




@end
