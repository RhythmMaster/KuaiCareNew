//
//  SelectdoctorTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 2016/12/12.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "SelectdoctorTableViewCell.h"

@implementation SelectdoctorTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headbtn = [UIImageView new];
        _namelab = [[UILabel alloc] init];
        _agelab = [[UILabel alloc] init];
        _xinglab = [[UILabel alloc] init];
        _numlab = [[UILabel alloc] init];
        _numView = [[UIImageView alloc] init];
        _selectbtn = [[UIButton alloc] init];
        _hospitalab = [[UILabel alloc] init];
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectZero];
        
        _headbtn.image = [UIImage imageNamed:@"默认头像"];
        _headbtn.layer.cornerRadius = 32;
        _headbtn.clipsToBounds = YES;
        
        _namelab.text = @"李天平";
        _namelab.font = [UIFont systemFontOfSize:18];
        
        _xinglab.text = @"星星";
        _xinglab.hidden = YES;
        _xinglab.font = [UIFont systemFontOfSize:14];
        
        _starRatingView.maximumValue = 5;
        _starRatingView.minimumValue = 0;
        _starRatingView.tintColor = kRGBA(246, 161, 44, 1.0);
        _starRatingView.allowsHalfStars = NO;
        _starRatingView.value = 3.0;
        //自己临时加的属性,错了背锅
        _starRatingView.allowClick = NO;
        
        
        _agelab.text = @"女：25岁";
        _agelab.font = [UIFont systemFontOfSize:14];
        
        _numView.image = [UIImage imageNamed:@"icon_l_fw"];
        
        _numlab.text = @"服务176次";
        _numlab.font = [UIFont systemFontOfSize:14];
        _numlab.textColor = RGB(43, 111, 254);
        
        [_selectbtn setTitle:@"选择" forState:UIControlStateNormal];
        _selectbtn.layer.cornerRadius = 10;
        _selectbtn.layer.masksToBounds = YES;
        [_selectbtn setTitleColor:RGB(43, 111, 254) forState:UIControlStateNormal];
        _selectbtn.layer.borderColor = [UIColor colorWithRed:43/255.0 green:111/255.0 blue:254/255.0 alpha:1.0].CGColor;
        _selectbtn.layer.borderWidth = 1;
        
        _hospitalab.text = @"上海第一人民医院";
        _hospitalab.font = [UIFont systemFontOfSize:14];
        _hospitalab.textColor = RGB(43, 111, 254);
        
        [self.contentView addSubview:_headbtn];
        [self.contentView addSubview:_namelab];
        [self.contentView addSubview:_agelab];
        [self.contentView addSubview:_xinglab];
        [self.contentView addSubview:_numlab];
        [self.contentView addSubview:_numView];
        [self.contentView addSubview:_selectbtn];
        [self.contentView addSubview:_hospitalab];
        [self.contentView addSubview:_starRatingView];
    }
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_headbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.left.equalTo(10);
        make.width.equalTo(64);
        make.height.equalTo(64);
    }];
    [_namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(_headbtn.mas_right).offset(10);
    }];
    [_agelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.equalTo(_namelab.mas_right).offset(5);
    }];
    
    [_xinglab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_namelab.mas_bottom).offset(3);
        make.left.equalTo(_headbtn.mas_right).offset(10);
        
    }];
    [_starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.namelab.mas_bottom).equalTo(3);
        make.left.equalTo(self.headbtn.mas_right).equalTo(10);
        make.size.equalTo(CGSizeMake(80, 15));
    }];
    [_numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headbtn.mas_right).offset(10);
        make.top.equalTo(_xinglab.mas_bottom).offset(15);
        make.height.equalTo(15);
        make.width.equalTo(15);
    }];
    [_numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numView.mas_right).offset(5);
        make.centerY.equalTo(_numView.mas_centerY);
    }];
    
    [_selectbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.top.equalTo(15);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    [_hospitalab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(_numView.mas_centerY);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (HCSStarRatingView *)starRatingView {
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_starRatingView];
        [_starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.namelab.mas_bottom).equalTo(3);
            make.left.equalTo(self.headbtn.mas_right).equalTo(10);
            make.size.equalTo(CGSizeMake(80, 15));
        }];
        _starRatingView.maximumValue = 5;
        _starRatingView.minimumValue = 0;
        _starRatingView.tintColor = kRGBA(246, 161, 44, 1.0);
        _starRatingView.allowsHalfStars = NO;
        _starRatingView.value = 3.0;
        //自己临时加的属性,错了背锅
        _starRatingView.allowClick = NO;
    }
    return _starRatingView;
}



@end
