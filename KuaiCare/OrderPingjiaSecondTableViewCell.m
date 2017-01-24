//
//  OrderPingjiaSecondTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderPingjiaSecondTableViewCell.h"

@implementation OrderPingjiaSecondTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _namelabel = [[UILabel alloc] init];
       
        [self starRatingView];
        [self.contentView addSubview:_namelabel];
        
        
        
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.equalTo(0);
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

- (HCSStarRatingView *)starRatingView {
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_starRatingView];
        [_starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(120, 16));
        }];
        _starRatingView.maximumValue = 5;
        _starRatingView.minimumValue = 0;
        _starRatingView.tintColor = kRGBA(246, 161, 44, 1.0);
        _starRatingView.allowsHalfStars = NO;
        _starRatingView.value = 5.0;
        //自己临时加的属性,错了背锅
        _starRatingView.allowClick = YES;
    }
    return _starRatingView;
}



@end
