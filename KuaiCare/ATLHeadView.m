//
//  ATLHeadView.m
//  ATLife
//
//  Created by Aisino on 16/9/29.
//  Copyright © 2016年 Aisino. All rights reserved.
//

#import "ATLHeadView.h"
#import "UIView+Frame.h"
@implementation ATLHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        // 设置一些属性(例如背景色)
      
        
    }
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.width = [UIScreen mainScreen].bounds.size.width;
//    NSLog(@"高度======%f",self.height);
    self.textLabel.x = 5;
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.textLabel.textColor = [UIColor blackColor];

    
}

@end
