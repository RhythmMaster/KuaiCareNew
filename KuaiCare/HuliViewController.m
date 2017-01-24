//
//  HuliViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/10/26.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "HuliViewController.h"
#import "SelectAddressViewController.h"
#import "SelectJiuzhenViewController.h"
#import "SelectRankViewController.h"
#import "SelectTimeViewController.h"
#import "SelectdoctorViewController.h"
#import "ZhifuViewController.h"
#import "MBProgressHUD+NJ.h"
#import "NetConstants.h"
#import "Utils.h"
#import "HuliFreeViewController.h"

#import "HuliFirstTableViewCell.h"
#import "HuliSecondTableViewCell.h"
#import "HuliThirdTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "JSTextView.h"

#import "HcdDateTimePickerView.h"

#import "XWLocationManager.h"

#import "HZSubScribeViewModel.h"
#import "HZRankKindCell.h"

#import "EditViewController.h"
#import "EditjiuzhenViewController.h"

@interface HuliViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    HcdDateTimePickerView * dateTimePickerView;
}
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *nameArray;
@property (nonatomic ,strong)JSTextView *textView;
@property (nonatomic ,strong)NSDictionary *dict;
@property (nonatomic ,strong)NSArray *listArray;

@property (nonatomic ,copy)NSString *datetimeStr;//医患预约时间

@property(nonatomic) UIButton *loationBtn;
//地图定位
@property(nonatomic) NSString *gpsaddress;//gps定位地址
@property(nonatomic) NSString *address;//地图定位地址
@property(nonatomic) NSString *addressXY;//医患下单时手机定位经纬度
@property(nonatomic) NSString *addressinfo;//详细地址

@property (nonatomic ,copy)NSString *rankname;//护理等级名称
@property (nonatomic ,copy)NSString *rankid;//护理等级ID
@property (nonatomic ,copy)NSString *incrementid;//增值服务的主键
@property (nonatomic ,copy)NSString *recovername;//康复项目的名称
@property (nonatomic ,copy)NSString *recoverid;//康复项目主键ID
@property (nonatomic ,copy)NSString *medicId;// 医护主键ID
@property (nonatomic ,copy)NSString *medicName;//联系人姓名
@property (nonatomic ,copy)NSString *medicPhone;//联系人电话
@property (nonatomic ,copy)NSString *patientId;//就诊人ID
@property (nonatomic ,copy)NSString *patientSex;//就诊人性别
@property (nonatomic ,copy)NSString *patientBirthday;//就诊人生日
@property (nonatomic ,copy)NSString *patienName;//就诊人姓名
@property (nonatomic ,copy)NSString *patientTel;//就诊人电话
@property (nonatomic ,copy)NSString *descrip;//描述

@property (nonatomic ,strong)UIButton * selectButton1;
@property (nonatomic ,strong)UIButton * selectButton2;


@property(nonatomic) HZSubScribeViewModel *subScribeVM;

@property(nonatomic) HZIsClickBtn *careBagBtn;
@property(nonatomic) HZIsClickBtn *cartridgeBagBtn;

@property(nonatomic) HZIsClickBtn *wrongBtn;
@property(nonatomic) HZIsClickBtn *rightBtn;

@property(nonatomic) NSString *addressStr;
@property(nonatomic) NSString *rankNameStr;
@property(nonatomic) NSString *nursrStr;



@property(nonatomic) NSString *incrementOne;
@property(nonatomic) NSString *incrementTwo;
@property(nonatomic) NSDictionary *paramters;


@property(nonatomic) UIButton *xiadanButton;


@end

@implementation HuliViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    HZDataHandler *data = [HZDataHandler sharedHadle];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (data.nameStr.length) {
        cell.textLabel.text = data.nameStr;
        [self.tableView reloadData];
        self.nursrStr = data.nameStr;
    }
    if (data.medicId.length) {
        self.medicId = data.medicId;
        NSLog(@"self.medicId%@", self.medicId);
    }
    data.nameStr = nil;
    data.hospital = nil;
    data.phone = nil;
    data.medicId = nil;
    
    
}


- (void)getCurrentLocation {
    [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            NSLog(@"定位出错,错误信息:%@",error);
            [kAppdelegate.window showWarning:@"定位失败"];
        }else{
            
            NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@%@%@ \n ",location.coordinate.latitude, location.coordinate.longitude,  placeMark.locality, placeMark.subLocality, placeMark.name);
            [self.loationBtn setTitle:placeMark.locality forState:UIControlStateNormal];
            self.gpsaddress = [NSString stringWithFormat:@"%@%@%@", placeMark.locality, placeMark.subLocality, placeMark.name];
            self.addressXY = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
            
            //数据持久化
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.address forKey:@"address"];
            [defaults setObject:self.addressXY forKey:@"addressXY"];
            [defaults synchronize];
            
        }
    } onViewController:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"护理项目";

    [self getCurrentLocation];
    
    [self.subScribeVM getSubScribeModelWithCompletionHandler:^(NSError *error) {
       
        if (!error) {
            [self.tableView reloadData];
            self.patienName = _subScribeVM.itemModel.jzrName;
            self.patientId = _subScribeVM.itemModel.jzrId;
            self.patientSex = _subScribeVM.itemModel.jzrSex;
            self.patientBirthday = _subScribeVM.itemModel.jzrAge;
            self.patientTel = _subScribeVM.itemModel.jzrTel;
            self.addressinfo = _subScribeVM.itemModel.commonAddressInfo;
            self.address = _subScribeVM.itemModel.commonAddress;
            self.medicName = _subScribeVM.itemModel.commonName;
            self.medicPhone = _subScribeVM.itemModel.commonTel;
            self.rankid = _subScribeVM.itemModel.itemList[1].ID;
            self.rankname = _subScribeVM.itemModel.itemList[1].name;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
    

    self.tableView  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.tableView registerClass:[HZRankKindCell class] forCellReuseIdentifier:@"HZRankKindCell"];
    
    self.nameArray = [[NSArray alloc] initWithObjects:@"请选择服务地址",@"请选择就诊人",@"请选择褥疮等级",@"请选择时间",@"请选择医护人员",nil];
    
    
    
    //增加对键盘的监听,当键盘出现或改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加对键盘的监听,当键盘退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"CELL1";
        HuliFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[HuliFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        self.recovername = self.subScribeVM.itemModel.name;
        self.recoverid = self.subScribeVM.itemModel.ID;
        
        cell.titleView.image = [UIImage imageNamed:@"icon_default_pic"];
        cell.titleLabel.text = self.subScribeVM.itemModel.name;
        cell.introLabel.text = self.subScribeVM.itemModel.desc;
        cell.timeImageView.image = [UIImage imageNamed:@"icon_l_time"];
        cell.timelabel.text = self.subScribeVM.itemModel.theraplTime;
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.subScribeVM.itemModel.servicePrice];
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            HZRankKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZRankKindCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.oneBtn setTitle:_subScribeVM.itemModel.itemList[0].name forState:UIControlStateNormal];
            cell.oneBtn.tag = 1234;
            [cell.oneBtn addTarget:self action:@selector(rankSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            if (cell.oneBtn.isClick) {
                [cell.oneBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
            } else {
                [cell.oneBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
            }
            [cell.twoBtn setTitle:_subScribeVM.itemModel.itemList[1].name forState:UIControlStateNormal];
            cell.twoBtn.tag = 1235;
            [cell.twoBtn addTarget:self action:@selector(rankSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            if (cell.twoBtn.isClick) {
                [cell.twoBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
            } else {
                [cell.twoBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
            }
            [cell.threeBtn setTitle:_subScribeVM.itemModel.itemList[2].name forState:UIControlStateNormal];
            cell.threeBtn.tag = 1236;
            [cell.threeBtn addTarget:self action:@selector(rankSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            if (cell.threeBtn.isClick) {
                [cell.threeBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
            } else {
                [cell.threeBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
            }
            [cell.declareBtn addTarget:self action:@selector(rankDeclareClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        static NSString *cellID = @"CELL2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text =[self.nameArray objectAtIndex:indexPath.row];
        
        if (indexPath.row == 3) {
            NSDate *nowDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
            NSString *nowDateStr = [dateFormatter stringFromDate:nowDate];
            nowDate = [dateFormatter dateFromString:nowDateStr];
            NSDate *defaDate = [nowDate initWithTimeIntervalSinceNow: +24 * 3600];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
            NSString *defaDateStr = [dateFormatter stringFromDate:defaDate];
            defaDate = [dateFormatter dateFromString:defaDateStr];
            NSString *defaDateText = [NSString stringWithFormat:@"%@(默认第二天的当前时间)", defaDateStr];
            NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:defaDateText];
            [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(defaDateStr.length, defaDateText.length - defaDateStr.length)];
            [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(defaDateStr.length, defaDateText.length - defaDateStr.length)];
            cell.textLabel.attributedText = attributeStr;
        }
        
        if (indexPath.row == 0 && self.addressinfo.length) {
            cell.textLabel.text = self.addressinfo;
        }
        if (indexPath.row == 1 && self.patienName.length) {
            cell.textLabel.text = self.patienName;
        }
        
        if (indexPath.row == 3 && self.datetimeStr.length) {
            cell.textLabel.text = self.datetimeStr;
        }
        if (indexPath.row == 4 && self.nursrStr.length) {
            cell.textLabel.text = self.nursrStr;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    if (indexPath.section == 2) {
        static NSString *cellID = @"CELL3";
        HuliSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[HuliSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        self.careBagBtn = cell.careBagBtn;
        if (cell.careBagBtn.isClick) {
            [cell.careBagBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        } else {
            [cell.careBagBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        }
        [cell.careBagBtn setTitle:[NSString stringWithFormat:@" %@", self.subScribeVM.itemModel.list[0].desc] forState:UIControlStateNormal];
        [cell.careBagBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
        cell.careBagBtn.selected = NO;
        [cell.careBagBtn addTarget:self action:@selector(careBagClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *careBagPriceStr = [NSString stringWithFormat:@"(¥%@)",self.subScribeVM.itemModel.list[0].price];
        
        NSMutableAttributedString *attributedCareBagPriceStr = [[NSMutableAttributedString alloc]initWithString:careBagPriceStr];
        [attributedCareBagPriceStr addAttribute:NSForegroundColorAttributeName
                               value:[UIColor colorWithRed:253/255.0 green:162/255.0 blue:36/255.0 alpha:1.0]
                               range:NSMakeRange(1, self.subScribeVM.itemModel.list[0].price.length + 2)];
        cell.careBagPriceLb.attributedText = attributedCareBagPriceStr;
        
        self.cartridgeBagBtn = cell.cartridgeBagBtn;
        if (cell.cartridgeBagBtn.isClick) {
            [cell.cartridgeBagBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            [cell.cartridgeBagBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        }
        [cell.cartridgeBagBtn setTitle:[NSString stringWithFormat:@" %@", self.subScribeVM.itemModel.list[1].desc] forState:UIControlStateNormal];
        [cell.cartridgeBagBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
        cell.cartridgeBagBtn.selected = NO;
        [cell.cartridgeBagBtn addTarget:self action:@selector(cartridgeBagClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *cartridgeBagBtnPriceStr = [NSString stringWithFormat:@"(¥%@)",self.subScribeVM.itemModel.list[1].price];
        
        NSMutableAttributedString *attributedcartridgeBagBtnPriceStr = [[NSMutableAttributedString alloc]initWithString:cartridgeBagBtnPriceStr];
        [attributedcartridgeBagBtnPriceStr addAttribute:NSForegroundColorAttributeName
                                          value:[UIColor colorWithRed:253/255.0 green:162/255.0 blue:36/255.0 alpha:1.0]
                                          range:NSMakeRange(1, self.subScribeVM.itemModel.list[1].price.length + 2)];
        cell.cartridgeBagPriceLb.attributedText = attributedcartridgeBagBtnPriceStr;
        return cell;
    }
    
    if (indexPath.section == 3) {
        static NSString *cellID = @"CELL4";
        HuliThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil) {
            cell = [[HuliThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell.freeButton addTarget:self action:@selector(freeButton:) forControlEvents:UIControlEventTouchUpInside];
        if (cell.wrongButton.isClick) {
            [cell.wrongButton setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        } else {
            [cell.wrongButton setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        }
        self.wrongBtn = cell.wrongButton;
        [cell.wrongButton addTarget:self action:@selector(wrongClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.wrongButton setTitle:@" 否" forState:UIControlStateNormal];
        cell.wrongButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cell.wrongButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if (cell.rightButton.isClick) {
            [cell.rightButton setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        } else {
            [cell.rightButton setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        }
        self.rightBtn = cell.rightButton;
        [cell.rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton setTitle:@" 是" forState:UIControlStateNormal];
        cell.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cell.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        return cell;
    }
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (kAppdelegate.haveLogin) {
            self.hidesBottomBarWhenPushed = YES;
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            SelectAddressViewController *addressVC = [[SelectAddressViewController alloc] init];
            addressVC.isCenterVC = NO;
            addressVC.block1 = ^(NSString* str) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                cell.textLabel.text = str;
                self.addressinfo = str;
            };
            addressVC.block2 = ^(NSString *str) {
                self.address = str;
                
            };
            addressVC.block3 = ^(NSString *str) {
                self.medicPhone = str;
            };
            addressVC.block4 =^(NSString *str) {
                self.medicName = str;
                
            };
            [self.navigationController pushViewController:addressVC animated:YES];
        } else {
            self.hidesBottomBarWhenPushed = YES;
            EditViewController *editVC = [[EditViewController alloc] init];
            [self.navigationController pushViewController:editVC animated:YES];
        }
        
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        if (kAppdelegate.haveLogin) {
            self.hidesBottomBarWhenPushed = YES;
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            SelectJiuzhenViewController *jiuzhenVC = [[SelectJiuzhenViewController alloc] init];
            jiuzhenVC.isCenterVC = NO;
            jiuzhenVC.block1 = ^(NSString *str) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                cell.textLabel.text = str;
                self.patienName = str;
                
            };
            jiuzhenVC.block2 = ^(NSString *str) {
                self.patientId = str;
            };
            jiuzhenVC.block3 = ^(NSString *str) {
                self.patientSex = str;
            };
            jiuzhenVC.block4 = ^(NSString *str) {
                
                self.patientBirthday = str;
            };
            jiuzhenVC.block5 = ^(NSString *str) {
                self.patientTel = str;
            };
            
            [self.navigationController pushViewController:jiuzhenVC animated:YES];
        } else {
            self.hidesBottomBarWhenPushed = YES;
            EditjiuzhenViewController *editVC  = [[EditjiuzhenViewController alloc] init];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:editVC animated:YES];
        }
        
    } else if (indexPath.section == 1 && indexPath.row ==2) {
        
    } else if (indexPath.section == 1 && indexPath.row == 3) {
       
        dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:24 * 3600]];
        [dateTimePickerView setMinYear:1890];
        [dateTimePickerView setMaxYear:2100];
        WK(weakSelf)
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            
            NSLog(@"%@",datetimeStr);
            
            
            NSDate *date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            //当前时间
            NSString *nowDateStr = [dateFormatter stringFromDate:date];
            date = [dateFormatter dateFromString:nowDateStr];
            NSDate *selectDate = [dateFormatter dateFromString:datetimeStr];
            NSLog(@"selectDate%@",selectDate);
            //取时间间隔
            NSTimeInterval time = [selectDate timeIntervalSinceDate:date];
            if (time >= 3600) {
                UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
                cell.textLabel.text = datetimeStr;
                _datetimeStr = datetimeStr;
            } else {
                [weakSelf.view showWarning:@"请选择大于当前时间一个小时!"];
                return;
            }
            
        };
        if (dateTimePickerView) {
            
            [self.view addSubview:dateTimePickerView];
            [dateTimePickerView showHcdDateTimePicker];
        }
    
    } else if (indexPath.section == 1 && indexPath.row == 4) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
        self.datetimeStr = cell.textLabel.text;
        NSLog(@"%@", self.datetimeStr);
        
        if (self.datetimeStr == nil) {
            [MBProgressHUD showToast:@"请选择就诊时间"];
        } else if ([self.datetimeStr isEqualToString:@"请选择时间"]) {
            [MBProgressHUD showToast:@"请选择就诊时间"];
        } else {
            self.hidesBottomBarWhenPushed = YES;
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            SelectdoctorViewController *doctorVC = [[SelectdoctorViewController alloc] init];
            doctorVC.datetimestr = self.datetimeStr;
            [self.navigationController pushViewController:doctorVC animated:YES];
            doctorVC.block1 = ^(NSString *str1) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
                cell.textLabel.text = str1;
                _nursrStr = str1;
                
            };
            doctorVC.block2 = ^(NSString *str2) {
                self.medicId = str2;
                
            };
            doctorVC.block3 = ^(NSString *str3) {
                //self.medicName = str3;
            };
            doctorVC.block4 = ^(NSString *str4) {
                //self.medicPhone = str4;
            };
            
            
        }
    }
}

#pragma mark method 

- (void)rankSelectClick:(HZIsClickBtn *)sender {
    
    HZRankKindCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    cell.oneBtn.isClick = NO;
    cell.twoBtn.isClick = NO;
    cell.threeBtn.isClick = NO;
    sender.isClick = YES;
    if (cell.oneBtn.isClick) {
        [cell.oneBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
    } else {
        [cell.oneBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
    }
    if (cell.twoBtn.isClick) {
        [cell.twoBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
    } else {
        [cell.twoBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
    }
    if (cell.threeBtn.isClick) {
        [cell.threeBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
    } else {
        [cell.threeBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
    }
    self.rankid = _subScribeVM.itemModel.itemList[sender.tag - 1234].ID;
    self.rankname = _subScribeVM.itemModel.itemList[sender.tag - 1234].name;
    
}

- (void)rankDeclareClick:(UIButton *)sender {
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    SelectRankViewController *rankVC = [[SelectRankViewController alloc] init];
    rankVC.rowID = self.subScribeVM.itemModel.list[0].itemId;
    rankVC.block1 = ^(NSString *str) {
        self.rankname = str;
        
    };
    rankVC.block2 = ^(NSString *str) {
        
        self.rankid = str;
        
    };
    rankVC.rowOfSelectBlock = ^(NSInteger row) {
        HZRankKindCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        
        if (row == 0) {
            [cell.oneBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
        } else {
            [cell.oneBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        }
        if (row == 1) {
            [cell.twoBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
        } else {
            [cell.twoBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        }
        if (row == 2) {
            [cell.threeBtn setImage:[UIImage imageNamed:@"icon_l_checked"] forState:UIControlStateNormal];
        } else {
            [cell.threeBtn setImage:[UIImage imageNamed:@"icon_l_uncheck"] forState:UIControlStateNormal];
        }
        self.rankid = _subScribeVM.itemModel.itemList[row].ID;
        self.rankname = _subScribeVM.itemModel.itemList[row].name;
    };
    [self.navigationController pushViewController:rankVC animated:YES];
}

- (void)careBagClick:(HZIsClickBtn *)sender {
    
    sender.isClick = !sender.isClick;
    if (sender.isClick) {
        [sender setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
    }

}
- (void)cartridgeBagClick:(HZIsClickBtn *)sender {
    sender.isClick = !sender.isClick;
    if (sender.isClick) {
        [sender setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
    }
    

}

- (void)wrongClick:(HZIsClickBtn *)sender {
    sender.isClick = !sender.isClick;
    if (sender.isClick) {
        self.rightBtn.isClick = NO;
        [sender setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        self.xiadanButton.backgroundColor = kGrayColor;
    } else {
        [self.rightBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        self.xiadanButton.backgroundColor = [UIColor blueColor];
    }
    
    
}
- (void)rightClick:(HZIsClickBtn *)sender {
    sender.isClick = !sender.isClick;
    if (sender.isClick) {
        self.wrongBtn.isClick = NO;
        [sender setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        [self.wrongBtn setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        self.xiadanButton.backgroundColor = [UIColor blueColor];
    } else {
        [self.wrongBtn setImage:[UIImage imageNamed:@"复选框选中"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        self.xiadanButton.backgroundColor = kGrayColor;
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return 0.1;
    }
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 130;
    }
    if (section == 3) {
        return 65;
    }
    return 0.1;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *view1 = [self creatFootView1];
        return view1;
    }
    if (section == 3) {
        UIView *view2 = [self creatFootView2];
        return view2;
    }
    
    return nil;
    
}
-(UIView*)creatFootView1 {
    UIView *view1 = [UIView new];
    _textView = [[JSTextView alloc] initWithFrame:CGRectMake(10, 10, KCWIDTH-20, 120)];
    [_textView.layer setCornerRadius:5];
    _textView.placeholder = @"需求描述";
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.placeholerColor = [UIColor lightGrayColor];
    [view1 addSubview:_textView];
    return view1;
}
-(void)textViewDidChange:(UITextView *)textView
{
    self.descrip = textView.text;
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}
- (void)leaveEditMode {
    
    [self.textView resignFirstResponder];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}


-(UIView*)creatFootView2 {
    UIView *view2 = [UIView new];
    UIButton *xiadanButton = [[UIButton alloc] initWithFrame:CGRectMake(KCWIDTH*0.3, 15, KCWIDTH-KCWIDTH*0.6, 40)];
    xiadanButton.backgroundColor = RGB(38, 107, 255);
    [xiadanButton setTitle:@"确定下单" forState:UIControlStateNormal];
    [xiadanButton addTarget:self action:@selector(xiadanbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    xiadanButton.layer.cornerRadius = 20;
    xiadanButton.layer.masksToBounds = YES;
    xiadanButton.backgroundColor = [UIColor blueColor];
    self.xiadanButton = xiadanButton;
    [view2 addSubview:xiadanButton];
    return view2;
}

- (void)xiadanbuttonClick:(UIButton *)sender {
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    self.datetimeStr = cell.textLabel.text;
    
    if (sender.selected) {
        [self.view showWarning:@"已下单成功,请去订单页面支付"];
        return;
    }
    
    if (!self.rightBtn.isClick) {
        [self.view showWarning:@"请同意免责条款!"];
        return;
    }
    
    if ([Utils isEmptyString:self.addressinfo]) {
        [MBProgressHUD showToast:@"请选择服务地址"];
        return;
    }
    if ([Utils isEmptyString:self.patienName]) {
        [MBProgressHUD showToast:@"请选择就诊人"];
        return;
    }
    if ([Utils isEmptyString:self.rankname]) {
        [MBProgressHUD showToast:@"请选择褥疮等级"];
        return;
    }
    if ([Utils isEmptyString:self.datetimeStr]) {
        
        [MBProgressHUD showToast:@"请选择时间"];
        return;
    } else if ([self.patienName isEqualToString:@"请选择时间"]) {
        
        [MBProgressHUD showToast:@"请选择时间"];
        return;
    }
    
    if ([Utils isEmptyString:self.nursrStr]) {
        [MBProgressHUD showToast:@"请选择医护人员"];
        return;
    }
    
    if (self.careBagBtn.isClick) {
        self.incrementOne = self.subScribeVM.itemModel.list[0].ID;
        self.incrementid = self.incrementOne;
    }
    if (self.cartridgeBagBtn.isClick) {
        self.incrementTwo = self.subScribeVM.itemModel.list[1].ID;
        self.incrementid = self.incrementTwo;
        
    }
    if (self.careBagBtn.isClick && self.cartridgeBagBtn.isClick ) {
        self.incrementid = [NSString stringWithFormat:@"%@,%@",self.incrementOne,self.incrementTwo];
       
    }
    
    
    
    if (!self.addressXY.length) {
        self.addressXY = @"";
    }
    if (!self.gpsaddress.length) {
        self.gpsaddress = @"";
    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/saveOrder",KCBaseURLString];
    NSDictionary *paramters = nil;
    if (self.textView.text.length > 0) {
        paramters = @{
                      
                      @"classifyId":self.rankid,
                      @"classifyName":self.rankname,
                      @"serviceId":self.incrementid,
                      @"itemId":self.recoverid,
                      @"itemName":self.recovername,
                      @"gpsaddress":self.gpsaddress,
                      @"address":self.address,
                      @"addressInfo":self.addressinfo,
                      @"addressXY":self.addressXY,
                      @"appointmentTime":self.datetimeStr,
                      @"personId":self.patientId,
                      @"personSex":self.patientSex,
                      @"personBirthday":self.patientBirthday,
                      @"personName":self.patienName,
                      @"personTel":self.patientTel,
                      @"name":self.medicName,
                      @"tel":self.medicPhone,
                      @"medicId":self.medicId,
                      @"description":self.textView.text
                      };

    } else {
        
        paramters = @{
                      @"classifyId":self.rankid,
                      @"classifyName":self.rankname,
                      @"serviceId":self.incrementid,
                      @"itemId":self.recoverid,
                      @"itemName":self.recovername,
                      @"gpsaddress":self.gpsaddress,
                      @"address":self.address,
                      @"addressInfo":self.addressinfo,
                      @"addressXY":self.addressXY,
                      @"appointmentTime":self.datetimeStr,
                      @"personId":self.patientId,
                      @"personSex":self.patientSex,
                      @"personBirthday":self.patientBirthday,
                      @"personName":self.patienName,
                      @"personTel":self.patientTel,
                      @"name":self.medicName,
                      @"tel":self.medicPhone,
                      @"medicId":self.medicId,
                      @"description":@""
                      };

    }
    
    
     NSData * jsonData = [NSJSONSerialization dataWithJSONObject:paramters options:0 error:nil];
     NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     NSDictionary *dict = @{@"data":myString};
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
     [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
        
         NSString *msg = [[responseObject objectForKey:@"MSG"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         [MBProgressHUD showToast:msg];
         
        NSString *str = [NSString stringWithString:[[responseObject objectForKey:@"CONTENT"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",str);
         
    
        
        self.hidesBottomBarWhenPushed = YES;
        ZhifuViewController *zhifuVC = [[ZhifuViewController alloc] init];
        zhifuVC.zhifuid = str;
        zhifuVC.block = ^ {
             
        };
        zhifuVC.gpsaddress = self.gpsaddress;
        zhifuVC.addressxy = self.addressXY;
             
             
        NSMutableArray *tmpArr = [NSMutableArray new];
        if (_careBagBtn.isClick) {
            NSMutableDictionary *careBagDic = [NSMutableDictionary new];
            [careBagDic setValue:self.subScribeVM.itemModel.list[0].desc forKey:@"desc"];
            [careBagDic setValue:self.subScribeVM.itemModel.list[0].price forKey:@"price"];
            [careBagDic setValue:self.subScribeVM.itemModel.list[0].file forKey:@"file"];
            [tmpArr addObject:careBagDic];
        } else {
            [tmpArr removeAllObjects];
        }
        if (_cartridgeBagBtn.isClick) {
            NSMutableDictionary *cartridgeBagDic = [NSMutableDictionary new];
            [cartridgeBagDic setValue:self.subScribeVM.itemModel.list[1].desc forKey:@"desc"];
            [cartridgeBagDic setValue:self.subScribeVM.itemModel.list[1].price forKey:@"price"];
            [cartridgeBagDic setValue:self.subScribeVM.itemModel.list[0].file forKey:@"file"];
            [tmpArr addObject:cartridgeBagDic];
        }
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setValue:self.subScribeVM.itemModel.name forKey:@"desc"];
        [dic setValue:self.subScribeVM.itemModel.servicePrice forKey:@"price"];
        [tmpArr addObject:dic];
        zhifuVC.projectArr = tmpArr.copy;
        [self.navigationController pushViewController:zhifuVC animated:YES];
         
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showToast:Net_Connection_Error];
    }];
    sender.selected = YES;
    
}
//点击了免责条款按钮
-(void)freeButton:sender
{
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    HuliFreeViewController *freeVC = [[HuliFreeViewController alloc] init];
    [self.navigationController pushViewController:freeVC animated:YES];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method for键盘
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    NSLog(@"height:%f", height);
    
    
    CGFloat offset = height - (kScreenH -(100 + 10 + 44 * 5 + 10 + 120));
    //    NSLog(@"%f",offset);
    if(offset > 0){
        
        [self moveUpKeyBoard:offset];
    }else{
        
        if(!(self.textView.superview==self.view)){
            
            CGFloat superOffset = height - (H(self.view)-(Y_H(self.textView.superview)));
            //            NSLog(@"%f",superOffset);
            if(superOffset>0){
                
                [self moveUpKeyBoard:superOffset];
            }
        }
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.view.frame.origin.y < 0) {
        [self moveDownKeyBoard];
    }
    
    
}

-(void)moveDownKeyBoard{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
- (void)moveUpKeyBoard:(CGFloat)offset{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}

#pragma  mark lazy
- (HZSubScribeViewModel *)subScribeVM {
    if (!_subScribeVM) {
        _subScribeVM = [HZSubScribeViewModel new];
    }
    return _subScribeVM;
}

@end
