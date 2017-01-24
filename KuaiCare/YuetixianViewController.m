//
//  YuetixianViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/2.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YuetixianViewController.h"

#import "HZMyMyCashchangeNM.h"

#import "HZHistoryViewController.h"

@interface YuetixianViewController ()<UITextFieldDelegate>


@property(nonatomic) UIView *backView;


@property(nonatomic) UIView *zhifuView;

@property(nonatomic) UILabel *zhifuNameLb;

@property(nonatomic) UIButton *accountBtn;

@property(nonatomic) UILabel *realName;

@property(nonatomic) UIButton *nameBtn;




@property(nonatomic) UIView *WithdrawView;

@property(nonatomic) UILabel *moneyLb;

@property(nonatomic) UITextField *numberTF;



@property(nonatomic) UIView *balanceView;

@property(nonatomic) UILabel *balanceLb;

@property(nonatomic) UIButton *withdrawBtn;

@property(nonatomic) UILabel *timeLB;

@property(nonatomic) UIButton *sureBtn;

@property(nonatomic) NSString *withdrawDepositCase;


@end

@implementation YuetixianViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kRGBA(242, 242, 242, 1.0);
    self.title = @"余额提现";
    
    
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [historyBtn setTitle:@"历史记录" forState:UIControlStateNormal];
    [historyBtn addTarget:self action:@selector(historyClick:) forControlEvents:UIControlEventTouchUpInside];
    historyBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    historyBtn.frame = CGRectMake(0, 0, 80, 24);
    UIBarButtonItem *historyBarBtn = [[UIBarButtonItem alloc] initWithCustomView:historyBtn];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBtn.width = -12;
    self.navigationItem.rightBarButtonItems = @[spaceBtn, historyBarBtn];
    
    
    [self nameBtn];
    [self numberTF];
    [self withdrawBtn];
    [self balanceLb];
    [self sureBtn];
    
    
    
    
    [HZMyMyCashchangeNM getWaitWithdrawDepositWithCompletionHandler:^(HZWaitWithdrawModel *model, NSError *error) {
        
        NSLog(@"%@", model.msg);
        NSLog(@"%@, %ld", model.name, model.aliapy);
        [_nameBtn setTitle:model.name forState:UIControlStateNormal];
        [_accountBtn setTitle:[NSString stringWithFormat:@"%ld", model.aliapy] forState:UIControlStateNormal];
        _balanceLb.text = [NSString stringWithFormat:@"零钱余额¥%@,可提现余额¥%@", model.cashReserve, model.withdrawDepositCase];
        self.withdrawDepositCase = model.withdrawDepositCase;
        
    }];

}

#pragma mark method 跳转
- (void)historyClick:(UIButton *)sender {
    NSLog(@"历史记录");
    HZHistoryViewController *historyVC = [HZHistoryViewController new];
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:historyVC animated:YES];
}

#pragma mark method 提现
- (void)withdrawClick:(UIButton *)sender {
    NSLog(@"提现");
    if (_numberTF.text.length == 0) {
        [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
        [SVProgressHUD showInfoWithStatus:@"请输入金额!"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    } else {
        //[self.view showBusyHUD];
        [HZMyMyCashchangeNM getWithdrawDepositWithDepositMoney:self.numberTF.text withdrawDepositCase:_withdrawDepositCase completionHandler:^(id model, NSError *error) {
            [kAppdelegate.window showWarning:[NSString stringWithFormat:@"提现%@", [model objectForKey:@"MSG"]]];
            if ([model objectForKey:@"STATE"]) {
                HZHistoryViewController *historyVC = [HZHistoryViewController new];
                self.hidesBottomBarWhenPushed = YES;
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
                self.navigationItem.backBarButtonItem = backItem;
                [self.navigationController pushViewController:historyVC animated:YES];
            } else {
                return;
            }
            
        }];
    }
    
}

#pragma mark delete
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_numberTF resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) textFieldDidChange:(UITextField *) TextField {
    
    if (TextField.text.length) {
        self.sureBtn.backgroundColor = kBlueColor;
    } else {
        _sureBtn.backgroundColor = kRGBA(146, 171, 214, 1.0);
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -懒加栽
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self.view addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(16);
            make.right.equalTo(-16);
            make.height.equalTo(240);
        }];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIView *)zhifuView {
    
    if (!_zhifuView) {
        _zhifuView = [UIView new];
        [self.backView addSubview:_zhifuView];
        [_zhifuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(75);
        }];
        _zhifuView.backgroundColor = kRGBA(250, 250, 250, 1.0);
    }
    return _zhifuView;
}

- (UILabel *)zhifuNameLb {
    if (!_zhifuNameLb) {
        _zhifuNameLb = [UILabel new];
        [self.zhifuView addSubview:_zhifuNameLb];
        [_zhifuNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(6);
            
        }];
        _zhifuNameLb.font = [UIFont systemFontOfSize:18];
        _zhifuNameLb.text = @"到支付宝";
    }
    return _zhifuNameLb;
}

- (UIButton *)accountBtn {
    if (!_accountBtn) {
        _accountBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.zhifuView addSubview:_accountBtn];
        [_accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.zhifuNameLb.mas_right).equalTo(24);
            make.centerY.equalTo(_zhifuNameLb.mas_centerY);
        }];
        _accountBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_accountBtn setTitle:@"123456788" forState:UIControlStateNormal];
        [_accountBtn setTitleColor:kRGBA(50, 71, 122, 1.0) forState:UIControlStateNormal];
    }
    return _accountBtn;
}

- (UILabel *)realName {
    if (!_realName) {
        _realName = [UILabel new];
        [self.zhifuView addSubview:_realName];
        [_realName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(self.accountBtn.mas_bottom).equalTo(2);
            
        }];
        _realName.font = [UIFont systemFontOfSize:18];
        _realName.text = @"真实姓名";
    }
    return _realName;
}

- (UIButton *)nameBtn {
    if (!_nameBtn) {
        _nameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.zhifuView addSubview:_nameBtn];
        [_nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.realName.mas_right).equalTo(24);
            make.centerY.equalTo(_realName.mas_centerY);
        }];
        _nameBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nameBtn setTitle:@"小火子逆天了" forState:UIControlStateNormal];
        [_nameBtn setTitleColor:kRGBA(50, 71, 122, 1.0) forState:UIControlStateNormal];
    }
    return _nameBtn;
}

- (UIView *)WithdrawView {
    if (!_WithdrawView) {
        _WithdrawView = [UIView new];
        [self.backView addSubview:_WithdrawView];
        [_WithdrawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.zhifuView.mas_bottom);
            make.height.equalTo(110);
        }];
        
    }
    return _WithdrawView;
}

- (UILabel *)moneyLb {
    if (!_moneyLb) {
        _moneyLb = [UILabel new];
        [self.WithdrawView addSubview:_moneyLb];
        [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(14);
        }];
        _moneyLb.font = [UIFont systemFontOfSize:19];
        _moneyLb.text = @"提现金额";
    }
    return _moneyLb;
}

- (UITextField *)numberTF {
    if (!_numberTF) {
        _numberTF = [UITextField new];
        [self.WithdrawView addSubview:_numberTF];
        [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(45);
            make.right.equalTo(0);
            make.top.equalTo(self.moneyLb.mas_bottom).equalTo(10);
            make.height.equalTo(70);
        }];
        _numberTF.font = [UIFont systemFontOfSize:35];
        _numberTF.delegate = self;
        
        UILabel *qianLb = [UILabel new];
        [self.WithdrawView addSubview:qianLb];
        [qianLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(15);
            make.centerY.equalTo(_numberTF.mas_centerY);
            
        }];
        qianLb.font = [UIFont systemFontOfSize:30];
        qianLb.text = @"¥";
        
        
    }
    
    [_numberTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    return _numberTF;
}

- (UIView *)balanceView {
    if (!_balanceView) {
        _balanceView = [UIView new];
        [self.backView addSubview:_balanceView];
        [_balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.WithdrawView.mas_bottom);
        }];
        UIView *lineView = [UIView new];
        [self.backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(_balanceView.mas_top);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = kGrayColor;
    }
    return _balanceView;
}

- (UILabel *)balanceLb {
    if (!_balanceLb) {
        _balanceLb = [UILabel new];
        [self.balanceView addSubview:_balanceLb];
        [_balanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            
        }];
        _balanceLb.textColor = kGrayColor;
        _balanceLb.text = @"零钱余额340,可提现余额¥200";
    }
    return _balanceLb;
}

- (UIButton *)withdrawBtn {
    if (!_withdrawBtn) {
        _withdrawBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.balanceView addSubview:_withdrawBtn];
        [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.centerY.equalTo(self.moneyLb.mas_centerY);
        }];
        [_withdrawBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:kRGBA(50, 71, 122, 1.0) forState:UIControlStateNormal];
    }
    return _withdrawBtn;
}


- (UILabel *)timeLB {
    if (!_timeLB) {
        _timeLB = [UILabel new];
        [self.view addSubview:_timeLB];
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.backView.mas_bottom).equalTo(12);
        }];
        _timeLB.textColor = kGrayColor;
        _timeLB.text = @"提现后一到两天到账";
    }
    return _timeLB;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(4);
            make.right.equalTo(-4);
            make.top.equalTo(self.timeLB.mas_bottom).equalTo(12);
            make.height.equalTo(50);
        }];
        _sureBtn.backgroundColor = kRGBA(146, 171, 214, 1.0);
        _sureBtn.layer.cornerRadius = 4;
        _sureBtn.clipsToBounds = YES;
        [_sureBtn setTitle:@"提现" forState:UIControlStateNormal];
        //[_sureBtn setBackgroundImage:[UIImage imageNamed:@"不可提现按钮"] forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(withdrawClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}


@end
