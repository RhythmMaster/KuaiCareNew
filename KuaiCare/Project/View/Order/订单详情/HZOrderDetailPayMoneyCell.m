//
//  HZOrderDetailPayMoneyCell.m
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderDetailPayMoneyCell.h"

@implementation HZOrderDetailPayMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self integralLb];
        [self integralNumberLb];
        [self payLb];
        [self payNumberLb];
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





- (UILabel *)integralLb {
    if (!_integralLb) {
        _integralLb = [UILabel new];
        [self.contentView addSubview:_integralLb];
        [_integralLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(6);
            make.left.equalTo(10);
        }];
        _integralLb.text = @"积分抵扣";
        _integralLb.font = [UIFont systemFontOfSize:14];
    }
    return _integralLb;
}

- (UILabel *)integralNumberLb {
    if (!_integralNumberLb) {
        _integralNumberLb = [UILabel new];
        [self.contentView addSubview:_integralNumberLb];
        [_integralNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(6);
        }];
        _integralNumberLb.text = @"嘟嘟";
        _integralNumberLb.textColor = [UIColor orangeColor];
        _integralNumberLb.font = [UIFont systemFontOfSize:14];
    }
    return _integralNumberLb;
}


- (UILabel *)payLb {
    if (!_payLb) {
        _payLb = [UILabel new];
        [self.contentView addSubview:_payLb];
        [_payLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.bottom.equalTo(-10);
        }];
        _payLb.text = @"实际支付";
        //_payLb.textColor = kGrayColor;
        _payLb.font = [UIFont systemFontOfSize:14];
    }
    return _payLb;
}

- (UILabel *)payNumberLb {
    if (!_payNumberLb) {
        _payNumberLb = [UILabel new];
        [self.contentView addSubview:_payNumberLb];
        [_payNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.bottom.equalTo(-10);
        }];
        _payNumberLb.text = @"嘟嘟";
        _payNumberLb.textColor = kBlueColor;
        _payNumberLb.font = [UIFont systemFontOfSize:14];
    }
    return _payNumberLb;
}




@end
