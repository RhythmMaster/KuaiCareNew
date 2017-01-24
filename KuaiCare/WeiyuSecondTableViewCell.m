//
//  WeiyuSecondTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/28.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "WeiyuSecondTableViewCell.h"

@implementation WeiyuSecondTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _verticalView = [[UIImageView alloc] init];
        _verticalView.image = [UIImage imageNamed:@"icon_l_sg"];
        _namelabel = [[UILabel alloc] init];
        _namelabel.text = @"服务内容";
        _timelabel = [[UILabel alloc] init];
        _timelabel.font = [UIFont systemFontOfSize:14];
        _timelabel.text = @"理疗时间： 50分钟";
        _timelabel.textColor = [UIColor lightGrayColor];
        _fuhulabel = [[UILabel alloc] init];
        _fuhulabel.font = [UIFont systemFontOfSize:14];
        _fuhulabel.text = @"服务内容： 褥疮的预防、褥疮的分级护理";
        _fuhulabel.textColor = [UIColor lightGrayColor];
        _shoufalabel = [[UILabel alloc] init];
        _shoufalabel.font = [UIFont systemFontOfSize:14];
        _shoufalabel.text = @"护理手法： 褥疮护理";
        _shoufalabel.textColor = [UIColor lightGrayColor];
        _horizonlabel = [[UILabel alloc] init];
        _horizonlabel.backgroundColor = RGB(242, 242, 242);
        
        
        [self.contentView addSubview:_verticalView];
        [self.contentView addSubview:_namelabel];
        [self.contentView addSubview:_timelabel];
        [self.contentView addSubview:_fuhulabel];
        [self.contentView addSubview:_shoufalabel];
        [self.contentView addSubview:_horizonlabel];
        
        
        
        


    }
    return self;
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(10);
        make.height.equalTo(20);
        make.width.equalTo(5);
    }];
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_verticalView.mas_right).offset(10);
        make.top.offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.mas_height).multipliedBy(0.16);
    }];
    
    [_horizonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_namelabel.mas_bottom).offset(10);
        make.left.offset(0);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(_verticalView.mas_height).multipliedBy(0.05);
    }];
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_horizonlabel.mas_bottom).offset(10);
         make.left.equalTo(_verticalView.mas_right).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.mas_height).multipliedBy(0.15);
    }];
    [_fuhulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timelabel.mas_bottom).offset(10);
        make.left.equalTo(_verticalView.mas_right).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.mas_height).multipliedBy(0.15);
    }];
    [_shoufalabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fuhulabel.mas_bottom).offset(10);
         make.left.equalTo(_verticalView.mas_right).offset(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.mas_height).multipliedBy(0.15);
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
