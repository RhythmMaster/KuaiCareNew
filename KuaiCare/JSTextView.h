//
//  JSTextView.h
//  Aisino
//
//  Created by Aisino on 16/5/31.
//  Copyright © 2016年 JSHT. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JSTextView : UITextView
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholerColor;
@property (nonatomic, strong) UIFont *placeholderFont;

@end
