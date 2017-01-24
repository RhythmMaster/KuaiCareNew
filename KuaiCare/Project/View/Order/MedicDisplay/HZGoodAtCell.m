//
//  HZGoodAtCell.m
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZGoodAtCell.h"

@implementation HZGoodAtCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self goodAtDetailLb];
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


- (UIButton *)certifiyBtn {
    if (!_certifiyBtn) {
        _certifiyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_certifiyBtn];
        [_certifiyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
        }];
        [_certifiyBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
        [_certifiyBtn setTitle:@" 从业资质已上传并审核" forState:UIControlStateNormal];
        [_certifiyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _certifiyBtn.enabled = NO;
    }
    return _certifiyBtn;
}

- (UILabel *)goodAtLb {
    if (!_goodAtLb) {
        _goodAtLb = [UILabel new];
        [self.contentView addSubview:_goodAtLb];
        [_goodAtLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.certifiyBtn.mas_bottom).equalTo(10);
        }];
        _goodAtLb.text = @"从业经验与擅长: ";
        _goodAtLb.font = [UIFont systemFontOfSize:15];
        _goodAtLb.textColor = kBlueColor;
    }
    return _goodAtLb;
}

- (UILabel *)goodAtDetailLb {
    if (!_goodAtDetailLb) {
        _goodAtDetailLb = [UILabel new];
        [self.contentView addSubview:_goodAtDetailLb];
        [_goodAtDetailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(self.goodAtLb.mas_bottom).equalTo(10);
            make.bottom.equalTo(-10);
        }];
        _goodAtDetailLb.numberOfLines = 0;
        _goodAtDetailLb.textColor = kGrayColor;
        _goodAtDetailLb.text = @"水电费水电费水电费是的范德萨发生的方式发送到发送到发送到发的说法都是";
        _goodAtDetailLb.font = [UIFont systemFontOfSize:14];
    }
    return _goodAtDetailLb;
}


@end
