//
//  MainWeiPromotTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/12/6.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "MainWeiPromotTableViewCell.h"

@implementation MainWeiPromotTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _introlab = [[UILabel alloc] init];
        _introlab.font = [UIFont systemFontOfSize:14];
        _introlab.numberOfLines = 0;
        [self.contentView addSubview:_introlab];
        
    }
    
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_introlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(15);
        make.right.offset(-15);
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
