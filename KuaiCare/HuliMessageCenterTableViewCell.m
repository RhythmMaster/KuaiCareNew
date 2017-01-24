//
//  HuliMessageCenterTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/10.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HuliMessageCenterTableViewCell.h"

@implementation HuliMessageCenterTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headView = [[UIImageView alloc] init];
        _headView.image = [UIImage imageNamed:@"img_inbite"];
        _titlelabel = [[UILabel alloc] init];
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.font = [UIFont systemFontOfSize:14];
        _messagelabel.textColor = [UIColor lightGrayColor];
        _timelabel = [[UILabel alloc] init];
        _timelabel.textColor = [UIColor lightGrayColor];
        _timelabel.font = [UIFont systemFontOfSize:13];
        _dianView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_headView];
        [self.contentView addSubview:_titlelabel];
        [self.contentView addSubview:_messagelabel];
        [self.contentView addSubview:_timelabel];
        [self.contentView addSubview:_dianView];

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(6);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.83);
        make.width.equalTo(self.mas_height).multipliedBy(0.83);
    }];
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView.mas_right).offset(10);
        make.top.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.33);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    
    [_messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titlelabel.mas_bottom).offset(5);
        make.left.equalTo(_headView.mas_right).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.mas_height).multipliedBy(0.28);
    }];
    
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(10);
    }];
    [_dianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_messagelabel.mas_centerY);
        make.right.offset(-15);
        make.height.equalTo(10);
        make.width.equalTo(10);
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
