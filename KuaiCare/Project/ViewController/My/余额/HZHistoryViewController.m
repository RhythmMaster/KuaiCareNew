//
//  HZHistoryViewController.m
//  KuaiCare
//
//  Created by tang on 17/1/4.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZHistoryViewController.h"

#import "HZStateOfWithDrawCell.h"
#import "HZTimeOfWithDrawCell.h"
#import "HZWaitOfWithDrawCell.h"

#import "HZWithdrawDepositListViewModel.h"

#import "HZWithDrawDatailsViewController.h"

@interface HZHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UITableView *tableView;

@property(nonatomic) UIView *residualAmountView;
@property(nonatomic) UILabel *residualAmountLb;


@property(nonatomic) HZWithdrawDepositListViewModel *withdrawDepositListVM;



@end

@implementation HZHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"余额提现记录";
    self.view.backgroundColor = kRGBA(235, 234, 241, 1.0);
    
    [self tableView];
    [self residualAmountLb];
    
    
    [self.withdrawDepositListVM getWithdrawDepositListWithCompletionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            [self.tableView reloadData];
        }
        
    }];
    
    
    
    
    //线左靠边
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.withdrawDepositListVM.rowOfNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.withdrawDepositListVM getDepositStatusWithIndex:section] == 0) {
        return 3;
    } else {
        return 2;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HZStateOfWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StateOfWithDrawCell" forIndexPath:indexPath];
        cell.accountNumberLb.text = [self.withdrawDepositListVM getDepositMoneyWithIndex:indexPath.section];
        if ([self.withdrawDepositListVM getDepositStatusWithIndex:indexPath.section] == 0) {
            cell.stateLb.hidden = YES;
            cell.stateImg.hidden = NO;
        } else {
            cell.stateLb.hidden = NO;
            cell.stateImg.hidden = YES;
            
            if ([self.withdrawDepositListVM getDepositStatusWithIndex:indexPath.section] == 1) {
                cell.stateLb.text = @"已到账";
            } else {
                cell.stateLb.text = @"提现失败";
            }
        }
        
        return cell;
    }
    if (indexPath.row == 1) {
        if ([self.withdrawDepositListVM getDepositStatusWithIndex:indexPath.section] == 0) {
            HZTimeOfWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZTimeOfWithDrawCell" forIndexPath:indexPath];
            
            cell.startTimeNumberLb.text = [self.withdrawDepositListVM getDepositTimeWithIndex:indexPath.section];
            cell.downTimeNumberLb.text = [self.withdrawDepositListVM getWithdrawDepositTimeWithIndex:indexPath.section];
            
            return cell;
            
        } else {
            HZWaitOfWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZWaitOfWithDrawCell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.waitLb.hidden = YES;
            cell.timeLb.hidden = NO;
            cell.timeNumberLb.hidden = NO;
            return cell;
        }
        
    }
    if (indexPath.row == 2) {
        HZWaitOfWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZWaitOfWithDrawCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.waitLb.hidden = NO;
        cell.timeLb.hidden = YES;
        cell.timeNumberLb.hidden = YES;
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 70;
    }
    return 40;
}

//让线左靠边
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        HZWithDrawDatailsViewController *withDrawDetailsVC = [HZWithDrawDatailsViewController new];
        
        withDrawDetailsVC.alipay = [self.withdrawDepositListVM getAlipayWithIndex:indexPath.section];
        withDrawDetailsVC.depositMoney = [self.withdrawDepositListVM getDepositMoneyWithIndex:indexPath.section];
        withDrawDetailsVC.depositStatus = [self.withdrawDepositListVM getDepositStatusWithIndex:indexPath.section];
        withDrawDetailsVC.depositTime = [self.withdrawDepositListVM getWithdrawDepositTimeWithIndex:indexPath.section];
        withDrawDetailsVC.billTime = [self.withdrawDepositListVM getBillTimeWithIndex:indexPath.section];
        NSLog(@"1111%@", [self.withdrawDepositListVM getBillTimeWithIndex:indexPath.section]);
        
        withDrawDetailsVC.payTime = [self.withdrawDepositListVM getPayTimeWithIndex:indexPath.section];
        withDrawDetailsVC.withdrawDepositTime = [self.withdrawDepositListVM getWithdrawDepositTimeWithIndex:indexPath.section];
        
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:withDrawDetailsVC animated:YES];
    }
    
    
}

#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(6);
            make.right.equalTo(-6);
            make.bottom.equalTo(-50);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[HZStateOfWithDrawCell class] forCellReuseIdentifier:@"StateOfWithDrawCell"];
        [_tableView registerClass:[HZTimeOfWithDrawCell class] forCellReuseIdentifier:@"HZTimeOfWithDrawCell"];
        [_tableView registerClass:[HZWaitOfWithDrawCell class] forCellReuseIdentifier:@"HZWaitOfWithDrawCell"];
    }
    return _tableView;
}

- (UIView *)residualAmountView {
    if (!_residualAmountView) {
        _residualAmountView = [UIView new];
        [self.view addSubview:_residualAmountView];
        [_residualAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(50);
        }];
        _residualAmountView.backgroundColor = kRGBA(239, 241, 245, 1.0);
    }
    return _residualAmountView;
}
- (UILabel *)residualAmountLb {
    if (!_residualAmountLb) {
        _residualAmountLb = [UILabel new];
        [self.residualAmountView addSubview:_residualAmountLb];
        [_residualAmountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _residualAmountLb.text = @"剩余免费提现额度998.00";
        _residualAmountLb.textColor = kGrayColor;
    }
    return _residualAmountLb;
}


- (HZWithdrawDepositListViewModel *)withdrawDepositListVM {
    if (!_withdrawDepositListVM) {
        _withdrawDepositListVM = [HZWithdrawDepositListViewModel new];
    }
    return _withdrawDepositListVM;
}


@end
