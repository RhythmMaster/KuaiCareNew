//
//  HZPayKindCell.m
//  KuaiCare
//
//  Created by tang on 17/1/11.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZPayKindCell.h"

@implementation HZPayKindCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self alipayLb];
        [self balanceLb];
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.5);
        }];
        lineView.backgroundColor = kLightGrayColor;
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

- (UIImageView *)alipayImg {
    if (!_alipayImg) {
        _alipayImg = [UIImageView new];
        [self.contentView addSubview:_alipayImg];
        [_alipayImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(10);
            make.size.equalTo(CGSizeMake(38, 38));
        }];
        _alipayImg.image = [UIImage imageNamed:@"icon_l_zfbzf"];
    }
    return _alipayImg;
}

- (UILabel *)alipayLb {
    if (!_alipayLb) {
        _alipayLb = [UILabel new];
        [self.contentView addSubview:_alipayLb];
        [_alipayLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.alipayImg.mas_right).equalTo(5);
            make.centerY.equalTo(0);
        }];
        _alipayLb.font = [UIFont systemFontOfSize:14];
        _alipayLb.text = @"支付宝";
    }
    return _alipayLb;
}


- (UIImageView *)kingImg {
    if (!_kingImg) {
        _kingImg = [UIImageView new];
        [self.contentView addSubview:_kingImg];
        [_kingImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(18, 18));
        }];
        _kingImg.image = [UIImage imageNamed:@"icon_l_checked"];
    }
    return _kingImg;
}

- (UILabel *)balanceLb {
    if (!_balanceLb) {
        _balanceLb = [UILabel new];
        [self.contentView addSubview:_balanceLb];
        [_balanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.kingImg.mas_left).equalTo(-5);
            make.centerY.equalTo(0);
        }];
        _balanceLb.font = [UIFont systemFontOfSize:14];
        _balanceLb.textColor = kBlueColor;
        _balanceLb.text = @"111111";
    }
    return _balanceLb;
}


@end
