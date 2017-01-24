//
//  HZOrderDetailProjectCell.m
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderDetailProjectCell.h"

@implementation HZOrderDetailProjectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self nameLb];
        [self priceLb];
        [self numberLb];
        [self totalPriceLb];
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

- (UIImageView *)fileImg {
    if (!_fileImg) {
        _fileImg = [UIImageView new];
        [self.contentView addSubview:_fileImg];
        [_fileImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(50, 50));
        }];
        
    }
    return _fileImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.fileImg.mas_right).equalTo(6);
            make.top.equalTo(self.fileImg.mas_top);
        }];
        _nameLb.font = [UIFont systemFontOfSize:15];
        _nameLb.textColor = [UIColor grayColor];
        _nameLb.text = @"是的发送到";
    }
    return _nameLb;
}
- (UILabel *)priceLb {
    if (!_priceLb) {
        _priceLb = [UILabel new];
        [self.contentView addSubview:_priceLb];
        [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.fileImg.mas_right).equalTo(6);
            make.bottom.equalTo(self.fileImg.mas_bottom);
        }];
        _priceLb.font = [UIFont systemFontOfSize:14];
        _priceLb.textColor = [UIColor orangeColor];
        _priceLb.text = @"¥10.00";
    }
    return _priceLb;
}

- (UILabel *)numberLb {
    if (!_numberLb) {
        _numberLb = [UILabel new];
        [self.contentView addSubview:_numberLb];
        [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _numberLb.font = [UIFont systemFontOfSize:14];
        _numberLb.textColor = [UIColor grayColor];
        _numberLb.text = @"x1";
    }
    return _numberLb;
}
- (UILabel *)totalPriceLb {
    if (!_totalPriceLb) {
        _totalPriceLb = [UILabel new];
        [self.contentView addSubview:_totalPriceLb];
        [_totalPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-6);
        }];
        _totalPriceLb.font = [UIFont systemFontOfSize:14];
        _totalPriceLb.textColor = [UIColor orangeColor];
        _totalPriceLb.text = @"¥10.00";
    }
    return _totalPriceLb;
}

@end
