//
//  CustomButton.m
//  KuaiCare
//
//  Created by macbook user on 16/10/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, KCWIDTH/2, 70)];
    if (self) {
        _headView = [[UIImageView alloc] init];
        _introlabel1 = [[UILabel alloc] init];
        _introlabel2 = [[UILabel alloc] init];
        _introlabel2.textColor = RGB(130, 130, 130);
        [self addSubview:_headView];
        [self addSubview:_introlabel1];
        [self addSubview:_introlabel2];
        
    
    }
    
    return self;
}
-(void)layoutSubviews
{
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(15);
        make.width.equalTo(self.mas_height).multipliedBy(0.3);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_introlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.equalTo(_headView.mas_right).offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
    }];
    
    [_introlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introlabel1.mas_bottom).offset(10);
        make.left.equalTo(_headView.mas_right).offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
    }];
    
}
@end
