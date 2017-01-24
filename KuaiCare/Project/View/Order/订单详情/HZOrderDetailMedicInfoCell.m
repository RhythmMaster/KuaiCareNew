//
//  HZOrderDetailMedicInfoCell.m
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderDetailMedicInfoCell.h"

@implementation HZOrderDetailMedicInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self medicNameLb];
        [self appointmentTimeLb];
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


- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [UIImageView new];
        [self.contentView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
        _headImg.layer.cornerRadius = 20;
        _headImg.clipsToBounds = YES;
        _headImg.backgroundColor = [UIColor blueColor];
    }
    return _headImg;
}
- (UILabel *)medicNameLb {
    if (!_medicNameLb) {
        _medicNameLb = [UILabel new];
        [self.contentView addSubview:_medicNameLb];
        [_medicNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).equalTo(10);
            make.top.equalTo(10);
//            make.width.equalTo(kScreenW - 40 - 30);
        }];
        _medicNameLb.numberOfLines = 0;
        _medicNameLb.textColor = [UIColor grayColor];
        _medicNameLb.font = [UIFont systemFontOfSize:13];
        _medicNameLb.text = @"圣诞节福利圣诞";
    }
    return _medicNameLb;
}

- (UILabel *)medicHospitalLb {
    if (!_medicHospitalLb) {
        _medicHospitalLb = [UILabel new];
        [self.contentView addSubview:_medicHospitalLb];
        [_medicHospitalLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.medicNameLb.mas_right).equalTo(1);
            make.centerY.equalTo(self.medicNameLb.mas_centerY);
            make.right.equalTo(-10);
        }];
        _medicHospitalLb.textColor = kGrayColor;
        _medicHospitalLb.font = [UIFont systemFontOfSize:12];
        _medicHospitalLb.numberOfLines = 0;
        _medicHospitalLb.hidden = YES;
    }
    return _medicHospitalLb;
}


- (UILabel *)medicAddressLb {
    if (!_medicAddressLb) {
        _medicAddressLb = [UILabel new];
        [self.contentView addSubview:_medicAddressLb];
        [_medicAddressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).equalTo(10);
            make.centerY.equalTo(0);
            make.right.equalTo(-35);
        }];
        _medicAddressLb.numberOfLines = 0;
        _medicAddressLb.textColor = [UIColor grayColor];
        _medicAddressLb.font = [UIFont systemFontOfSize:13];
        _medicAddressLb.text = @"第三方咖啡色的定";
    }
    return _medicAddressLb;
}

- (UIButton *)phoneBtn {
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_phoneBtn];
        [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(-6);
            make.size.equalTo(CGSizeMake(25, 25));
        }];
        
        [_phoneBtn setImage:[UIImage imageNamed:@"icon_l_tellogo"] forState:UIControlStateNormal];
    }
    return _phoneBtn;
}

- (UILabel *)appointmentTimeLb {
    if (!_appointmentTimeLb) {
        _appointmentTimeLb = [UILabel new];
        [self.contentView addSubview:_appointmentTimeLb];
        [_appointmentTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).equalTo(10);
            make.top.equalTo(self.medicAddressLb.mas_bottom).equalTo(4);
            make.right.equalTo(self.phoneBtn.mas_left).equalTo(-4);
            make.bottom.equalTo(-10);
        }];
        _appointmentTimeLb.numberOfLines = 0;
        _appointmentTimeLb.textColor = [UIColor grayColor];
        _appointmentTimeLb.font = [UIFont systemFontOfSize:13];
        _appointmentTimeLb.text = @"第三方咖啡色";
    }
    return _appointmentTimeLb;
}





@end
