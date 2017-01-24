//
//  HZOrderDetailPatientInfonCell.m
//  KuaiCare
//
//  Created by tang on 16/12/29.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HZOrderDetailPatientInfonCell.h"

@implementation HZOrderDetailPatientInfonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self patientInfoLb];
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

- (UILabel *)contactLb {
    if (!_contactLb) {
        _contactLb = [UILabel new];
        [self.contentView addSubview:_contactLb];
        [_contactLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(6);
            make.right.equalTo(-8);
        }];
        _contactLb.lineBreakMode = NSLineBreakByTruncatingTail;
        _contactLb.textColor = [UIColor grayColor];
        _contactLb.font = [UIFont systemFontOfSize:14];
        _contactLb.text = @"第三方咖啡色的法定";
    }
    return _contactLb;
}

- (UILabel *)addressLb {
    if (!_addressLb) {
        _addressLb = [UILabel new];
        [self.contentView addSubview:_addressLb];
        [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.contactLb.mas_bottom).equalTo(4);
            make.right.equalTo(-8);
        }];
        _addressLb.lineBreakMode = NSLineBreakByTruncatingTail;
        _addressLb.textColor = [UIColor grayColor];
        _addressLb.font = [UIFont systemFontOfSize:14];
        _addressLb.text = @"第三方咖啡色的法定";
    }
    return _addressLb;
}

- (UILabel *)patientInfoLb {
    if (!_patientInfoLb) {
        _patientInfoLb = [UILabel new];
        [self.contentView addSubview:_patientInfoLb];
        [_patientInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.addressLb.mas_bottom).equalTo(4);
            make.right.equalTo(-8);
        }];
        _patientInfoLb.lineBreakMode = NSLineBreakByTruncatingTail;
        _patientInfoLb.textColor = [UIColor grayColor];
        _patientInfoLb.font = [UIFont systemFontOfSize:14];
        _patientInfoLb.text = @"第三方咖啡色的法定";
    }
    return _patientInfoLb;
}





@end
