//
//  SelectjiuzhenTableViewCell.m
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "SelectjiuzhenTableViewCell.h"

@implementation SelectjiuzhenTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        _namelabel = [[UILabel alloc] init];
        _phonelabel = [[UILabel alloc] init];
        _selectButton = [[UIButton alloc] init];
        _editButton = [[UIButton alloc] init];
        _removeButton = [[UIButton alloc] init];
        _linelabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_namelabel];
        [self.contentView addSubview:_phonelabel];
        [self.contentView addSubview:_selectButton];
        [self.contentView addSubview:_editButton];
        [self.contentView addSubview:_removeButton];
        [self.contentView addSubview:_linelabel];
        
        _linelabel.backgroundColor = RGB(242, 242, 242);
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.equalTo(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.mas_height).multipliedBy(0.18);
    }];
    [_phonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_namelabel.mas_bottom).offset(10);
        make.left.equalTo(10);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.mas_height).multipliedBy(0.15);
        
    }];
    
    [_linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(_phonelabel.mas_bottom).offset(10);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(_namelabel.mas_height).multipliedBy(0.05);
        
    }];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_linelabel.mas_bottom).offset(15);
        make.left.offset(10);
        make.height.equalTo(self.mas_height).multipliedBy(0.14);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];

    [_removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.equalTo(_linelabel.mas_bottom).offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.14);
        make.width.equalTo(self.mas_width).multipliedBy(0.2);
        
    }];
    
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_removeButton.mas_left).offset(-5);
        make.top.equalTo(_linelabel.mas_bottom).offset(15);
        make.height.equalTo(self.mas_height).multipliedBy(0.14);
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
