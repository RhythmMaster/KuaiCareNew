//
//  ZhifuSecondTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/7.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "ZhifuSecondTableViewCell.h"

@implementation ZhifuSecondTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _jifenlabel = [[UILabel alloc] init];
        _jifenlabel.text = @"1111";
        _jifenlabel.font = [UIFont systemFontOfSize:14];
        
      
        
        
        _jifenswitch = [[UISwitch alloc] init];
    
        _pricelabel = [[UILabel alloc] init];
        _pricelabel.text = @"1111";
        _pricelabel.font = [UIFont systemFontOfSize:14];
        
        
        [self addSubview:_jifenlabel];
        [self addSubview:_jifenswitch];
        [self addSubview:_pricelabel];

   

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_jifenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_jifenswitch.mas_centerY);
        make.left.offset(10);
    }];

    
    [_jifenswitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(10);
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.equalTo(_jifenlabel.mas_bottom).offset(20);
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
