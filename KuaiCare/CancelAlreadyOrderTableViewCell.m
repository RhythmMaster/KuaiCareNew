//
//  CancelAlreadyOrderTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/16.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "CancelAlreadyOrderTableViewCell.h"

@implementation CancelAlreadyOrderTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectButton = [[UIButton alloc] init];
        [self.contentView addSubview:_selectButton];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.bottom.equalTo(0);
        make.width.equalTo(KCWIDTH*0.8);
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
