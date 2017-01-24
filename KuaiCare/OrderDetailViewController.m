//
//  OrderDetailViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderPingjiaViewController.h"
#import "MyorderViewController.h"
#import "OrderFirstTableViewCell.h"
#import "OrderSecondTableViewCell.h"
#import "OrderThirdTableViewCell.h"
#import "OrderFourthTableViewCell.h"
#import "OrderFifthTableViewCell.h"
#import "OrderSixTableViewCell.h"
#import "TimeBasic.h"


#import "HZOrderDetailViewModel.h"

#import "HZOrderDetailPatientInfonCell.h"
#import "HZOrderDetailMedicInfoCell.h"
#import "HZOrderDetailProjectCell.h"
#import "HZOrderDetailPayMoneyCell.h"

#import "HZOrderListOperationNetManager.h"

#import "CancelWeiJiedanViewController.h"
#import "ZhifuViewController.h"

#import "HZPatientCommentCell.h"
#import "HZTotalSimpleCell.h"
#import "HZSwitchCell.h"
#import "HZPayKindCell.h"


@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIView *topView;

@property(nonatomic) UIView *orderInfoOfHeadView;
@property(nonatomic) UIButton *orderInfoBtn;
@property(nonatomic) UIButton *contactBtn;


@property(nonatomic) UIView *operationView;
@property(nonatomic) UIButton *leftBtn;
@property(nonatomic) UIButton *rightBtn;

@property(nonatomic) BOOL selectRow;
@property(nonatomic) BOOL isUseIntegral;

@property(nonatomic) CGFloat payMoney;


@property(nonatomic) HZOrderDetailViewModel *orderDetailVM;


@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"订单详情";
    self.selectRow = 1;
    
    [self leftBtn];
    [self tableView];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
    _tableView.tableHeaderView = headView;
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self.orderDetailVM getOrderInfoWithOrderId:self.orderId refundMode:self.refundMode completionHandler:^(NSError *error) {
            if (!error) {
    
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
                    
                    _leftBtn.hidden = NO;
                    _rightBtn.hidden = NO;
                    [_leftBtn setTitle:@"取消订单"  forState:UIControlStateNormal];
                    [_rightBtn setTitle:@"确认支付" forState:UIControlStateNormal];
                    
                }
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 2) {
                    _leftBtn.hidden = YES;
                    _rightBtn.hidden = NO;
                    [_rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    
                }
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 3) {
                    
                    _leftBtn.hidden = NO;
                    _rightBtn.hidden = NO;
                    [_leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_rightBtn setTitle:@"联系医护" forState:UIControlStateNormal];
                    
                }
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 4) {
                    _leftBtn.hidden = YES;
                    _rightBtn.hidden = NO;
                    [_rightBtn setTitle:@"联系医护" forState:UIControlStateNormal];
                }
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 5) {
                    
                    _leftBtn.hidden = NO;
                    _rightBtn.hidden = NO;
                    [_leftBtn setTitle:@"确认服务" forState:UIControlStateNormal];
                    [_rightBtn setTitle:@"联系医护" forState:UIControlStateNormal];
                }
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 6) {
                    
                    _leftBtn.hidden = NO;
                    _rightBtn.hidden = NO;
                    if (_orderDetailVM.orderDetailModel.isEvaluate.integerValue) {
                        [_leftBtn setTitle:@"查看评价" forState:UIControlStateNormal];
                    } else {
                       [_leftBtn setTitle:@"评价医护" forState:UIControlStateNormal];
                    }
                    
                    [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 7) {
                    
                    _leftBtn.hidden = YES;
                    _rightBtn.hidden = NO;
                    [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 8) {
                    
                    _leftBtn.hidden = YES;
                    _rightBtn.hidden = NO;
                    [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                [_tableView reloadData];
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
            [_tableView.mj_header endRefreshing];
        }];
        
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
        return 6;
    }
    if (self.orderDetailVM.orderDetailModel.evaluateTime.length && self.orderDetailVM.orderDetailModel.evaluateTime != nil) {
        if (self.orderDetailVM.orderDetailModel.isEvaluate.boolValue) {
            return 6;
        }
    }
    
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.orderDetailVM.numberOfProject;
    }
    if (section == 3) {
        if (self.orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
            return 3;
        } else {
            return 2;
        }
    }
    if (section == 4) {
        return self.orderDetailVM.orderInfoArr.count;
    }
    if (section == 5) {
        if (self.orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
            return 2;
        } else {
            return 1;
        }
    }
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HZOrderDetailPatientInfonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZOrderDetailPatientInfonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contactLb.text = [NSString stringWithFormat:@"联系人: %@(%@)", _orderDetailVM.orderDetailModel.name, [_orderDetailVM getTel]];
        cell.addressLb.text = [NSString stringWithFormat:@"地址: %@", _orderDetailVM.orderDetailModel.addressInfo];
        cell.patientInfoLb.text = [NSString stringWithFormat:@"就诊人: %@  %@  %ld岁", _orderDetailVM.orderDetailModel.personName, _orderDetailVM.orderDetailModel.personSex, _orderDetailVM.orderDetailModel.personAge];
        
        return cell;
        
    }
    if (indexPath.section == 1) {
        HZOrderDetailMedicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZOrderDetailMedicInfoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *medicStr = [NSString stringWithFormat:@"医护: %@ (%@)", _orderDetailVM.orderDetailModel.medicName, _orderDetailVM.orderDetailModel.medicHospital];
        NSMutableAttributedString *medicAttributedStr = [[NSMutableAttributedString alloc] initWithString:medicStr];
        if (_orderDetailVM.orderDetailModel.medicName.length) {
            
            //设置字体和设置字体的范围
            [medicAttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(_orderDetailVM.orderDetailModel.medicName.length + 5, _orderDetailVM.orderDetailModel.medicHospital.length + 2)];
            //添加文字颜色
            [medicAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(_orderDetailVM.orderDetailModel.medicName.length + 5, _orderDetailVM.orderDetailModel.medicHospital.length + 2)];
            
            cell.medicNameLb.attributedText = medicAttributedStr;
        }
        
        
        cell.medicAddressLb.text = [NSString stringWithFormat:@"地址: %@", _orderDetailVM.orderDetailModel.medicAddress];
        cell.appointmentTimeLb.text = [NSString stringWithFormat:@"预约上门时间: %@", _orderDetailVM.orderDetailModel.appointmentTime];
        [cell.headImg sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, _orderDetailVM.orderDetailModel.head].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
        
        [cell.phoneBtn addTarget:self action:@selector(makeCallClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    if (indexPath.section == 2) {
        HZOrderDetailProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZOrderDetailProjectCell" forIndexPath:indexPath];
        cell.backgroundColor = kLightGrayColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.fileImg sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [_orderDetailVM getProjectFileWithIndex:indexPath.row]].tzl_URL];
        cell.nameLb.text = [_orderDetailVM getProjectNameWithIndex:indexPath.row];
        cell.priceLb.text = [_orderDetailVM getProjectPriceWithIndex:indexPath.row];
        cell.numberLb.text = [NSString stringWithFormat:@"x%@", [_orderDetailVM getProjectQuantityWithIndex:indexPath.row]];
        cell.totalPriceLb.text = [NSString stringWithFormat:@"¥%@", [_orderDetailVM getProjectPriceTotalWithIndex:indexPath.row]];
        
        return cell;
        
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            HZTotalSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZTotalSimpleCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *totalStr = [NSString stringWithFormat:@"合计: ¥%@", _orderDetailVM.orderDetailModel.orderMoney];
            
            NSMutableAttributedString *totalAttributeStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
            //添加文字颜色
            [totalAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(4, totalStr.length - 4)];
            cell.totalLb.attributedText = totalAttributeStr;
            return cell;
        }
        if (indexPath.row == 1) {
            if (self.orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
                HZSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZSwitchCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.integralSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
                
                NSString *interReserve = [NSString stringWithFormat:@"%.f", _orderDetailVM.orderDetailModel.integralReserve];
                NSString *integralConversion = [NSString stringWithFormat:@"%.2f", _orderDetailVM.orderDetailModel.integralReserve / _orderDetailVM.orderDetailModel.integralConversion];
                
                NSString *string1 = [NSString stringWithFormat:@"可用%.f积分抵%.2f元",_orderDetailVM.orderDetailModel.integralReserve,_orderDetailVM.orderDetailModel.integralReserve / _orderDetailVM.orderDetailModel.integralConversion];
                NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:string1];
                [AttributedStr1 addAttribute:NSFontAttributeName
                                       value:[UIFont systemFontOfSize:14.0]
                                       range:NSMakeRange(2,interReserve.length)];
                [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor colorWithRed:0/255.0 green:178/255.0 blue:149/255.0 alpha:1.0]
                                       range:NSMakeRange(2,interReserve.length)];
                
                
                [AttributedStr1 addAttribute:NSFontAttributeName
                                       value:[UIFont systemFontOfSize:14.0]
                                       range:NSMakeRange(5+interReserve.length,integralConversion.length)];
                [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor colorWithRed:255/255.0 green:182/255.0 blue:73/255.0 alpha:1.0]
                                       range:NSMakeRange(5+interReserve.length,integralConversion.length)];
                cell.integralLb.attributedText = AttributedStr1;
                
                return cell;
            } else {
                HZOrderDetailPayMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZOrderDetailPayMoneyCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                CGFloat integralNumber = _orderDetailVM.orderDetailModel.orderMoney.floatValue - _orderDetailVM.orderDetailModel.payMoney.floatValue;
                cell.integralNumberLb.text = [NSString stringWithFormat:@"¥%.2f",integralNumber];
                cell.payNumberLb.text = [NSString stringWithFormat:@"¥%@", _orderDetailVM.orderDetailModel.payMoney];
                return cell;
            }
        }
        HZOrderDetailPayMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZOrderDetailPayMoneyCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.integralNumberLb.text = [NSString stringWithFormat:@"¥0.00"];
        cell.payNumberLb.text = [NSString stringWithFormat:@"¥%@", _orderDetailVM.orderDetailModel.orderMoney];
        return cell;
        
    }
    
    if (indexPath.section == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = kGrayColor;
        if (self.orderDetailVM.orderInfoArr.count) {
            NSLog(@"%@", self.orderDetailVM.orderInfoArr[indexPath.row]);
            
            cell.textLabel.text = self.orderDetailVM.orderInfoArr[indexPath.row];
        }
        return cell;
    }
    
    if (indexPath.section == 5) {
        if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
            HZPayKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZPayKindCell" forIndexPath:indexPath];
            if (indexPath.row == 0) {
                if (self.selectRow == 0) {
                    cell.kingImg.image = [UIImage imageNamed:@"icon_l_checked"];
                } else {
                    cell.kingImg.image = [UIImage imageNamed:@"icon_l_uncheck"];
                }
                cell.alipayImg.image = [UIImage imageNamed:@"icon_l_zfbzf"];
                cell.alipayLb.text = @"支付宝";
                cell.balanceLb.hidden = YES;
            } else {
                if (self.selectRow) {
                    cell.kingImg.image = [UIImage imageNamed:@"icon_l_checked"];
                } else {
                    cell.kingImg.image = [UIImage imageNamed:@"icon_l_uncheck"];
                }
                cell.alipayImg.image = [UIImage imageNamed:@"icon_l_xjtc"];
                cell.alipayLb.text = @"余额支付";
                cell.balanceLb.hidden = NO;
                cell.balanceLb.text = _orderDetailVM.orderDetailModel.cashReserve;
            }
            return cell;
        } else {
            HZPatientCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZPatientCommentCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.headImg sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, _orderDetailVM.orderDetailModel.head].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
            if (self.orderDetailVM.orderDetailModel.medicName.length) {
                cell.phoneLb.text = self.orderDetailVM.orderDetailModel.medicName;
            } else {
                cell.phoneLb.text = self.orderDetailVM.orderDetailModel.medicPhone;
            }
            cell.timeLb.text = self.orderDetailVM.orderDetailModel.evaluateTime;
            cell.itemLbAndGradeLb.text = @"打分";
            cell.starRatingView.value = self.orderDetailVM.orderDetailModel.synthesizeScore.floatValue;
            cell.commentLb.text = self.orderDetailVM.orderDetailModel.evaluateReason;
            return cell;
        }
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        [self orderInfoBtn];
        [self contactBtn];
        return self.orderInfoOfHeadView;
    }
    
    if (section == 5) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
        headView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [UIView new];
        [headView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.5);
        }];
        lineView.backgroundColor = kGrayColor;
        
        UILabel *titleLb = [UILabel new];
        [headView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(10);
        }];
        titleLb.font = [UIFont systemFontOfSize:14];
        if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
            titleLb.text = @"支付方式";
        } else {
            titleLb.text = @"医护评价";
        }
        return headView;
        
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 5) {
        self.selectRow = indexPath.row;
        [_tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        return 40;
    }
    if (section == 5) {
        return 34;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 3 || section == 4) {
        return 12;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 72;
    } else if (indexPath.section == 1) {
        return 78;
    } else if (indexPath.section == 2) {
        return 60;
        
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 40;
        }
        if (indexPath.row == 1) {
            if (self.orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
                return 44;
            }
            return 60;
        }
        return 60;
    }
    
    if (indexPath.section == 5) {
        if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
            return 50;
        }
        return [tableView fd_heightForCellWithIdentifier:@"HZPatientCommentCell" configuration:^(HZPatientCommentCell *cell) {
            [cell.headImg sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, _orderDetailVM.orderDetailModel.head].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
            if (self.orderDetailVM.orderDetailModel.medicName.length) {
                cell.phoneLb.text = self.orderDetailVM.orderDetailModel.medicName;
            } else {
                cell.phoneLb.text = self.orderDetailVM.orderDetailModel.medicPhone;
            }
            cell.timeLb.text = self.orderDetailVM.orderDetailModel.evaluateTime;
            cell.itemLbAndGradeLb.text = @"打分";
            cell.starRatingView.value = self.orderDetailVM.orderDetailModel.synthesizeScore.floatValue;
            cell.commentLb.text = self.orderDetailVM.orderDetailModel.evaluateReason;
        }];
    }
    
    return 24;
}

- (void)pingjiaButtonClick {
    self.hidesBottomBarWhenPushed = YES;
    OrderPingjiaViewController *pingjiaVC = [[OrderPingjiaViewController alloc] init];
    [self.navigationController pushViewController:pingjiaVC animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method  

- (void)switchClick:(UISwitch *)sender {
    self.isUseIntegral = sender.on;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:3];
    HZOrderDetailPayMoneyCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat payMoney = _orderDetailVM.orderDetailModel.orderMoney.floatValue - _orderDetailVM.orderDetailModel.integralReserve / _orderDetailVM.orderDetailModel.integralConversion;
    
    if (sender.on) {
        
        if (_orderDetailVM.orderDetailModel.integralReserve / _orderDetailVM.orderDetailModel.integralConversion <= _orderDetailVM.orderDetailModel.orderMoney.floatValue) {
            cell.integralNumberLb.text = [NSString stringWithFormat:@"¥%.2f", _orderDetailVM.orderDetailModel.integralReserve / _orderDetailVM.orderDetailModel.integralConversion];
        } else {
            cell.integralNumberLb.text = [NSString stringWithFormat:@"¥%@", _orderDetailVM.orderDetailModel.orderMoney];
        }
        
        if (payMoney > 0) {
            cell.payNumberLb.text = [NSString stringWithFormat:@"¥%.2f", payMoney];
        } else {
            cell.payNumberLb.text = [NSString stringWithFormat:@"¥0.00"];
        }
        
    } else {
        cell.integralNumberLb.text = [NSString stringWithFormat:@"¥0.00"];
        cell.payNumberLb.text = [NSString stringWithFormat:@"¥%@", _orderDetailVM.orderDetailModel.orderMoney];
    }
    
}

- (void)leftClick:(UIButton *)sender {
    self.block();
    NSString *orderId = _orderDetailVM.orderDetailModel.orderId;
    if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 1 || _orderDetailVM.orderDetailModel.orderStatus.integerValue == 3) {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请确认是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            CancelWeiJiedanViewController *cancelVC = [CancelWeiJiedanViewController new];
            cancelVC.rowid = orderId;
            cancelVC.block = ^ {
                [_tableView.mj_header beginRefreshing];
            };
            self.hidesBottomBarWhenPushed = YES;
            //返回去除文字
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            
            [self.navigationController pushViewController:cancelVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    } if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 5) {//确认服务
        
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"是否确认服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.view showBusyHUD];
            [HZOrderListOperationNetManager confirmServiceWithOrderId:orderId address:self.gpsaddress addressXY:self.addressXY completionHandler:^(id model, NSError *error) {
                if (!error) {
                    
                    //想想: 完成服务需要将state改为6, 同时改变按钮
                    _orderDetailVM.orderDetailModel.orderStatus = @"6";
                    _leftBtn.hidden = NO;
                    _rightBtn.hidden = NO;
                    [_leftBtn setTitle:@"评价医护" forState:UIControlStateNormal];
                    [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                    [self.view showWarning:@"确认服务成功"];
                     [_tableView.mj_header beginRefreshing];
                    
                }
            }];
            
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    } if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 6) {//服务评价
        
        OrderPingjiaViewController *evaluateVC = [OrderPingjiaViewController new];
        evaluateVC.isEvaluate = _orderDetailVM.orderDetailModel.isEvaluate;
        evaluateVC.orderId = orderId;
        evaluateVC.block = ^ {
            [_tableView.mj_header beginRefreshing];
        };
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:evaluateVC animated:YES];
        self.hidesBottomBarWhenPushed = YES;
        
        return;
        
    }
    
}
- (void)rightClick:(UIButton *)sender {
    self.block();
    NSString *orderId = _orderDetailVM.orderDetailModel.orderId;
    
    if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 1) {
        
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请确认是否支付" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认支付" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self payEvent];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
        
    } else if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 6 || _orderDetailVM.orderDetailModel.orderStatus.integerValue == 7 || _orderDetailVM.orderDetailModel.orderStatus.integerValue == 8) {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderListOperationNetManager deleteOrderWithOrderId:orderId completionHandler:^(id model, NSError *error) {
                if (!error) {
                    self.block();
                    [self.navigationController popViewControllerAnimated:YES];
                    [kAppdelegate.window showWarning:[model objectForKey:@"MSG"]];
                }
                
                
            }];
            
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
        
        
    } else if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 2) {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"温馨提示" message:@"请确认是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            CancelWeiJiedanViewController *cancelVC = [CancelWeiJiedanViewController new];
            cancelVC.rowid = orderId;
            cancelVC.block = ^ {
                [_tableView.mj_header beginRefreshing];
            };
            self.hidesBottomBarWhenPushed = YES;
            //返回去除文字
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            
            [self.navigationController pushViewController:cancelVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    } else if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 3 || _orderDetailVM.orderDetailModel.orderStatus.integerValue == 4 || _orderDetailVM.orderDetailModel.orderStatus.integerValue == 5) {
        
        NSInteger tel =  _orderDetailVM.orderDetailModel.medicPhone.integerValue;
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打号码: %ld", tel] preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld", tel]]];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:callAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
        
    } else if (_orderDetailVM.orderDetailModel.orderStatus.integerValue == 6) {
        
        
    }
    
    
}

- (void)makeCallClick:(UIButton *)sender {
    //号码有待修改
    NSInteger tel =  _orderDetailVM.orderDetailModel.medicPhone.integerValue;
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打号码: %ld", tel] preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld", tel]]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:callAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    return;
}

- (void)payEvent {
    //支付宝支付
    if (self.selectRow == NO) {
        NSString *appID = kAlipayAppID;
        NSString *privateKey = kAlipayPrivateKey;
        if ([appID length] == 0 || [privateKey length] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少appId或者私钥。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        Order* order = [Order new];
        
        // NOTE: app_id设置
        order.app_id = appID;
        
        // NOTE: 支付接口名称
        order.method = @"alipay.trade.app.pay";
        
        // NOTE: 参数编码格式
        order.charset = @"utf-8";
        
        // NOTE: 当前时间点
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        order.timestamp = [formatter stringFromDate:[NSDate date]];
        
        // NOTE: 支付版本
        order.version = @"1.0";
        
        // NOTE: sign_type设置
        order.sign_type = @"RSA";
        
        // NOTE: 商品数据
        order.biz_content = [BizContent new];
        order.biz_content.body = @"订单支付";
        order.biz_content.subject = @"订单支付";
        
        
        NSString *zhifucode = _orderDetailVM.orderDetailModel.orderCode;
        order.biz_content.out_trade_no = zhifucode; //订单ID（由商家自行制定）
        
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", _orderDetailVM.orderDetailModel.orderMoney.floatValue]; //商品价格
        
        //将商品信息拼接成字符串
        NSString *orderInfo = [order orderInfoEncoded:NO];
        NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
        NSLog(@"orderSpec = %@",orderInfo);
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderInfo];
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"kuaihuli";
            
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                     orderInfoEncoded, signedString];
            
            
            kAppdelegate.alipayType = TZLAlipayTypeOrderMode;
            
            NSDictionary *dict = @{@"orderId":self.orderDetailVM.orderDetailModel.orderId,@"address":@"",@"addressXY":@"",@"isUseIntegral":[NSString stringWithFormat:@"%d", self.isUseIntegral]};
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
            NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *paramters = @{@"data":myString};
            kAppdelegate.orderDic = paramters;
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"aaffaf %@",resultDic);
                
                int status = [[resultDic objectForKey:@"resultStatus"] intValue];
                NSLog(@"dafaf%d",status);
                
                if (status == 9000) {
                    NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/aliPay",KCBaseURLString];
                    NSDictionary *dict = @{@"orderId":self.orderDetailVM.orderDetailModel.orderId,@"address":@"",@"addressXY":@"",@"isUseIntegral":[NSString stringWithFormat:@"%d", self.isUseIntegral]};
                    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
                    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    // NSString *string = [NSString stringWithFormat:@"%@", paramters];
                    NSDictionary *paramters = @{@"data":myString};
                    
                    AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
                    [mannager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSLog(@"%@",responseObject);
                        
                        NSString *string = [[responseObject objectForKey:@"MSG"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSLog(@"gggg%@",string);
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                    }];
                }
            }];
        }
    }
    //余额支付
    if (self.selectRow) {
        
            
            NSString *url = [NSString stringWithFormat:@"%@/app/patient/order/balancePay",KCBaseURLString];
            NSDictionary *dict = @{@"orderId":self.orderDetailVM.orderDetailModel.orderId,@"address":@"",@"addressXY":@"",@"isUseIntegral":[NSString stringWithFormat:@"%d", self.isUseIntegral]};
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
            NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            // NSString *string = [NSString stringWithFormat:@"%@", paramters];
            NSDictionary *paramters = @{@"data":myString};
            
            AFHTTPSessionManager *mannager = [AFHTTPSessionManager manager];
            [mannager POST:url parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                NSString *string = [[responseObject objectForKey:@"MSG"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.view showWarning:string];
                if ([[responseObject objectForKey:@"STATE"] integerValue] == 1) {
                    
                    [_tableView.mj_header beginRefreshing];
                    
                }
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];

        
    }
}

#pragma  mark lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.bottom.equalTo(-40);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[HZOrderDetailPatientInfonCell class] forCellReuseIdentifier:@"HZOrderDetailPatientInfonCell"];
        [_tableView registerClass:[HZOrderDetailMedicInfoCell class] forCellReuseIdentifier:@"HZOrderDetailMedicInfoCell"];
        [_tableView registerClass:[HZOrderDetailProjectCell class] forCellReuseIdentifier:@"HZOrderDetailProjectCell"];
        [_tableView registerClass:[HZOrderDetailPayMoneyCell class] forCellReuseIdentifier:@"HZOrderDetailPayMoneyCell"];
        [_tableView registerClass:[HZPatientCommentCell class] forCellReuseIdentifier:@"HZPatientCommentCell"];
        [_tableView registerClass:[HZTotalSimpleCell class] forCellReuseIdentifier:@"HZTotalSimpleCell"];
        [_tableView registerClass:[HZSwitchCell class] forCellReuseIdentifier:@"HZSwitchCell"];
        [_tableView registerClass:[HZPayKindCell class] forCellReuseIdentifier:@"HZPayKindCell"];
    }
    return _tableView;
}

- (UIView *)orderInfoOfHeadView {
    if (!_orderInfoOfHeadView) {
        _orderInfoOfHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
        _orderInfoOfHeadView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [UIView new];
        [_orderInfoOfHeadView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(0);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = kLightGrayColor;
        
    }
    return _orderInfoOfHeadView;
}
- (UIButton *)orderInfoBtn {
    if (!_orderInfoBtn) {
        _orderInfoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.orderInfoOfHeadView addSubview:_orderInfoBtn];
        [_orderInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(12);
            make.centerY.equalTo(0);
        }];
        [_orderInfoBtn setTitle:@" 订单信息" forState:UIControlStateNormal];
        [_orderInfoBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
        [_orderInfoBtn setImage:[UIImage imageNamed:@"icon_m_dd_unselect-1"] forState:UIControlStateNormal];
    }
    return _orderInfoBtn;
}

- (UIButton *)contactBtn {
    if (!_contactBtn) {
        _contactBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.orderInfoOfHeadView addSubview:_contactBtn];
        [_contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-12);
            make.centerY.equalTo(0);
        }];
        [_contactBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [_contactBtn addTarget:self action:@selector(makeCallClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBtn;
}


- (UIView *)operationView {
    if (!_operationView) {
        _operationView = [UIView new];
        [self.view addSubview:_operationView];
        [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(40);
        }];
        _operationView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [UIView new];
        [_operationView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.height.equalTo(0.5);
        }];
        lineView.backgroundColor = kLightGrayColor;
        
        
    }
    return _operationView;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.operationView addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-8);
        }];
//        [_rightBtn setTitle:@"确认服务" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightBtn.layer.borderColor = kBlueColor.CGColor;
        _rightBtn.layer.borderWidth = 1;
        _rightBtn.layer.cornerRadius = 5;
        _rightBtn.clipsToBounds = YES;
        _rightBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [_rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
    }
    
    

    
    
    
    
    return _rightBtn;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.operationView addSubview:_leftBtn];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(self.rightBtn.mas_left).equalTo(-20);
        }];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
        _leftBtn.layer.borderColor = kGrayColor.CGColor;
        _leftBtn.layer.borderWidth = 1;
        _leftBtn.layer.cornerRadius = 5;
        _leftBtn.clipsToBounds = YES;
        _leftBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [_leftBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    return _leftBtn;
}

- (HZOrderDetailViewModel *)orderDetailVM {
    if (!_orderDetailVM) {
        _orderDetailVM = [HZOrderDetailViewModel new];
    }
    return _orderDetailVM;
}

@end
