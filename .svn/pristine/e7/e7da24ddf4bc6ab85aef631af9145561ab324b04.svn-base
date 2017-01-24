//
//  CustomBtn.m
//  KuaiCare
//
//  Created by macbook user on 16/10/31.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "CustomBtn.h"
#import "UIView+Frame.h"
@implementation CustomBtn

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setImage:[UIImage imageNamed:@"arrow_down_icon"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"tableView_arrow_icon"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
    
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.titleLabel.x = self.width/3;
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width - 20;
    self.titleLabel.height = self.height;
    [self.titleLabel setTextColor: [UIColor blackColor]];
    
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    
    
    self.imageView.y = (self.height -20)/2.0;
    self.imageView.height = 20;
    self.imageView.width = 20;
    self.imageView.x = self.titleLabel.x+size.width+25;
    
    
}
@end
