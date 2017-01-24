//
//  OrderThirdTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderThirdTableViewCell.h"

@implementation OrderThirdTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleView = [[UIImageView alloc] init];
        _introlabel = [[UILabel alloc] init];
        _pricelabel1 = [[UILabel alloc] init];
        _numberlabel = [[UILabel alloc] init];
        _pricelabel2 = [[UILabel alloc] init];
        
        _introlabel.font = [UIFont systemFontOfSize:14];
        _pricelabel1.font = [UIFont systemFontOfSize:13];
        _pricelabel1.textColor = [UIColor orangeColor];
        _numberlabel.font = [UIFont systemFontOfSize:13];
        _pricelabel2.textColor = [UIColor orangeColor];
        _pricelabel2.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_titleView];
        [self.contentView addSubview:_introlabel];
        [self.contentView addSubview:_pricelabel1];
        [self.contentView addSubview:_numberlabel];
        [self.contentView addSubview:_pricelabel2];

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.8);
        make.width.equalTo(self.mas_height).multipliedBy(0.8);
    }];
    [_introlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(_titleView.mas_right).offset(10);
    }];
    
    [_pricelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introlabel.mas_bottom).offset(8);
        make.left.equalTo(_titleView.mas_right).offset(10);
    }];
    
    [_numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    [_pricelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.right.offset(-10);
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
