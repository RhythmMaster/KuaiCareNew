//
//  HuliThirdTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HuliThirdTableViewCell.h"

@implementation HuliThirdTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _agressLabel = [[UILabel alloc] init];
        _agressLabel.font = [UIFont systemFontOfSize:14];
        _agressLabel.text = @"同意“快护理服务”";
        _freeButton = [[UIButton alloc] init];
        [_freeButton setTitle:@"免责条款" forState:UIControlStateNormal];
        _freeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        
        [_freeButton setTitleColor:RGB(38, 107, 255) forState:UIControlStateNormal];
        _freeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _wrongButton = [[HZIsClickBtn alloc] init];
        _wrongButton.isClick = NO;
        _rightButton = [[HZIsClickBtn alloc] init];
        _rightButton.isClick = YES;
        
        [self.contentView addSubview:_agressLabel];
        [self.contentView addSubview:_freeButton];
        [self.contentView addSubview:_wrongButton];
        [self.contentView addSubview:_rightButton];
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_agressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_freeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_agressLabel.mas_right).offset(1);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    [_wrongButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.offset(15);
        make.bottom.offset(-15);
        make.width.equalTo(self.mas_width).multipliedBy(0.15);
        
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wrongButton.mas_left).offset(-5);
        make.top.offset(15);
        make.bottom.offset(-15);
        make.width.equalTo(self.mas_width).multipliedBy(0.15);
    }];
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
