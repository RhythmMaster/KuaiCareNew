//
//  HZTimeOfWithDrawCell.m
//  dddd
//
//  Created by tang on 16/12/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeOfWithDrawCell.h"

@implementation HZTimeOfWithDrawCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self startTimeNumberLb];
        [self downTimeNumberLb];
        [self progressImg];
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

- (UILabel *)startTimeLb {
    if (!_startTimeLb) {
        _startTimeLb = [UILabel new];
        [self.contentView addSubview:_startTimeLb];
        [_startTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
        }];
        _startTimeLb.textColor = kGrayColor;
        _startTimeLb.text = @"提现时间";
    }
    return _startTimeLb;
}

- (UILabel *)startTimeNumberLb {
    if (!_startTimeNumberLb) {
        _startTimeNumberLb = [UILabel new];
        [self.contentView addSubview:_startTimeNumberLb];
        [_startTimeNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.startTimeLb.mas_bottom).equalTo(10);
        }];
        _startTimeNumberLb.font = [UIFont systemFontOfSize:14];
        _startTimeNumberLb.text = @"11-29 17:25";
    }
    return _startTimeNumberLb;
}

- (UILabel *)downTimeLb {
    if (!_downTimeLb) {
        _downTimeLb = [UILabel new];
        [self.contentView addSubview:_downTimeLb];
        [_downTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(10);
        }];
        _downTimeLb.textColor = kGrayColor;
        _downTimeLb.text = @"预计到账";
    }
    return _downTimeLb;
}

- (UILabel *)downTimeNumberLb {
    if (!_downTimeNumberLb) {
        _downTimeNumberLb = [UILabel new];
        [self.contentView addSubview:_downTimeNumberLb];
        [_downTimeNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(self.downTimeLb.mas_bottom).equalTo(10);
        }];
        _downTimeNumberLb.font = [UIFont systemFontOfSize:14];
        _downTimeNumberLb.text = @"11-29 17:25";
    }
    return _downTimeNumberLb;
}
- (UIImageView *)progressImg {
    if (!_progressImg) {
        _progressImg = [UIImageView new];
        [self.contentView addSubview:_progressImg];
        _progressImg.image = [UIImage imageNamed:@"横向进度条"];
        [_progressImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
    }
    return _progressImg;
}

@end
