//
//  HZWaitOfWithDrawCell.m
//  dddd
//
//  Created by tang on 16/12/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWaitOfWithDrawCell.h"

@implementation HZWaitOfWithDrawCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self timeNumberLb];
        [self detailsLb];
        [self waitLb];
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


- (UILabel *)waitLb {
    if (!_waitLb) {
        _waitLb = [UILabel new];
        [self.contentView addSubview:_waitLb];
        [_waitLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _waitLb.textColor = kBlueColor;
        _waitLb.font = [UIFont systemFontOfSize:14];
        _waitLb.text = @"提取处理中,请耐心等待";
        _waitLb.hidden = YES;
    }
    return _waitLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [UILabel new];
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _timeLb.text = @"提现时间";
        _timeLb.textColor = kGrayColor;
    }
    return _timeLb;
}

- (UILabel *)timeNumberLb {
    if (!_timeNumberLb) {
        _timeNumberLb = [UILabel new];
        [self.contentView addSubview:_timeNumberLb];
        [_timeNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLb.mas_right).equalTo(15);
            make.centerY.equalTo(0);
        }];
        _timeNumberLb.text = @"12-13 10:44";
        _timeNumberLb.textColor = kGrayColor;
    }
    return _timeNumberLb;
}

- (UILabel *)detailsLb {
    if (!_detailsLb) {
        _detailsLb = [UILabel new];
        [self.contentView addSubview:_detailsLb];
        [_detailsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.centerY.equalTo(0);
        }];
        _detailsLb.textColor = kGrayColor;
        _detailsLb.text = @"详情";
        _detailsLb.font = [UIFont systemFontOfSize:14];
    }
    return _detailsLb;
}


@end
