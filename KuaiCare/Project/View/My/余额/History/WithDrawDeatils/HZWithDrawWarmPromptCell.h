//
//  HZWithDrawWarmPromptCell.h
//  dddd
//
//  Created by tang on 16/12/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CJLabel.h"
#import "NSString+CJString.h"

@interface HZWithDrawWarmPromptCell : UITableViewCell

@property(nonatomic) UIImageView *warmPromptImg;
@property(nonatomic) UILabel *warmPromptLb;

@property(nonatomic) CJLabel *warmPromptDetatilLb;
@property(nonatomic) UIButton *suggestBtn;

@end
