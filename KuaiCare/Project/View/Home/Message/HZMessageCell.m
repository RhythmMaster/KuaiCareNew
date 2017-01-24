//
//  HZMessageCell.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMessageCell.h"

@implementation HZMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self detailLb];
        [self timeLb];
        [self dianImg];
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

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(36, 36));
            
        }];
        _iconImg.layer.cornerRadius = 18;
        _iconImg.clipsToBounds = YES;
    }
    return _iconImg;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).equalTo(12);
            make.top.equalTo(10);
            
        }];
        _titleLb.font = [UIFont systemFontOfSize:16];
        //
        _titleLb.text = @"系统提示";
    }
    return _titleLb;
}

- (UILabel *)detailLb {
    if (!_detailLb) {
        _detailLb = [UILabel new];
        [self.contentView addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLb.mas_left);
            make.top.equalTo(_titleLb.mas_bottom).equalTo(6);
            make.right.equalTo(-40);
        }];
        _detailLb.lineBreakMode = NSLineBreakByTruncatingTail;
        _detailLb.font = [UIFont systemFontOfSize:12];
        _detailLb.textColor = [UIColor grayColor];
        //_detailLb.numberOfLines = 0;
        //test
        _detailLb.text = @"打发第三方士大夫水电费是否是打发胜多负少师傅说事实发生";
    }
    return _detailLb;
}



- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [UILabel new];
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLb.mas_top);
            make.right.equalTo(-10);
        }];
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.textColor = [UIColor grayColor];
        _timeLb.text = @"16:43";
    }
    return _timeLb;
}

- (UIImageView *)dianImg {
    if (!_dianImg) {
        _dianImg = [UIImageView new];
        [self.contentView addSubview:_dianImg];
        [_dianImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-8);
            make.size.equalTo(CGSizeMake(8, 8));
        }];
        _dianImg.layer.cornerRadius = 4;
        _dianImg.clipsToBounds = YES;
        _dianImg.backgroundColor = [UIColor redColor];
    }
    return _dianImg;
}




@end
