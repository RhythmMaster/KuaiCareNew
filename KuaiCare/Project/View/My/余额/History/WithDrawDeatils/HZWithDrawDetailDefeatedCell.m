//
//  HZWithDrawDetailDefeatedCell.m
//  dddd
//
//  Created by tang on 16/12/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithDrawDetailDefeatedCell.h"

@implementation HZWithDrawDetailDefeatedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self platformStateLb];
        
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
            make.top.equalTo(0);
            make.bottom.equalTo(-15);
        }];
        _progressImg.image = [UIImage imageNamed:@"提现失败进度条"];
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
            make.top.equalTo(18);
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
            make.top.equalTo(62);
        }];
        _platformLb.text = @"提现失败";
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
            make.top.equalTo(self.platformTimeLb.mas_bottom).equalTo(10);
            make.bottom.equalTo(-8);
        }];
        _platformStateLb.textColor = [UIColor grayColor];
        _platformStateLb.text = @"支付宝账户与真实姓名不一致";
    }
    return _platformStateLb;
}

@end
