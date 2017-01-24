//
//  RankTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "RankTableViewCell.h"

@implementation RankTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rankView = [[UIImageView alloc] init];
        _ranktitlelabel = [[UILabel alloc] init];
        _rankIntrolabel = [[UILabel alloc] init];
        _rankIntrolabel.font = [UIFont systemFontOfSize:14];
        _rankIntrolabel.numberOfLines = 0;
        [self.contentView addSubview:_rankView];
        [self.contentView addSubview:_ranktitlelabel];
        [self.contentView addSubview:_rankIntrolabel];
        
    }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.bottom.offset(-10);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    
    [_ranktitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(_rankView.mas_right).offset(5);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.mas_height).multipliedBy(0.15);
    }];
    
    [_rankIntrolabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ranktitlelabel.mas_bottom).offset(5);
        make.left.equalTo(_rankView.mas_right).offset(5);
        make.width.equalTo(self.mas_width).multipliedBy(0.65);
        make.height.equalTo(self.mas_height).multipliedBy(0.6);
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