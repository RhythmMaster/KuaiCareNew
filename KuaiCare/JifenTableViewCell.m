//
//  JifenTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "JifenTableViewCell.h"

@implementation JifenTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _statuslabel = [[UILabel alloc] init];
        _jifentimelabel = [[UILabel alloc] init];
        _jifentimelabel.font = [UIFont systemFontOfSize:14];
        _jifentimelabel.textColor = [UIColor lightGrayColor];
        _shumulabel = [[UILabel alloc] init];
        _shumulabel.font = [UIFont systemFontOfSize:30];
        _shumulabel.textColor = RGB(43, 144, 119);
        _shumulabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_statuslabel];
        [self.contentView addSubview:_jifentimelabel];
        [self.contentView addSubview:_shumulabel];
  


    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_statuslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [_jifentimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statuslabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    [_shumulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
//        make.bottom.offset(-20);
//        make.width.equalTo(self.mas_width).multipliedBy(0.2);
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
