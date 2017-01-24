//
//  HZTotalCell.m
//  KuaiCare
//
//  Created by tang on 16/12/20.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZTotalCell.h"

@implementation HZTotalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self totalLb];
        
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = kRGBA(245, 245, 245, 1.0);
        
    }
    return self;
}

- (UILabel *)totalNumberLb {
    if (!_totalNumberLb) {
        _totalNumberLb = [UILabel new];
        [self.contentView addSubview:_totalNumberLb];
        [_totalNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-10);
        }];
        _totalNumberLb.textColor = [UIColor orangeColor];
        _totalNumberLb.font = [UIFont systemFontOfSize:15];
    }
    return _totalNumberLb;
}

- (UILabel *)totalLb {
    if (!_totalLb) {
        _totalLb = [UILabel new];
        [self.contentView addSubview:_totalLb];
        [_totalLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(self.totalNumberLb.mas_left).equalTo(-6);
        }];
        _totalLb.font = [UIFont systemFontOfSize:15];
        _totalLb.text = @"合计: ";
    }
    return _totalLb;
}









- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
