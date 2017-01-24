//
//  HZKindOfCommentCell.m
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZKindOfCommentCell.h"

@implementation HZKindOfCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self threeBtn];
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

- (UIButton *)oneBtn {
    if (!_oneBtn) {
        _oneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_oneBtn];
        [_oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _oneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_oneBtn setTitle:@"服务态度好" forState:UIControlStateNormal];
        [_oneBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _oneBtn.layer.borderColor = kBlueColor.CGColor;
        _oneBtn.layer.borderWidth = 1;
        _oneBtn.layer.cornerRadius = 5;
        _oneBtn.clipsToBounds = YES;
        _oneBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    }
    return _oneBtn;
}

- (UIButton *)twoBtn {
    if (!_twoBtn) {
        _twoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_twoBtn];
        [_twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneBtn.mas_right).equalTo(10);
            make.centerY.equalTo(0);
        }];
        _twoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_twoBtn setTitle:@"上门准时" forState:UIControlStateNormal];
        [_twoBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _twoBtn.layer.borderColor = kBlueColor.CGColor;
        _twoBtn.layer.borderWidth = 1;
        _twoBtn.layer.cornerRadius = 5;
        _twoBtn.clipsToBounds = YES;
        _twoBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    }
    return _twoBtn;
}

- (UIButton *)threeBtn {
    if (!_threeBtn) {
        _threeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_threeBtn];
        [_threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoBtn.mas_right).equalTo(10);
            make.centerY.equalTo(0);
        }];
        _threeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_threeBtn setTitle:@"迟到了" forState:UIControlStateNormal];
        [_threeBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
        _threeBtn.layer.borderColor = kGrayColor.CGColor;
        _threeBtn.layer.borderWidth = 1;
        _threeBtn.layer.cornerRadius = 5;
        _threeBtn.clipsToBounds = YES;
        _threeBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    }
    return _threeBtn;
}

@end
