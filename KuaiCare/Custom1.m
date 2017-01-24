//
//  Custom1.m
//  KuaiCare
//
//  Created by macbook user on 16/11/10.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "Custom1.h"

@implementation Custom1

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self nameLb];
        
    }
    return self;
}



- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
        [self addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.centerX.equalTo(0);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
    }
    return _img;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.img.mas_centerX);
            make.top.equalTo(self.img.mas_bottom).equalTo(5);
            
        }];
        _nameLb.textColor = [UIColor whiteColor];
        _nameLb.font = [UIFont systemFontOfSize:14];
        
    }
    return _nameLb;
}


@end
