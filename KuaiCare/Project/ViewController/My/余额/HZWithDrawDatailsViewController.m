//
//  HZWithDrawDatailsViewController.m
//  dddd
//
//  Created by tang on 16/12/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithDrawDatailsViewController.h"

#import "HZWithDrawDetailsAccountTableViewCell.h"
#import "HZWithDrawDetailsStateCell.h"
#import "HZWithDrawDeatilProgressCell.h"

#import "HZWithDrawDetailDefeatedCell.h"

#import "HZWithDrawWarmPromptCell.h"





@interface HZWithDrawDatailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UITableView *tableView;

@property(nonatomic) NSInteger withDrawState;

@end

@implementation HZWithDrawDatailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"余额提现详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    
    self.withDrawState = 2;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section) {
        HZWithDrawDetailsAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZWithDrawDetailsAccountTableViewCell" forIndexPath:indexPath];
        cell.withDrawNumberLb.text = self.depositMoney;
        cell.withDrawAccountNumberLb.text = self.alipay;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section) {
        if (!indexPath.row) {
            HZWithDrawDetailsStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZWithDrawDetailsStateCell" forIndexPath:indexPath];
            if (self.depositStatus == 0) {
                cell.withDrawStateLb.text = @"提现中";
                cell.withDrawStateLb.textColor = kBlueColor;
            } else if (self.depositStatus == 1) {
                cell.withDrawStateLb.text = @"已到账";
                cell.withDrawStateLb.textColor = kGrayColor;
            } else {
                cell.withDrawStateLb.text = @"提现失败";
                cell.withDrawStateLb.textColor = kGrayColor;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            if (self.depositStatus == 2) {
                
                HZWithDrawDetailDefeatedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZWithDrawDetailDefeatedCell" forIndexPath:indexPath];
                cell.withDrawTimeLb.text = self.depositTime;
                cell.platformTimeLb.text = self.payTime;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else {
                
                HZWithDrawDeatilProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZWithDrawDeatilProgressCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (self.depositStatus == 0) {
                    
                    cell.progressImg.image = [UIImage imageNamed:@"体现中进度条"];
                    cell.withDrawTimeLb.text = self.depositTime;
                    cell.platformTimeLb.text = self.billTime;
                    cell.predictTimeLb.text = self.withdrawDepositTime;
                } else {
                    
                    cell.progressImg.image = [UIImage imageNamed:@"提现已完成进度条"];
                    cell.withDrawTimeLb.text = self.depositTime;
                    cell.platformTimeLb.text = self.billTime;
                    cell.predictTimeLb.text = self.payTime;
                }
                
            return cell;
            }
        }
        if (indexPath.row == 2) {
            HZWithDrawWarmPromptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZWithDrawWarmPromptCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.depositStatus == 0) {
                
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentLeft;
                paragraph.lineSpacing = 1.2;
                
                NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraph};
        
                NSString *str = nil;
                if (self.depositStatus == 0) {
                    str = @"如您任有疑问, 请反馈问题给客服, 我们会在24小时内答复您, 请点击意见反馈。";
                } else if (self.depositStatus == 1) {
                    str = @"提现金额已到账, 您可通过登录个人支付宝账号可是您支付宝当天入账明细及余款变动情况。";
                } else {
                    str = @"提现操作失败, 快护理账户余额未变动, 如有疑问, 请点击意见反馈。";
                }
                
                NSMutableAttributedString *labelTitle = [NSString getNSAttributedString:str labelDict:dic];
                cell.warmPromptDetatilLb.attributedText = labelTitle;
                NSDictionary *linkDic = @{NSForegroundColorAttributeName:kBlueColor, NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)};
                [cell.warmPromptDetatilLb addLinkString:@"意见反馈" linkAddAttribute:linkDic linkParameter:nil block:^(CJLinkLabelModel *linkModel) {
                    NSLog(@"意见反馈");
                }];

                CGFloat width = [[UIScreen mainScreen] bounds].size.width-20;
                CGRect labelFrame = cell.warmPromptDetatilLb.frame;
                labelFrame.size = [NSString sizeLabelToFit:labelTitle width:width height:MAXFLOAT];
                cell.warmPromptDetatilLb.frame = labelFrame;
                
                
            }
            
            return cell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        return [tableView fd_heightForCellWithIdentifier:@"HZWithDrawDetailsAccountTableViewCell" configuration:^(HZWithDrawDetailsAccountTableViewCell *cell) {
            
        }];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            if (self.depositStatus == 2) {
                return [tableView fd_heightForCellWithIdentifier:@"HZWithDrawDetailDefeatedCell" configuration:^(HZWithDrawDetailDefeatedCell *cell) {
                    
                }];
            } else {
                return [tableView fd_heightForCellWithIdentifier:@"HZWithDrawDeatilProgressCell" configuration:^(HZWithDrawDeatilProgressCell *cell) {
                    if (self.depositStatus == 0) {
                        cell.progressImg.image = [UIImage imageNamed:@"体现中进度条"];
                    } else {
                        cell.progressImg.image = [UIImage imageNamed:@"提现已完成进度条"];
                    }
            }];
            }
        }
        if (indexPath.row == 2) {
            return [tableView fd_heightForCellWithIdentifier:@"HZWithDrawWarmPromptCell" configuration:^(HZWithDrawWarmPromptCell *cell) {
                
            }];
        }
    }
    return 44;
}














#pragma  mark lazy 
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[HZWithDrawDetailsAccountTableViewCell class] forCellReuseIdentifier:@"HZWithDrawDetailsAccountTableViewCell"];
        [_tableView registerClass:[HZWithDrawDetailsStateCell class] forCellReuseIdentifier:@"HZWithDrawDetailsStateCell"];
        [_tableView registerClass:[HZWithDrawDeatilProgressCell class] forCellReuseIdentifier:@"HZWithDrawDeatilProgressCell"];
        [_tableView registerClass:[HZWithDrawDetailDefeatedCell class] forCellReuseIdentifier:@"HZWithDrawDetailDefeatedCell"];
        [_tableView registerClass:[HZWithDrawWarmPromptCell class] forCellReuseIdentifier:@"HZWithDrawWarmPromptCell"];
    }
    return _tableView;
}












@end
