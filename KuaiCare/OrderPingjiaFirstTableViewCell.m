//
//  OrderPingjiaFirstTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/11/3.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderPingjiaFirstTableViewCell.h"

@implementation OrderPingjiaFirstTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleView1 = [[UIImageView alloc] init];
        _titleView2 = [[UIImageView alloc] init];
        _titleView3 = [[UIImageView alloc] init];
        _clockView = [[UIImageView alloc] init];
        _plusView1 = [[UILabel alloc] init];
        _plusView2 = [[UILabel alloc] init];
        _titlelabel = [[UILabel alloc] init];
        _introlabel = [[UILabel alloc] init];
        _timelabel = [[UILabel alloc] init];
        _pricelabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_titleView1];
        [self.contentView addSubview:_titleView2];
        [self.contentView addSubview:_titleView3];
        [self.contentView addSubview:_clockView];
        [self.contentView addSubview:_plusView1];
        [self.contentView addSubview:_plusView2];
        [self.contentView addSubview:_titlelabel];
        [self.contentView addSubview:_introlabel];
        [self.contentView addSubview:_timelabel];
        [self.contentView addSubview:_pricelabel];

        
        _titlelabel.font = [UIFont systemFontOfSize:16];
        _introlabel.font = [UIFont systemFontOfSize:13];
        _introlabel.textColor = kGrayColor;
        _timelabel.font = [UIFont systemFontOfSize:13];
        _timelabel.textColor = kGrayColor;
        
        _clockView.image = [UIImage imageNamed:@"icon_l_time"];
        _plusView1.text = @"+";
        _plusView1.font = [UIFont systemFontOfSize:20];
        _plusView2.text = @"+";
        _plusView2.font = [UIFont systemFontOfSize:20];
        
        _pricelabel.font = [UIFont systemFontOfSize:13];
        _pricelabel.textColor = kBlueColor;

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_titleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleView1.mas_right).equalTo(6);
        make.top.equalTo(_titleView1.mas_top);
    }];
    [_introlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleView1.mas_right).equalTo(6);
        make.top.equalTo(_titlelabel.mas_bottom).equalTo(0);
    }];
    [_clockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleView1.mas_right).equalTo(6);
        make.bottom.equalTo(_titleView1.mas_bottom);
        make.height.equalTo(self.mas_height).multipliedBy(0.15);
        make.width.equalTo(self.mas_height).multipliedBy(0.15);
    }];
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_clockView.mas_right).equalTo(6);
        make.centerY.equalTo(_clockView.mas_centerY);
    }];
    
    [_plusView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_introlabel.mas_right).equalTo(20);
        make.centerY.equalTo(0);
    }];
    
    [_titleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_plusView1.mas_right).equalTo(8);
        make.centerY.equalTo(0);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
        make.width.equalTo(self.mas_height).multipliedBy(0.5);
    }];
    
    [_plusView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleView2.mas_right).equalTo(8);
        make.centerY.equalTo(0);
    }];
    
    [_titleView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_plusView2.mas_right).offset(8);
        make.centerY.equalTo(0);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
        make.width.equalTo(self.mas_height).multipliedBy(0.5);
    }];
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(-10);
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
