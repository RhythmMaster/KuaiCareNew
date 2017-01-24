//
//  HZWithDrawDeatilProgressCell.m
//  dddd
//
//  Created by tang on 16/12/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithDrawDeatilProgressCell.h"

@implementation HZWithDrawDeatilProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self predictTimeLb];
        [self platformTimeLb];
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

- (UIImageView *)progressImg {
    if (!_progressImg) {
        _progressImg = [UIImageView new];
        [self.contentView addSubview:_progressImg];
        [_progressImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(10);
            //make.height.equalTo(100);
            make.bottom.equalTo(-15);
        }];
        _progressImg.contentMode = UIViewContentModeScaleAspectFit;
        _progressImg.clipsToBounds = YES;
        
    }
    return _progressImg;
}

- (UILabel *)withDrawLb {
    if (!_withDrawLb) {
        _withDrawLb = [UILabel new];
        [self.contentView addSubview:_withDrawLb];
        [_withDrawLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.progressImg.mas_right).equalTo(7);
            make.top.equalTo(_progressImg.mas_top);
        }];
        _withDrawLb.text = @"提现";
    }
    return _withDrawLb;
}

- (UILabel *)withDrawTimeLb {
    if (!_withDrawTimeLb) {
        _withDrawTimeLb = [UILabel new];
        [self.contentView addSubview:_withDrawTimeLb];
        [_withDrawTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(self.withDrawLb.mas_top);
        }];
        _withDrawTimeLb.text = @"12-13 23:44";
    }
    return _withDrawTimeLb;
}

- (UILabel *)platformLb {
    if (!_platformLb) {
        _platformLb = [UILabel new];
        [self.contentView addSubview:_platformLb];
        [_platformLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.withDrawLb.mas_left);
            make.top.equalTo(56);
        }];
        _platformLb.text = @"平台处理中";
    }
    return _platformLb;
}

- (UILabel *)platformTimeLb {
    if (!_platformTimeLb) {
        _platformTimeLb = [UILabel new];
        [self.contentView addSubview:_platformTimeLb];
        [_platformTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.withDrawTimeLb.mas_right);
            make.top.equalTo(self.platformLb.mas_top);
        }];
        _platformTimeLb.text = @"12-13 23:44";
    }
    return _platformTimeLb;
}

- (UILabel *)platformStateLb {
    if (!_platformStateLb) {
        _platformStateLb = [UILabel new];
        [self.contentView addSubview:_platformStateLb];
        [_platformStateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.platformLb.mas_left);
            make.top.equalTo(self.platformLb.mas_bottom).equalTo(10);
        }];
        _platformStateLb.textColor = [UIColor grayColor];
        _platformStateLb.text = @"等待平台处理中,请耐心等待";
    }
    return _platformStateLb;
}

- (UILabel *)predictLb {
    if (!_predictLb) {
        _predictLb = [UILabel new];
        [self.contentView addSubview:_predictLb];
        [_predictLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.platformStateLb.mas_left);
            make.bottom.equalTo(-15);
        }];
        _predictLb.text = @"预计到账";
        _predictLb.textColor = kGrayColor;
    }
    return _predictLb;
}


- (UILabel *)predictTimeLb {
    if (!_predictTimeLb) {
        _predictTimeLb = [UILabel new];
        [self.contentView addSubview:_predictTimeLb];
        [_predictTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(self.predictLb.mas_top);
        }];
        _predictTimeLb.text = @"12-13 23:44";
        _predictTimeLb.textColor = kGrayColor;
    }
    return _predictTimeLb;
}









@end
