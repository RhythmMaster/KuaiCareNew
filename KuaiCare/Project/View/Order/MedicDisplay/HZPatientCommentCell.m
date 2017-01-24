//
//  HZPatientCommentCell.m
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZPatientCommentCell.h"

@implementation HZPatientCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commentLb];
        [self timeLb];
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
            make.left.top.equalTo(10);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
        _headImg.layer.cornerRadius = 20;
        _headImg.clipsToBounds = YES;
        _headImg.image = [UIImage imageNamed:@"默认头像"];
    }
    return _headImg;
}

- (UILabel *)phoneLb {
    if (!_phoneLb) {
        _phoneLb = [UILabel new];
        [self.contentView addSubview:_phoneLb];
        [_phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).equalTo(10);
            make.top.equalTo(10);
        }];
        _phoneLb.text = @"111********";
        _phoneLb.font = [UIFont systemFontOfSize:16];
    }
    return _phoneLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [UILabel new];
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.right.equalTo(-10);
        }];
        _timeLb.text = @"2017-01-06";
        _timeLb.textColor = kGrayColor;
        _timeLb.font = [UIFont systemFontOfSize:13];
    }
    return _timeLb;
}

- (UILabel *)itemLbAndGradeLb {
    if (!_itemLbAndGradeLb) {
        _itemLbAndGradeLb = [UILabel new];
        [self.contentView addSubview:_itemLbAndGradeLb];
        [_itemLbAndGradeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.phoneLb.mas_bottom).equalTo(6);
            make.left.equalTo(self.headImg.mas_right).equalTo(10);
        }];
        _itemLbAndGradeLb.textColor = kGrayColor;
        _itemLbAndGradeLb.text = @"褥疮护理 打分";
        _itemLbAndGradeLb.font = [UIFont systemFontOfSize:13];
    }
    return _itemLbAndGradeLb;
}

- (HCSStarRatingView *)starRatingView {
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_starRatingView];
        [_starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.itemLbAndGradeLb.mas_right).equalTo(4);
            make.centerY.equalTo(self.itemLbAndGradeLb.mas_centerY);
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

- (UIButton *)oneBtn {
    if (!_oneBtn) {
        _oneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_oneBtn];
        [_oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.starRatingView.mas_bottom).equalTo(10);
        }];
        _oneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_oneBtn setTitle:@"服务态度好" forState:UIControlStateNormal];
        [_oneBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _oneBtn.layer.borderColor = kBlueColor.CGColor;
        _oneBtn.layer.borderWidth = 1;
        _oneBtn.layer.cornerRadius = 5;
        _oneBtn.clipsToBounds = YES;
        _oneBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        _oneBtn.hidden = YES;
    }
    return _oneBtn;
}

- (UIButton *)twoBtn {
    if (!_twoBtn) {
        _twoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_twoBtn];
        [_twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneBtn.mas_right).equalTo(10);
            make.centerY.equalTo(self.oneBtn.mas_centerY);
        }];
        _twoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_twoBtn setTitle:@"上门准时" forState:UIControlStateNormal];
        [_twoBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _twoBtn.layer.borderColor = kBlueColor.CGColor;
        _twoBtn.layer.borderWidth = 1;
        _twoBtn.layer.cornerRadius = 5;
        _twoBtn.clipsToBounds = YES;
        _twoBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        _twoBtn.hidden = YES;
    }
    return _twoBtn;
}

- (UILabel *)commentLb {
    if (!_commentLb) {
        _commentLb = [UILabel new];
        [self.contentView addSubview:_commentLb];
        [_commentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.starRatingView.mas_bottom).equalTo(10);
            make.right.equalTo(-10);
            make.bottom.equalTo(-8);
        }];
        _commentLb.numberOfLines = 0;
        _commentLb.textColor = kGrayColor;
        _commentLb.text = @"收费的方式的是否收费是水电费水电费是否是复试水电费水电费水电费是的范德萨发生的方式发送到发送到发送到发的说法都是";
        _commentLb.font = [UIFont systemFontOfSize:14];
    }
    return _commentLb;
}

@end
