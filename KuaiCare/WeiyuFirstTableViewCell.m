//
//  WeiyuFirstTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/28.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "WeiyuFirstTableViewCell.h"

@implementation WeiyuFirstTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _verticalView = [[UIImageView alloc] init];
        _verticalView.image = [UIImage imageNamed:@"icon_l_sg"];
        _namelabel = [[UILabel alloc] init];
        _namelabel.text = @"初级褥疮护理";
        _priclabel = [[UILabel alloc] init];
        _priclabel.text = @"¥220";
        _priclabel.textAlignment = NSTextAlignmentRight;
        _priclabel.textColor = RGB(250, 151, 0);
        _introlabel = [[UILabel alloc] init];
        _introlabel.text = @"本服务主要针对长期卧床、皮肤受压、有创面需要处理及指导的初期压疮(褥疮)人群。";
        _introlabel.textColor = [UIColor lightGrayColor];
        _introlabel.font = [UIFont systemFontOfSize:13];
        _introlabel.numberOfLines = 0;
        _headView = [[UIImageView alloc] init];
        _headView.image = [UIImage imageNamed:@"icon_l_def_tx"];
        _orderButton = [[UIButton alloc] init];
        _orderButton.backgroundColor = RGB(37, 157, 234);
        [_orderButton setTitle:@"预约上门护理" forState:UIControlStateNormal];
        _orderButton.layer.cornerRadius = 5;
        _orderButton.clipsToBounds = YES;
        [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _horizonlabel = [[UILabel alloc] init];
        _horizonlabel.backgroundColor = RGB(242, 242, 242);

        [self.contentView addSubview:_verticalView];
        [self.contentView addSubview:_namelabel];
        [self.contentView addSubview:_priclabel];
        [self.contentView addSubview:_introlabel];
        [self.contentView addSubview:_headView];
        [self.contentView addSubview:_orderButton];
        [self.contentView addSubview:_horizonlabel];

//        _verticalabel.backgroundColor = [UIColor redColor];
//        _namelabel.backgroundColor = [UIColor redColor];
//        _priclabel.backgroundColor = [UIColor redColor];
//        _introlabel.backgroundColor = [UIColor redColor];
//        _headView.backgroundColor = [UIColor redColor];
//        _orderButton.backgroundColor = [UIColor redColor];
//        _horizonlabel.backgroundColor = [UIColor redColor];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(15);
        make.height.equalTo(20);
        make.width.equalTo(5);
    }];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_verticalView.mas_right).offset(10);
        make.top.offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [_priclabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.12);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    [_horizonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(_namelabel.mas_bottom).offset(15);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(_namelabel.mas_height).multipliedBy(0.05);
    }];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_horizonlabel.mas_bottom).offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.22);
        make.width.equalTo(self.mas_height).multipliedBy(0.22);
    }];
    [_introlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_horizonlabel.mas_bottom).offset(15);
        make.left.equalTo(_headView.mas_right).offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.22);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
    }];
    
    [_orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(_headView.mas_bottom).offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
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
