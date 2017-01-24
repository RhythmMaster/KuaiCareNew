//
//  HZRankKindCell.m
//  KuaiCare
//
//  Created by tang on 17/1/12.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZRankKindCell.h"

@implementation HZRankKindCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self oneBtn];
        [self twoBtn];
        [self threeBtn];
        [self declareBtn];
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

- (UIView *)oneView {
    if (!_oneView) {
        _oneView = [UIView new];
        [self.contentView addSubview:_oneView];
        [_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
            make.width.equalTo(kScreenW * 0.25);
        }];
    }
    return _oneView;
}

- (HZIsClickBtn *)oneBtn {
    if (!_oneBtn) {
        _oneBtn = [HZIsClickBtn buttonWithType:UIButtonTypeCustom];
        [self.oneView addSubview:_oneBtn];
        [_oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _oneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_oneBtn setTitle:@" 一级" forState:UIControlStateNormal];
        [_oneBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        [_oneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _oneBtn;
}

- (UIView *)twoView {
    if (!_twoView) {
        _twoView = [UIView new];
        [self.contentView addSubview:_twoView];
        [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(self.oneView.mas_right).equalTo(0);
            make.width.equalTo(kScreenW * 0.25);
        }];
    }
    return _twoView;
}

- (HZIsClickBtn *)twoBtn {
    if (!_twoBtn) {
        _twoBtn = [HZIsClickBtn buttonWithType:UIButtonTypeCustom];
        [self.twoView addSubview:_twoBtn];
        [_twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _twoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_twoBtn setTitle:@" 二级" forState:UIControlStateNormal];
        [_twoBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        [_twoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _twoBtn.isClick = YES;
    }
    return _twoBtn;
}


- (UIView *)threeView {
    if (!_threeView) {
        _threeView = [UIView new];
        [self.contentView addSubview:_threeView];
        [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(self.twoView.mas_right).equalTo(0);
            make.width.equalTo(kScreenW * 0.25);
        }];
    }
    return _threeView;
}

- (HZIsClickBtn *)threeBtn {
    if (!_threeBtn) {
        _threeBtn = [HZIsClickBtn buttonWithType:UIButtonTypeCustom];
        [self.threeView addSubview:_threeBtn];
        [_threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _threeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_threeBtn setTitle:@" 三级" forState:UIControlStateNormal];
        [_threeBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        [_threeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _threeBtn;
}

- (UIView *)declareView {
    if (!_declareView) {
        _declareView = [UIView new];
        [self.contentView addSubview:_declareView];
        [_declareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(self.threeView.mas_right).equalTo(0);
            make.width.equalTo(kScreenW * 0.25);
        }];
        
    }
    return _declareView;
}

- (UIButton *)declareBtn {
    if (!_declareBtn) {
        _declareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.declareView addSubview:_declareBtn];
        [_declareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        [_declareBtn setTitle:@" 等级说明" forState:UIControlStateNormal];  
    }
    return _declareBtn;
}



@end
