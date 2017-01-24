//
//  HuliSecondTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HuliSecondTableViewCell.h"

@implementation HuliSecondTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _selectlabel = [[UILabel alloc] init];
//        _selectlabel.text = @"请选择其它需要";
//        _selectlabel.font = [UIFont systemFontOfSize:14];
//        _selectButton1 = [[UIButton alloc] init];
//        _selectButton2 = [[UIButton alloc] init];
//        _hulibaoLabel = [[UILabel alloc] init];
//        _hulibaoLabel.textColor = [UIColor lightGrayColor];
//        
//        _shabuLabel = [[UILabel alloc] init];
//        _shabuLabel.textColor = [UIColor lightGrayColor];
//        
//        [self.contentView addSubview:_selectlabel];
//        [self.contentView addSubview:_selectButton1];
//        [self.contentView addSubview:_selectButton2];
//        [self.contentView addSubview:_hulibaoLabel];
//        [self.contentView addSubview:_shabuLabel];
        
        
        [self selectlabel];
        [self careBagBtn];
        
        
    }
    return self;
}



- (UILabel *)selectlabel {
    if (!_selectlabel) {
        _selectlabel = [UILabel new];
        _selectlabel.text = @"请选择其它需要";
        _selectlabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_selectlabel];
        [_selectlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(12);
        }];
    }
    return _selectlabel;
}

- (UILabel *)cartridgeBagPriceLb {
    if (!_cartridgeBagPriceLb) {
        _cartridgeBagPriceLb = [UILabel new];
         _cartridgeBagPriceLb.textColor = kGrayColor;
        [self.contentView addSubview:_cartridgeBagPriceLb];
        [_cartridgeBagPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-8);
        }];
        _cartridgeBagPriceLb.font = [UIFont systemFontOfSize:14];
    }
    return _cartridgeBagPriceLb;
}

- (HZIsClickBtn *)cartridgeBagBtn {
    if (!_cartridgeBagBtn) {
        _cartridgeBagBtn = [HZIsClickBtn buttonWithType:UIButtonTypeCustom];
        _cartridgeBagBtn.isClick = YES;
        [self.contentView addSubview:_cartridgeBagBtn];
        [_cartridgeBagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cartridgeBagPriceLb.mas_left).equalTo(-2);
            make.centerY.equalTo(0);
        }];
        _cartridgeBagBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _cartridgeBagBtn;
}

- (UILabel *)careBagPriceLb {
    if (!_careBagPriceLb) {
        _careBagPriceLb = [UILabel new];
        _careBagPriceLb.textColor = kGrayColor;
        [self.contentView addSubview:_careBagPriceLb];
        [_careBagPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cartridgeBagBtn.mas_left).equalTo(-15);
            make.centerY.equalTo(0);
        }];
        _careBagPriceLb.font = [UIFont systemFontOfSize:14];
    }
    return _careBagPriceLb;
}

- (HZIsClickBtn *)careBagBtn {
    if (!_careBagBtn) {
        _careBagBtn = [HZIsClickBtn buttonWithType:UIButtonTypeCustom];
        _careBagBtn.isClick = YES;
        [self.contentView addSubview:_careBagBtn];
        [_careBagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.careBagPriceLb.mas_left).equalTo(-2);
            make.centerY.equalTo(0);
        }];
        _careBagBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _careBagBtn;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [_selectlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.35);
        make.bottom.offset(-10);
    }];
    
    
    [_shabuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [_selectButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_shabuLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width).multipliedBy(0.15);
    }];
    
    [_hulibaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_selectButton2.mas_left).offset(-5);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    
    [_selectButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_hulibaoLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width).multipliedBy(0.2);
    }];
    
    
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
