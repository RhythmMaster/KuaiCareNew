//
//  HZWithDrawDetailsStateCell.m
//  dddd
//
//  Created by tang on 16/12/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithDrawDetailsStateCell.h"

@implementation HZWithDrawDetailsStateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self withDrawProgressLb];
        [self withDrawStateLb];
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

- (UILabel *)withDrawProgressLb {
    if (!_withDrawProgressLb) {
        _withDrawProgressLb = [UILabel new];
        [self.contentView addSubview:_withDrawProgressLb];
        [_withDrawProgressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _withDrawProgressLb.text = @"提现处理进度";
    }
    return _withDrawProgressLb;
}

- (UILabel *)withDrawStateLb {
    if (!_withDrawStateLb) {
        _withDrawStateLb = [UILabel new];
        [self.contentView addSubview:_withDrawStateLb];
        [_withDrawStateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        _withDrawStateLb.textColor = kBlueColor;
        _withDrawStateLb.text = @"提现中";
    }
    return _withDrawStateLb;
}

@end
