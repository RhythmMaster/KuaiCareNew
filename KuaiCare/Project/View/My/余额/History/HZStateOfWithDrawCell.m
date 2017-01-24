//
//  HZStateOfWithDrawCell.m
//  dddd
//
//  Created by tang on 16/12/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZStateOfWithDrawCell.h"

@implementation HZStateOfWithDrawCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self accountNumberLb];
        [self stateImg];
        [self stateLb];
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

- (UILabel *)accountLb {
    if (!_accountLb) {
        _accountLb = [UILabel new];
        [self.contentView addSubview:_accountLb];
        [_accountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(8);
        }];
        _accountLb.font = [UIFont systemFontOfSize:16];
        _accountLb.text = @"金额";
        _accountLb.textColor = [UIColor grayColor];
    }
    return _accountLb;
}

- (UILabel *)accountNumberLb {
    if (!_accountNumberLb) {
        _accountNumberLb = [UILabel new];
        [self.contentView addSubview:_accountNumberLb];
        [_accountNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.accountLb.mas_right).equalTo(40);
            make.centerY.equalTo(0);
        }];
        _accountNumberLb.font = [UIFont systemFontOfSize:16];
        _accountNumberLb.text = @"1.00";
    }
    return _accountNumberLb;
}

- (UILabel *)stateLb {
    if (!_stateLb) {
        _stateLb = [UILabel new];
        [self.contentView addSubview:_stateLb];
        [_stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        _stateLb.textColor = kGrayColor;
        _stateLb.text = @"已到账";
        
    }
    return _stateLb;
}
- (UIImageView *)stateImg {
    if (!_stateImg) {
        _stateImg = [UIImageView new];
        [self.contentView addSubview:_stateImg];
        [_stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.top.bottom.equalTo(0);
        }];
        _stateImg.contentMode = UIViewContentModeScaleAspectFill;
        _stateImg.clipsToBounds = YES;
        _stateImg.image = [UIImage imageNamed:@"提现中标签"];
    }
    return _stateImg;
}

@end
