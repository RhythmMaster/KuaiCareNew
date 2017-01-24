//
//  OrderFirstTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderFirstTableViewCell.h"

@implementation OrderFirstTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contactlabel = [[UILabel alloc] init];
        _contactlabel.font = [UIFont systemFontOfSize:14];
        _contactlabel.textColor = [UIColor grayColor];
        _addresslabel = [[UILabel alloc] init];
        _addresslabel.font = [UIFont systemFontOfSize:14];
        _addresslabel.textColor = [UIColor grayColor];
        _jiuzhenlabel = [[UILabel alloc] init];
        _jiuzhenlabel.font = [UIFont systemFontOfSize:14];
        _jiuzhenlabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_contactlabel];
        [self.contentView addSubview:_addresslabel];
        [self.contentView addSubview:_jiuzhenlabel];

        

        
    }
    
    
    return self;
    
}






-(void)layoutSubviews
{
    [super layoutSubviews];
    [_contactlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(8);

    }];
    [_addresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_contactlabel.mas_bottom).offset(8);
    }];
    [_jiuzhenlabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_addresslabel.mas_bottom).offset(8);
        
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
