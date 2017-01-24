//
//  HZTotalSimpleCell.m
//  KuaiCare
//
//  Created by tang on 17/1/11.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZTotalSimpleCell.h"

@implementation HZTotalSimpleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self totalLb];
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.5);
        }];
        lineView.backgroundColor = kLightGrayColor;
        
        
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

- (UILabel *)totalLb {
    if (!_totalLb) {
        _totalLb = [UILabel new];
        [self.contentView addSubview:_totalLb];
        [_totalLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-10);
        }];
        _totalLb.font = [UIFont systemFontOfSize:14];
    }
    return _totalLb;
}

@end
