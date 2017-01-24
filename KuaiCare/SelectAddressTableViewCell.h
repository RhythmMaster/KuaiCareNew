//
//  SelectAddressTableViewCell.h
//  KuaiCare
//
//  Created by macbook user on 16/10/27.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAddressTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *namelabel;
@property (nonatomic ,strong)UILabel *phonelabel;
@property (nonatomic ,strong)UILabel *addresslabel;
@property (nonatomic ,strong)UIButton*selectButton;
@property (nonatomic ,strong)UIButton*editButton;
@property (nonatomic ,strong)UIButton*removeButton;

@property (nonatomic ,strong)UILabel *linelabel;
@end
