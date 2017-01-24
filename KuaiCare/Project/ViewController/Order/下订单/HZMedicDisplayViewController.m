//
//  HZMedicDisplayViewController.m
//  KuaiCare
//
//  Created by tang on 17/1/6.
//  Copyright © 2017年 macbook user. All rights reserved.
//

#import "HZMedicDisplayViewController.h"
#import "HZMedicInfoCell.h"
#import "HZGoodAtCell.h"
#import "HZKindOfCommentCell.h"
#import "HZPatientCommentCell.h"

#import "HuliViewController.h"


#import "HZMedicDisplayViewModel.h"

@interface HZMedicDisplayViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UITableView *tableView;
@property(nonatomic) HZMedicDisplayViewModel *medicDisplayVM;

@end

@implementation HZMedicDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"医护介绍";
    
    UIBarButtonItem *sureRightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认医护" style:UIBarButtonItemStyleDone target:self action:@selector(sureClick:)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -6;
    
    self.navigationItem.rightBarButtonItems = @[spaceItem, sureRightBtn];
    
    
    [self tableView];
    
    
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.medicDisplayVM getMedicDisplayWithRequestMode:VMRequestModeRefresh medicId:self.medicId completionHandler:^(NSError *error) {
            if (!error) {
                [_tableView reloadData];
            }
        }];
        [_tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self.medicDisplayVM getMedicDisplayWithRequestMode:VMRequestModeMore medicId:self.medicId completionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                if (_medicDisplayVM.medicModel.list.count == 0) {
                    [self.view showWarning:@"没有更多评价了"];
                }
            }];
            [_tableView.mj_footer endRefreshing];
    }];
    
    
    [_tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark method 
- (void)sureClick:(UIBarButtonItem *)sender {
    NSLog(@"确认医护");
    NSString *nameStr = nil;
    NSString *hospitalStr = nil;
    if (!self.medicDisplayVM.medicModel.name.length) {
        nameStr = @"暂无";
    } else {
        nameStr = self.medicDisplayVM.medicModel.name;
    }
    if (!_medicDisplayVM.medicModel.hospital.length) {
        hospitalStr = @"暂无";
    } else {
        hospitalStr = _medicDisplayVM.medicModel.hospital;
    }
    
    NSString *str1 = [NSString stringWithFormat:@"%@(%@)",nameStr, hospitalStr];
    NSString *str2 = self.medicId;
    NSString *str3 = self.medicDisplayVM.medicModel.name;
    NSString *str4 = self.medicDisplayVM.medicModel.phone;
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HuliViewController class]]) {
            HuliViewController *huiliVC =(HuliViewController *)controller;
            [self.navigationController popToViewController:huiliVC animated:YES];
            HZDataHandler *dataHandler = [HZDataHandler sharedHadle];
            dataHandler.nameStr = str1;
            dataHandler.medicId = str2;
            dataHandler.hospital = str3;
            dataHandler.phone = str4;
        }
    }

}

#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 + self.medicDisplayVM.numberOfRow;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section) {
        if (!indexPath.row) {
            HZMedicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZMedicInfoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.headImg sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, _medicDisplayVM.medicModel.head].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
            
            NSString *nameStr = _medicDisplayVM.medicModel.name;
            NSString *postNameStr = _medicDisplayVM.medicModel.postName;
            NSString *string = nil;
            if (nameStr.length && postNameStr.length) {
                string = [NSString stringWithFormat:@"%@(%@)", nameStr, postNameStr];
            } else {
                if (nameStr.length) {
                    string = nameStr;
                } else {
                    nameStr = @"暂无";
                }
                if (postNameStr.length) {
                    string = postNameStr;
                } else {
                    postNameStr = @"暂无";
                }
                string = [NSString stringWithFormat:@"%@(%@)", nameStr, postNameStr];
            }
            
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
            [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(nameStr.length, postNameStr.length + 2)];
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(nameStr.length, postNameStr.length + 2)];
            cell.nameAndCareerLb.attributedText = attribute;
            
            cell.hospitalLb.text = _medicDisplayVM.medicModel.hospital;
            cell.receiveOrderNumberLbAndGradeLb.text = [NSString stringWithFormat:@"接单数:%ld次  综合评分:", _medicDisplayVM.medicModel.count];
            cell.starRatingView.value = _medicDisplayVM.medicModel.score.floatValue;
            
            return cell;
        } else {
            HZGoodAtCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZGoodAtCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.goodAtDetailLb.text = _medicDisplayVM.medicModel.goodAtField;
            
            return cell;
        }
    }
    
    if (indexPath.section == 1) {
        
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [NSString stringWithFormat:@"用户评价 (%ld)", _medicDisplayVM.numberOfRow];
            return cell;
        
    }
    HZPatientCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZPatientCommentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.headImg sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [_medicDisplayVM getListHeadWithIndex:indexPath.section - 2]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
    if ([_medicDisplayVM getListNickNameWithIndex:indexPath.section - 2].length) {
        cell.phoneLb.text = [_medicDisplayVM getListNickNameWithIndex:indexPath.section - 2];
    } else if ([_medicDisplayVM getListPhoneWithIndex:indexPath.section - 2].length){
        cell.phoneLb.text = [_medicDisplayVM getListPhoneWithIndex:indexPath.section - 2];
    } else {
        cell.phoneLb.text = @"患者";
    }
    cell.timeLb.text = [_medicDisplayVM getListEvaluateTimeWithIndex:indexPath.section - 2];
    cell.itemLbAndGradeLb.text = [NSString stringWithFormat:@"%@ 打分", [_medicDisplayVM getListItemNameWithIndex:indexPath.section - 2]];
    cell.starRatingView.value = [_medicDisplayVM getListSynthesizeScoreWithIndex:indexPath.section - 2].floatValue;
    cell.commentLb.text = [_medicDisplayVM getListEvaluateReasonWithIndex:indexPath.section - 2];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        if (!indexPath.row) {
            return 90;
        } else {
            return [tableView fd_heightForCellWithIdentifier:@"HZGoodAtCell" configuration:^(HZGoodAtCell *cell) {
                cell.goodAtDetailLb.text = _medicDisplayVM.medicModel.goodAtField;
            }];
        }
        
    }
    if (indexPath.section == 1) {
        return 50;
    }
    return [tableView fd_heightForCellWithIdentifier:@"HZPatientCommentCell" configuration:^(HZPatientCommentCell *cell) {
        [cell.headImg sd_setImageWithURL:[NSString stringWithFormat:@"%@%@?uploadFileId=%@", kBaseDownPath, kDownloadPath, [_medicDisplayVM getListHeadWithIndex:indexPath.section - 2]].tzl_URL placeholderImage:[UIImage imageNamed:@"默认头像"]];
        if ([_medicDisplayVM getListNickNameWithIndex:indexPath.section - 2].length) {
            cell.phoneLb.text = [_medicDisplayVM getListNickNameWithIndex:indexPath.section - 2];
        } else if ([_medicDisplayVM getListPhoneWithIndex:indexPath.section - 2].length){
            cell.phoneLb.text = [_medicDisplayVM getListPhoneWithIndex:indexPath.section - 2];
        } else {
            cell.phoneLb.text = @"患者";
        }

        cell.timeLb.text = [_medicDisplayVM getListEvaluateTimeWithIndex:indexPath.section - 2];
        cell.itemLbAndGradeLb.text = [NSString stringWithFormat:@"%@ 打分", [_medicDisplayVM getListItemNameWithIndex:indexPath.section - 2]];
        cell.starRatingView.value = [_medicDisplayVM getListSynthesizeScoreWithIndex:indexPath.section - 2].floatValue;
        cell.commentLb.text = [_medicDisplayVM getListEvaluateReasonWithIndex:indexPath.section - 2];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return 0.1;
    }
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[HZMedicInfoCell class] forCellReuseIdentifier:@"HZMedicInfoCell"];
        [_tableView registerClass:[HZGoodAtCell class] forCellReuseIdentifier:@"HZGoodAtCell"];
        [_tableView registerClass:[HZKindOfCommentCell class] forCellReuseIdentifier:@"HZKindOfCommentCell"];
        [_tableView registerClass:[HZPatientCommentCell class] forCellReuseIdentifier:@"HZPatientCommentCell"];
    }
    return _tableView;
}

- (HZMedicDisplayViewModel *)medicDisplayVM {
    if (!_medicDisplayVM) {
        _medicDisplayVM = [HZMedicDisplayViewModel new];
    }
    return _medicDisplayVM;
}

@end
