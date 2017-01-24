//
//  OrderSecondTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderSecondTableViewCell.h"

@implementation OrderSecondTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headButton = [[UIButton alloc] init];
        _yihulabel = [[UILabel alloc] init];
        _yihuadresslabel = [[UILabel alloc] init];
        _yihutimelabel = [[UILabel alloc] init];
        _phonebutton = [[UIButton alloc] init];
        
        [self.contentView addSubview:_headButton];
        [self.contentView addSubview:_yihulabel];
        [self.contentView addSubview:_yihuadresslabel];
        [self.contentView addSubview:_yihutimelabel];
        [self.contentView addSubview:_phonebutton];

        _headButton.backgroundColor = [UIColor redColor];
        _yihulabel.backgroundColor = [UIColor redColor];
        _yihuadresslabel.backgroundColor = [UIColor redColor];
        _yihutimelabel.backgroundColor = [UIColor redColor];
        _phonebutton.backgroundColor = [UIColor redColor];

        
        
    }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
        make.width.equalTo(self.mas_height).multipliedBy(0.4);
    }];
    [_yihulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(10);
        make.top.offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.mas_height).multipliedBy(0.18);
    }];
    
    [_yihuadresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(10);
        make.top.equalTo(_yihulabel.mas_bottom).offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.mas_height).multipliedBy(0.18);
    }];
    [_yihutimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(10);
        make.top.equalTo(_yihuadresslabel.mas_bottom).offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.mas_height).multipliedBy(0.18);
    }];
   
    [_phonebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.equalTo(_yihuadresslabel.mas_bottom).offset(0);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
        make.width.equalTo(self.mas_height).multipliedBy(0.4);
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
