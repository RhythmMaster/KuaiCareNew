//
//  YihuFirstTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/4.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YihuFirstTableViewCell.h"

@implementation YihuFirstTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headButton = [[UIButton alloc] init];
        _namelabel1 = [[UILabel alloc] init];
        _namelabel2 = [[UILabel alloc] init];
        _hospitallabel = [[UILabel alloc] init];
        _numberlabel = [[UILabel alloc] init];
        _zonghelabel = [[UILabel alloc] init];
        _xinglabel = [[UILabel alloc] init];
       

        [self.contentView addSubview:_headButton];
        [self.contentView addSubview:_namelabel1];
        [self.contentView addSubview:_namelabel2];
        [self.contentView addSubview:_hospitallabel];
        [self.contentView addSubview:_numberlabel];
        [self.contentView addSubview:_zonghelabel];
        [self.contentView addSubview:_xinglabel];

        _headButton.backgroundColor = [UIColor redColor];
        _namelabel1.backgroundColor = [UIColor redColor];
        _namelabel2.backgroundColor = [UIColor redColor];
        _hospitallabel.backgroundColor = [UIColor redColor];
        _numberlabel.backgroundColor = [UIColor redColor];
        _zonghelabel.backgroundColor = [UIColor redColor];
        _xinglabel.backgroundColor = [UIColor redColor];

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.75);
        make.width.equalTo(self.mas_height).multipliedBy(0.75);
    }];
    [_namelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(20);
        make.top.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.25);
        make.height.equalTo(self.mas_height).multipliedBy(0.22);
    }];
    [_namelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_namelabel1.mas_right).offset(5);
        make.top.offset(12);
        make.width.equalTo(self.mas_width).multipliedBy(0.25);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_hospitallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(20);
        make.top.equalTo(_namelabel1.mas_bottom).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(20);
        make.top.equalTo(_hospitallabel.mas_bottom).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.25);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_zonghelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numberlabel.mas_right).offset(15);
        make.top.equalTo(_hospitallabel.mas_bottom).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.2);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    
    [_xinglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_zonghelabel.mas_right).offset(5);
        make.top.equalTo(_hospitallabel.mas_bottom).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
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
