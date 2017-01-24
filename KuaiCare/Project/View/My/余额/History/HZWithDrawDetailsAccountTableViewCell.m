//
//  HZWithDrawDetailsAccountTableViewCell.m
//  dddd
//
//  Created by tang on 16/12/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithDrawDetailsAccountTableViewCell.h"

@implementation HZWithDrawDetailsAccountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self withDrawLb];
        [self withDrawNumberLb];
        [self withDrawAccountLb];
        [self withDrawAccountNumberLb];
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

- (UILabel *)withDrawLb {
    if (!_withDrawLb) {
        _withDrawLb = [UILabel new];
        [self.contentView addSubview:_withDrawLb];
        [_withDrawLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(20);
        }];
        _withDrawLb.textColor = kGrayColor;
        _withDrawLb.text = @"提现金额";
    }
    return _withDrawLb;
}

- (UILabel *)withDrawNumberLb {
    if (!_withDrawNumberLb) {
        _withDrawNumberLb = [UILabel new];
        [self.contentView addSubview:_withDrawNumberLb];
        [_withDrawNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(20);
        }];
        _withDrawNumberLb.text = @"1.00";
    }
    return _withDrawNumberLb;
}

- (UILabel *)withDrawAccountLb {
    if (!_withDrawAccountLb) {
        _withDrawAccountLb = [UILabel new];
        [self.contentView addSubview:_withDrawAccountLb];
        [_withDrawAccountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.withDrawLb.mas_bottom).equalTo(15);
            make.bottom.equalTo(-15);
        }];
        _withDrawAccountLb.text = @"到支付宝账户";
        _withDrawAccountLb.textColor = kGrayColor;
        
    }
    return _withDrawAccountLb;
}

- (UILabel *)withDrawAccountNumberLb {
    if (!_withDrawAccountNumberLb) {
        _withDrawAccountNumberLb = [UILabel new];
        [self.contentView addSubview:_withDrawAccountNumberLb];
        [_withDrawAccountNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(self.withDrawNumberLb.mas_bottom).equalTo(15);
            make.bottom.equalTo(-15);
        }];
        _withDrawAccountNumberLb.text = @"12121212121";
    }
    return _withDrawAccountNumberLb;
}
@end
