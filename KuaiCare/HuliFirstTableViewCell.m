//
//  HuliFirstTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HuliFirstTableViewCell.h"

@implementation HuliFirstTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleView = [[UIImageView alloc] init];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        
        
        _introLabel = [[UILabel alloc] init];
        _introLabel.font = [UIFont systemFontOfSize:14];
        _introLabel.textColor = [UIColor lightGrayColor];
        _introLabel.numberOfLines = 0;
        
        
        _timeImageView = [[UIImageView alloc] init];
        
        _timelabel = [[UILabel alloc] init];
        _timelabel.font = [UIFont systemFontOfSize:14];
        _timelabel.textColor = [UIColor lightGrayColor];
        
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = RGB(253, 162, 36);
        
        [self.contentView addSubview:_titleView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        [self.contentView addSubview:_timeImageView];
        [self.contentView addSubview:_timelabel];
        [self.contentView addSubview:_priceLabel];
        
        
        
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(_titleView.mas_right).offset(10);
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleView.mas_right).offset(10);
        make.right.equalTo(-10);
        make.height.equalTo(35);
        
        
    }];
    [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introLabel.mas_bottom).offset(7);
        make.left.equalTo(_titleView.mas_right).offset(10);
        make.width.equalTo(self.mas_height).multipliedBy(0.15);
        make.height.equalTo(self.mas_height).multipliedBy(0.15);
        
    }];
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introLabel.mas_bottom).offset(7);
        make.left.equalTo(_timeImageView.mas_right).offset(5);
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introLabel.mas_bottom).offset(7);
        make.right.offset(-10);
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
