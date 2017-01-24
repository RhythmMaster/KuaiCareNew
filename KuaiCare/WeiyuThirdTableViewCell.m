//
//  WeiyuThirdTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/28.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "WeiyuThirdTableViewCell.h"

@implementation WeiyuThirdTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _verticalView = [[UIImageView alloc] init];
        _verticalView.image = [UIImage imageNamed:@"icon_l_sg"];
        _namelabel = [[UILabel alloc] init];
        _namelabel.text = @"用户须知";
              _horizonlabel = [[UILabel alloc] init];
        _horizonlabel.backgroundColor = RGB(242, 242, 242);
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.text = @"1、本平台提供褥疮的预防，以及一度褥疮和二度褥疮的护理。2、三度褥疮局部组织出现溃疡和坏死，建议及时就医。3、患者提供之前医院就诊病例报告，自备褥疮护理的敷料、生理盐水、棉签等物品（可以在护理师上门之前沟通时，根据护理师要求提前将物品备好）。护理前签署知情同意书。";
        _messagelabel.numberOfLines = 0;
        _messagelabel.font = [UIFont systemFontOfSize:14];
        _messagelabel.textColor = [UIColor lightGrayColor];

        
        [self.contentView addSubview:_verticalView];
        [self.contentView addSubview:_namelabel];
        [self.contentView addSubview:_horizonlabel];
        [self.contentView addSubview:_messagelabel];

      

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(0);
        make.height.equalTo(20);
        make.width.equalTo(5);
    }];
   [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.offset(15);
       make.left.equalTo(_verticalView.mas_right).offset(10);
       make.width.equalTo(self.mas_width).multipliedBy(0.6);
       make.height.equalTo(self.mas_height).multipliedBy(0.1);
   }];
   [_horizonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(_verticalView.mas_bottom).offset(10);
       make.left.offset(0);
       make.width.equalTo(self.mas_width);
       make.height.equalTo(_verticalView.mas_height).multipliedBy(0.05);
   }];
   [_messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(_horizonlabel.mas_bottom).offset(5);
       make.left.equalTo(_verticalView.mas_right).offset(10);
       make.right.offset(-10);
       make.height.equalTo(self.mas_height).multipliedBy(0.75);
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
