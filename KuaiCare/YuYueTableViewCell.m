//
//  YuYueTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YuYueTableViewCell.h"

@implementation YuYueTableViewCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _clockButton = [[UIButton alloc] init];
        [_clockButton setBackgroundImage:[UIImage imageNamed:@"icon_sy_yyhl"] forState:UIControlStateNormal];
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = RGB(235, 235, 241);
        _huliLabel = [[UILabel alloc] init];
        _huliLabel.text = @"预约护理";
        _huliLabel.font = [UIFont systemFontOfSize:16];
        _huliLabel.textColor = RGB(38, 107, 255);
        _hulishiLabel = [[UILabel alloc] init];
        _hulishiLabel.text = @"预约护理师";
        _hulishiLabel.font = [UIFont systemFontOfSize:14];
        _hulishiLabel.textColor = RGB(171, 174, 191);
        [self.contentView addSubview:_clockButton];
        [self.contentView addSubview:_lineLabel];
        [self.contentView addSubview:_huliLabel];
        [self.contentView addSubview:_hulishiLabel];
    }
    
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_clockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(20);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
        make.width.equalTo(self.mas_height).multipliedBy(0.5);
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo (_clockButton.mas_right).offset(20);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_height).multipliedBy(0.01);
    }];
    [_huliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(_lineLabel.mas_right).offset(30);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    [_hulishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_huliLabel.mas_bottom).offset(10);
        make.left.equalTo(_lineLabel.mas_right).offset(30);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
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
