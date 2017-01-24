//
//  PersonfirstTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "PersonfirstTableViewCell.h"

@implementation PersonfirstTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _personheadButton = [[UIImageView alloc] init];
        _personheadButton.image = [UIImage imageNamed:@"默认头像"];
        _phoneLabel = [[UILabel alloc] init];
        _qiandaoButton = [[UIButton alloc] init];
        
        [self.contentView addSubview:_personheadButton];
        [self.contentView addSubview:_phoneLabel];
        [self.contentView addSubview:_qiandaoButton];
        
    }
    return  self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_personheadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.6);
        make.width.equalTo(self.mas_height).multipliedBy(0.6);
    }];
    _personheadButton.layer.cornerRadius = 30;
    _personheadButton.clipsToBounds = YES;
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.left.equalTo(_personheadButton.mas_right).offset(20);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        
    }];
    [_qiandaoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneLabel.mas_bottom).offset(10);
        make.left.equalTo(_personheadButton.mas_right).offset(20);
        make.height.equalTo(self.mas_height).multipliedBy(0.22);
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
