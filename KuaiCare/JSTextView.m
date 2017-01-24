
//
//  JSTextView.m
//  Aisino
//
//  Created by Aisino on 16/5/31.
//  Copyright © 2016年 JSHT. All rights reserved.
//

#import "JSTextView.h"
@interface JSTextView()

@end
@implementation JSTextView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholerColor = [UIColor darkGrayColor];
        self.placeholderFont = [UIFont systemFontOfSize:14];
        [self awakeFromNib];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textCenter) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, kScreenW - 30, 60)];
    self.placeLabel.numberOfLines = 0;
    self.placeLabel.font =  self.placeholderFont;
    self.placeLabel.textColor = self.placeholerColor;
    self.placeLabel.text = self.placeholder;
    [self addSubview:  self.placeLabel];
    
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        
        self.placeLabel.hidden = YES;
    }else{
        self.placeLabel.text = placeholder;
        self.placeholerColor = [UIColor redColor];
    }
}

-(void)textCenter{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        
        self.placeLabel.hidden = YES;
        
    }if (self.text.length > 0) {
        
        self.placeLabel.hidden= YES;
        
    }else{
        
        self.placeLabel.hidden = NO;
        
    }
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.placeLabel removeFromSuperview];
    
}
@end
