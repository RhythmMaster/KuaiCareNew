//
//  FuwuInfoTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "FuwuInfoTableViewCell.h"

@implementation FuwuInfoTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self leibieLabel];
        [self zhifustatusLabel];
       
        [self hospitalabel];
        [self pricelabel];
        
        [self fuwutimelabel];
        
        
        [self dingdanButton];

        
        

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIView *)stateView {
    if (!_stateView) {
        _stateView = [UIView new];
        [self.contentView addSubview:_stateView];
        [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(48);
        }];
        
        
        UIView *lineView = [UIView new];
        [_stateView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = RGB(242, 242, 242);
        
        
    }
    return _stateView;
}

- (UIImageView *)lineView {
    if (!_lineView) {
        _lineView = [UIImageView new];
        [self.stateView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.centerY.equalTo(0);
        }];
        _lineView.image = [UIImage imageNamed:@"icon_l_sg"];
    }
    return _lineView;
}


- (UILabel *)leibieLabel {
    if (!_leibieLabel) {
        _leibieLabel = [UILabel new];
        [self.stateView addSubview:_leibieLabel];
        [_leibieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).equalTo(10);
            make.centerY.equalTo(0);
        }];
        _leibieLabel.text = @"服务类别: 褥疮护理";
    }
    return _leibieLabel;
}

- (UILabel *)zhifustatusLabel {
    if (!_zhifustatusLabel) {
        _zhifustatusLabel = [UILabel new];
        [self.stateView addSubview:_zhifustatusLabel];
        [_zhifustatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        _zhifustatusLabel.font = [UIFont systemFontOfSize:16];
        _zhifustatusLabel.textColor = RGB(54, 136, 255);
    }
    return _zhifustatusLabel;
}



//infoView
- (UIView *)infoView {
    if (!_infoView) {
        _infoView = [UIView new];
        [self.contentView addSubview:_infoView];
        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.stateView.mas_bottom);
            make.height.equalTo(170);
        }];
        
        UIView *lineView = [UIView new];
        [_infoView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = RGB(242, 242, 242);
        
    }
    return _infoView;
}
- (UIImageView *)touxiangView {
    if (!_touxiangView) {
        _touxiangView = [UIImageView new];
        [self.infoView addSubview:_touxiangView];
        [_touxiangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
            make.size.equalTo(CGSizeMake(50, 50));
        }];
        _touxiangView.layer.cornerRadius = 25;
        _touxiangView.clipsToBounds = YES;
        
    }
    return _touxiangView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        [self.infoView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.touxiangView.mas_right).equalTo(12);
            make.top.equalTo(10);
        }];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
        
    }
    return _nameLabel;
}

- (UILabel *)hospitalabel {
    if (!_hospitalabel) {
        _hospitalabel = [UILabel new];
        [self.infoView addSubview:_hospitalabel];
        [_hospitalabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).equalTo(0);
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.width.equalTo(kScreenW * 0.55);
        }];
        _hospitalabel.font = [UIFont systemFontOfSize:13];
        _hospitalabel.textColor = [UIColor lightGrayColor];
        _hospitalabel.textAlignment = NSTextAlignmentLeft;
    }
    return _hospitalabel;
}
- (UILabel *)xiangmuLabel {
    if (!_xiangmuLabel) {
        _xiangmuLabel = [UILabel new];
        [self.infoView addSubview:_xiangmuLabel];
        [_xiangmuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.touxiangView.mas_right).equalTo(12);
            make.top.equalTo(self.nameLabel.mas_bottom).equalTo(12);
        }];
        _xiangmuLabel.font = [UIFont systemFontOfSize:14];
    
    }
    return _xiangmuLabel;
}

- (UILabel *)pricelabel {
    if (!_pricelabel) {
        _pricelabel = [UILabel new];
        [self.infoView addSubview:_pricelabel];
        [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.centerY.equalTo(self.xiangmuLabel.mas_centerY);
        }];
        _pricelabel.font = [UIFont systemFontOfSize:16];
        _pricelabel.textColor = RGB(253, 155, 0);
    }
    return _pricelabel;
}

- (UILabel *)jiuzhenlabel {
    if (!_jiuzhenlabel) {
        _jiuzhenlabel = [UILabel new];
        [self.infoView addSubview:_jiuzhenlabel];
        [_jiuzhenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.touxiangView.mas_bottom).equalTo(12);
        }];
        _jiuzhenlabel.textColor = [UIColor lightGrayColor];
        _jiuzhenlabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _jiuzhenlabel;
}
- (UILabel *)addresslabel {
    if (!_addresslabel) {
        _addresslabel = [UILabel new];
        [self.infoView addSubview:_addresslabel];
        [_addresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.jiuzhenlabel.mas_bottom).equalTo(6);
            make.width.equalTo(kScreenW - 20);
            
        }];
        _addresslabel.textColor = [UIColor lightGrayColor];
        _addresslabel.font = [UIFont systemFontOfSize:14];
    }
    return _addresslabel;
}

- (UILabel *)xiadantimelabel {
    if (!_xiadantimelabel) {
        _xiadantimelabel = [UILabel new];
        [self.infoView addSubview:_xiadantimelabel];
        [_xiadantimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.addresslabel.mas_bottom).equalTo(6);
        }];
        _xiadantimelabel.textColor = [UIColor lightGrayColor];
        _xiadantimelabel.font = [UIFont systemFontOfSize:14];
    }
    return _xiadantimelabel;
}

- (UILabel *)fuwutimelabel {
    if (!_fuwutimelabel) {
        _fuwutimelabel = [UILabel new];
        [self.infoView addSubview:_fuwutimelabel];
        [_fuwutimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.xiadantimelabel.mas_bottom).equalTo(6);
        }];
        _fuwutimelabel.textColor = [UIColor lightGrayColor];
        _fuwutimelabel.font = [UIFont systemFontOfSize:14];
    }
    return _fuwutimelabel;
}


- (UIView *)operationView {
    if (!_operationView) {
        _operationView = [UIView new];
        [self.contentView addSubview:_operationView];
        [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.infoView.mas_bottom);
            make.height.equalTo(44);
        }];
        
        UIView *lineView = [UIView new];
        [_infoView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = RGB(242, 242, 242);
        
    }
    return _operationView;
}

- (UIButton *)zhifuButton {
    if (!_zhifuButton) {
        _zhifuButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.operationView addSubview:_zhifuButton];
        [_zhifuButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-8);
        }];
        
        _zhifuButton.layer.cornerRadius = 2;
        _zhifuButton.layer.masksToBounds = YES;
        _zhifuButton.layer.borderColor = [UIColor colorWithRed:38/255.0 green:107/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _zhifuButton.layer.borderWidth = 1;
        [_zhifuButton setTitle:@"确认支付" forState:UIControlStateNormal];
        _zhifuButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_zhifuButton setTitleColor:RGB(54, 136, 255) forState:UIControlStateNormal];
        _zhifuButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        _zhifuButton.layer.cornerRadius = 4;
        _zhifuButton.clipsToBounds = YES;
        
    }
    return _zhifuButton;
}

- (UIButton *)dingdanButton {
    if (!_dingdanButton) {
        _dingdanButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.operationView addSubview:_dingdanButton];
        [_dingdanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(self.zhifuButton.mas_left).equalTo(-8);
        }];
        
        _dingdanButton.layer.borderColor = [UIColor blackColor].CGColor;
        _dingdanButton.layer.borderWidth = 1;
        _dingdanButton.layer.cornerRadius = 2;
        _dingdanButton.layer.masksToBounds = YES;
        [_dingdanButton setTitle:@"取消订单" forState:UIControlStateNormal];
        _dingdanButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_dingdanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _dingdanButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        _dingdanButton.layer.cornerRadius = 4;
        _dingdanButton.clipsToBounds = YES;

        
    }
    return _dingdanButton;
}










@end
