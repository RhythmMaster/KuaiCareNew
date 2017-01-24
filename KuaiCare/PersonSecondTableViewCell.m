//
//  PersonSecondTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "PersonSecondTableViewCell.h"

@implementation PersonSecondTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _customButton1 = [[CustomButton alloc] init];
        _customButton1.headView.image = [UIImage imageNamed:@"jifen"];
        _customButton1.introlabel1.text = @"我的积分";
        _customButton1.introlabel2.text = @"2222";
        _customButton1.introlabel2.font = [UIFont systemFontOfSize:14];
        _customButton2 = [[CustomButton alloc] init];
        _customButton2.headView.image = [UIImage imageNamed:@"fenx"];
        _customButton2.introlabel1.text = @"分享奖励";
        _customButton2.introlabel2.text = @"有奖奖励";
        _customButton2.introlabel2.font = [UIFont systemFontOfSize:14];

        _customButton3 = [[CustomButton alloc] init];
        _customButton3.headView.image = [UIImage imageNamed:@"jzpeople"];
        _customButton3.introlabel1.text = @"就诊人管理";
        _customButton3.introlabel2.text = @"添加/管理就诊人";
        _customButton3.introlabel2.font = [UIFont systemFontOfSize:14];

        _customButton4 = [[CustomButton alloc] init];
        _customButton4.headView.image = [UIImage imageNamed:@"adress"];
        _customButton4.introlabel1.text = @"常用地址管理";
        _customButton4.introlabel2.text = @"地址管理";
        _customButton4.introlabel2.font = [UIFont systemFontOfSize:14];

        
        
        _verticalabel = [[UILabel alloc] init];
        _horizonlabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_customButton1];
        [self.contentView addSubview:_customButton2];
        [self.contentView addSubview:_customButton3];
        [self.contentView addSubview:_customButton4];
        [self.contentView addSubview:_verticalabel];
        [self.contentView addSubview:_horizonlabel];
        
        _horizonlabel.backgroundColor = RGB(235, 235, 241);
        _verticalabel.backgroundColor = RGB(235, 235, 241);
        
        
        
    }
    
    
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_customButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);

    }];
    
    [_horizonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customButton1.mas_bottom).offset(1);
        make.left.offset(5);
        make.right.offset(-5);
        make.height.equalTo(_customButton1.mas_height).multipliedBy(0.01);
    }];
    [_verticalabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.bottom.offset(-5);
        make.left.equalTo(_customButton1.mas_right).offset(1);
        make.width.equalTo(_customButton1.mas_height).multipliedBy(0.01);
    }];
    [_customButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(_customButton1.mas_right).offset(0);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    
    [_customButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customButton1.mas_bottom).offset(0);
        make.left.offset(0);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];

    
    [_customButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customButton1.mas_bottom).offset(0);
        make.left.equalTo(_customButton3.mas_right).offset(0);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
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
