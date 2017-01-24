//
//  CellBtn.m
//  KuaiCare
//
//  Created by macbook user on 16/10/31.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "CellBtn.h"

@implementation CellBtn
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    if (self.showImage.length > 0) {
        
        //        NSLog(@"显示图片");
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"cell.png"] forState:UIControlStateSelected];
        
    }
    
    
}

@end
