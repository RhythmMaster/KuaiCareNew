//
//  HZWithDrawWarmPromptCell.m
//  dddd
//
//  Created by tang on 16/12/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithDrawWarmPromptCell.h"

@implementation HZWithDrawWarmPromptCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self warmPromptDetatilLb];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)warmPromptImg {
    if (!_warmPromptImg) {
        _warmPromptImg = [UIImageView new];
        [self.contentView addSubview:_warmPromptImg];
        [_warmPromptImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        _warmPromptImg.contentMode = UIViewContentModeScaleAspectFit;
        _warmPromptImg.image = [UIImage imageNamed:@"温馨提示"];
    }
    return _warmPromptImg;
}

- (UILabel *)warmPromptLb {
    if (!_warmPromptLb) {
        _warmPromptLb = [UILabel new];
        [self.contentView addSubview:_warmPromptLb];
        [_warmPromptLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.warmPromptImg.mas_right).equalTo(10);
            make.centerY.equalTo(_warmPromptImg.mas_centerY);
        }];
        _warmPromptLb.text = @"温馨提示";
        _warmPromptLb.textColor = [UIColor grayColor];
    }
    return _warmPromptLb;
}

- (CJLabel *)warmPromptDetatilLb {
    if (!_warmPromptDetatilLb) {
        _warmPromptDetatilLb = [CJLabel new];
        [self.contentView addSubview:_warmPromptDetatilLb];
        [_warmPromptDetatilLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.warmPromptLb.mas_left);
            make.top.equalTo(_warmPromptLb.mas_bottom).equalTo(8);
            make.right.equalTo(-8);
            make.bottom.equalTo(-10);
        }];
        _warmPromptDetatilLb.numberOfLines = 0;
        _warmPromptDetatilLb.textColor = [UIColor grayColor];
        _warmPromptDetatilLb.text = @"按时发生的发生的发顺丰案说法是否是否是否撒地方阿斯蒂芬阿斯顿发到付af阿道夫啊按时打算发顺丰是否饭";
    }
    return _warmPromptDetatilLb;
}

- (UIButton *)suggestBtn {
    if (!_suggestBtn) {
        _suggestBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_suggestBtn];
    }
    return _suggestBtn;
}

@end
