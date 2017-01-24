//
//  YihuSecondTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/4.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YihuSecondTableViewCell.h"

@implementation YihuSecondTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectButton = [[UIButton alloc] init];
        _titlelabel = [[UILabel alloc] init];
        _jingyanlabel = [[UILabel alloc] init];
        _introlabel = [[UILabel alloc] init];
        [self.contentView addSubview:_selectButton];
        [self.contentView addSubview:_titlelabel];
        [self.contentView addSubview:_jingyanlabel];
        [self.contentView addSubview:_introlabel];

        _selectButton.backgroundColor = [UIColor redColor];
        _titlelabel.backgroundColor = [UIColor redColor];
        _jingyanlabel.backgroundColor = [UIColor redColor];
        _introlabel.backgroundColor = [UIColor redColor];

        
    }
    
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.1);
        make.width.equalTo(self.mas_height).multipliedBy(0.1);
    }];
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.equalTo(_selectButton.mas_right).offset(5);
        make.height.equalTo(self.mas_height).multipliedBy(0.1);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
    }];
    
    [_jingyanlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titlelabel.mas_bottom).offset(15);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);

    }];
    [_introlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jingyanlabel.mas_bottom).offset(15);
        make.left.offset(10);
        make.bottom.offset(-15);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
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
