//
//  ZhifuThirdTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/7.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "ZhifuThirdTableViewCell.h"

@implementation ZhifuThirdTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _stylelabel = [[UILabel alloc] init];
        _stylelabel.text = @"支付方式";
        _stylelabel.font = [UIFont systemFontOfSize:14];
        _zhifuView = [[UIImageView alloc] init];
        _zhifuView.image = [UIImage imageNamed:@"icon_l_zfbzf"];
        _zhifulabel = [[UILabel alloc] init];
        _zhifulabel.text = @"支付宝";
        _zhifulabel.font = [UIFont systemFontOfSize:14];
        _zhifuButton = [[UIButton alloc] init];
        
        
        _yueView = [[UIImageView alloc] init];
        _yueView.image = [UIImage imageNamed:@"icon_l_xjtc"];
        _yuelabel = [[UILabel alloc] init];
        _yuelabel.text = @"余额";
        _yuelabel.font = [UIFont systemFontOfSize:14];
        _yueButton = [[UIButton alloc] init];
        
        [self.contentView addSubview:_stylelabel];
        [self.contentView addSubview:_zhifuView];
        [self.contentView addSubview:_zhifulabel];
        [self.contentView addSubview:_zhifuButton];
        [self.contentView addSubview:_yueView];
        [self.contentView addSubview:_yuelabel];
        [self.contentView addSubview:_yueButton];
       

        
    }
    return self;
}
-(void)layoutSubviews
{
    
    [_stylelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.offset(10);
            make.height.equalTo(self.mas_height).multipliedBy(0.12);
            make.width.equalTo(self.mas_width).multipliedBy(0.4);
        }];
    
    [_zhifuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_stylelabel.mas_bottom).offset(20);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_zhifulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_zhifuView.mas_right).offset(10);
        make.top.equalTo(_stylelabel.mas_bottom).offset(25);
        make.height.equalTo(self.mas_height).multipliedBy(0.1);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    
    [_zhifuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_zhifuView.mas_centerY);
        make.width.height.equalTo(40);
    }];
    
    [_yueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_zhifuView.mas_bottom).offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    [_yuelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_zhifuView.mas_right).offset(10);
        make.top.equalTo(_zhifuView.mas_bottom).offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.1);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
    }];
    
    [_yueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_yueView.mas_centerY);
        make.height.width.equalTo(40);
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
