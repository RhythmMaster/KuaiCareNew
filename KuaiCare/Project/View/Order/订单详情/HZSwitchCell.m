//
//  HZSwitchCell.m
//  KuaiCare
//
//  Created by tang on 17/1/11.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZSwitchCell.h"

@implementation HZSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self integralLb];
        [self integralSwitch];
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
            make.centerY.equalTo(0);
            make.left.equalTo(10);
        }];
        _integralLb.font = [UIFont systemFontOfSize:14];
        _integralLb.text = @"积分";
    }
    return _integralLb;
}

- (UISwitch *)integralSwitch {
    if (!_integralSwitch) {
        _integralSwitch = [UISwitch new];
        [self.contentView addSubview:_integralSwitch];
        [_integralSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-10);
        }];
        _integralSwitch.on = NO;
    }
    return _integralSwitch;
}


@end
