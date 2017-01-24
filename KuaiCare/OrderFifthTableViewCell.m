//
//  OrderFifthTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderFifthTableViewCell.h"

@implementation OrderFifthTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _messageView = [[UIImageView alloc] init];
        _contactButton = [[UIButton alloc] init];
        _messagelabel = [[UILabel alloc] init];
        _dingdanlabel = [[UILabel alloc] init];
        _goumailabel = [[UILabel alloc] init];
        _cancelabel = [[UILabel alloc] init];
        _xiadanlabel = [[UILabel alloc] init];
        _linelabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_messageView];
        [self.contentView addSubview:_contactButton];
        [self.contentView addSubview:_messagelabel];
        [self.contentView addSubview:_dingdanlabel];
        [self.contentView addSubview:_goumailabel];
        [self.contentView addSubview:_cancelabel];
        [self.contentView addSubview:_linelabel];
        [self.contentView addSubview:_xiadanlabel];

        _messageView.backgroundColor = [UIColor redColor];
        _contactButton.backgroundColor = [UIColor redColor];
        _messagelabel.backgroundColor = [UIColor redColor];
        _dingdanlabel.backgroundColor = [UIColor redColor];
        _goumailabel.backgroundColor = [UIColor redColor];
        _cancelabel.backgroundColor = [UIColor redColor];
        _linelabel.backgroundColor = [UIColor redColor];
        _xiadanlabel.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
        make.width.equalTo(self.mas_height).multipliedBy(0.07);
        
    }];
    [_messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_messageView.mas_right).offset(5);
        make.top.offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);

    }];
    [_contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
    }];
    [_linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageView.mas_bottom).offset(8);
        make.left.offset(0);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(_messagelabel.mas_height).multipliedBy(0.05);
    }];
    
    [_dingdanlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_linelabel.mas_bottom).offset(8);
        make.left.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
    }];
    [_goumailabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dingdanlabel.mas_bottom).offset(5);
        make.left.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
    }];
    [_xiadanlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goumailabel.mas_bottom).offset(5);
        make.left.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.mas_height).multipliedBy(0.14);
    }];
    [_cancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_xiadanlabel.mas_bottom).offset(5);
        make.left.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
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