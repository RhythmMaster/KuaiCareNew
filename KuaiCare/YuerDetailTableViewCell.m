//
//  YuerDetailTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YuerDetailTableViewCell.h"

@implementation YuerDetailTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _namelabel = [[UILabel alloc] init];
        _yuelabel = [[UILabel alloc] init];
        _yuelabel.font = [UIFont systemFontOfSize:14];
        _yuelabel.textColor = [UIColor lightGrayColor];
        _pricelabel = [[UILabel alloc] init];
        _pricelabel.textAlignment = NSTextAlignmentRight;
        _timelabel = [[UILabel alloc] init];
        _timelabel.font = [UIFont systemFontOfSize:14];
        _timelabel.textColor = [UIColor lightGrayColor];
        _nextButton = [[UIButton alloc] init];
        [_nextButton setImage:[UIImage imageNamed:@"gray_com"] forState:UIControlStateNormal];
        [_nextButton setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [self.contentView addSubview:_namelabel];
        [self.contentView addSubview:_yuelabel];
        [self.contentView addSubview:_pricelabel];
        [self.contentView addSubview:_timelabel];
        [self.contentView addSubview:_nextButton];

        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    [_yuelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_namelabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.offset(30);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
        make.width.equalTo(self.mas_height).multipliedBy(0.25);
        
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_nextButton.mas_left).offset(-5);
        make.top.offset(15);
        make.width.equalTo(self.mas_width).multipliedBy(0.35);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_nextButton.mas_left).offset(-5);
        make.top.equalTo(_pricelabel.mas_bottom).offset(10);
//        make.width.equalTo(self.mas_width).multipliedBy(0.35);
//        make.height.equalTo(self.mas_height).multipliedBy(0.3);
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
