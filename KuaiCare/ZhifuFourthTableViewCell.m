//
//  ZhifuFourthTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/7.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "ZhifuFourthTableViewCell.h"

@implementation ZhifuFourthTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setBackgroundColor:RGB(54, 136, 255)];
        [_submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitButton setTitleEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 20;
    
        _submitButton.layer.masksToBounds = YES;
        [self.contentView addSubview:_submitButton];
    }
    return self;
}
-(void)layoutSubviews
{
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(40);
        make.width.equalTo(KCWIDTH/3);
    
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
