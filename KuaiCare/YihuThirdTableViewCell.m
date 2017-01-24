//
//  YihuThirdTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/4.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YihuThirdTableViewCell.h"

@implementation YihuThirdTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _yihuView = [[UIImageView alloc] init];
        _phonelabel = [[UILabel alloc] init];
        _dafenlabel = [[UILabel alloc] init];
        _messagelabel = [[UILabel alloc] init];
        _xinglabel = [[UILabel alloc] init];
        _timelabel = [[UILabel alloc] init];
        
        
        
        [self.contentView addSubview:_yihuView];
        [self.contentView addSubview:_phonelabel];
        [self.contentView addSubview:_dafenlabel];
        [self.contentView addSubview:_messagelabel];
        [self.contentView addSubview:_xinglabel];
        [self.contentView addSubview:_timelabel];

        _yihuView.backgroundColor = [UIColor redColor];
        _phonelabel.backgroundColor = [UIColor redColor];
        _dafenlabel.backgroundColor = [UIColor redColor];
        _messagelabel.backgroundColor = [UIColor redColor];
        _xinglabel.backgroundColor = [UIColor redColor];
        _timelabel.backgroundColor = [UIColor redColor];

        
        
        
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_yihuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.44);
        make.width.equalTo(self.mas_height).multipliedBy(0.44);
    }];
    [_phonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yihuView.mas_right).offset(10);
        make.top.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.22);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.right.offset(-10);
        make.height.equalTo(self.mas_height).multipliedBy(0.22);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    
    
    [_dafenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yihuView.mas_right).offset(10);
        make.top.equalTo(_phonelabel.mas_bottom).offset(8);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);

    }];
    
    [_xinglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dafenlabel.mas_right).offset(5);
        make.top.equalTo(_phonelabel.mas_bottom).offset(8);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    [_messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_xinglabel.mas_bottom).offset(10);
        make.bottom.offset(-10);
        make.left.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
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
