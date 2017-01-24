//
//  ZhifufirstTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/7.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "ZhifufirstTableViewCell.h"

@implementation ZhifufirstTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headView = [[UIImageView alloc] init];
        _yihulabel = [[UILabel alloc] init];
        _hospitalabel = [[UILabel alloc] init];
        _timelabel = [[UILabel alloc] init];
        
        _headView.layer.cornerRadius = 19;
        _headView.clipsToBounds = YES;
        
        _yihulabel.font = [UIFont systemFontOfSize:16];
        _timelabel.font = [UIFont systemFontOfSize:16];
        
        _headView.image = [UIImage imageNamed:@"默认头像"];
        
        [self.contentView addSubview:_headView];
        [self.contentView addSubview:_yihulabel];
        [self.contentView addSubview:_hospitalabel];
        [self.contentView addSubview:_timelabel];
  
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.6);
        make.width.equalTo(self.mas_height).multipliedBy(0.6);
    
    }];
    [_yihulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(_headView.mas_right).offset(5);
    }];
    
    [_hospitalabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yihulabel.mas_right).offset(5);
        make.top.offset(12);
    }];
    
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yihulabel.mas_bottom).offset(10);
        make.left.equalTo(_headView.mas_right).offset(5);
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
